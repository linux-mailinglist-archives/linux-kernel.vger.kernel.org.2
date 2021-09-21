Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D0541316A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 12:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbhIUKU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 06:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbhIUKU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 06:20:58 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5CAC061756
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 03:19:26 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id h129so1917643iof.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 03:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gxVjksGN/3yuclGhnmoWEQKT5gLNVLIOyY61uXcwmWI=;
        b=vO46N99FpdRLkV1NF+gjE9qSMCIUZhOeIy/mhBx5gPsP926ONSii9PXt2deJ3DGL3e
         NjIwdQOHkvYPd4Je03SklDs0b7KsYP4kBXjpK1TGDI3dgQe8P2djwcVqx5/y1K8c9zsB
         mCX9S3NgX/2UoLP5azlPU7WExgd7yVRpONvUhrwD/09Hr+e9fRaQHJ8HnUJ715Znm7DN
         Z7OHvsjM9YttYJcPUA485abYs9vP8yJ5zt5EJt7CuMP3zlnrxV8eEfWnhcLotbLwrXuk
         sy1LU5Cz+yhgoFdFfChdHpOSm3m5AKYD4dNUes/f9eEjwCbOLNoyiziW05Z4RH7ftFJn
         sEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gxVjksGN/3yuclGhnmoWEQKT5gLNVLIOyY61uXcwmWI=;
        b=lCkAKpt1mrGZ215xvbr6/ZsFIJcF2FVWVnL56M3CYPcz8fldYW72dqBaJvQsqS7zGA
         1wd7aMJ77gbkKwQLc2fVge+lEyma+1gH7jeMocRlFOXzagbaBX/94MFuqIHNzh8BcMOH
         yMbHaNgQVwbL1KNOVBa0gp8t95Nvg4AX6azZcsAkj2JCHk3kZbpN9onWT5jQ1G0r6Akm
         7Lqx7xAQBoOaEPxH3hk+FcBaU39WjbpQn9EkubJVVnnuQLvJBu8JodIAQYTc0+wVoMxj
         x9Gnh/kb1qFpg7DU6z+174dfT5kLNi0iZpBct6lvDEp5UZdevDj0+rauOFxnjNUzCcKS
         Hwsw==
X-Gm-Message-State: AOAM533uFwV7AuPpHGP4tnDTmy6Sy4UZ2A3IVXrKzcWR1l0OG2mqMuOn
        nGl8hPszmCqErAD1oDHBuTqKk3DEFDiE5XRyDvucnw==
X-Google-Smtp-Source: ABdhPJz86aatVqFyHRCUhvImhsp2CKqHcGwOGrpQiGAsYeZo1977hFAgAenDq9K/oh27Yx/hhOzO2jV+sXZxluuCWfk=
X-Received: by 2002:a02:908a:: with SMTP id x10mr23047196jaf.30.1632219565662;
 Tue, 21 Sep 2021 03:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAMi1Hd3k2snB4-=M57pVrMVom=a9_2a0DTFk-+Hzpubwk-Pr9Q@mail.gmail.com>
 <64a2a428-8bb1-0078-2403-1ca8e28cf4b1@codeaurora.org> <CAMi1Hd2MCxJgbHz9oGWe4L+MXNM3p+Xntpcg6t3TvZxwjJTy0Q@mail.gmail.com>
 <47a06078-dd41-7b3d-3de3-4e6c24211691@codeaurora.org>
In-Reply-To: <47a06078-dd41-7b3d-3de3-4e6c24211691@codeaurora.org>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Tue, 21 Sep 2021 15:48:49 +0530
Message-ID: <CAMi1Hd1UtTECaDROGm7hE377Dp5qLzZeqBowmxoQJpOm9uQFHw@mail.gmail.com>
Subject: Re: dwc3-qcom: tx-fifo-resize regression on Poco F1 (sdm845) with v5.15-rc1
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jack Pham <jackp@codeaurora.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        John Stultz <john.stultz@linaro.org>,
        linux-usb@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Sept 2021 at 13:00, Wesley Cheng <wcheng@codeaurora.org> wrote:
