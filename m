Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0B8315156
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 15:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhBIOOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 09:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbhBIONw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 09:13:52 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AE2C061786
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 06:13:37 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id l14so8707570qvp.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 06:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qtFCK0z4ywUD3O29byIfhhkjF0iydn71SM7pfUSL7H4=;
        b=WtRY7RyEU/fEeDDP+uiq/bRv6pcgHTWxGTWMyAxC54c4qbJhvvBbLY5sYW3D4rnTLT
         BG1w2BP2Ya06vRcrBkFhpBboSkxgCkwCCV0SvvNbpf9WDr4F+UdZs5CBmUskr0SjMFBJ
         h9vEG7Ixm1bGnjxKhAS3X6Os+fMDRlnfjMm040mvRVRwfITYXpDqFzgOO/1xMnloRrQA
         l7uhG12iVnsbjb8Nvw5i9kw05AjgIECvQDQB1v7TLFLh3pBLh5B76STbszrOtS/dfX9x
         fDtS2fX8Ldsz/uIY8ekoR6bOrmEv1ke22JrwTHZ7v7MgMYqdCmndejFycAlMaKGAJ2o3
         eZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qtFCK0z4ywUD3O29byIfhhkjF0iydn71SM7pfUSL7H4=;
        b=TJ3G3SHSvX5iCjjCi4kltT9nvwAjpx6mbRVQmBTaqdOZ9RmtHv+nu2vijtyjcpma9N
         fb/RLLAhDYppYZM7y0AyBDOVyOPZfAqlIIOgR5SeVDQDWi6A4G9/59p0Aohg4VxLE2x9
         vB2D5zsEsQsV0rs/cIbceivDnfiR6fH0wKyknq5IQ4rFrEj21pAu3BbSzENNpodf+Z6G
         jokjoVANpJhJkUrxD2Qa3mTdr1Up7HhiDwu6lE5X8HRPG349Gv8uUFdwgaq7xnWdUXvy
         IXKNzk10UvG7Nh2QE7KfA2jVonZnZJhatQWZGAmq475ahJBDIcxSYiUWbjplPpSRh4fW
         3vFw==
X-Gm-Message-State: AOAM5317XgX9C1HrfYLHJnsY6Eq7btZ8LXO2kAn2Sw0b+e63MdAWWhrT
        5M7rwScJqZEi9ohAhYagfZDpqVIeOP7+2qEF7hSrRQ==
X-Google-Smtp-Source: ABdhPJw99RxRQ12zTjUdBvnsVRWtJIMpcSNLzhfBoDp6m7eHgSHfgaq5W4Whi7EhAn+BbgH150/nGzrtNKuw8opZ1Rk=
X-Received: by 2002:ad4:44a9:: with SMTP id n9mr21076072qvt.10.1612880016257;
 Tue, 09 Feb 2021 06:13:36 -0800 (PST)
MIME-Version: 1.0
References: <20210209134610.19904-1-kostap@marvell.com> <20210209134610.19904-5-kostap@marvell.com>
In-Reply-To: <20210209134610.19904-5-kostap@marvell.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Tue, 9 Feb 2021 15:13:24 +0100
Message-ID: <CAPv3WKeMgJwVjzdAHHHSG8EHB9C_Lt7hrZmdhRWp5B8q1UkxXQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] dts: marvell: Enable 10G interface on 9130-DB board
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

Hi,


wt., 9 lut 2021 o 14:47 <kostap@marvell.com> napisa=C5=82(a):
>
> From: Stefan Chulski <stefanc@marvell.com>
>
> This patch enables eth0 10G interface on CN9130-DB paltforms.
>
> Signed-off-by: Stefan Chulski <stefanc@marvell.com>
> Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
> ---
>  arch/arm64/boot/dts/marvell/cn9130-db.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
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
> --
> 2.17.1
>

You can add my:
Tested-by: Marcin Wojtas <mw@semihalf.com>

Please do the same for cp1_eth0?

Best regards,
Marcin
