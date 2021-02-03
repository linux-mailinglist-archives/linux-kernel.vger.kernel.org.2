Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81DBD30D983
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 13:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbhBCMJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 07:09:01 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44180 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234415AbhBCMI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:08:56 -0500
Received: from zn.tnic (p200300ec2f0c84005017455b058bf408.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:8400:5017:455b:58b:f408])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8CB511EC047F;
        Wed,  3 Feb 2021 13:08:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1612354092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SWdmElQrBoZjy9apBMzzUtINAXqs3VGDJ8lvf/D/UbM=;
        b=Nnxv80R4lSkNGJeRYw78dmKEI+vnevc8WcYfNWeqP6eDySYn+frB1Il+I8JCsnJ5mfwU04
        o0EY3SFVGyJ6pFKNvvfP1zJ73KnUGL++GfkLj3/eGtZcIo+iSYqL4KPY5NeoIh9QLg/3jV
        udmtQtYCQenFl587kXkskT3SV0F+dFE=
Date:   Wed, 3 Feb 2021 13:08:14 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     John Millikin <john@john-millikin.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/tools: Use POSIX-compliant syntax for empty regex
 groups
Message-ID: <20210203120814.GB13819@zn.tnic>
References: <ed1d5611-a0e6-7629-c827-a17112944c5f@john-millikin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed1d5611-a0e6-7629-c827-a17112944c5f@john-millikin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 25, 2020 at 10:30:43PM +0900, John Millikin wrote:
> The syntax for POSIX regexes technically doesn't allow empty branches in
> conditional match groups. GNU libc accepts them as equivalent to `()',
> but other libc implementations (e.g. macOS libc) reject them with a
> parse error.
> 
> Changing to compliant syntax, `(|_sym)' to `(()|_sym)', lets the `relocs'
> tool run successfully when using a non-GNU platform as a build host for
> cross-compiling the kernel.
> 
> Signed-off-by: John Millikin <john@john-millikin.com>
> ---
> 
> Helper binary to verify behavior for the current platform:
> 
>     #include <regex.h>
>     #include <stdio.h>
>     int main(int argc, char **argv) {
>         regex_t compiled;
>         int err = regcomp(&compiled, argv[1], REG_EXTENDED|REG_NOSUB);
>         if (err != 0) {
>             char errbuf[128];
>             regerror(err, &compiled, errbuf, sizeof(errbuf));
>             printf("regcomp(\"%s\"): %s\n", argv[1], errbuf);
>            return 1;
>         }
>         printf("regcomp(\"%s\"): OK\n", argv[1]);
>         return 0;
>     }
> 
> Output from GNU libc 2.28 and a fussier non-GNU libc:
> 
>     debian:~$ ./regcomp '^a(|b)$'
>     regcomp("^a(|b)$"): OK
>     debian:~$ ./regcomp '^a(()|b)$'
>     regcomp("^a(()|b)$"): OK
> 
>     darwin:~$ ./regcomp '^a(|b)$'
>     regcomp("^a(|b)$"): empty (sub)expression
>     darwin:~$ ./regcomp '^a(()|b)$'
>     regcomp("^a(()|b)$"): OK
> 

I guess you can add those to the commit message as they explain in
detail what the situation is.

>  arch/x86/tools/relocs.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
> index ce7188cbdae5..e6f28616a625 100644
> --- a/arch/x86/tools/relocs.c
> +++ b/arch/x86/tools/relocs.c
> @@ -57,12 +57,12 @@ static const char * const sym_regex_kernel[S_NSYMTYPES] = {
>      [S_REL] =

$ test-apply.sh /tmp/build.01
checking file arch/x86/tools/relocs.c
patch: **** malformed patch at line 67:      [S_REL] =

Don't tell me the apple mangles patches...

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
