Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CED83F1388
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 08:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbhHSG3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 02:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbhHSG3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 02:29:48 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FC4C061756
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 23:29:12 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id u15so3281180plg.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 23:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1kz12NDqoO9zWoOr/K63J+3YgCfYNhAV2a4u1ChokLg=;
        b=Idc7ZRu5ncBrBaCpLn2Xo6Bb7skPL8rfWvaVplzBb2hgvlbQ+NYM4Tf6Zd697znV4L
         LXg89AMFPYj3O0Qu3wiZtzquL6NTC9fQd6cfIvXxiG4vnxzhtrt7n3xZp/00acqOPCCF
         RJ3F+00uTdrz3ONiV3ImEnLw2Tf3Q8ScGDmzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1kz12NDqoO9zWoOr/K63J+3YgCfYNhAV2a4u1ChokLg=;
        b=KYJf+FCdFOmL/EflCW0ktkptNMI4Q3Y5myPCY7nbo6fgjdHqESmq9kLd0a4MoNOnz7
         16VUjWulkwqSIoa/i5YiLN7uiGqf2rg75M3pRQWANFX82mF5X12EUMiZMySTgbTO5WEm
         bkcMfyqwWvoac9NfqD9lTZhMNg2rOxdvXNgfXJ497a+bDC0gXfjGr9VqGcSghJZnEPMD
         fUtMd1VhixIGuHxG8eCFeiBOeKGL0KLGP5NQmM561ZBFjPhyowy6A+blJj6h0U1ZJ7t7
         zNPjXTMqiOFC/jswEhCPuiCfg5JHqsWzTdxnMGaUp0//jVYZc8tsX9hIs0G43qtgq/xK
         /ZFQ==
X-Gm-Message-State: AOAM531Lf7uWSToiW+lj7Ie1gsCiltb/c6Pudkd3sG/9YnFcETg1Wb18
        Y4HzZxUZ6QKx5hJoJ28h/pp+Ag==
X-Google-Smtp-Source: ABdhPJxtgT9/z655pT8mP61QVSDc1qpnlMu3N/QUCsWW/2TXN6ULFIBL7R939CsqWBxDMoInisCeIQ==
X-Received: by 2002:a17:90b:370d:: with SMTP id mg13mr12031727pjb.117.1629354552228;
        Wed, 18 Aug 2021 23:29:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d13sm1848559pfn.136.2021.08.18.23.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 23:29:11 -0700 (PDT)
Date:   Wed, 18 Aug 2021 23:29:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 05/13] kbuild: remove stale *.symversions
Message-ID: <202108182328.5CF89AC2@keescook>
References: <20210819005744.644908-1-masahiroy@kernel.org>
 <20210819005744.644908-6-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819005744.644908-6-masahiroy@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 09:57:36AM +0900, Masahiro Yamada wrote:
> cmd_update_lto_symversions merges all the existing *.symversions, but
> some of them might be stale.
> 
> If the last EXPORT_SYMBOL is removed from a C file, the *.symversions
> file is not deleted or updated. It contains stale CRCs, which will be
> used for linking the vmlinux or modules.
> 
> It is not a big deal when the EXPORT_SYMBOL is really removed. However,
> when the EXPORT_SYMBOL is moved to another file, the same __crc_<symbol>
> will appear twice in the merged *.symversions, possibly with different
> CRCs if the function argument is changed at the same time. It would
> cause potential breakage of module versioning.
> 
> If no EXPORT_SYMBOL is found, let's remove *.symversions explicitly.

Ah, and this was an issue for non-LTO builds too? Regardless, nice
catch.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  scripts/Makefile.build | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 279363266455..585dae34746a 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -177,6 +177,8 @@ cmd_modversions_c =								\
>  	if $(NM) $@ 2>/dev/null | grep -q __ksymtab; then			\
>  		$(call cmd_gensymtypes_c,$(KBUILD_SYMTYPES),$(@:.o=.symtypes))	\
>  		    > $@.symversions;						\
> +	else									\
> +		rm -f $@.symversions;						\
>  	fi;
>  else
>  cmd_modversions_c =								\
> -- 
> 2.30.2
> 

-- 
Kees Cook
