Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8DAC3EF899
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 05:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236854AbhHRDdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 23:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235554AbhHRDdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 23:33:22 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03883C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 20:32:48 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id a21so764821pfh.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 20:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=JVWM1e48keuxJEZyPP2QSd2itI/kmHuk3JHjusMRB3Y=;
        b=f5QVtgRN/qQ8FRYVFoZwMFtXsA3QJioXXHGLyaapm7AYSJeP/YIXdzI3BHSxU/y/gY
         ASRo/SBMqVA2BNWF95fRBWuyREnofh6y/OLunUB6gsUXUSCxJAXtnxHFqyQ0dd/mVO7L
         I886hJpCoAm9B7UaWYBoyG+H6ISSNuZCchDIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=JVWM1e48keuxJEZyPP2QSd2itI/kmHuk3JHjusMRB3Y=;
        b=JI5Jd/lafqoVJsDa8rdtbp8iY9mQAuBStNk03eJOgBA+2SQohpWLVSBXyFPE3RYP6K
         SU6NgA1IPDiI2D3y/UT+XwYh+ff8zfr3cOxrYAk+xMqMYGocc957XhSvILWRtwJU4s0r
         GyCgxaSxPm6pHP8/f+JkGHkThzNfSUb6EfOVPRZ3jr06j9yC2CUZ8sxqxvsIPBO9aond
         wl6vFikzgcVRXnNXBsZBBGF/KcxH8ESlRkEgL5ZOH4J6zLuJWs5o0TLmg3jQo+y7PjQJ
         zXs+U/UJmdGB/MFVb+t1xqA3oDVWPY01sA31Ok1zbbxVvFBUuptKHJJQ6LDpGbszPbLg
         FWig==
X-Gm-Message-State: AOAM531rfjvLGhFomn9VIzLa4gkG/tqyzjGB+SMmqIn3wR4UNoji8TPX
        ReECfqgJRsGhES46yvB1DaUZaw==
X-Google-Smtp-Source: ABdhPJwWhyoAOgoayOIjXjOosORW76E6dR6lxM5gqxM+kdBP2Aigtgkr96w1mxbR3nPsawKqh7JNYg==
X-Received: by 2002:aa7:8bdd:0:b0:3e2:13fc:dd2f with SMTP id s29-20020aa78bdd000000b003e213fcdd2fmr7077243pfd.53.1629257567442;
        Tue, 17 Aug 2021 20:32:47 -0700 (PDT)
Received: from localhost ([2001:4479:e000:e400:bb2:9104:6a48:5aa6])
        by smtp.gmail.com with ESMTPSA id r16sm3499715pje.10.2021.08.17.20.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 20:32:46 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Jan Stancek <jstancek@redhat.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org,
        christophe.leroy@csgroup.eu, linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, jstancek@redhat.com
Subject: Re: [PATCH/RFC] powerpc/module_64: allow .init_array constructors
 to run
In-Reply-To: <920acea9aa18e4f2956581a8e158bdaa376fdf63.1629203945.git.jstancek@redhat.com>
References: <920acea9aa18e4f2956581a8e158bdaa376fdf63.1629203945.git.jstancek@redhat.com>
Date:   Wed, 18 Aug 2021 13:32:43 +1000
Message-ID: <877dgjbf6s.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Stancek <jstancek@redhat.com> writes:

> gcov and kasan rely on compiler generated constructor code.
> For modules, gcc-8 with gcov enabled generates .init_array section,
> but on ppc64le it doesn't get executed. find_module_sections() never
> finds .init_array section, because module_frob_arch_sections() renames
> it to _init_array.
>
> Avoid renaming .init_array section, so do_mod_ctors() can use it.

This (the existing renaming) breaks a KASAN test too, so I'd love to see
this fixed.

However, I don't know that renaming the section is a complete fix: from
memory it is still be possible to get relocations that are too far away
and require separate trampolines. But I wasn't able to construct a
module that exhibited this behaviour and test a fix before I got pulled
away to other things.

Kind regards,
Daniel

>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
> I wasn't able to trace the comment:
>   "We don't handle .init for the moment: rename to _init"
> to original patch (it pre-dates .git). I'm not sure if it
> still applies today, so I limited patch to .init_array. This
> fixes gcov for modules for me on ppc64le 5.14.0-rc6.
>
> Renaming issue is also mentioned in kasan patches here:
>   https://patchwork.ozlabs.org/project/linuxppc-dev/cover/20210319144058.772525-1-dja@axtens
>
>  arch/powerpc/kernel/module_64.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
> index 6baa676e7cb6..c604b13ea6bf 100644
> --- a/arch/powerpc/kernel/module_64.c
> +++ b/arch/powerpc/kernel/module_64.c
> @@ -299,8 +299,16 @@ int module_frob_arch_sections(Elf64_Ehdr *hdr,
>  					  sechdrs[i].sh_size);
>  
>  		/* We don't handle .init for the moment: rename to _init */
> -		while ((p = strstr(secstrings + sechdrs[i].sh_name, ".init")))
> +		while ((p = strstr(secstrings + sechdrs[i].sh_name, ".init"))) {
> +#ifdef CONFIG_CONSTRUCTORS
> +			/* find_module_sections() needs .init_array intact */
> +			if (strstr(secstrings + sechdrs[i].sh_name,
> +				".init_array")) {
> +				break;
> +			}
> +#endif
>  			p[0] = '_';
> +		}
>  
>  		if (sechdrs[i].sh_type == SHT_SYMTAB)
>  			dedotify((void *)hdr + sechdrs[i].sh_offset,
> -- 
> 2.27.0
