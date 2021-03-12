Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B6D3390D2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbhCLPJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbhCLPJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:09:13 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B915C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:09:13 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id v11so1964019wro.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6z5yK8vEdlIPN8f6oHZ6+h6lqAhTCq/itvEZweQcS40=;
        b=SPoSWepUZZcZbGEOBlAli4oXCu/0VO5KeExM0FWwcOByekNYj7WLqNUH4xpPX4WZFo
         ySMH/S7b5x3kjFXw0C8B2FVWkWRZW16IPAE52q6rIP46olkrJ/h/ZoMvu2dkHb2re0FB
         zkLIjlqC5sL5C4Kb8HOQlgxSaySo665y2PgQzf+NDaCML34hV2U0ylk1IRINCFmtg3gP
         F1msse7QguYjEcN4QLorVAjscl9m8A9MaOGIZSEODdf+phfliSTfgQnHlCZIIWCazZtc
         zkBhu083V+HTWuBQxkNzgTOxx7egxFew1YGNfiRDFHJa9NwMDfoO6d+pEmCBMu+TmdLn
         E/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6z5yK8vEdlIPN8f6oHZ6+h6lqAhTCq/itvEZweQcS40=;
        b=pKkEI0hlPFgqgMRbj5iXDWhndFTBBGYVWEmIDV70el4rBUX70gf4yXqq1U/SGSctFz
         Begk+lTN+dfgHEscco4FI/fCGQgFsU+R6yhhaNnKIjz0C2ibyU9JV3XWFdzUJ3EZecKP
         fsDp09MHx5Dwfuy+vRUAp/ohHng2NSn+jHHcHX6E0xEXxpiJoDhUVipC976jBnzKEhkt
         2QplIB9mXSZw4Pj9FWqKmSmtja/xv7bIOZhjx2ipvGGF2OFetykuGRTskIhwniuohpDo
         53s/sJs/pS/vyn2TwLNg3R5xzMKJlc7QiLstNC4SS4dmPYYNbC+Ga0Pur9Hh7TCCWSei
         PusA==
X-Gm-Message-State: AOAM532dL7/aIErJ/yTosWD6nSnkf01WHGuKBePLs+/U/FGEAt1MQ93+
        ONGDLctFw0l+wJ+Xa1rIKVcumg==
X-Google-Smtp-Source: ABdhPJzX0GBowZ73CykHUe0qR+AXWgyRwFYf4xN0vLpadApF7HRvmSNgjf5B+3YuBS9k55qAx/9s8A==
X-Received: by 2002:adf:f851:: with SMTP id d17mr14371835wrq.267.1615561751666;
        Fri, 12 Mar 2021 07:09:11 -0800 (PST)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id a13sm6155249wrp.31.2021.03.12.07.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 07:09:11 -0800 (PST)
Date:   Fri, 12 Mar 2021 15:09:09 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 07/10] of: fdt: Demote kernel-doc abuses
Message-ID: <20210312150909.GV701493@dell>
References: <20210312110758.2220959-1-lee.jones@linaro.org>
 <20210312110758.2220959-8-lee.jones@linaro.org>
 <CAL_JsqJe7rp-FyXmPmf8RfBWrP0EmW7etML13HKLqEobtR2=Kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJe7rp-FyXmPmf8RfBWrP0EmW7etML13HKLqEobtR2=Kg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2021, Rob Herring wrote:

