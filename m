Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FBB3DC1E2
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 02:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbhGaARa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 20:17:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234211AbhGaAR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 20:17:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97C7860E09;
        Sat, 31 Jul 2021 00:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627690642;
        bh=v9W11yuhUc1ArFzXc2d11Un1ugxJhd8TImD3TfT1dXo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kwNlVcY0TTNsw9lstRNHKrv88P8wCxENV2CttvaL+qrxYXYbqX9ZAdPju+uP1yF5U
         +YN/1qN0U9aeMpFZ9dZjroTQIwEue+38qOZ55/pGD+Wh/iDcblxv10EXcMNfokDXIS
         FA7oF5NapUlndrLLwWxUulhiAbZ5L79pvIWWQER0/Y44/HsWf8oMuePPDJra78Xvdk
         X0xmUXXETDgBx4CftaNnlVuADyr2riZgaR2NX3DxgwgWmJ2Ojvf+h+ZLXXDOHeoaNq
         X5dGC5Z8UDZKV9SeRFfMD29cIrf3sGwgRE1IIyMMQk0ihDO4Nxu4skseWCzrk078/l
         xftjcwY0P+BOw==
Date:   Sat, 31 Jul 2021 09:17:18 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 RESEND] x86/tools: fix objdump version check again
Message-Id: <20210731091718.e5bf207d185196d746d2b527@kernel.org>
In-Reply-To: <20210731000146.2720-1-rdunlap@infradead.org>
References: <20210731000146.2720-1-rdunlap@infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jul 2021 17:01:46 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> Skip (omit) any version string info that is parenthesized.
> 
> Warning: objdump version 15) is older than 2.19
> Warning: Skipping posttest.
> 
> where 'objdump -v' says:
> GNU objdump (GNU Binutils; SUSE Linux Enterprise 15) 2.35.1.20201123-7.18

Looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,


> 
> Fixes: 8bee738bb1979 ("x86: Fix objdump version check in chkobjdump.awk for different formats.")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: Borislav Petkov <bp@alien8.de>
> ---
> v3: rebase & resend
>     correct Ingo's email address (not @elte.hu)
>     add x86@kernel.org email address
>     add BP's email address
> 
>  arch/x86/tools/chkobjdump.awk |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-next-20210715.orig/arch/x86/tools/chkobjdump.awk
> +++ linux-next-20210715/arch/x86/tools/chkobjdump.awk
> @@ -10,6 +10,7 @@ BEGIN {
>  
>  /^GNU objdump/ {
>  	verstr = ""
> +	gsub(/\(.*\)/, "");
>  	for (i = 3; i <= NF; i++)
>  		if (match($(i), "^[0-9]")) {
>  			verstr = $(i);


-- 
Masami Hiramatsu <mhiramat@kernel.org>