>
> Hi Amit,
>
> On 9/21/2021 12:04 AM, Amit Pundir wrote:
> > Hi Wesley,
> >
> > On Tue, 21 Sept 2021 at 02:44, Wesley Cheng <wcheng@codeaurora.org> wrote:
> >>
> >> Hi Amit,
> >>
> >> On 9/20/2021 1:45 PM, Amit Pundir wrote:
> >>> Hi Wesley, All,
> >>>
> >>> I see a reboot loop on Xiaomi Pocophone F1 (sdm845) with TX FIFO
> >>> resize patches which landed in v5.15-rc1. Upstream commit cefdd52fa045
> >>> "usb: dwc3: dwc3-qcom: Enable tx-fifo-resize property by default" to
> >>> be specific, which switched on this feature by default.
> >>>
> >>> At times the phone crashes into the fastboot mode after the reboot
> >>> loop, but mostly end up booting to UI after a while. This is what it
> >>> looks like https://people.linaro.org/~amit.pundir/beryllium-userdebug/PXL_20210920_162749483.mp4.
> >>>
> >>
> >> I believe Android will attempt a number of bootup sequences and if it
> >> fails, it falls back to fastboot mode.  Are there any available logs you
> >> might be able to collect to see where the issue is?
> >
> > It is a stock phone with no UART access, so I can't get early crash
> > logs unless I'm booted up to adb shell. I can try getting some info
> > using pstore-ramoops but warm reset support for sdm845 was not
> > upstreamed when I tried using that the last time.
> >
>
> I see, can we maybe avoid the actual resizing by commenting out the
> following writel() calls, but let the fifo resize logic calculate the EPs?
>
> void dwc3_gadget_clear_tx_fifos(struct dwc3 *dwc)
> {
> ...
>                 /* Don't change TXFRAMNUM on usb31 version */
>                 size = DWC3_IP_IS(DWC3) ? 0 :
>                         dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(num >> 1)) &
>                                    DWC31_GTXFIFOSIZ_TXFRAMNUM;
>                 /* Comment the dwc3_writel() */
>                 //dwc3_writel(dwc->regs, DWC3_GTXFIFOSIZ(num >> 1), size);
>
> and
>
> static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
> {
> ...
>         /* Comment the dwc3_writel() */
>         //dwc3_writel(dwc->regs, DWC3_GTXFIFOSIZ(dep->number >> 1), fifo_size);
>         dwc->num_ep_resized++;
>
> Those 2 writel() would be the one that actually programs the TXFIFO
> register.  I hope when commented out, no resize should actually happen
> anymore.
>
> With this, hopefully we can get some logs from the device at least :)

I can boot fine with above 2 writel() removed but I don't see EP
counts being printed in the log anywhere and the only relevant
message in dmesg I see is this:

    Duplicate name in dwc3@a600000, renamed to "tx-fifo-resize#1"

which is interesting because I don't see tx-fifo-resize property being
set by any of the upstream sdm845 or relevant dtsi files.


>
> >>
> >>> PocoF1 does support TX fifo resizing as I can see that in the
> >>> downstream dts. So maybe it is the tx-fifo-max-num which need to be
> >>> adjusted for the device? I couldn't find the tx-fifo-max-num
> >>> equivalent in the downstream tree though
> >>> https://github.com/MiCode/Xiaomi_Kernel_OpenSource/tree/dipper-q-oss/
> >>>
> >>
> >> I assume that you've already confirmed reverting that change resolves
> >> the constant reboots?
> >
> > Yes reverting that change resolves the reboot loop issue. Speaking of
> > which, since no other platform seem to be running into this issue and
> > "tx-fifo-max-num" property is apparently not at fault either, is it
> > reasonable to skip adding "tx-fifo-resize" property for PocoF1 using
> > of_machine_is_compatible("xiaomi,beryllium") as a workaround?
> >
>
> Since SDM845 does technically support txfifo resize downstream, let me
> see if I can figure out what is different on this particular device
> after getting the logs.
>
> Thanks
> Wesley Cheng
>
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
