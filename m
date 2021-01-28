Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D829D307BC8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 18:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbhA1RHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 12:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbhA1RGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 12:06:16 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9641BC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 09:05:35 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id i141so6146812yba.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 09:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZU1E+hwpvXYdTh/qIiNM8VSWMHxSs6gIkqcZKacaSJk=;
        b=hMon+a8pCGyQX1TKt2MYK5I3raPQgYl51+v7F+rYC1j4LnbNfSMIGlit5el71iyTzg
         L7wF2BfV0lHSzLa1rhuEyq5b5q8MH4egbQKzk/E9DcA1wnjj4U0thuNpqrnvsCOuKVXG
         aJrMyGKZbpKWpICk0d8V6EFKUw3QXG/APqW0Fi+IMkO0dyEmh4+iQGwfDNNmitWtg1DS
         nnA6K/WLX0ysU0SJXkfKK0ExIc1W9fzmDrxCLx1I/Wo/yF22EHv2wlMqpd9SL/xBXYHB
         6g5MfG4sezXYC0kefJWJT+0AEYqY1g+xl6t/uzvSuu288GE21AYepcLtTcXrUIGfrkmK
         YOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZU1E+hwpvXYdTh/qIiNM8VSWMHxSs6gIkqcZKacaSJk=;
        b=LMfgJ8WoylVLWkevJYkGP8gW6jFbBAljMlxslfEDKijR3W6BTyu3GjR4p4U2dQUBcb
         4Jb9jo9K7wLAUfW32t2lo7f751ZMmxklDj1cEBqHc+m1EKtUuppYEpUUPck2aNqTKDNX
         EVVmG3riiyWsBWx4/rDMC9Q9CbsssEe+rq1Lug4yg2sjDEZGxMTQV1jc/eEdUAC5wpvq
         iTh6OSx2+g7ieNQr1UTxT+oeCdOxK04fxmVq56BNyRs3cGqdgrVlhSYp6E3a/dr6xTMw
         wjD21J0eR1XaydSsGeQIELWDRmciz7e5irwywENiwJH8gBxbVDRsQ673ako4D3L5mVmO
         kH2Q==
X-Gm-Message-State: AOAM532eGrp9GtR3XTNm4oHcER8jRM7w/3dRLCN74sjmf/5GO1jR6tb2
        5vZRUGIhYy8tIwMdfgg5eF5ifK7WWjk1PBqx9H6nAg==
X-Google-Smtp-Source: ABdhPJzjk3EwCrbDets63MKERWUm51YIKaub5GTzoMd8q8rnmWTtHgYBA8eGrfBsHJyhg/WhEf9ZPqinY2NNjIZVRf8=
X-Received: by 2002:a25:718b:: with SMTP id m133mr196558ybc.412.1611853534659;
 Thu, 28 Jan 2021 09:05:34 -0800 (PST)
MIME-Version: 1.0
References: <20201218031703.3053753-1-saravanak@google.com>
 <20201218031703.3053753-6-saravanak@google.com> <6ca35fea-3c67-127d-2190-a34c0318a5a3@microchip.com>
 <CAGETcx-sZC4nKi9VKYUgaBnH4Kf3FraKEe+CMXxm_-DWjz9t5w@mail.gmail.com> <97a1fe96-ee2c-43cf-58fe-6ed910d3fb2c@microchip.com>
In-Reply-To: <97a1fe96-ee2c-43cf-58fe-6ed910d3fb2c@microchip.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 28 Jan 2021 09:04:57 -0800
Message-ID: <CAGETcx-GbSEYxWTB+sDQCh9-sQmKi=ejcBf=036YeQhY-DQu9A@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] driver core: Set fw_devlink=on by default
To:     Tudor.Ambarus@microchip.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Kevin Hilman <khilman@baylibre.com>,
        John Stultz <john.stultz@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Marc Zyngier <maz@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nicolas.Ferre@microchip.com, Ludovic.Desroches@microchip.com,
        alexandre.belloni@bootlin.com, Claudiu.Beznea@microchip.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 2:59 AM <Tudor.Ambarus@microchip.com> wrote:
>
> Hi, Saravana,
>
> On 1/25/21 8:16 PM, Saravana Kannan wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > On Mon, Jan 25, 2021 at 9:05 AM <Tudor.Ambarus@microchip.com> wrote:
> >>
> >> Hi, Saravana,
> >>
> >> On 12/18/20 5:17 AM, Saravana Kannan wrote:
> >>> Cyclic dependencies in some firmware was one of the last remaining
> >>> reasons fw_devlink=on couldn't be set by default. Now that cyclic
> >>> dependencies don't block probing, set fw_devlink=on by default.
> >>>
> >>> Setting fw_devlink=on by default brings a bunch of benefits (currently,
> >>> only for systems with device tree firmware):
> >>> * Significantly cuts down deferred probes.
> >>> * Device probe is effectively attempted in graph order.
> >>> * Makes it much easier to load drivers as modules without having to
> >>>   worry about functional dependencies between modules (depmod is still
> >>>   needed for symbol dependencies).
> >>>
> >>> If this patch prevents some devices from probing, it's very likely due
> >>> to the system having one or more device drivers that "probe"/set up a
> >>> device (DT node with compatible property) without creating a struct
> >>> device for it.  If we hit such cases, the device drivers need to be
> >>> fixed so that they populate struct devices and probe them like normal
> >>> device drivers so that the driver core is aware of the devices and their
> >>> status. See [1] for an example of such a case.
> >>>
> >>> [1] - https://lore.kernel.org/lkml/CAGETcx9PiX==mLxB9PO8Myyk6u2vhPVwTMsA5NkD-ywH5xhusw@mail.gmail.com/
> >>> Signed-off-by: Saravana Kannan <saravanak@google.com>
> >>
> >> next-20210125 fails to boot on at91 sama5d2 platforms. No output is
> >> seen, unless earlyprintk is enabled.
> >>
> >> I have bisected this to commit e590474768f1cc04 ("driver core: Set
> >> fw_devlink=on by default").
> >>
> >> I've attached a log that I'm seeing on a sama5d2_xplained (sama5_defconfig
> >> and arch/arm/boot/dts/at91-sama5d2_xplained.dts). I enabled the
> >> following logs:
> >> 1. The ones in device_links_check_suppliers()
> >> 2. The ones in device_link_add()
> >> 3. initcall_debug=1
> >>
> >> There seem to be some probe fails due to the pmc supplier not being ready:
> >> calling  at_xdmac_init+0x0/0x18 @ 1
> >> platform f0010000.dma-controller: probe deferral - supplier f0014000.pmc not ready
> >> platform f0004000.dma-controller: probe deferral - supplier f0014000.pmc not ready
> >> initcall at_xdmac_init+0x0/0x18 returned -19 after 19531 usecs
> >>
> >> calling  udc_driver_init+0x0/0x18 @ 1
> >> platform 300000.gadget: probe deferral - supplier f0014000.pmc not ready
> >> initcall udc_driver_init+0x0/0x18 returned -19 after 7524 usecs
> >>
> >> There are others too. I'm checking them.
> >
> > Thanks Tudor. I'll look into this within a few days. I'm also looking
> > into coming up with a more generic solution.
> >
>
> I've sent a patch addressing this at:
> https://lore.kernel.org/lkml/20210128104446.164269-1-tudor.ambarus@microchip.com/T/#u
>
> Can you please take a look?

Thanks for taking a look at this. I responded in that thread.

-Saravana
