Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0802141C082
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 10:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244648AbhI2IWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 04:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240284AbhI2IWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 04:22:54 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EBFC06161C;
        Wed, 29 Sep 2021 01:21:13 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id h11-20020a4aa74b000000b002a933d156cbso511930oom.4;
        Wed, 29 Sep 2021 01:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lgf3K3VLK2P72k3X7tYE68TbO1QXLr6qgwQW6hpUoFI=;
        b=lXi/4LCb9nFg8wzNr+NfGtsOsG94Ghr2L1CAJ4hamrqr9BomEUzxXJm+Jg4HYUB3b+
         W6oVgaTy8LSQjYFaDzgsF4WLuFM7KQLJ65UbqzcUFI3r2EUZA0icodEnkRamJY4C9YlJ
         Ermr/YVY0KEJacrKA+vUkecR6nP08URzmUSSaTuOebAwYmgbslBkm2V8rvfLZxNu5UsM
         aVN4T3VTsXNw/aPVPTf1so30sMmuP4nMCuJFlwujllUcDFzSJa0QaOLz8rKatQ2LEqsW
         DjoFOkkf3uENLmUvM17973UEKpOZSdvDVOP9Nvz4+a93p1/RrsayD01sIukizp77gVhE
         Bs+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lgf3K3VLK2P72k3X7tYE68TbO1QXLr6qgwQW6hpUoFI=;
        b=HgMJmSMMYx6LDlif0JUixa+L0DbCjFgOlYx9ASblLPVhq61uTy+Fkwh0lKVA7mWT8c
         RdLaJfuY4hilsfbbA82+smMcVgthvUzi2v4FxCqL6z7ZwN/n1p/H0DogX7DeQhUgKHT7
         lSwE6B8YnTRb5UvVnVfLDxgRNSIkkEsjhLpF+bmAcKOl2jgls0SNlXTG/s62e5l90VbW
         34G0lzM+wvVqETAkoFzGQStnCnvibkUWNM+FaWQp719BUrm677nU4cgXuC79xdshaiEF
         LTPFJk7yWEMgGzAOROt0db4bgZmZLMH20XwD3HJZybhYJEGafG+J9usrITl/vJ2D8YzQ
         7+LQ==
X-Gm-Message-State: AOAM530hZXeFRH2e32ZklvACTGuP4S4JQt5Q088awY0o8D+Gj660gy1z
        MaumkfauuQZRKjmabfXexcCmze2cVOiENXNtqGM=
X-Google-Smtp-Source: ABdhPJyFk57sQfd60jBhJBLcHvOBXc+qq/bLZjiO2gs+tNB1o60Man3Q4/u91y0Rb0hIXVgFZkPA6Q5hlSTg+BckX+o=
X-Received: by 2002:a4a:ba90:: with SMTP id d16mr8573117oop.31.1632903673078;
 Wed, 29 Sep 2021 01:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210928073609.198975-1-zhang.lyra@gmail.com> <20210928113057.GJ4199@sirena.org.uk>
In-Reply-To: <20210928113057.GJ4199@sirena.org.uk>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Wed, 29 Sep 2021 16:20:37 +0800
Message-ID: <CAAfSe-vM8iG1OtQeVR1CxQtpvA8kqSs3pJ78RQQOL7GcWcTwSw@mail.gmail.com>
Subject: Re: [PATCH 1/2] regulator: Add Unisoc's SC2730 regulator driver
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sept 2021 at 19:31, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Sep 28, 2021 at 03:36:08PM +0800, Chunyan Zhang wrote:
>
> > +++ b/drivers/regulator/sc2730-regulator.c
> > @@ -0,0 +1,502 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2018-2021 Unisoc Inc.
> > + */
>
> Please make the entire comment a C++ one so things look more
> intentional.

Ok.

>
> > +static int debugfs_enable_get(void *data, u64 *val)
> > +{
> > +     struct regulator_dev *rdev = data;
> > +
>
> > +static int debugfs_enable_set(void *data, u64 val)
> > +{
> > +     struct regulator_dev *rdev = data;
> > +
>
> > +static int debugfs_voltage_get(void *data, u64 *val)
> > +{
>
> > +static int debugfs_voltage_set(void *data, u64 val)
> > +{
>
> If these were to be implemented they should be in the core as there's
> nothing device specific about them (the read side is there), please
> remove them from the driver.

Ok.

>
> > +static const struct of_device_id sc2730_regulator_match[] = {
> > +     { .compatible = "sprd,sc2730-regulator" },
> > +     {},
> > +};
> > +MODULE_DEVICE_TABLE(of, sc2730_regulator_match);
>
> Since this is a part of a MFD I'd not expect it to have a compatible
> string?

Since we switched to use devm_of_platform_populate() [1] to register
MFD subdevices, compatible is required, IIUC.

[1] https://elixir.bootlin.com/linux/latest/source/drivers/mfd/sprd-sc27xx-spi.c#L199

Thanks for the review,
Chunyan
