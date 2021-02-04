Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D922530FC23
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 20:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239226AbhBDTBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 14:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239221AbhBDTAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 14:00:45 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4302C061786
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 11:00:03 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id l23so3158385qtq.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 11:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V7C9t9ZYkeBsgCVn9arSTJoeGAAcql4uHxNX8d4G94I=;
        b=Tdlzo87fkKjytvKaNyWaNOMLo5IN/cUSMGGP0BdoTSS922doovTYiIM4jI8wBavOd3
         qaik+6cHGly6q/tcdiZV7xRKuBCPbR6CYcGoWTg24YyqNNiqZyItowAyhwUKQ+E9JBVK
         JxddOCgLGaHo45x04OHC+Stq6mFbVnbxQNpeZucQ5VevpvnZWxvlmc1JCfwxA96FLjI3
         jAdV79isEEMx5Yy2SMOs0fiQvYjnelJ1DkWhHeanhI51Gl79LgwoMxQgUiLoyPB94pVo
         dUMNpupFjFB6i/x7PfCn1PhMwR0fI2kPco8v+DtXnSjCDsb9iqzydoDIB9dk0tfy0cSs
         FC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V7C9t9ZYkeBsgCVn9arSTJoeGAAcql4uHxNX8d4G94I=;
        b=IDy0TJpr5xHNxYEjLb3CXl/uFalGVaL4N1ebMQhKgCcw+J45lpwtKd3EYavsM1yCr5
         zpF6/GnS/5AxRNtlLBD3kikCBpWTPKqLhMOvso4nG8H1wAI8dNM2m5mkByF7mp4KNwij
         F03CS5qdp6xBECmXxz1ZsOgx0Q1Iq/KPVR/jvmg30lQR+5AG78N0Da5aIDE5+n/erV0Z
         Qf1EC8We+/X2lgEzSd2eTerKbN3xRWRUiY+GjYfVTUZm4qz2wAcfA1/VGreI0OgruPnd
         vgx+YD1MahJhOG1UB5kwBfDiHfZhf1+aupy+8uwYET5daOp6zhD6RXF5gM8vR/NzovDF
         ii4A==
X-Gm-Message-State: AOAM53174I9yAv/3O3Mh4UozzSZedVcgVT449CG4y1XQrIjEfDw+T4X5
        TssW0QRZh82tT+T5+zhfEOH7NekQijLSbN1JHSQZpg==
X-Google-Smtp-Source: ABdhPJxFPcMhVIltx6KLYv4GtJdlbwVZwoxd6s6m7uTVKz6rc4Yyhc9VNI2V5JzdrOq6LJHPh2tKwndvkY2L2FnxnCA=
X-Received: by 2002:ac8:a82:: with SMTP id d2mr944463qti.343.1612465203069;
 Thu, 04 Feb 2021 11:00:03 -0800 (PST)
MIME-Version: 1.0
References: <1612253821-1148-1-git-send-email-stefanc@marvell.com> <1612253821-1148-3-git-send-email-stefanc@marvell.com>
In-Reply-To: <1612253821-1148-3-git-send-email-stefanc@marvell.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Thu, 4 Feb 2021 19:59:52 +0100
Message-ID: <CAPv3WKc0LhtLsBVKBP24pn84cUMj1MCOsCAM18EauxXEPk2zHA@mail.gmail.com>
Subject: Re: [PATCH v7 net-next 02/15] dts: marvell: add CM3 SRAM memory to
 cp115 ethernet device tree
To:     Stefan Chulski <stefanc@marvell.com>
Cc:     netdev <netdev@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>, nadavh@marvell.com,
        Yan Markman <ymarkman@marvell.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Russell King <rmk+kernel@armlinux.org.uk>, atenart@kernel.org,
        Konstantin Porotchkin <kostap@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

wt., 2 lut 2021 o 09:17 <stefanc@marvell.com> napisa=C5=82(a):
>
> From: Konstantin Porotchkin <kostap@marvell.com>
>
> CM3 SRAM address space would be used for Flow Control configuration.
>
> Signed-off-by: Stefan Chulski <stefanc@marvell.com>
> Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
> ---
>  arch/arm64/boot/dts/marvell/armada-cp11x.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/b=
oot/dts/marvell/armada-cp11x.dtsi
> index 9dcf16b..359cf42 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi

The commit message mentions CP115, but the patch updates both CP110
and CP115 - please update one of those (either message or the patch),
so that it is consistent.

Thanks,
Marcin


> @@ -69,6 +69,8 @@
>                         status =3D "disabled";
>                         dma-coherent;
>
> +                       cm3-mem =3D <&CP11X_LABEL(cm3_sram)>;
> +
>                         CP11X_LABEL(eth0): eth0 {
>                                 interrupts =3D <39 IRQ_TYPE_LEVEL_HIGH>,
>                                         <43 IRQ_TYPE_LEVEL_HIGH>,
> @@ -211,6 +213,14 @@
>                         };
>                 };
>
> +               CP11X_LABEL(cm3_sram): cm3@220000 {
> +                       compatible =3D "mmio-sram";
> +                       reg =3D <0x220000 0x800>;
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <1>;
> +                       ranges =3D <0 0x220000 0x800>;
> +               };
> +
>                 CP11X_LABEL(rtc): rtc@284000 {
>                         compatible =3D "marvell,armada-8k-rtc";
>                         reg =3D <0x284000 0x20>, <0x284080 0x24>;
> --
> 1.9.1
>
