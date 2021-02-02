Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103DB30B53D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 03:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhBBC01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 21:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbhBBC0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 21:26:22 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8632C061573;
        Mon,  1 Feb 2021 18:25:41 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id u14so958329wmq.4;
        Mon, 01 Feb 2021 18:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DR5yCvFMeWyg5lOQpZzKiO9ls9286n+whAuS0V/qOws=;
        b=N54kLpmRW/o0Fx65J53agalyEoePAFJedinVSSjnVhjrWXWzOrpeN7nNLXlG4VywCS
         FDyjypLmxXVo9rP5G38azUjHObGzlEkBwwyTVRe/u9SsIzoUqik/erCwjLd2IDRsecTs
         UGHSqvXZximjKgl7eJ2lxqqoApoT5KZzBx3qw969slmX2XoAGOqpaKuZzDVx5ekrOf6D
         FJhMq8JE7YCuPzm/YG9htmOxeSpGEkvlPUA8dwiLnZ2vYrbUTRZvMxnPPuqlXhanu1Ld
         xCZaq1eseyizv9+8TK1ceO1XJCO75/R1o+kNwrypByL8m1y9vTP/rqDPwBeLsOyNL0HL
         xjdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DR5yCvFMeWyg5lOQpZzKiO9ls9286n+whAuS0V/qOws=;
        b=ke315s84UmczHNKdbF5AZ7tv9SqOMq+PVeMhX0oMIPkmCjQ8q4PnsDNQ8/fBpUnj/g
         xt6kcI3iFdbhu6sp2MYBClv/5hrWJXcYCddNd3HabDCmLPW3/JJkS+2I1tkUWFd9amnQ
         fDvRQmrI/gLkBj7pwsGdRe1rV1Dn7D2TgDupVbSkRg/GmkWEaMRBHRRplxnmQKeOXEmt
         pqbh6M84Ukjmy5j7cBDR8ZClxSmCvi8JQcvCRs07+uw7sIova3VkE7O4l3vaamsdTZ+X
         L6T41LuiZmJBKvZ+UP+sAa5gQJbdjJ6wgnmBWe4ZIzJ/wXpI2b90rE0VsihM7g2MoVIl
         cGYA==
X-Gm-Message-State: AOAM5300npWN0cY503HcIfV1m7wziHMxRZf7nsdIvIBtDav6flH75Q5t
        fu+oHur40wMjLdy3bLxKhvM=
X-Google-Smtp-Source: ABdhPJz32kMfJiyD3thxl1MMQl3s+ioMDDtAS4T5kA9kPajX9emg1cy9yjTQHmgLVK7JuamG9wBOYQ==
X-Received: by 2002:a1c:620a:: with SMTP id w10mr1360206wmb.167.1612232740495;
        Mon, 01 Feb 2021 18:25:40 -0800 (PST)
Received: from [172.16.20.20] ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id a16sm28531311wrr.89.2021.02.01.18.25.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 18:25:40 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.17\))
Subject: Re: [PATCH v2 0/5] arm64: dts: meson: add support for ODROID-HC4
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <7h5z3bi9lz.fsf@baylibre.com>
Date:   Tue, 2 Feb 2021 06:25:37 +0400
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dongjin Kim <tobetter@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CF8AA6AA-1BC0-41A6-B0EE-A4D326487011@gmail.com>
References: <20210131055358.21293-1-christianshewitt@gmail.com>
 <7h5z3bi9lz.fsf@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
X-Mailer: Apple Mail (2.3445.104.17)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 2 Feb 2021, at 4:42 am, Kevin Hilman <khilman@baylibre.com> wrote:
>=20
> Hi Christian,
>=20
> Christian Hewitt <christianshewitt@gmail.com> writes:
>=20
>> This series fixes minor sort-order issues in the Amlogic bindings =
yaml and
>> dtb Makefile, then converts the existing ODROID-C2 dts into dtsi so =
we can
>> support its new sister product the ODROID-HC4.
>>=20
>> I've also given the devices different audio card names. This is =
partly
>> cosmetic, but also because HC4 is HDMI-only while C4 can be used with
>> other i2c audio devices via an expansion connector so users may want =
to
>> use different alsa configs.
>>=20
>> Patches to support the spifc chip are still being upstreamed [0] so =
this
>> will be addressed in a follow up. A WIP patch for the dts change can =
be
>> found in my amlogic-5.11.y dev branch [1].
>>=20
>> For reference, here's dmesg from LibreELEC on 5.11-rc5 [2].
>>=20
>> Changes since v1:
>> - fix ODRIOD typo in patch 3
>> - fix SPI-NOT size in patch 5
>> - add Neil's Acks/Reviews
>=20
> Could you please rebase this on top of my v5.12/dt64 branch[1]?  This
> has conflicts with some stuff already queued up there.
>=20
> Thanks,
>=20
> Kevin
>=20
> [1] =
https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git/=
log/?h=3Dv5.12/dt64

Oops. v3 sent based on that branch. Thanks.

Christian=
