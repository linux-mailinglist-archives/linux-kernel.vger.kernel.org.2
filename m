Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC3C3C8687
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 16:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239502AbhGNPCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 11:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbhGNPCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 11:02:37 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087EEC061762
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 07:59:45 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id h9so2576991oih.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 07:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nTz18Jk122sS3DksvsV26XHaiOTs4W7MgSnZfV6Ve8w=;
        b=cAhFYtUFFghd3ORohdXDzi+zJ9cgiPev8KqUU9qg5EuMo/4ZyT/PjlYBv/C7KUT2a6
         2lDpCbDxs0mf30o0XwaJyhkp8PtKRhJX8geGdVz8tVEccGHzPRHN5XkyzOO0GZC85MJv
         TipVjVCCbhMNxWOLkIdc+V3MSbg+j2O6SZ0Ftto8xgcd//fV6OjmlejEk/qrAnXxOuBU
         EJDtdVH+9v/hzb0J/kW2CG4LCnUfCeePqiSjR5yhMcKgE+pQRCh8higXJ0jF5ATuDrs/
         W2D885YFFfu4G0+zyjtoDuiHhrxeaUQ4W1K2dabd2WXgYRABwKwfNN9hxP0IJykPWYhO
         mANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nTz18Jk122sS3DksvsV26XHaiOTs4W7MgSnZfV6Ve8w=;
        b=Z0opOTQspCvCSEz4HMAP/NRA40hGJBiTZQ2L2VYs4YtPgR7H7YYaNbNcshAd5lbzg3
         gQlllHrpUvgthA1X7CelVE6Kxc+XceLMhEi0/RGgBzFRpyVK4KPtpELfgeidg+lCsTwp
         kGOabQZ9PAXD6XfJiTk0Zt7yIGcBzmsLOJFj3E10LWZe4Gguau4IzgGhpC1W+53lrGEg
         WeJq5U4SDvgy1fVrYrPRF27THs5HjFEHtA4HKVwuH/ZOLbv/sCWKDm4N1Db2EgsEUT2l
         Ny7hxmEuAan5PJpCHOZR2PI+ag/FyJJCK6iWzY4Nlczujns6wUvlZkxCsKYFlrBJrJkt
         3gsg==
X-Gm-Message-State: AOAM533PyStvL5qS3hF1zxYMUeCt5B//X3cgw+AY4BS6T1NHBlOgOM5h
        CMSUWvgbQLDNBShkRbub4ysPjQ==
X-Google-Smtp-Source: ABdhPJzpWIEmodrbCajE5SWtgbSG8/UkT7KoEn+NDfJjdtMeySYmd9SbwyGak1dfUWnVpWcliCBvxQ==
X-Received: by 2002:aca:bb41:: with SMTP id l62mr7638839oif.113.1626274784340;
        Wed, 14 Jul 2021 07:59:44 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id c34sm516369otu.42.2021.07.14.07.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 07:59:43 -0700 (PDT)
Date:   Wed, 14 Jul 2021 09:59:41 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     John Stultz <john.stultz@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: Re: [PATCH 29/29] arm64: dts: qcom: Harmonize DWC USB3 DT nodes name
Message-ID: <YO773RXaezcLNREX@yoga>
References: <20201020115959.2658-1-Sergey.Semin@baikalelectronics.ru>
 <20201020115959.2658-30-Sergey.Semin@baikalelectronics.ru>
 <CALAqxLX_FNvFndEDWtGbFPjSzuAbfqxQE07diBJFZtftwEJX5A@mail.gmail.com>
 <20210714124807.o22mottsrg3tv6nt@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714124807.o22mottsrg3tv6nt@mobilestation>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14 Jul 07:48 CDT 2021, Serge Semin wrote:
[..]
> As Krzysztof said in
> https://lore.kernel.org/lkml/20201221210423.GA2504@kozik-lap/
> and Bjorn noted in his response to your email, the only way to solve
> the problem is to fix the user-land app so one would be able to deal
> with both old and new DT-nodes name.

How do you suggest this to be done? The userspace ABI in question is
used to bind a USB gadgets to the particular USB controller, using the
device name of the USB controller.

> Alternatively you can just
> replace the dts with older one, where the name still have
> the "dwc3"-prefix.
> 

This is exactly what Linus has mind when he tells us not to break
user space.

Regards,
Bjorn
