Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979203B0EB3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 22:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhFVUa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 16:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhFVUa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 16:30:27 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB40C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 13:28:10 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id m14so458727edp.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 13:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X5CvNIGn+uveqQuIQS4du1ZTZMasSyyQsp7zluQgLD0=;
        b=WciAeMDK5MbomldMgX1vfqrUSPoIknmeADksmKJHf5vbClibwq6GSyQ7cK20HRctwb
         lESv/vzkxrRUDEyqIV+eRdPuWTa+ms8dKvrqKcL7hdPbSzWTE3WGQgkYCZyp+XxZV7Au
         X8/tHUVuMXfa/LaUfVFxuXxVznGVWmilATFg+LcMScJ7Fn0b2HUhOz94YTZjGfa9g5zH
         hHleS38ZfNJ62kzmN24LE9J0EzPPqCJNbUlDJV1SfvoqID9Aw3g6IBenHBVEJl4/lItK
         yC08xKEMbGMmGRQV6FY7v5KugN/g7VZhcROmj8H1Z4CHi5Hu6PRIQr/fcfQHK2dPx5fD
         GkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X5CvNIGn+uveqQuIQS4du1ZTZMasSyyQsp7zluQgLD0=;
        b=PKPlIQOqnq5WFX7f0c7/EbM1fhPedyqOEjGO6+Gxd1jVaB8lwR/SLLb86WMiEM4rN1
         vrBCV4SNwAMzfxLKC3cMwyzGnkNqMsAc37sdMOEUmh8eoFeyQXjG8qmp9SeEwlxTjsSr
         pr/AVOKGxBg2J1Gis4a241hSm9MuAvMVCtfY+ynABWOl/Zg9OoTIhHRS0DmvguWSbXG2
         RNbJS689AS908UxT5Htc4sK++pVM6wYERkJzI1kyUAy43XxdIVaEThmN67Sd9Pn4sGf9
         9NenCmJT1BRmtdjgftXjkqhzxIHTXacFIyWJLjrzLhsAHTyGrOAViW6/07zBAh4tVnmp
         F8Tw==
X-Gm-Message-State: AOAM531P2o3VzrH4Bzfey8XPrHneSyqanNjNs8ly1s6chJqpt2HnsDbT
        tGAB6SL9+wlCLj61x+4x4Xqeqdb7bv/NcOGbtQQ=
X-Google-Smtp-Source: ABdhPJyDXk6FUdcXb8rrM3nwzI3yys7EvkNfVi/l6gPIA8s75q6azLGkkbBjfs++dkSHRFVMxeAj/5zJhsxJ4KCbLH8=
X-Received: by 2002:aa7:d74b:: with SMTP id a11mr7669139eds.40.1624393688890;
 Tue, 22 Jun 2021 13:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210617194154.2397-1-linux.amoon@gmail.com> <20210617194154.2397-5-linux.amoon@gmail.com>
 <CAFBinCB1rrmJ5=M0tSGS_47BarFcrs2Kz5qFzrHw8+OEYxX3DA@mail.gmail.com>
 <CANAwSgQVgKUoTpfaJyfxdphqc6M=Oq6jj5zZ7An9St7PdzQHYA@mail.gmail.com>
 <CAFBinCDpQybqD96CCMBDKYUXEYCABr0QMfxFH1AWrXP12UxxMg@mail.gmail.com> <CANAwSgTd1zq_gHbVZesLY=e3DRRGgn_o5omuDo9Lub4FavOtbQ@mail.gmail.com>
In-Reply-To: <CANAwSgTd1zq_gHbVZesLY=e3DRRGgn_o5omuDo9Lub4FavOtbQ@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 22 Jun 2021 22:27:58 +0200
Message-ID: <CAFBinCC3ZN9GqOAR1AnXao5G1UCgi6QOCRHeve0mHBXtYYdKOA@mail.gmail.com>
Subject: Re: [RFCv1 4/8] phy: amlogic: meson8b-usb2: Use phy set_mode callback function
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On Mon, Jun 21, 2021 at 9:20 AM Anand Moon <linux.amoon@gmail.com> wrote:
[...]
> In order to enable USB phy we probably need to do a little bit
> differently than the vendor kernel.
I agree with you here, the vendor kernel is skipping most of the
frameworks which we have available in mainline Linux

> OTG port on Odroid C1+ and Odroid C2 server two purposes
> 1 > It could act as USB host port.
> 2 > It could be used as USB power on the devices, just like Raspberry pi.
>       What I meant is we need some driver code to protect the power to SbC.
yep, so we need something that controls mode switching
depending on the mode the VBUS regulator needs to be enabled (HOST) or
disabled (DEVICE/PERIPHERAL).
VBUS control however is not part of the PHY - in mainline Linux either
the dwc2 driver or a USB connector driver are taking care of it.

> So I saw your work on extcon, that's the reason I would like to void
> any changes PHY right now.
I believe that this specific PHY is unrelated to mode switching.
Either it automatically detects the mode and changes it's settings
internally or the PHY settings are the same for both modes.
Since VBUS control is not the responsibility of the PHY this is
certainly possible

My changes are not ready yet but I'll ping you once I have something to test

> I observe some failures like below.
> [    6.013859] dwc2 c9000000.usb: DWC OTG HCD URB Dequeue
> [    6.013897] dwc2 c9000000.usb: Called usb_hcd_giveback_urb()
> [    6.013902] dwc2 c9000000.usb:   urb->status = -115
-115 is -EINPROGRESS but I am not sure if/when that's a bad thing or
to be expected


Best regards,
Martin
