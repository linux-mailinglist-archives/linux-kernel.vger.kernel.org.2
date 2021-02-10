Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD763168A6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 15:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhBJODd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 09:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbhBJOCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 09:02:54 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FBCC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 06:02:14 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id o21so1548127qtr.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 06:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6WiDGSBnYqLsXv6lvPHQ+KqJDHOJ69kpa9/logsOjNE=;
        b=ObDq5vnoNF9zunSukgf9jTYHbW95puZS3bA9T4IidFfRxoFjJk7fRcMjWK+RoCnxxw
         FEgMMQ266vip+uw3wfy6UYhOFiiOwuX6mYYFSuPk4k2g2kga2zkDjJkRuDphhUuNGaoE
         Sp8caM7RxnPSQ78pjTRpJ6CYQc90VYFY15FrNH/b5v74Xb1xXvuqPlSkZKd8P92f/NsZ
         Rqd95vxQpQASTIDoz1PERxQNWuJjRo+dylSVvTES083xfXahlDwjMr1y5pocTRgcp6Dc
         TkK9ffN1iANQwfMD8J86jQDbByqbDnZINV0kdZq7L4tx9CYs904+dZrS1r9863XmmxTr
         TUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6WiDGSBnYqLsXv6lvPHQ+KqJDHOJ69kpa9/logsOjNE=;
        b=VCVKPAASatzJsDF1dRRKM8AFUUPmzYsts3g0dAii/38Nt9Yr0QJZ1FO7tzcbY0+qSa
         tizywK+jSu2G08vepD8gcSfUICp8hX45hrNsHWib7gsfwrHZLkrF0nvcPW6Y5YDKivGV
         HDZBQL2tKhh/m2z+akCe92VbUHCE4q4oHEmhnRB/Wa7gv1t9WPtSu+IU0AtnWTiVfG4o
         DqIkUin0X9Ut7yIfZCvfnbEV0i9iZWdfwHkewkmrq63AOOoOG8DygSwiHH7h9e8FnAXg
         p7ENo6vUxB5QZaLguZaOpUooP2awLJYvvph3IHFYrSozGF5Tgudw1E2dzicSBERws6J5
         IOig==
X-Gm-Message-State: AOAM532KoDEep4Wx11mceQniQAtkkIpOVVGVb8vNfBc1EQsAEQRPOwo6
        oL0SZ1JF6SK6mL89SSWdaH0uTshG0KQHCYDZqTOv+A==
X-Google-Smtp-Source: ABdhPJyklgAHzNmKOgnwKyvHJnmEttD7gqZ5dNBiSK8hLQ/j72sdwqpRGHD6FbOBfhnwmbvUyKOqsvk6l0Y1vGKc7SA=
X-Received: by 2002:ac8:5c41:: with SMTP id j1mr2801615qtj.306.1612965733141;
 Wed, 10 Feb 2021 06:02:13 -0800 (PST)
MIME-Version: 1.0
References: <20210210131604.28806-1-kostap@marvell.com> <20210210131604.28806-5-kostap@marvell.com>
In-Reply-To: <20210210131604.28806-5-kostap@marvell.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Wed, 10 Feb 2021 15:02:00 +0100
Message-ID: <CAPv3WKfs3mYsM5omSSF+yZjo_s8-qFh9Yrr8JqB8FpvmPSvWdQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] dts: marvell: Enable 10G interfaces on 9130-DB and
 9131-DB boards
To:     Kostya Porotchkin <kostap@marvell.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Vladimir Vid <vladimir.vid@sartura.hr>, tmn505@gmail.com,
        luka.kovacic@sartura.hr,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        vkoul@kernel.org, kishon@ti.com,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>, nadavh@marvell.com,
        Stefan Chulski <stefanc@marvell.com>,
        =?UTF-8?B?QmVuIFBlbGVkICjXkdefINek15zXkyk=?= <bpeled@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 10 lut 2021 o 14:16 <kostap@marvell.com> napisa=C5=82(a):
>
> From: Stefan Chulski <stefanc@marvell.com>
>
> This patch enables eth0 10G interface on CN9130-DB paltforms and
> eth0 10G and eth3 10G interfaces on CN9131-DB.

Thank you.
Reviewed-by: Marcin Wojtas <mw@semihalf.com>

>
> Signed-off-by: Stefan Chulski <stefanc@marvell.com>
> Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
> ---
>  arch/arm64/boot/dts/marvell/cn9130-db.dtsi | 2 +-
>  arch/arm64/boot/dts/marvell/cn9131-db.dtsi | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/cn9130-db.dtsi b/arch/arm64/boot=
/dts/marvell/cn9130-db.dtsi
> index 8de3a552b806..97c74b81fd78 100644
> --- a/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
> +++ b/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
> @@ -125,7 +125,7 @@
>
>  /* SLM-1521-V2, CON9 */
>  &cp0_eth0 {
> -       status =3D "disabled";
> +       status =3D "okay";
>         phy-mode =3D "10gbase-kr";
>         /* Generic PHY, providing serdes lanes */
>         phys =3D <&cp0_comphy4 0>;
> diff --git a/arch/arm64/boot/dts/marvell/cn9131-db.dtsi b/arch/arm64/boot=
/dts/marvell/cn9131-db.dtsi
> index 82471a83ad6d..f2e4d3a6a4f8 100644
> --- a/arch/arm64/boot/dts/marvell/cn9131-db.dtsi
> +++ b/arch/arm64/boot/dts/marvell/cn9131-db.dtsi
> @@ -84,7 +84,7 @@
>
>  /* CON50 */
>  &cp1_eth0 {
> -       status =3D "disabled";
> +       status =3D "okay";
>         phy-mode =3D "10gbase-kr";
>         /* Generic PHY, providing serdes lanes */
>         phys =3D <&cp1_comphy4 0>;
> --
> 2.17.1
>
