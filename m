Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2A13B4760
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 18:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhFYQ1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 12:27:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229741AbhFYQ1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 12:27:16 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3814A61969;
        Fri, 25 Jun 2021 16:24:55 +0000 (UTC)
Date:   Fri, 25 Jun 2021 12:24:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yun Zhou <yun.zhou@windriver.com>
Cc:     <linux-kernel@vger.kernel.org>,
        <kernel-hardening@lists.openwall.com>, <ying.xue@windriver.com>,
        <zhiquan.li@windriver.com>
Subject: Re: [PATCH 1/2] seq_buf: fix overflow when length is bigger than 8
Message-ID: <20210625122453.5e2fe304@oasis.local.home>
In-Reply-To: <20210625155348.58266-1-yun.zhou@windriver.com>
References: <20210625155348.58266-1-yun.zhou@windriver.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jun 2021 23:53:47 +0800
Yun Zhou <yun.zhou@windriver.com> wrote:

> There's two variables being increased in that loop (i and j), and i
> follows the raw data, and j follows what is being written into the buffer.
> We should compare 'i' to MAX_MEMHEX_BYTES or compare 'j' to HEX_CHARS.
> Otherwise, if 'j' goes bigger than HEX_CHARS, it will overflow the
> destination buffer.
> 
> This bug was introduced by commit 6d2289f3faa71dcc ("tracing: Make
> trace_seq_putmem_hex() more robust")

No it wasn't. The bug was in the original code:

  5e3ca0ec76fce ("ftrace: introduce the "hex" output method")

Which had this:

> static notrace int
> trace_seq_putmem_hex(struct trace_seq *s, void *mem, size_t len)
> {
>         unsigned char hex[HEX_CHARS];
>         unsigned char *data;
>         unsigned char byte;
>         int i, j;
> 
>         BUG_ON(len >= HEX_CHARS);

If len is 16 (and HEX_CHARS is 17) the bug wouldn't happen.

> 
>         data = mem;
> 
> #ifdef __BIG_ENDIAN
>         for (i = 0, j = 0; i < len; i++) {
> #else
>         for (i = len-1, j = 0; i >= 0; i--) {
> #endif

The above starts at len-1 (15) and will iterate 15 times.

>                 byte = data[i];
> 
>                 hex[j]   = byte & 0x0f;
>                 if (hex[j] >= 10)
>                         hex[j] += 'a' - 10;
>                 else
>                         hex[j] += '0';
>                 j++;
> 
>                 hex[j] = byte >> 4;
>                 if (hex[j] >= 10)
>                         hex[j] += 'a' - 10;
>                 else
>                         hex[j] += '0';
>                 j++;

j is incremented twice for every loop, and if len was 15, that is 30 times.

Needless to say, once i iterated 9 times, then j would be 18, and one
more than the size of hex. And boom, it breaks.



>         }
>         hex[j] = ' ';
>         j++;
> 
>         return trace_seq_putmem(s, hex, j);
> }



> 
> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
> ---
>  lib/seq_buf.c | 29 +++++++++++------------------
>  1 file changed, 11 insertions(+), 18 deletions(-)
> 
> diff --git a/lib/seq_buf.c b/lib/seq_buf.c
> index 6aabb609dd87..aa2f666e584e 100644
> --- a/lib/seq_buf.c
> +++ b/lib/seq_buf.c
> @@ -210,7 +210,8 @@ int seq_buf_putmem(struct seq_buf *s, const void *mem, unsigned int len)
>   * seq_buf_putmem_hex - write raw memory into the buffer in ASCII hex
>   * @s: seq_buf descriptor
>   * @mem: The raw memory to write its hex ASCII representation of
> - * @len: The length of the raw memory to copy (in bytes)
> + * @len: The length of the raw memory to copy (in bytes).
> + *       It can be not larger than 8.
>   *
>   * This is similar to seq_buf_putmem() except instead of just copying the
>   * raw memory into the buffer it writes its ASCII representation of it
> @@ -228,27 +229,19 @@ int seq_buf_putmem_hex(struct seq_buf *s, const void *mem,
>  
>  	WARN_ON(s->size == 0);
>  
> -	while (len) {
> -		start_len = min(len, HEX_CHARS - 1);
> +	start_len = min(len, MAX_MEMHEX_BYTES);
>  #ifdef __BIG_ENDIAN
> -		for (i = 0, j = 0; i < start_len; i++) {
> +	for (i = 0, j = 0; i < start_len; i++) {
>  #else
> -		for (i = start_len-1, j = 0; i >= 0; i--) {
> +	for (i = start_len-1, j = 0; i >= 0; i--) {
>  #endif
> -			hex[j++] = hex_asc_hi(data[i]);
> -			hex[j++] = hex_asc_lo(data[i]);
> -		}
> -		if (WARN_ON_ONCE(j == 0 || j/2 > len))
> -			break;
> -
> -		/* j increments twice per loop */
> -		len -= j / 2;
> -		hex[j++] = ' ';
> -
> -		seq_buf_putmem(s, hex, j);
> -		if (seq_buf_has_overflowed(s))
> -			return -1;
> +		hex[j++] = hex_asc_hi(data[i]);
> +		hex[j++] = hex_asc_lo(data[i]);
>  	}
> +
> +	seq_buf_putmem(s, hex, j);
> +	if (seq_buf_has_overflowed(s))
> +		return -1;
>  	return 0;
>  }
>  

The above is *way* too complex for a backport that should go back to
the beginning. You were partially, correct, and the proper fix would be:


diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index 707453f5d58e..eb68b5b3eb26 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -229,8 +229,10 @@ int seq_buf_putmem_hex(struct seq_buf *s, const void *mem,
 
 	WARN_ON(s->size == 0);
 
+	BUILD_BUG_ON(MAX_MEMHEX_BYTES * 2 >= HEX_CHARS);
+
 	while (len) {
-		start_len = min(len, HEX_CHARS - 1);
+		start_len = min(len, MAX_MEMHEX_BYTES - 1);
 #ifdef __BIG_ENDIAN
 		for (i = 0, j = 0; i < start_len; i++) {
 #else
-- 
2.29.2


That solves the first bug, and is easy to backport.

The second bug, is that data doesn't go forward (as you stated in your
original patch) which would be:

diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index eb68b5b3eb26..39b9374d3a1e 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -244,13 +244,14 @@ int seq_buf_putmem_hex(struct seq_buf *s, const void *mem,
 		if (WARN_ON_ONCE(j == 0 || j/2 > len))
 			break;
 
-		/* j increments twice per loop */
-		len -= j / 2;
 		hex[j++] = ' ';
 
 		seq_buf_putmem(s, hex, j);
 		if (seq_buf_has_overflowed(s))
 			return -1;
+
+		len -= start_len;
+		data += start_len;
 	}
 	return 0;
 }

Why are you making it so complicated?

-- Steve