> On Fri, Mar 12, 2021 at 4:08 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > Fixes the following W=1 kernel build warning(s):
> >
> >  drivers/of/fdt.c:478: warning: Function parameter or member 'node' not described in '__reserved_mem_reserve_reg'
> >  drivers/of/fdt.c:478: warning: Function parameter or member 'uname' not described in '__reserved_mem_reserve_reg'
> >  drivers/of/fdt.c:525: warning: Function parameter or member 'node' not described in '__reserved_mem_check_root'
> >  drivers/of/fdt.c:547: warning: Function parameter or member 'node' not described in '__fdt_scan_reserved_mem'
> >  drivers/of/fdt.c:547: warning: Function parameter or member 'uname' not described in '__fdt_scan_reserved_mem'
> >  drivers/of/fdt.c:547: warning: Function parameter or member 'depth' not described in '__fdt_scan_reserved_mem'
> >  drivers/of/fdt.c:547: warning: Function parameter or member 'data' not described in '__fdt_scan_reserved_mem'
> >  drivers/of/fdt.c:547: warning: expecting prototype for fdt_scan_reserved_mem(). Prototype was for __fdt_scan_reserved_mem() instead
> >  drivers/of/fdt.c:663: warning: Function parameter or member 'parent' not described in 'of_scan_flat_dt_subnodes'
> >  drivers/of/fdt.c:708: warning: Function parameter or member 'node' not described in 'of_get_flat_dt_prop'
> >  drivers/of/fdt.c:708: warning: Function parameter or member 'name' not described in 'of_get_flat_dt_prop'
> >  drivers/of/fdt.c:708: warning: Function parameter or member 'size' not described in 'of_get_flat_dt_prop'
> >  drivers/of/fdt.c:758: warning: Function parameter or member 'node' not described in 'of_flat_dt_match'
> >  drivers/of/fdt.c:758: warning: Function parameter or member 'compat' not described in 'of_flat_dt_match'
> >  drivers/of/fdt.c:778: warning: Function parameter or member 'node' not described in 'of_get_flat_dt_phandle'
> >  drivers/of/fdt.c:778: warning: expecting prototype for of_get_flat_dt_prop(). Prototype was for of_get_flat_dt_phandle() instead
> >  drivers/of/fdt.c:955: warning: Function parameter or member 'node' not described in 'early_init_dt_scan_root'
> >  drivers/of/fdt.c:955: warning: Function parameter or member 'uname' not described in 'early_init_dt_scan_root'
> >  drivers/of/fdt.c:955: warning: Function parameter or member 'depth' not described in 'early_init_dt_scan_root'
> >  drivers/of/fdt.c:955: warning: Function parameter or member 'data' not described in 'early_init_dt_scan_root'
> >  drivers/of/fdt.c:991: warning: Function parameter or member 'node' not described in 'early_init_dt_scan_memory'
> >  drivers/of/fdt.c:991: warning: Function parameter or member 'uname' not described in 'early_init_dt_scan_memory'
> >  drivers/of/fdt.c:991: warning: Function parameter or member 'depth' not described in 'early_init_dt_scan_memory'
> >  drivers/of/fdt.c:991: warning: Function parameter or member 'data' not described in 'early_init_dt_scan_memory'
> >
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Frank Rowand <frowand.list@gmail.com>
> > Cc: benh@kernel.crashing.org
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/of/fdt.c | 19 ++++++++++---------
> >  1 file changed, 10 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > index dcc1dd96911a9..1fb3348eb9516 100644
> > --- a/drivers/of/fdt.c
> > +++ b/drivers/of/fdt.c
> > @@ -470,7 +470,7 @@ void *initial_boot_params __ro_after_init;
> >
> >  static u32 of_fdt_crc32;
> >
> > -/**
> > +/*
> >   * __reserved_mem_reserve_reg() - reserve all memory described in 'reg' property
> >   */
> >  static int __init __reserved_mem_reserve_reg(unsigned long node,
> > @@ -516,7 +516,7 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
> >         return 0;
> >  }
> >
> > -/**
> > +/*
> >   * __reserved_mem_check_root() - check if #size-cells, #address-cells provided
> >   * in /reserved-memory matches the values supported by the current implementation,
> >   * also check if ranges property has been provided
> > @@ -539,7 +539,7 @@ static int __init __reserved_mem_check_root(unsigned long node)
> >         return 0;
> >  }
> >
> > -/**
> > +/*
> >   * fdt_scan_reserved_mem() - scan a single FDT node for reserved memory
> 
> This is still wrong. Should be __fdt_scan_reserved_mem.

Ah, the warning went away because I demoted it.

Will fix.  The others too.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
