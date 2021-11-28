Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2676460B1F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 00:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240895AbhK1Xda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 18:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346859AbhK1Xb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 18:31:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1C8C06174A;
        Sun, 28 Nov 2021 15:28:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F20E61177;
        Sun, 28 Nov 2021 23:28:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ABEFC53FD2;
        Sun, 28 Nov 2021 23:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638142091;
        bh=Ef3py9nfbZ/GGBZQDpykJfCW0FBVpQ9KktMJRPVDlII=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FWRNXtv3RFRiIFD58rmBcUTZ/fqVR+21IGbrI607Khpz1vzG+Cfq66OxgGwyzrcVY
         ZVyzVGIn9kQHyA2adt56TFUahd/wTyng+6/ogC41Dcc115+XJb4TFkVwIXgP74mLbk
         jrsR+xR4nYrRPSUXeUXji6SxfcFNhsOPhiHbyhL/DLxcrlgFHCc4UCfVmic2+/xW7f
         P+dVNTwPbrIp7nWSK+SIscabo7DwlfDwbTROAf1/6417ME3UMsHSA44aQlJ1Ib3rur
         Zn+CJfUxGYWxIX80QJIxx00m4/K6rCOdtO5T+NcylA+r/Mto1dy/uvdPonVSBYEvNs
         Ktg1mbNt0bJoA==
Received: by mail-ed1-f43.google.com with SMTP id r25so63997616edq.7;
        Sun, 28 Nov 2021 15:28:10 -0800 (PST)
X-Gm-Message-State: AOAM531XKqziIrZ5ctP+bhdywrfA3Lh02kJeB2idjKLqgt/v+uhMQS7h
        DLYnw8deIOm1Nw4WLpRev6RgGWHr+i7G2jqn7g==
X-Google-Smtp-Source: ABdhPJyxyBK1wEmdDR7bkS9Aa1whQi6oxXJIFx9wc2rPMVqQjxS/ZMJEmC5qWbpiRNWoXZz/qGtXU4YwlLHxcU5DDh8=
X-Received: by 2002:a05:6402:35ce:: with SMTP id z14mr67782841edc.197.1638142089244;
 Sun, 28 Nov 2021 15:28:09 -0800 (PST)
MIME-Version: 1.0
References: <20211123224926.7722-1-j@jannau.net> <277222bd-e3b5-3140-b18f-acd93399c97e@marcan.st>
In-Reply-To: <277222bd-e3b5-3140-b18f-acd93399c97e@marcan.st>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Sun, 28 Nov 2021 17:27:57 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJzZGahwvzaTkhoZ_mEq1fvfTuJqe79whTgUiLXWb8E8A@mail.gmail.com>
Message-ID: <CAL_JsqJzZGahwvzaTkhoZ_mEq1fvfTuJqe79whTgUiLXWb8E8A@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Add DTs for all Apple M1 (t8103) devices
To:     Hector Martin <marcan@marcan.st>
Cc:     Janne Grunau <j@jannau.net>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 12:51 AM Hector Martin <marcan@marcan.st> wrote:
>
> On 24/11/2021 07.49, Janne Grunau wrote:
> > Hej all,
> >
> > hopefully the last iteration of this series. Thanks for the reviews.
> >
> > Changes since v3:
> >   - fixed typo in "arm64: dts: apple: t8103: Add cd321x nodes" commit
> >     message
> >   - fixed node order by address in t8103.dtsi
> >   - removed clock-names property from i2c nodes
> >   - renamed cd321x nodes to "usb-pd"
> >   - added Reviewed-by and Acked-by tags
> >
> > This series is available as branch at
> >      https://github.com/jannau/linux/tree/apple_m1/dt-for-5.17_v4
> >
> > For reference the message from v3:
> >
> > this series extends the device tree files and bindings to all current
> > Apple M1 devices. Specifically it adds DTs for following devices:
> > - MacBook Air (M1, 2020)
> > - Macbook Pro (13-inch, M1, 2020)
> > - iMac (24-inch, M1, 2021)
> >
> > It also adds i2c and cd321x devices nodes. Bindings and code changes for
> > those were merged for 5.16 without adding devices to the device tree.
> > Patches are include in a single series for dependencies
> >
> > Series depends for functionality and dtbs verification on
> > "[PATCH 0/3] Apple Arm patform device tree and bindings fixes".
> >
> >
> > Janne Grunau (4):
> >    dt-bindings: arm: apple: Add iMac (24-inch 2021) to Apple bindings
> >    arm64: dts: apple: Add missing M1 (t8103) devices
> >    arm64: dts: apple: t8103: Add i2c nodes
> >    arm64: dts: apple: t8103: Add cd321x nodes
> >
> >   .../devicetree/bindings/arm/apple.yaml        |  6 +-
> >   arch/arm64/boot/dts/apple/Makefile            |  4 +
> >   arch/arm64/boot/dts/apple/t8103-j274.dts      | 33 ++-----
> >   arch/arm64/boot/dts/apple/t8103-j293.dts      | 41 +++++++++
> >   arch/arm64/boot/dts/apple/t8103-j313.dts      | 33 +++++++
> >   arch/arm64/boot/dts/apple/t8103-j456.dts      | 59 +++++++++++++
> >   arch/arm64/boot/dts/apple/t8103-j457.dts      | 47 ++++++++++
> >   arch/arm64/boot/dts/apple/t8103-jxxx.dtsi     | 67 ++++++++++++++
> >   arch/arm64/boot/dts/apple/t8103.dtsi          | 87 +++++++++++++++++++
> >   9 files changed, 347 insertions(+), 30 deletions(-)
> >   create mode 100644 arch/arm64/boot/dts/apple/t8103-j293.dts
> >   create mode 100644 arch/arm64/boot/dts/apple/t8103-j313.dts
> >   create mode 100644 arch/arm64/boot/dts/apple/t8103-j456.dts
> >   create mode 100644 arch/arm64/boot/dts/apple/t8103-j457.dts
> >   create mode 100644 arch/arm64/boot/dts/apple/t8103-jxxx.dtsi
> >
> >
> > base-commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
> > prerequisite-patch-id: 6827208d4389960d14555ee96768586179f9e8a7
> > prerequisite-patch-id: d5f23530f8cb99fbd9355f4bf0ccbaaca0cd6d7c
> > prerequisite-patch-id: 40ab5e8cc6dc6b5d44f075d8409f39966452bfb3
> >
>
> Acked-by: Hector Martin <marcan@marcan.st>
>
>
> Applied locally to asahi-soc/dt (with the #4 commit message fixed); that
> needs to be on top of the fixes branch, so I'll wait for Rob's ack on
> the binding change there before sending out the pulls. Thanks!

For just compatible additions, don't need to wait on me.

Rob
