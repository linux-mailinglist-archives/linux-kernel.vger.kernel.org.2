Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A663D550E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 10:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbhGZHal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 03:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbhGZHaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 03:30:39 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F52CC061764
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 01:11:09 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 21so9969692oin.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 01:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aleksander-es.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0GP/EHeB2F+joGDHU02CEiGN7OLbvD6PYDzreWGz75Y=;
        b=bWjvUWCy0CBmB2s70fd3Kkx52yx3LEJ5JZnLcv9ee1cv2SjeoIlDKIDVayngd9K6ks
         UveqbpPisyT3xluAnHYHLDprWWh2tLvzKadsLyzxne/z2bhqFc6YXb9Qd7fAKIjYLSzg
         P+LO6KSqbJAfTMh/W7efJ6IRgtWFmAE/jioTo6b4o43BFnu/9mfTiSKzx8wueYiLV3zj
         ASvdYD9wTNOl+27Jf02f246TWynZ8WNpPHy9rUWftoBYQSbAedJSSjEo2Doqu/h5CuSr
         3tGPl9uEvYchI/5PtRtMD0nn1Fi69fRKhfwv/G9/NAZJArgg/ouaSEYIe5AXV/A8JMna
         ntpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0GP/EHeB2F+joGDHU02CEiGN7OLbvD6PYDzreWGz75Y=;
        b=HsGcie+Sqj8OnaIWkEkBO0XkhFdUJMfBAAuTp+6z7w6E3cJnVsw7k6kPK6VRPwD05K
         EbJBNbE/8la09I/QBNBWA2bPiXl7tnkY1VGsdBT4vuGyfYTiCTiinJLBK1fYi5L32Mg3
         MGaQXqHt0udQ/Veu8uAYUlRsizmlCLnsJMPNpcLSRrnPaKhe6I256O+OXoW7nmj5liSe
         SywXnioOFZU4Uxw+uX7USkqvLKu2djMKUQ9AduGdsuRVRAR61YGU5UxeYrmuNu4Ooi9j
         9Kj6d4kPt9XhGHGGuv3iqPwlpnszrn7yDMi5i1xAcMPgMs+TZ+9PhADg7mcDu1N4Cd/4
         vTSA==
X-Gm-Message-State: AOAM532CjdtPgfNb3/OylQq++JJvLGi80t7XX1e9y2W5X+/9nk1z+5tD
        H7KCn5FjRW8QobGpDitNOG0Ak+IkqZEhH19FEOOK4w==
X-Google-Smtp-Source: ABdhPJxsLtxOE30YI4uU9tzXePvXaR+jEzI/+O8buRjlY4pKNDL9jEQFsrUHWJneA04tkY5laBLNP5cPn8JGfpAlsCg=
X-Received: by 2002:aca:3094:: with SMTP id w142mr8854244oiw.37.1627287068295;
 Mon, 26 Jul 2021 01:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210719145317.79692-1-stephan@gerhold.net> <20210719145317.79692-5-stephan@gerhold.net>
 <CAMZdPi8oxRMo0erfd0wrUPzD2UsbexoR=86u2N75Fd9RpXHoKg@mail.gmail.com>
 <YPmRcBXpRtKKSDl8@gerhold.net> <CAHNKnsQr4Ys8q3Ctru-H=L3ZDwb__2D3E08mMZchDLAs1KetAg@mail.gmail.com>
In-Reply-To: <CAHNKnsQr4Ys8q3Ctru-H=L3ZDwb__2D3E08mMZchDLAs1KetAg@mail.gmail.com>
From:   Aleksander Morgado <aleksander@aleksander.es>
Date:   Mon, 26 Jul 2021 10:10:57 +0200
Message-ID: <CAAP7ucLDEoJzwNvWLCWyCNE+kKBDn4aBU-9XT_Uv_yetnX4h-g@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 4/4] net: wwan: Add Qualcomm BAM-DMUX WWAN
 network driver
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Loic Poulain <loic.poulain@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dmaengine@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey!

>
> But what if we implement the QMI multiplexing management part in the
> kernel? This way the kernel will take care about modem-to-host
> communication protocols and interfaces, and provides userspace with a
> single WWAN device (possibly with multiple network and network
> management interfaces).
>
> I do not propose to fully implement QMI protocol inside the kernel,
> but implement only a mux management part, while passing all other
> messages between a "modem" and a userspace software as-is.
>
> What pros and cons of such a design do you see?
>

The original GobiNet driver already provided some QMI protocol
implementation in the driver itself. In addition to initial device
setup as you suggest, it also allowed userspace applications to
allocate and release QMI clients for the different services that could
be used independently by different processes. Not going to say that
was the wrong way to do it, but the implementation is definitely not
simple. The decision taken in qmi_wwan to make the driver as simple as
possible and leave all the QMI management to userspace was quite an
important one; it made the driver extremely simple, leaving all the
complexity of managing the protocol to userspace, and while it had
some initial drawbacks (e.g. only one process could talk QMI at a
time) the userspace tools have evolved to avoid them (e.g. the
qmi-proxy).

I wrote some time ago about this, maybe it's still relevant today:
Blogpost https://sigquit.wordpress.com/2014/06/11/qmiwwan-or-gobinet/,
Article in PDF https://aleksander.es/data/Qualcomm%20Gobi%20devices%20on%20Linux.pdf

Making the driver talk QMI just for device setup would require the
kernel to know how the QMI protocol works, how QMI client allocations
and releases are done, how errors are reported, how is the format of
the requests and responses involved; it would require the kernel to
wait until the QMI protocol endpoint in the modem is capable of
returning QMI responses (this could be up to 20 or 30 secs after the
device is available in the bus), it would require to have possibly
some specific rules on how the QMI clients are managed after a
suspend/resume operation. It would also require to sync the access to
the CTL service, which is the one running QMI service allocations and
releases, so that both kernel and userspace can perform operations
with that service at the same time. It would need to know how
different QMI capable devices behave, because not all devices support
the same services, and some don't even support the WDA service that
would be the one needed to setup data aggregation. There is definitely
some overlap on what the kernel could do and what userspace could do,
and I'd say that we have much more flexibility in userspace to do all
this leaving all the complexity out of the kernel driver.

ModemManager already provides a unified API to e.g. setup multiplexed
data sessions, regardless of what the underlying kernel implementation
is (qmi_wwan only, qmi_wwan+rmnet, ipa+rmnet, bam-dmux, cdc_mbim...) .
The logic doing all that is extremely complex and possibly full of
errors, I would definitely not want to have all that logic in the
kernel itself, let the errors be in userspace! Unifying stuff in the
kernel is a good idea, but if you ask me, it should be done in a way
that is as simple as possible, leaving complexity to userspace, even
if that means that userspace still needs to know what type of device
we have behind the wwan subsystem, because userspace will anyway need
to know all that.

-- 
Aleksander
https://aleksander.es
