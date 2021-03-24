Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14DC6346E57
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 01:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbhCXAti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 20:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbhCXAtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 20:49:18 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131C8C0613D9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 17:49:18 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id s21so10856299pjq.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 17:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pqlDAkfpFxPvtCYcs4rpRWhh2vQJErVgPPsfWn8QpKE=;
        b=NMbztM4I619xLFkutZ9T3xKcbWtEQumZDAH4+TzP5UeHAXdbRCmG+ik1Gwrl+skzEh
         4kheY1dwKvniJdmn3cmFutU2xCahjejs7pRg9M7leVP9nzua4+RoMi0oPOJ7RXVbqMj8
         pyJvHHqmSYOliRyhTW08AmBGcFiXMc/L7X3Jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pqlDAkfpFxPvtCYcs4rpRWhh2vQJErVgPPsfWn8QpKE=;
        b=U4Y0L2qTCQebDV9Eu6OY+LtCeeWZHr1JUXJeOm7UD9WC4jXYwy7D4gIlsSH/Ce1jcu
         tgfe/Yr2qrv67Kdqw7I3/InQ4H9CHoPI8dUrOGXsnUTYUJIZlYmt9ruTLyHTTzVIU7Px
         57++BMjC5mv+jD7jbhO3KLmNXBlgGK4EzstiC8nHFJ3JFuen90d8iVP8O3A02DvBW3xa
         lMiD8YQKDGcKsiy++MFrpxKGQcc8cl137/L48w8BVVS3m2Z4q5X2wE3bM4PrxjIey70c
         iXZRiCkeBewAMsOjmjcZBUzEbqiX4NhgznjPCbrj2y3oR21Ad0XDPSKNzw1cUK5jI1nK
         5BPg==
X-Gm-Message-State: AOAM5300GqksjygM8aJBbTiy6LE3VeZjU0nlCARmt7gj3hq1w2XTkz9y
        Yft+qhDM04ZSR3uX7r3EkSUJAg==
X-Google-Smtp-Source: ABdhPJyvh4woIN16EDJ0HLxyAHCrRhNd5iy6Y6QmH6u4YlHQwt/o8oJwXx9AGorbf/T0wQ9vH02vaw==
X-Received: by 2002:a17:903:30c3:b029:e6:5008:f7a7 with SMTP id s3-20020a17090330c3b02900e65008f7a7mr1017020plc.73.1616546957382;
        Tue, 23 Mar 2021 17:49:17 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:40a3:9725:46c3:85f6])
        by smtp.gmail.com with UTF8SMTPSA id w203sm344685pff.59.2021.03.23.17.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 17:49:16 -0700 (PDT)
Date:   Tue, 23 Mar 2021 17:49:14 -0700
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
Message-ID: <YFqMivRlDllNuqu/@google.com>
References: <1616434280-32635-1-git-send-email-sanm@codeaurora.org>
 <1616434280-32635-4-git-send-email-sanm@codeaurora.org>
 <YFna5mxrJAzR2s0g@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YFna5mxrJAzR2s0g@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 01:11:18PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Mar 22, 2021 at 11:01:19PM +0530, Sandeep Maheswaram wrote:
> > Configure interrupts based on hs_phy_mode to avoid triggering of
> > interrupts during system suspend and suspends successfully.
> > Set genpd active wakeup flag for usb gdsc if wakeup capable devices
> > are connected so that wake up happens without reenumeration.
> > Add helper functions to enable,disable wake irqs.
> 
> That feels like a lot of different things all in one patch.

Sandeep: one thing you could do to reduce the churn is to add
dwc3_qcom_enable/disable_wakeup_irq() in a separate patch, without
any functional changes. Then this patch would only add the different
branches based on the PHY mode.

The handling of the power domain could probably also be done in a
separate patch, if I recall correctly it is only an optimization.
