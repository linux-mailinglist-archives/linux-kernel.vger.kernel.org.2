Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873DB35A9D0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 03:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbhDJBFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 21:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbhDJBFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 21:05:49 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75535C061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 18:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Received:Date:From:To:Cc:
        Subject:Message-ID:References:MIME-Version:Content-Type:
        Content-Disposition:In-Reply-To; bh=+7wzJQFL7hr5KXWeTq/So2HMeFsi
        T+/RRKBLo4YOw70=; b=NIhZJdUw5rrtOjFX7YI5x0vzUICV70edFfcRNCGJjBCK
        Nu7E2cx4vui77vPn1mSPSkD+gQZHm0OoCpd+q8L+umIuicdDMyPanpDjekImBMLY
        9zGtdxapzqhz2eCCxJhy7uYK+r1YsUJI1nrNl15uvYEhC+zmPlICxZrB7xIv7OY=
Received: from wfg-e595 (unknown [125.120.234.91])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygBHT0vZ+XBgnLW8AA--.26S3;
        Sat, 10 Apr 2021 09:05:30 +0800 (CST)
Received: from wfg by wfg-e595 with local (Exim 4.93)
        (envelope-from <wfg@mail.ustc.edu.cn>)
        id 1lV244-001QeW-IV; Sat, 10 Apr 2021 09:05:32 +0800
Date:   Sat, 10 Apr 2021 09:05:32 +0800
From:   Wu Fengguang <wfg@mail.ustc.edu.cn>
To:     Hui Zhu <teawater@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH for vm-scalability] usemem: Add code for touch-alloc
Message-ID: <20210410010532.GA339619@wfg-e595>
References: <20210408134255.12330-1-teawater@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210408134255.12330-1-teawater@gmail.com>
X-CM-TRANSID: LkAmygBHT0vZ+XBgnLW8AA--.26S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJrWruF18Xr1fAFWDWryUZFb_yoW8Cr18pa
        1xKwn8trW7t39IkFWSvas8WFy5Gwn5ta1xta17t34UZa42yF15urW3Zwn7AF48ArykZFs7
        Aay3CFyDurZFyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUklb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI
        12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r
        1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lc2xSY4AK67AK
        6w4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8qjg7UUUU
        U==
X-CM-SenderInfo: xzijqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied, thanks!

On Thu, Apr 08, 2021 at 09:42:55PM +0800, Hui Zhu wrote:
>Add code for touch-alloc.
>And Change read memory to write memory to avoid use the zero-page for
>reads in do_anonymous_page.
>
>Signed-off-by: Hui Zhu <teawater@gmail.com>
>---
> usemem.c | 34 ++++++++++++++++++++++------------
> 1 file changed, 22 insertions(+), 12 deletions(-)
>
>diff --git a/usemem.c b/usemem.c
>index e2c46ec..5b90aae 100644
>--- a/usemem.c
>+++ b/usemem.c
>@@ -329,6 +329,18 @@ void detach(void)
> 	}
> }
>
>+unsigned long do_access(unsigned long *p, unsigned long idx, int read)
>+{
>+	volatile unsigned long *vp = p;
>+
>+	if (read)
>+		return vp[idx];	/* read data */
>+	else {
>+		vp[idx] = idx;	/* write data */
>+		return 0;
>+	}
>+}
>+
> unsigned long * allocate(unsigned long bytes)
> {
> 	unsigned long *p;
>@@ -355,6 +367,14 @@ unsigned long * allocate(unsigned long bytes)
> 		p = (unsigned long *)ALIGN((unsigned long)p, pagesize - 1);
> 	}
>
>+	if (opt_touch_alloc) {
>+		unsigned long i;
>+		unsigned long m = bytes / sizeof(*p);
>+
>+		for (i = 0; i < m; i += 1)
>+			do_access(p, i, 0);
>+	}
>+
> 	return p;
> }
>
>@@ -436,18 +456,6 @@ void shm_unlock(int seg_id)
> 	shmctl(seg_id, SHM_UNLOCK, NULL);
> }
>
>-unsigned long do_access(unsigned long *p, unsigned long idx, int read)
>-{
>-	volatile unsigned long *vp = p;
>-
>-	if (read)
>-		return vp[idx];	/* read data */
>-	else {
>-		vp[idx] = idx;	/* write data */
>-		return 0;
>-	}
>-}
>-
> #define NSEC_PER_SEC  (1UL * 1000 * 1000 * 1000)
>
> long nsec_sub(long nsec1, long nsec2)
>@@ -953,6 +961,8 @@ int main(int argc, char *argv[])
> 				opt_punch_holes = 1;
> 			} else if (strcmp(opts[opt_index].name, "init-time") == 0) {
> 				opt_init_time = 1;
>+			} else if (strcmp(opts[opt_index].name, "touch-alloc") == 0) {
>+				opt_touch_alloc = 1;
> 			} else
> 				usage(1);
> 			break;
>-- 
>2.17.1
>

