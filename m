Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC923309DB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 10:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhCHJCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 04:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhCHJBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 04:01:44 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C838FC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 01:01:43 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id f22-20020a7bc8d60000b029010c024a1407so3306337wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 01:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MUaH7+fr5vYVOb9hsqFBaWwMCQH5+tHHSDiOUUhLamc=;
        b=QJaLoZ8d9LOLKJTQLV6D9acDSJDuvg7olRz0pvRYF5GXK6I8kgTthkCcex6G5Omj0p
         DuQXi0RDWDojkKX3Qy8CJfyyVCcTvfSw++94ohX2saG2oxzYsfD5RSgp/5m1kiNQEvam
         PhC0NNBC796PWDISX0Nos/3E8/YXAAbkRSBPA4BKO28pbu1xO9JxcUhLYDFla4qThRC0
         nWPQMZ1qgbnmGV0Ny/VIQ3AGUmU9BiqglHvtxXHu5Cj66+ZnprSYcNnd/EuPR9WhMxmm
         GPkVzcnHzJzUQWJ711jMKKI0rBLiwVqdt3mpN7Na2Rjs7MPhs2dm0lngbMO8Jx00C34Z
         dnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MUaH7+fr5vYVOb9hsqFBaWwMCQH5+tHHSDiOUUhLamc=;
        b=WeklzccMBkx/RrcEBtjDyn7A0SyQqhi/sYxA69bIpmDa3SUsTdvGGDhkt/5G5FLzP/
         ncgAev4xXn1s0dh1RiXBuNnVtuV13ADCLhhl+cW4WxNBVaxFVVuKGjMLYww3WCWJtJey
         42iQ3+mOtGUThYUZrUR5jSDpIkZtLeUGeeHVrYjTQKi3yqWSTq9bzSiLISa4utP9C+VZ
         yhMvytFGf3ZxLuNxtu4iWQFF0oBtPdSjhJ39P15KkK6C9T99xU8LwE8usN63vca9zEVN
         PsaBxNKx0IyfkRZzh+1cSsfsSAsMD0j4ZHgDaPIavFux8YUurk6430ZhreS6fSM4i3go
         kJ0A==
X-Gm-Message-State: AOAM5322Q2MwR9fxH7TabU3LdW/ET79SrNw3Tx1JIX6g/RuvClmCr012
        PWlpONnLTtWb7OenCwDfAAe1rQ==
X-Google-Smtp-Source: ABdhPJyFZrtFhtFuOYvUfQcTY5j5EJfCFALswDW1ZlVQUOcNFYFOJ88E8/oirRiM1lLro33elITSsQ==
X-Received: by 2002:a1c:cc14:: with SMTP id h20mr20932255wmb.14.1615194102495;
        Mon, 08 Mar 2021 01:01:42 -0800 (PST)
Received: from dell ([91.110.221.130])
        by smtp.gmail.com with ESMTPSA id x25sm18433888wmj.14.2021.03.08.01.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 01:01:41 -0800 (PST)
Date:   Mon, 8 Mar 2021 09:01:24 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     linux-kernel@vger.kernel.org, trix@redhat.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v3 0/4] Some improvement for Intel MAX 10 MFD drivers
Message-ID: <20210308090124.GA4931@dell>
References: <1614578385-26955-1-git-send-email-yilun.xu@intel.com>
 <20210308020454.GA32151@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210308020454.GA32151@yilunxu-OptiPlex-7050>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Mar 2021, Xu Yilun wrote:

> Hi Lee:
> 
> Could you please help on review this patchset? They are some
> improvements for intel-m10-bmc MFD driver.

Please don't send contentless pings 1 week after submitting a set.

Also please refrain from top-posting.

This patch is on my TO-REVIEW list.

Unfortunately, since I work in reverse chronological order, you just
pushed the set to the back of the list.

If after a suitable period, usually around 2 weeks, you think your
submission has been missed, please submit a [RESEND] instead.

> On Mon, Mar 01, 2021 at 01:59:41PM +0800, Xu Yilun wrote:
> > This patchset is some improvements for intel-m10-bmc and its subdevs.
> > 
> > Main changes from v1:
> > - Add a patch (#2) to simplify the definition of the legacy version reg.
> > - Add a patch (#4), add entry in MAINTAINERS for intel-m10-bmc mfd driver
> >   and the subdev drivers.
> > 
> > Main changes from v2:
> > - Add Tom Rix as the reviewer for intel-m10-bmc mfd driver and the subdev
> >   drivers.
> > - Rebased to 5.12-rc1
> > 
> > 
> > Matthew Gerlach (1):
> >   mfd: intel-m10-bmc: Add access table configuration to the regmap
> > 
> > Xu Yilun (3):
> >   mfd: intel-m10-bmc: Fix the register access range
> >   mfd: intel-m10-bmc: Simplify the legacy version reg definition
> >   MAINTAINERS: Add entry for Intel MAX 10 mfd driver
> > 
> >  MAINTAINERS                       | 10 ++++++++++
> >  drivers/mfd/intel-m10-bmc.c       | 25 ++++++++++++++++++-------
> >  include/linux/mfd/intel-m10-bmc.h |  7 +++++--
> >  3 files changed, 33 insertions(+), 9 deletions(-)
> > 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
