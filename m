Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E115B3AE400
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 09:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhFUHXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 03:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhFUHX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 03:23:28 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92B7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 00:21:14 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id h17so7566907edw.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 00:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mbnpi+F4BB/za1oZMA5jK8Z4P2+DO3unM76FgufrKCk=;
        b=C1wLOHrY+8yhoDafdxlC+Y0cECMb7v+XjOPS3rH+P2Q1WcsO3W3Ujeip9PHRSxraJA
         n1DY1bRWGnPiGESaP7X8wiyJDg06t+h2dXdFHbUtF4k9gfMm5yfuJU+CXRAZhaVZD5Px
         ZM+sxnjmJrFVWLCZVITVK/u6ClhSfIoAXb2aFrx0890J65fENt6EqvO7oeib0Il388wH
         Sfr5jRmp66bSmL6MwLDac09qoxIypuUlznhLJE3X+sh+ggRAu1WLccmiruaTk+5vJQEp
         Cr4gHD8jcdHk0X8OTlyjizOPF0jZv6vzutA/QjWdcBWZc3epT5HKoMeew2lcb9fws58c
         p86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mbnpi+F4BB/za1oZMA5jK8Z4P2+DO3unM76FgufrKCk=;
        b=Bu0h/PfwwG5fgsPkTasNkUdUAEM7Vf34Cxl/NkiVHeBEsJYAPYLCKpg6I/kjT6mdSn
         daxhTMSbtZ+uzyCI5Doo+3S3j8wOJ5FNg0TfqXkeBi7PI1Kj++SEn4u1wlxehrxYNX9u
         HDssL9zUPJV53b7z6YkNyf2iThd7UUJI6qrOaUrgGNnbxvOoTz0D42IviCw+Jylcq5Sj
         HbO6gY0bKIFbo/8dUihxM6XYtWxV++5nOurhNeE1ZiJ/xpsAotqO6eE031r9AZCZBCfA
         14ZJUI4KKWMDW9qQo8TLBtaCnbAOk0KyZRkVTq7M8rCCmnmHTHWeqiwa0zfyzFmPZ5gq
         zdFA==
X-Gm-Message-State: AOAM533P5vynCG3ZeXV7rdw/XJVMwUsYOXQlKfo9yEn6uQP35+YMUlh5
        wzrCa+mwPyT/r6MpnRg/TdBJNY3GKFcEoGB1H8U=
X-Google-Smtp-Source: ABdhPJzlIsUmCD7QxdwFQ9JK241Kbhh7qVixABRLmzZHYhoNnheWKO0m38DxzqM0PUPXsxCYX3EZhXqDzI0UcRcRofI=
X-Received: by 2002:a05:6402:3581:: with SMTP id y1mr2055328edc.31.1624260073558;
 Mon, 21 Jun 2021 00:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210617194154.2397-1-linux.amoon@gmail.com> <CAFBinCDVnBApYziHazeS8f2FXHQ-tUS55-g6B22c20OtfYD=xw@mail.gmail.com>
 <CANAwSgQcVDdPMZjuaN4O1dpVDd-KrNCGLDq0h4vfP4YZ2vSV2Q@mail.gmail.com> <CAFBinCA0-M-P5bWMKmMTq+Kgx+iEBpxirjWGxpaQqR3pfn84Fw@mail.gmail.com>
In-Reply-To: <CAFBinCA0-M-P5bWMKmMTq+Kgx+iEBpxirjWGxpaQqR3pfn84Fw@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 21 Jun 2021 12:51:02 +0530
Message-ID: <CANAwSgQnW6RknOjfn2q0avggG7VLwEo+LaxUdbfTw1v17g5UGQ@mail.gmail.com>
Subject: Re: [RFCv1 0/8] Meson-8b and Meson-gxbb USB phy code re-structure
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
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

Hi Martin,

On Sat, 19 Jun 2021 at 01:47, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Fri, Jun 18, 2021 at 3:20 PM Anand Moon <linux.amoon@gmail.com> wrote:
> [...]
> > (some email id got messed up while sending these changes.)
> it happened to me before: don't worry, it's something that can be fixed
>
> [...]
> > > > Initially if we connect USB HDD at initial boot it get detected.
> > > > but after that usb hotplug of USB HDD is broken.
> > > > I did not observe and USB debug events messages to trace the root cause.
> > > >
> > > > Another issue I observed is increase of USB interrupts event
> > > > even if there is not much activity on USB ports.
> > > > I tried some clk changes but it did not workout for me.
> > > I suggest reporting this to the dwc2 maintainers and asking for advice
> > > on how to debug these issues.
> > >
> > Yes I have enabled the CONFIG_USB_DWC2_DEBUG
> > to help debug this issue but could not find much clue on
> > why this is happening.
> I think CONFIG_USB_DWC2_DEBUG is a good starting point.
> For myself I came to the conclusion that the dwc2 IP is too complex to
> understand without additional information
> Some additional information can be found in public datasheets of other
> SoCs which are also using a dwc2 core, see for example RK3128 [0] or
> RT3050 [1]
> That's why my suggestion is to additionally ask the dwc2 maintainers
> (which are not Cc'ed on this mail) for debugging suggestions.
>

Yes, I will investigate with mode debugging and Cc USB maintainers in
the next version for more details.

>
> Best regards,
> Martin
>

Thanks for these inputs.
>
> [0] https://rockchip.fr/RK312X%20TRM/chapter-26-usb-otg-2-0.pdf
> [1] http://static6.arrow.com/aropdfconversion/aa9a14376a75e7c5d6daa9f6aaed8411909d2021/rt3050_5x_v2.0_081408_0902.pdf

Thanks

-Anand
