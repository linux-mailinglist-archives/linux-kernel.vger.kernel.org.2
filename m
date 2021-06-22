Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08FF3B073B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 16:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbhFVOUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 10:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbhFVOT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 10:19:57 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A66C061766
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 07:17:41 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id 17so3236260qtt.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 07:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lI1CGYho/79qaVk4ajAhdU3sl6kD5lr0csW+7Y9UryM=;
        b=KE0AlCEEZ1+U8kg+l418asb139t/GShpu5pbfYsvxp8pFAyL2ltzjEkEZL3ECmXkmx
         ZBONjF0IjYgMZzB4KhuXzwtahLr2XjImP9IuyOz/N+mMV/Gul8uByxaTCp03OISZoolG
         JfOHgADpGV663PWMgfI8do2gKB0QBJOvFifZ3m4hdXuI1cngGwNOCQaRYprYSr0nzhG2
         eiIy0J7sEzOT3VD+kp2TWd4Ed3U7Q8/lOPHuQYfP6Sk0vf2eUPRjKzwMfyBLcH+wAKrj
         qBHSMX5QiXzE3nZfdKDPCR5qfxovl+X4InOewCdtbQSt0L9lFgi+jwyIXxnH1T89ikzO
         idYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lI1CGYho/79qaVk4ajAhdU3sl6kD5lr0csW+7Y9UryM=;
        b=mck6dGNsWuf3/lLhKffzXZ22LLuRP6AXuWSjHVT32Kow5WbWgzGkDhnE3pi6gTEzGY
         D8+45eGFMcM3bbgpTzF5qRNmYrwKQAAbLyABSSV5jve1O4kN0bwkUIuaIbPbv7v7yPb3
         UQwKJWcDTCmUTpWAXnQ8XqGSIzs4aR4+T1fwLTUJ1JR/BtsLzLW9c9JF5PLj/B+Llnup
         sWv3sWta4uG5VlFN42R7NakGIEkR5N5qFzoMwsPFohPT5JtnM2oU9ptJi2jQTIAHyMJW
         knbfcpWPsMkZgZHW+Imq/pfZyB0R5+eN91eh8GhX6HNC7EW5ibfxA92V0wJX7rHlHphh
         +aXw==
X-Gm-Message-State: AOAM533BoHKDTwi6cUaxRx3K0h19Ya1icI4B6OTCIHCXEcS8a3YhPHI0
        jb0fN1klUia1RTyz8T53gPl5AGROzZkD/ekvZdQheQ==
X-Google-Smtp-Source: ABdhPJxtA2MrKV6nOcIRw7RyX7tXe4SI4vNTSA8HWvzEVkasMro+kyUnsPgYGorj3GwFAXHE4yczHQMn+iDjFsqnsQk=
X-Received: by 2002:ac8:59c8:: with SMTP id f8mr3647160qtf.238.1624371460518;
 Tue, 22 Jun 2021 07:17:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210621223141.1638189-1-dmitry.baryshkov@linaro.org>
 <20210621223141.1638189-3-dmitry.baryshkov@linaro.org> <20210622112843.GB4574@sirena.org.uk>
In-Reply-To: <20210622112843.GB4574@sirena.org.uk>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 22 Jun 2021 17:17:28 +0300
Message-ID: <CAA8EJpoTdg3O6dzpTaNS5fJRbtb1Fndv0mEuO+e4b6XCmuvzhQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] regulator: qca6390: add support for QCA639x
 powerup sequence
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jun 2021 at 14:29, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Jun 22, 2021 at 01:31:36AM +0300, Dmitry Baryshkov wrote:
>
> > Qualcomm QCA6390/1 is a family of WiFi + Bluetooth SoCs, with BT part
> > being controlled through the UART and WiFi being present on PCIe
> > bus. Both blocks share common power sources. Add device driver handling
> > power sequencing of QCA6390/1.
>
> Are you sure this is a regulator and not a MFD?  It appears to be a
> consumer driver that turns on and off a bunch of regulators en masse
> which for some reason exposes that on/off control as a single supply.
> This looks like it'd be much more appropriate to implement as a MFD or
> possibly power domain with the subdevices using runtime PM, it's clearly
> not a regulator.

First attempt was designed to be an MFD. And Lee clearly stated that
this is wrong:
"This is not an MFD, since it utilised neither the MFD API nor
of_platform_populate() to register child devices." [1]

I've attempted implementing that as a genpd (in previous iterations),
but it results in worse design. PCIe controllers are not expected to
handle power domains for EP devices, especially in cases when the PD
must come up before the controller does link training and bus probe.
I've tried following Rob's suggestions on implementing things clearly,
but doing so results in too big restructure just for a single device.

> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2021, Linaro Limited
> > + */
>
> Please make the entire comment a C++ one so things look more
> intentional.

Ack.

>
> > +static int qca6390_enable(struct regulator_dev *rdev)
> > +{
> > +     struct qca6390_data *data = rdev_get_drvdata(rdev);
> > +     int ret;
> > +
> > +     ret = regulator_bulk_enable(data->num_vregs, data->regulators);
> > +     if (ret) {
> > +             dev_err(data->dev, "Failed to enable regulators");
> > +             return ret;
> > +     }
>
> The regulator API is *not* recursive, I am astonished this works.

It does, even with lockdep enabled. Moreover BT regularly does disable
and enable this regulator, so both enable and disable paths were well
tested.
Should I change this into some internal call to remove API recursiveness?

>
> > +     /* Wait for 1ms before toggling enable pins. */
> > +     usleep_range(1000, 2000);
>
> There's core support for delays after power on, better to use it.

Ack.

>
> > +     data->enable_counter++;
>
> You shouldn't assume that enable and disable calls are matched.

Ack.

--
With best wishes
Dmitry
