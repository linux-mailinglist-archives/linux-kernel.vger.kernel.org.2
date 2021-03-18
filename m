Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293CB33FF14
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 06:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhCRFxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 01:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhCRFw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 01:52:59 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D95C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 22:52:58 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id gb6so2358760pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 22:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HFnvCDyiDf/wXkwBZxcS7hyjxLXnLTp2jBAW0bn33UQ=;
        b=MXB/zjXdp9mm9moKZkRhOBxcpgK+FGMMTS7zXwSq0BNTrtHc5RjCTKABMaBwl2XRH2
         1Cx9jAYecE+0q9K7KxUEFr0jIVdVNduxTdQ8C+XhkyeRiIIcPIaHmQgsk2lWg/xsshch
         Z97QRsNogtrRutzljWF5QJuDnPzdciyYX6d7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HFnvCDyiDf/wXkwBZxcS7hyjxLXnLTp2jBAW0bn33UQ=;
        b=KrUnZXS6QhguZTnp/TF0O8nrmB1SgZ7uvwUrlSYEcI36vdvhEy+qkNX34o/GwpUmyz
         9kpX1rdESGTBWuIsOqUQLsIBonpCW1TMljHWXkG62jLfpyQj2Czu3E/4IYXx6letYwTd
         QqXWDgypZy1hoIrOseKvWcA3G56LCaoRWbzM3Wwlqjm64RDJ6T8w55ajmysaTdnr0vVe
         HWuRC7NQzxe2rhFv1Ptn+2fnHQ4w2B/E0sVrRjTJxSVlh8xPykEOfxQzOnSojV+pox/4
         wBt3nZR92ypG0ptZW3EiII+fZ9ojiQiNlY7KwyD/2kEK1NA9H6K7ehiWd7ILp6n3vhdm
         XZMQ==
X-Gm-Message-State: AOAM531wWZBRGSYcRDmXX37ihPZ2ze0TMd8q90q31kcHTpLNyA4LWE2s
        JkwhLHT3W71wc7rh2D0vgGpulg==
X-Google-Smtp-Source: ABdhPJzNV7VwYKDSP95ny2zJ1+cMAig/Dkcu+O5FILijf/qb+Toh9TR4o2X4szY+1VXGaRr/axJaBA==
X-Received: by 2002:a17:90a:5587:: with SMTP id c7mr2450777pji.5.1616046778334;
        Wed, 17 Mar 2021 22:52:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g18sm900079pfb.178.2021.03.17.22.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 22:52:57 -0700 (PDT)
Date:   Wed, 17 Mar 2021 22:52:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] gcc-plugins: avoid errors with -std=gnu++11 on
 old gcc
Message-ID: <202103172251.F9D770D@keescook>
References: <279558.1615192821@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <279558.1615192821@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 03:40:21AM -0500, Valdis Klētnieks wrote:
> It turns out that older gcc (4.9 and 5.4) have gnu++11 support, but
> due to a gcc bug fixed in gcc6, throw errors during the build.
> The relevant gcc bug is https://gcc.gnu.org/bugzilla/show_bug.cgi?id=69959
> 
> Version the option based on what gcc we're using.

Is there a better way to detect this than with version checking?

-Kees

> 
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> Fixes: 27c287b41659 ("gcc-plugins: fix gcc 11 indigestion with plugins...")
> ---
> diff --git a/scripts/gcc-plugins/Makefile b/scripts/gcc-plugins/Makefile
> index b5487cce69e8..cc779973724a 100644
> --- a/scripts/gcc-plugins/Makefile
> +++ b/scripts/gcc-plugins/Makefile
> @@ -21,8 +21,11 @@ always-y += $(GCC_PLUGIN)
>  
>  GCC_PLUGINS_DIR = $(shell $(CC) -print-file-name=plugin)
>  
> +# need gnu++11 for gcc 11, but 4.9 and 5.4 need gnu++98
> +GCC_FLAVOR = $(call cc-ifversion, -ge, 1100, 11, 98)
> +
>  plugin_cxxflags	= -Wp,-MMD,$(depfile) $(KBUILD_HOSTCXXFLAGS) -fPIC \
> -		   -I $(GCC_PLUGINS_DIR)/include -I $(obj) -std=gnu++11 \
> +		   -I $(GCC_PLUGINS_DIR)/include -I $(obj) -std=gnu++$(GCC_FLAVOR) \
>  		   -fno-rtti -fno-exceptions -fasynchronous-unwind-tables \
>  		   -ggdb -Wno-narrowing -Wno-unused-variable \
>  		   -Wno-format-diag
> 
> 

-- 
Kees Cook
