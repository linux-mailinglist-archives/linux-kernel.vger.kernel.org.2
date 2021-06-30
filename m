Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E34F3B7F32
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 10:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbhF3Ioi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 04:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbhF3Ioh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 04:44:37 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0490C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 01:42:08 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j2so2539718wrs.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 01:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iupOz/lM3nLVoO3qVSMzdJaUPPRF/UbP8kUJwTndH6g=;
        b=xrqheZzIL1v8Uc9aMLXQVjrsFhj8HDjnOhnmrWxQqFzW3XoY0hZRVyGSrMfJIqXOAs
         Vz+fLNceEdmBIpouUalw+j6EBPFwix206qZjcxGYLdoRXXcudaPucHdzMRlQi6Mv6its
         zEGmsYTQJS2fSiJqeWgbDeJ3i6ylt59cqqcbkjNl2bIzKL7gi5rttOEySAiKHjfEIneF
         acx35nb8IC/vClbjtjCgwDWlvbHF70SXT+9GGH7b1LgLMZGFMeEIxCOSmO/tWQPM1dNh
         JTgWnKmgx6B+ycLtJag5vs4o1OaKWRexnhhd5N5sfjG81YuIJ0Cr659HjMCouFYjnpxU
         IpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iupOz/lM3nLVoO3qVSMzdJaUPPRF/UbP8kUJwTndH6g=;
        b=YXv6RRuzeSO7PRB2jFMT5ypUhB7jrWZ+9+BSf0CGdGZZgwrNLosq6UgaaFeosr7+FE
         +21HPfD7wkJNSzxVQ5A10Nx7wHdhsTB0Zzxq6XG4ss7gYEn9O+2uFzUSI0iuzoTRLIV8
         lScqpomwx8uPmpCh/4UkxADBd9D+QsT1EcWfU4hy9+2vf4pGJrP43w/BYPRawVZ4pLI7
         oVOdcWX2RQ/6NTuf6OQk5zUXquBSIsqORkHbwUdt1SLX6F+HrmFGADgUaPTePSL0XR8S
         2IZ5NRhDEdVwdu3l5YBLmrb3HJt1bEEqCw2MpfMgZ7vNslc7IMsC0z/uuJtzHMHgPuEL
         asHQ==
X-Gm-Message-State: AOAM5315ruLZT16l1wXSBGgmvnJ0PAkV8+A3h0wEwwDa+p8o76pFPc4G
        KqAYZAQVguxMiBGszBRg+CTgJw==
X-Google-Smtp-Source: ABdhPJyS7wtM5YlTm5jL8zfR/yjvrseRXbC9o6ifJ8dXHEnguNVfftuNFKBMF6Qi+YFo2s1xt6K0NA==
X-Received: by 2002:a5d:6a81:: with SMTP id s1mr11797876wru.41.1625042527541;
        Wed, 30 Jun 2021 01:42:07 -0700 (PDT)
Received: from dell ([95.144.13.171])
        by smtp.gmail.com with ESMTPSA id d12sm18002529wri.77.2021.06.30.01.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 01:42:07 -0700 (PDT)
Date:   Wed, 30 Jun 2021 09:42:05 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Yunus Bas <Y.Bas@phytec.de>
Cc:     "stwiss.opensource@diasemi.com" <stwiss.opensource@diasemi.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: mfd-core: Change "Failed to locate of_node" warning
 to debug
Message-ID: <YNwuXWGe8am89Bn9@dell>
References: <20210616081949.26618-1-y.bas@phytec.de>
 <YMm+VXRrRKIHGgmr@dell>
 <5a3f5fd82a391ade9a659338983e5efa7924210d.camel@phytec.de>
 <YMsHXEP36Vxr7lAb@dell>
 <03cb3befabdda032b1ec9d97b4daac69fa23c759.camel@phytec.de>
 <YNsid9K4PdUJbKqs@dell>
 <5a718e7812f2ce46347ae94fda6175f38c65359e.camel@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a718e7812f2ce46347ae94fda6175f38c65359e.camel@phytec.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> No. This is not about DA9061 or it's mfd_cell-entries at all. My
> concern is about the general behaviour of the MFD-framework and how
> mfd_cell entries with compatibles are initialized.

I'm still not 100% sure I understand your use-case.

Let's take this back to basics.

What device are you trying to instantiate?  A DA9062 derivative?

> > Actually, this has served to highlight that your DTS is not correct.
> > 
> > Why are some devices represented in DT and some aren't?
> > 
> > If anything, I'm tempted to upgrade the info() print to warn().
> > 
> 
> Imagine only required parts of the MFD is connected to the designed
> system and unrequired parts are not. In that case, fully describing the
> MFD in the devicetree wouldn't represent the system at all.
> 
> Actually it would make more sense to check if mfd_cell-entries with
> compatibles are represented in the devicetree and add them after
> matching. This way the warning would serve it's purpose. What do you
> think of it?

I think the DT and MFD should match, so again, the way I currently
view this, doing it this way is just a different way to paper over the
cracks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
