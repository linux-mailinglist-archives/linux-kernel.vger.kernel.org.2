Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1454B346E62
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 01:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbhCXA5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 20:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbhCXA4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 20:56:42 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B102C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 17:56:42 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id u19so13496592pgh.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 17:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h2JtxWq5KlA+aTENrci0BbTIjTR5pL1ehPUfioP17ww=;
        b=mdylSgtzUAZCVGwTE47jvcDg5m6W4yNItz32xBuv2n0FJcK5bOI46eXiRKAVhmX5gN
         v69Nc0v05jAQnjH1z50jxw9BfEssWsZemkNU4hdTyWudysyU8wYf6eOMsvynYbEKRHMI
         OwFtpSlbp1dZzAcCPai22SxLKgViyL6wyOqr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h2JtxWq5KlA+aTENrci0BbTIjTR5pL1ehPUfioP17ww=;
        b=EU8LiZ7eQOMDRodAyyPayfscc/SfFF2hqmh3VmAfur+ec3E0CQgguEIFxh3DQkRfE2
         tV98Uor1vu4z2FYuvSymtTgRuDwUoII58qrh3WMW09d5yzuL+60Sr4/8ERHRvWTSEGfF
         Nmjdvlxit1KvmUeR2W2H6qvkOcEOLhCr44bnxL/sHPU1Y2HkFE7OeWEUKfpUTz3AJLyJ
         0ywX0uoVCT21Vhaq3T9kzd6gAXFw/80vGbyDMVJ5r699HjhCGlkmY8C64brmrsqDGOcc
         CG4prwWGioMFm72PJ4AQBFIO3JBAFd4jmg5X70LT2cchJcO0uDdkwJ5oTSWycDK1hogm
         U1uQ==
X-Gm-Message-State: AOAM531dMek9lFN667e34s7Mhx0AlJIz0cIUf6PnAlbDViRJQPHft9sy
        VC5IYGD2xyQl087EEEmf4h1WjA==
X-Google-Smtp-Source: ABdhPJziJ3JXAD6m13EcNQP6pdLqzU32BKmPDBLBzBkozEcZ6Z2/VNUa4r5mBZE4Sm0f/1kY6upfBQ==
X-Received: by 2002:a62:1997:0:b029:1ed:5de5:5f1c with SMTP id 145-20020a6219970000b02901ed5de55f1cmr527401pfz.14.1616547401706;
        Tue, 23 Mar 2021 17:56:41 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:40a3:9725:46c3:85f6])
        by smtp.gmail.com with UTF8SMTPSA id 186sm356171pfb.143.2021.03.23.17.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 17:56:41 -0700 (PDT)
Date:   Tue, 23 Mar 2021 17:56:39 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sandeep Maheswaram <sanm@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>
Subject: Re: [PATCH v5 3/4] usb: dwc3: qcom: Configure wakeup interrupts and
 set genpd active wakeup flag
Message-ID: <YFqORzIw5WOLyDwm@google.com>
References: <1616434280-32635-1-git-send-email-sanm@codeaurora.org>
 <1616434280-32635-4-git-send-email-sanm@codeaurora.org>
 <YFna5mxrJAzR2s0g@kroah.com>
 <YFqMivRlDllNuqu/@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YFqMivRlDllNuqu/@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 05:49:14PM -0700, Matthias Kaehlcke wrote:
> On Tue, Mar 23, 2021 at 01:11:18PM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Mar 22, 2021 at 11:01:19PM +0530, Sandeep Maheswaram wrote:
> > > Configure interrupts based on hs_phy_mode to avoid triggering of
> > > interrupts during system suspend and suspends successfully.
> > > Set genpd active wakeup flag for usb gdsc if wakeup capable devices
> > > are connected so that wake up happens without reenumeration.
> > > Add helper functions to enable,disable wake irqs.
> > 
> > That feels like a lot of different things all in one patch.
> 
> Sandeep: one thing you could do to reduce the churn is to add
> dwc3_qcom_enable/disable_wakeup_irq() in a separate patch, without
> any functional changes. Then this patch would only add the different
> branches based on the PHY mode.
> 
> The handling of the power domain could probably also be done in a
> separate patch, if I recall correctly it is only an optimization.

Actually another thing that could be in a separate patch is enabling
wakeup support based on 'wakeup-source'. That's not even directly
related with this series.

With all that you'd have fairly atomic patches and it should be easy to
write meaningful commit messages.
