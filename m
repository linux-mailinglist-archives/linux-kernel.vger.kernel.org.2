Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2F541B406
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 18:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241864AbhI1Qjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 12:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241841AbhI1Qjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 12:39:54 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42F7C061749
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 09:38:14 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id r1so32977864ybo.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 09:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NidJhDFKleQVXlEZfqCJKrel6vUdjqPR6YuC5wFIREs=;
        b=VaOO6PWInASpyJkK+NCUu7r06A85FElDK+VCiYMAWxx41ZXkhpPaJ4gvQAZdFV7yXE
         rhMZ/bB+Di2JPC0yeZcB5c79kPLmix7zSmNr1GW8+vM4CYQypuKYcYEm9vLpDdY13I/t
         UTUOuoJApZDWuGKPCRm/edwlKn7HXnISzfij5d7r07Vqc5koana6ZBbvdkJJokO6y5Eq
         kHpvkHD6TbS1pxOG+Kth7Qlte25LP8+7gABsjPPbq618aDWKWa5cc6L2RFIj4UfVpCC4
         7+WLhGm0IMFLcNAcGi/n7ZdmLJFVwC2xCDbGMEvGosa6doPy4aGdol4lIzZtir+Fsje/
         olkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NidJhDFKleQVXlEZfqCJKrel6vUdjqPR6YuC5wFIREs=;
        b=yjdKVU/ngkGdJZgR5u9mxEJE04tLbFXN1McuvdsLIZXFH3J+Yh8uO/6VP1gvjVPfZe
         E8xZANsVjsWwwN6XIXSC/uuwSzDpKpvXEUajOhkF1K1uac7j+VXC1qoRL6X+2tqf/M2H
         oJHt/6V4tD3DxD1kiCKYaFE4sfbWjYOkhHPqDG+PkEnv9X8CGx49Q5quFtM6qhVeVcgi
         t6fCVAGfL2vg6uzZ5MNIMf9CAQHJ46kEGiIwizmGLDPn0M7cBt9Bkp3Jdt+0n9L6J5Gc
         05jPq2Q/sfhXM3gO36PACGYeAI6Y2x4OI2xn5EMcvonC8a3mrcmnGbhnNwqRVQuh4nMO
         0DOw==
X-Gm-Message-State: AOAM532qRsQW+n9NNZaEXEvJ0Ms6mhzu7mu+hClMALvEt+bgsddmsaMB
        KQb+5tq6pZacmEqeiChDfDGvGjwvNK1wRGWFbmNAxA==
X-Google-Smtp-Source: ABdhPJyexz0v4kSqFZ9qeYAlNw+MyCoD5uulH8/ODMbblguUJ/vUtCAhclfCvhFYok2NfKJqLxRpbX3rD+QF+59idGw=
X-Received: by 2002:a25:4684:: with SMTP id t126mr6335213yba.476.1632847092780;
 Tue, 28 Sep 2021 09:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210927204830.4018624-1-dmitry.baryshkov@linaro.org>
 <CAGETcx-3Y3rOSoXu3SbDa6BP_jcT8uSQA+MV55QCY4b0Oe7L-A@mail.gmail.com>
 <11fe1793-1455-ae44-b213-9afe47dfa370@linaro.org> <CAGETcx_HRmvDKuXQEJkMk7zBpedLGkQmvJ24tAWpCHFf4DPX_w@mail.gmail.com>
 <YVMK90kRtkBxptlR@kroah.com>
In-Reply-To: <YVMK90kRtkBxptlR@kroah.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 28 Sep 2021 09:37:36 -0700
Message-ID: <CAGETcx_7hgF_mk+fh6Bk1VvGm=2t1gZ_P2C4+N2Ai0V6jEkpxw@mail.gmail.com>
Subject: Re: [PATCH] Revert "of: property: fw_devlink: Add support for remote-endpoint"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 5:30 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Sep 27, 2021 at 06:13:12PM -0700, Saravana Kannan wrote:
> > On Mon, Sep 27, 2021 at 5:56 PM Dmitry Baryshkov
> > > root@qcom-armv8a:~# ls -l /sys/bus/platform/devices/88e9000.phy/
> > > lrwxrwxrwx    1 root     root             0 Aug  4 15:13
> > > consumer:platform:a600000.usb ->
> > > ../../../virtual/devlink/platform:88e9000.phy--platform:a600000.usb
> > > lrwxrwxrwx    1 root     root             0 Aug  4 15:13
> > > consumer:platform:af00000.clock-controller ->
> > > ../../../virtual/devlink/platform:88e9000.phy--platform:af00000.clock-controller
> > > -rw-r--r--    1 root     root          4096 Aug  4 15:13 driver_override
> > > -r--r--r--    1 root     root          4096 Aug  4 15:13 modalias
> > > lrwxrwxrwx    1 root     root             0 Aug  4 15:13 of_node ->
> > > ../../../../firmware/devicetree/base/soc@0/phy@88e9000
> > > drwxr-xr-x    2 root     root             0 Aug  4 15:13 power
> > > lrwxrwxrwx    1 root     root             0 Aug  4 15:10 subsystem ->
> > > ../../../../bus/platform
> > > lrwxrwxrwx    1 root     root             0 Aug  4 15:13
> > > supplier:platform:100000.clock-controller ->
> > > ../../../virtual/devlink/platform:100000.clock-controller--platform:88e9000.phy
> > > lrwxrwxrwx    1 root     root             0 Aug  4 15:13
> > > supplier:platform:18200000.rsc:clock-controller ->
> > > ../../../virtual/devlink/platform:18200000.rsc:clock-controller--platform:88e9000.phy
> > > lrwxrwxrwx    1 root     root             0 Aug  4 15:13
> > > supplier:platform:18200000.rsc:pm8150-rpmh-regulators ->
> > > ../../../virtual/devlink/platform:18200000.rsc:pm8150-rpmh-regulators--platform:88e9000.phy
> > > -rw-r--r--    1 root     root          4096 Aug  4 15:10 uevent
> > > -r--r--r--    1 root     root          4096 Aug  4 15:13
> > > waiting_for_supplier
> > >
> > > Thus it is not possible to spot this device link without
> > > CONFIG_DEBUG_DRIVER=y (or any similar debugging technique).
> >
> > I sent out some patches to make this easier. But doesn't look like
> > it'll land in 5.15.
> > https://lore.kernel.org/lkml/20210915172808.620546-1-saravanak@google.com/
>
> I have now queued these up to make it into 5.15-final, this thread has
> convinced me :)

Thanks :)

-Saravana
