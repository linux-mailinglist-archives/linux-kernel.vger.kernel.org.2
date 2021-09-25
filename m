Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838954183B7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 19:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhIYRns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 13:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhIYRnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 13:43:47 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFDAC061570;
        Sat, 25 Sep 2021 10:42:12 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id v18so14260034edc.11;
        Sat, 25 Sep 2021 10:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IeR6I78v07QTr7GwuPjqPsC9KmUX8D77z/xH6y8yFI8=;
        b=IRAqRPzgfb+l3oosTcNuCrp/+4E0gI9cN8XAOxGuWL0Q86mesco1wT35ZtwEjsPg7O
         mVrG1YDvsUYZw33ZU0BzxOPLenOe+00qlat4v4mAl2f2FD7a3CAar45txxjbowsFXy6n
         cuG9C1NRRPeu+40lWz/N154oiu18PwHQJqe/xXBOmVFfqrCpkA2qjjehQ1IBDLhQYbXm
         RLRbbiW7YweqJRdWVgGHYujen/b2CvdlCsQ6hemxWRVWz7/CTkEWaSsji86pMxchJ0jk
         DoY9/T+PJJUEqfXgfoQk9WRCDeYiBg3zDLg2mIA+Ytwpig5Oxw45in0XnQyMSuHMbKvu
         WkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IeR6I78v07QTr7GwuPjqPsC9KmUX8D77z/xH6y8yFI8=;
        b=QuF9f/Pldni6UO8jXzKOVXTaBgfe/LCp2x2QzX8Kue3HF+DssoqU9EjcHM0UuSTmXa
         mjMimkgrZx4yQ1BqYI8IoCMgRzxGepU6UizhnXjlmVbzTYhoPWfpSQWyustXi9MYzVjn
         8lzdGYnghw3BMKrar8mn7acOhv2JHTCM1scfXhYcUqWe3csSKi7u8KojZP15nd6BVykq
         Y+MsQEOr64l7gL/MOVbDgE4LYtZycLUCuu0PYcmpjy1cTHTtkX8iueeVRfMJ72ScTIvg
         8OR5uVCrhEGJNBKlQCT2ktp+Iv5rKJEdChICsP9bu0k3JLS+Vlht9URvhPnOItqJCzgW
         tm8Q==
X-Gm-Message-State: AOAM531t/pXXGaw0BxGdSSj8UAedd8i6Z6oy6hNvudlvY5oAXxGeMtvY
        AW//PsBXGVszl8iwf0LegNuTGgJDLcNIJKHbQ+8=
X-Google-Smtp-Source: ABdhPJw4TvWMdEO0MgDEFaxjkEHiKZXec68E1FwOLvkbn3swXGq+JhkZppepiqKsD9J2+Mhv0mlMjMZvOL7r42tie7U=
X-Received: by 2002:a05:6402:319a:: with SMTP id di26mr12638279edb.84.1632591730983;
 Sat, 25 Sep 2021 10:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210817041548.1276-1-linux.amoon@gmail.com> <20210817041548.1276-2-linux.amoon@gmail.com>
 <c7f6213b-5ddc-881c-1aea-9cc7b03e6a4f@baylibre.com> <CAFBinCBeNMET2tvH0h6HF3dR+xBb59hifQyaoXigUs3UGkS+KQ@mail.gmail.com>
 <2b07b3de-cee5-c570-8fde-6a4c684122d6@baylibre.com> <CANAwSgRNp8UtU+Yy4smwZ5POTWTU+xN1mrf_cH7Pu9yX5HU=VA@mail.gmail.com>
 <CAFBinCDmNt+aXRE4xFZdegOUs8BqJiTPF3+DQ-buvWWXrQLkdw@mail.gmail.com>
In-Reply-To: <CAFBinCDmNt+aXRE4xFZdegOUs8BqJiTPF3+DQ-buvWWXrQLkdw@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Sat, 25 Sep 2021 23:11:58 +0530
Message-ID: <CANAwSgTcTCNWD3QTt4-c8BeAbFxDewbZewaSouggPuK9cpSXog@mail.gmail.com>
Subject: Re: [PATCHv3 1/6] ARM: dts: meson8b: odroidc1: Add usb phy power node
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Matt Corallo <oc2udbzfd@mattcorallo.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Emiliano Ingrassia <ingrassia@epigenesys.com>,
        Brian Kim <brian.kim@hardkernel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Tue, 21 Sept 2021 at 00:56, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Tue, Aug 31, 2021 at 10:48 PM Anand Moon <linux.amoon@gmail.com> wrote:
> [...]
> > After enabling CONFIG_REGULATOR_DEBUG, with this patch applied
> > I still not getting the USB regulator to enable.
> > Do you see different output at your end?
> I don't have much time for testing and debugging currently but I'll
> put it on my TODO-list
> Until either of us has found the issue I suggest not merging this patch.
>
Ok no problem.

Basically, I have just roughly gone through the architecture of
Amlogic's OTG framework.
Below is the global configuration registers for DWC2 OTG framer work

[0] https://github.com/hardkernel/linux/blob/odroidc-3.10.y/drivers/amlogic/usb/dwc_otg/310/dwc_otg_regs.h#L66-L151

Within some configurations, it helps tune the power for vbus and interrupt
For example
[1] https://github.com/hardkernel/linux/blob/odroidc-3.10.y/drivers/amlogic/usb/dwc_otg/310/dwc_otg_attr.c#L666-L717

Amlogic basically used the mode parameter to external tune the DWC2 driver
it could help more fine-tuning the driver.

[2] https://github.com/hardkernel/linux/blob/odroidc-3.10.y/drivers/amlogic/usb/dwc_otg/310/dwc_otg_driver.c#L1461-L1703

I feel we need to identify many more PHY tuning parameters to make the
USB work correctly.






Thanks
-Anand

>
> Best regards,
> Martin
