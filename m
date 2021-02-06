Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0330311CFD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 12:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhBFLwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 06:52:42 -0500
Received: from mout.gmx.net ([212.227.17.20]:58121 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229707AbhBFLwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 06:52:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612612258;
        bh=HQRvOd7R+XGLJh5/A0+URGFieXzXq8K66bXLp9TitJc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jotPSxi2gj4m1M0enmSN3AZoHWT40/czP9/WC0woKO0ucSUMhjVFd5Y0/ZoBIdnIZ
         GliLM3WqytmVJ8L9nYXK8AaBrob7sVnRT1y0nAVUMrd1msdI27UCje4CW6s3E/Qnay
         x8mHVgaDyI+QOpFlozAo0it+2sh2Jqvj5bpP0WYM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.167] ([37.4.249.89]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPogF-1lLMh729kR-00MvcP; Sat, 06
 Feb 2021 12:50:58 +0100
Subject: Re: [RFC/PATCH 09/11] ARM: dts: bcm2711: Enable V3D
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     phil@raspberrypi.com, linux-kernel@vger.kernel.org
References: <20210205135249.2924-1-nsaenzjulienne@suse.de>
 <20210205135249.2924-10-nsaenzjulienne@suse.de>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <bb5c1091-8e3a-c13a-1f75-3c2bc1a40632@gmx.net>
Date:   Sat, 6 Feb 2021 12:50:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210205135249.2924-10-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:UuGM7JJSSCyFqp62EFvQsewyj3POYV88WAMG0nLsE3jr9exgP8a
 xR10r2+TKg4tICSJb/4dCgaZvA401yOLSXYB4T/PH9p6nIWCbOQICDHv8U150E3lVLcIX7p
 boy8kJxfMumlk1buzbIo1I90fkywqveLjTOAkv1qeEwKPf9eyqVbIYAIfLYJk1goSaIGV+r
 6bYeNuoblfdIyHOoet5wQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:k4eAxP1S9EE=:5daa6BEohiVAajSS55KHvv
 alnktLEsYxmp8fRBn5JJS63xhee7gkadnzVZnB/yaQJefe1SbctyKQ2OTcbB0eaVX2BoTKy3v
 AXLH4vLf4Jx15O/pKy8kwCklC7oEekT0gboDyVgV44/YUqoCWl4sSP+il0sIE06c9PF7s49ML
 J4z5Y/ThFpJIChRR8BCwMU7w4NxyuLCqxl3+qbiQa7BH9OtZGvizp/kyuCI0OU274DpStKaf5
 TEpilyyKH60XUY/6/oMRg9MPwiXu9e+T+Bj4cNGOUJIha+CjL+BCKuRn8LLy+nqCJFQpCih5d
 N/ixOIsIZFKMje24/VUxPgaITjqgnO0ME9uKcsQYoE11tqVYfUXt2n0E4xG0oVtiMp0JA4Za5
 BVhN37b08Kk1pusKwOuO+sV7zKAfPGLW4gw0e8n3iF7t7AeC5Eo1l1Mvz2DJJPIK3q+Zn3FQY
 8R0C+pMnl+LeaeoGIs54y8VMvQm03ixEGaor6i587q155uqlbTFUY8YCoK9LwFLvtAxd5KIwH
 mrrZIIVohRXKsEMXh3jQNI5CW73so5pM49B+oGqxeBkOY9/chw+mtrs0Y+kgycgphqFZx/zJr
 D6yg6RH5Ptk0b5COFH9GL0rT19JTx7Cy6T5P6563hZaCewqWuKIOeH+BV2GiZkNnooHVBaNyW
 3Fca3UukCw5koN1iuW4SFV4fg4WMZTeRQS4/ZNBuKaApXY7VdediCzxrYhcO27JbeDaNdzPjJ
 Hhq1iB1FnnZnPXFSDwl6YkzP+l6ETw28mYVHPIk/EkxpeVqLxH9bZfKhNqIWI6ktJkNZKY6GZ
 yE231F3IGGL7soJ/7lsptLmCCLthjM4ZwFn9z9t1CN0ontMJcncQ+IeVnsXLWGY0HICoV6QvD
 FqcXVEAYZF6pXX7rnq0g==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 05.02.21 um 14:52 schrieb Nicolas Saenz Julienne:
> This enables V3D for bcm2711 (used in the Raspberry Pi 4).
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  arch/arm/boot/dts/bcm2711.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.=
dtsi
> index 537498a93a3a..dd8376f474db 100644
> --- a/arch/arm/boot/dts/bcm2711.dtsi
> +++ b/arch/arm/boot/dts/bcm2711.dtsi
> @@ -548,6 +548,18 @@ genet_mdio: mdio@e14 {
>  				#size-cells =3D <0x1>;
>  			};
>  		};
> +
> +		v3d: gpu@7ec04000 {
just a nit. I prefer the lowest register value here.
> +			compatible =3D "brcm,bcm2711-v3d";
> +			reg =3D <0x0 0x7ec00000 0x4000>,
> +			      <0x0 0x7ec04000 0x4000>;
> +			reg-names =3D "hub", "core0";
> +
> +			power-domains =3D <&pm BCM2835_POWER_DOMAIN_GRAFX_V3D>;
> +			resets =3D <&pm BCM2835_RESET_V3D>;
> +			clocks =3D <&firmware_clocks 5>;
> +			interrupts =3D <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
> +		};
>  	};
>  };
>
