Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED81941B398
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 18:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241736AbhI1QPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 12:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241645AbhI1QPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 12:15:22 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5C9C061745
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 09:13:42 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id b15so23917423ils.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 09:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v2zQz4XizfHwgNsfMM/95d+v9BN58F9SfAkKgr4nWbo=;
        b=HCNd3PAb5VTA0Hj/uDS3qEqaivstHqwG5xndb95BxPTFJkpvoMisLEMufr5yfuKlp5
         HTVL4MiqJcRnINa5nUgdphCKL/tY9ganf/5KVqVyksJSmXrkZnQHnNsRGRlPQZMmvG+C
         o39/gJk3zvYKzgMWBo74gI5Psh7VnFl1jHNJHoBiWCf81AHyPGUPOP+abkmf3rkpZUa6
         /cwoe++eZ95EIWrmbx3AAqajl72o+lGuKK61VDj4goKvwDXSGTva1OvdWdgS84a5u5uz
         2E/jvsJbc+BtkT2MrJA0A+EJiOzXKbUgjVzL9QcKWFgHhMJ3psvEZQKaH8U7hrcoN06Q
         EUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v2zQz4XizfHwgNsfMM/95d+v9BN58F9SfAkKgr4nWbo=;
        b=qv5S6zRHZHkeGzrB2c2oHInJtg9V+LmPDf1v1yPQzC9nJsATY2xaamU74QRzAzJOSG
         6FXsV7+u/PR4RVsSZJjUa5OcT/6Epj26HukwiTG+XAyD2c3aiPmOggBmu/Z3LFLY8/E7
         v4d1jMVX2nHVpT3WgCrV1pkTD0nRJ3zUIeJyBCHZgvbqKRjMlKstaSZAB1HeQvc+xKyq
         HBKjRAIPy2PBwqvTttdismw1TNKHVAnX/bTs9GyfV/6sBq1NU0GuT3d/7NJNiNbZy5MU
         RFHM3nvjotGq99eJPHR4SXn9IhfGkCXBUqipcZpOvdXMqgojMiHEEljkJ5qoIOYrvSFG
         O1iQ==
X-Gm-Message-State: AOAM5332EuiBRKMGYs3Qa2G0GTLe/Qzv0MPVDrgnNWhbM9Xa/k1W25Cl
        DA7oITV1MuXqln6iQs4ggd4JNfqWS6sgFMk6V0svzA==
X-Google-Smtp-Source: ABdhPJzp8SM43R1E44WVwU8mJUjw3G0PTjGQFg+A/ShFORc/dbikzu4gAC9vpc8iqa0HhmQSmXfVld7ORrgwtPucs7M=
X-Received: by 2002:a92:c5c9:: with SMTP id s9mr5056555ilt.56.1632845622062;
 Tue, 28 Sep 2021 09:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210923181830.3449602-1-robert.marko@sartura.hr> <20210928154801.vkdt5qbsm4z7ox4y@pali>
In-Reply-To: <20210928154801.vkdt5qbsm4z7ox4y@pali>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Tue, 28 Sep 2021 18:13:31 +0200
Message-ID: <CA+HBbNEF5s23K6goPAco9n=OhNqg4zcmTP6WKdh3p6qb8XSG5w@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: marvell: add Globalscale MOCHAbin
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 5:48 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Thursday 23 September 2021 20:18:30 Robert Marko wrote:
> > +/* SPI-NOR */
> > +&cp0_spi1{
> > +     status =3D "okay";
> > +
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&cp0_spi1_pins>;
> > +
> > +     spi-flash@0 {
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <1>;
> > +             compatible =3D "jedec,spi-nor";
> > +             reg =3D <0>;
> > +             spi-max-frequency =3D <20000000>;
> > +
> > +             partitions {
> > +                     compatible =3D "fixed-partitions";
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <1>;
> > +
> > +                     partition@0 {
> > +                             label =3D "u-boot";
> > +                             reg =3D <0x0 0x3e0000>;
>
> For sure U-Boot cannot start at offset zero as this is 64-bit ARM board
> which uses at least TF-A firmware, which loads U-Boot.
>
> Also on these mvebu SoCs is executed prior TF-A firmware custom Marvell
> initialization code responsible for DDR training.
>
> So on offset zero you cannot flash U-Boot, otherwise board would not be
> bootable.
>
> So I would suggest to either define correct offset at which U-Boot
> starts or rename this whole partition to something generic, e.g. with
> label "firmware". To not expose that on zero offset is stored U-Boot.
>
> Due to how big is this partition I guess it contains concatenation of
> various firmware and bootloader parts.

You are correct, its the mv-ddr + TF-A + U-boot in that partition, its just=
 a
matter of habit calling it "u-boot".
I will rename to "firmware" which is much more appropriate.

Regards,
Robert
>
> > +                             read-only;
> > +                     };
> > +
> > +                     partition@3e0000 {
> > +                             label =3D "hw-info";
> > +                             reg =3D <0x3e0000 0x10000>;
> > +                             read-only;
> > +                     };
> > +
> > +                     partition@3f0000 {
> > +                             label =3D "u-boot-env";
> > +                             reg =3D <0x3f0000 0x10000>;
> > +                     };
> > +             };
> > +     };
> > +};



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
