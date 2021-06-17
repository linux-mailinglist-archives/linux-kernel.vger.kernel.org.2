Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F0E3AB7DE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 17:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbhFQPtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 11:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbhFQPtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 11:49:42 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D3BC061574;
        Thu, 17 Jun 2021 08:47:33 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id c7so3748431edn.6;
        Thu, 17 Jun 2021 08:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lk7/EHcABy0uGn74EGnMmedO8vl0ZDyyXsIzLqJ/JMU=;
        b=tyjupme6WZKvcs6O5cG9I7Br0ci3RubAZEj+Xmh9/ukduEZ5lmySa9Ob6IREfr/W0d
         l27IKzur1AluotOY0GUxuZFHSFHsHzkg7EddUfHkhmmOCeWw3HV4+HXd1xcD5deK2aM9
         wxP9AOUQYp82Kj265p+Gt/56HdyGTZeOTUb+SSDeaFFu5sM7fr/DD93RVitu88I1/I+u
         TDE0WYCB79zJAmWKv9ZCh4x1GDaix/DbzEafHfxCnultqqnmTKRZ4UflkmGMLJO6hVoe
         tQZzmfP8tn/N0MbTU5t2eTnzBzBnQjmCEicEPXFLvGktpoBz8LczDnwazqi0Dm1Lfh2y
         BqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lk7/EHcABy0uGn74EGnMmedO8vl0ZDyyXsIzLqJ/JMU=;
        b=nmyLWP23J5VJoIMBQ9CfZbFvXLMIvoYvJhxu3S6seARVUtA5w2+zoqZpogk/6Kaj41
         zIq9NfTWtKj+C/EKlA1fgRIcwqlBJTCuovhH7FV0VeavKxeUd+B7frFJZQywzmqytWMa
         3dbdixnvP12GNGi8nDeFRU4GZyu7DvApWau9jxA9mv9tRg8I4ePz96qn8IxN/h+SGfCG
         hiZgmKqr+VwuS6q/mFcO5pKUZ/+P2RRswtViAm0Knl6IznqaXPyNSP0SSmCEAG3pH7nn
         T2Zuv2VZGTfyjjDBJvNzvHrjLzk7CMlO5BUOURHrCszPNUfUvkteLmQ7zdzreJrn3Ccl
         mJ6g==
X-Gm-Message-State: AOAM530hs1UxOLjQNSPEDLoS1HZwJTWYUzDn8QELknbfrj4w4oeMrtTM
        cNglSBb1OzbW9cqFlQevQma6oOgNY3tKSA==
X-Google-Smtp-Source: ABdhPJzAyWffhjQQscfABwEcFJAeZ6PSFkN1A1tW2+1/ihFGU5LwCZv3yYsFVORcvM+LgLF0uuh0TQ==
X-Received: by 2002:aa7:d344:: with SMTP id m4mr7551638edr.281.1623944851670;
        Thu, 17 Jun 2021 08:47:31 -0700 (PDT)
Received: from jernej-laptop.localnet (cpe1-4-249.cable.triera.net. [213.161.4.249])
        by smtp.gmail.com with ESMTPSA id ci4sm3980380ejc.110.2021.06.17.08.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 08:47:31 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh@kernel.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 16/19] arm64: dts: allwinner: Add Allwinner H616 .dtsi file
Date:   Thu, 17 Jun 2021 17:47:29 +0200
Message-ID: <8040051.UxXjYCDM83@jernej-laptop>
In-Reply-To: <20210617154242.iovbze64up4u7wba@gilmour>
References: <20210615110636.23403-1-andre.przywara@arm.com> <20210616110630.54061205@slackpad.fritz.box> <20210617154242.iovbze64up4u7wba@gilmour>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne =C4=8Detrtek, 17. junij 2021 ob 17:42:42 CEST je Maxime Ripard napisal(=
a):
> On Wed, Jun 16, 2021 at 11:06:30AM +0100, Andre Przywara wrote:
> > > > +	reserved-memory {
> > > > +		#address-cells =3D <2>;
> > > > +		#size-cells =3D <2>;
> > > > +		ranges;
> > > > +
> > > > +		/* 512KiB reserved for ARM Trusted Firmware (BL31) */
> > > > +		secmon_reserved: secmon@40000000 {
> > > > +			reg =3D <0x0 0x40000000 0x0 0x80000>;
> > > > +			no-map;
> > > > +		};
> > > > +	};
> > >=20
> > > Can't this be added by ATF directly?
> >=20
> > It actually is, and if you use U-Boot's DT ($fdtcontroladdr), that
> > actually works. But as it stands right now, U-Boot fails to propagate
> > this to any DTB that gets *loaded*. Fixing this requires generic code
> > fixes, so I can't just hack this in for sunxi quickly.
> > So I wanted to keep this around for a while, as missing this is a
> > showstopper for booting Linux.
>=20
> It looks like we didn't need it for the H6, what makes it any different?

H616 TF-A resides in DRAM and H6 resides in SRAM A2 (IIRC). H616 has much l=
ess=20
useful SRAM due to ARISC removal.

Best regards,
Jernej

>=20
> > > > +		mmc0: mmc@4020000 {
> > > > +			compatible =3D "allwinner,sun50i-h616-mmc",
> > > > +				     "allwinner,sun50i-a100-
mmc";
> > > > +			reg =3D <0x04020000 0x1000>;
> > > > +			clocks =3D <&ccu CLK_BUS_MMC0>, <&ccu=20
CLK_MMC0>;
> > > > +			clock-names =3D "ahb", "mmc";
> > > > +			resets =3D <&ccu RST_BUS_MMC0>;
> > > > +			reset-names =3D "ahb";
> > > > +			interrupts =3D <GIC_SPI 35=20
IRQ_TYPE_LEVEL_HIGH>;
> > > > +			pinctrl-names =3D "default";
> > > > +			pinctrl-0 =3D <&mmc0_pins>;
> > > > +			status =3D "disabled";
> > > > +			max-frequency =3D <150000000>;
> > > > +			cap-sd-highspeed;
> > > > +			cap-mmc-highspeed;
> > > > +			mmc-ddr-3_3v;
> > > > +			mmc-ddr-1_8v;
> > >=20
> > > This is not something you know in the DTSI? It entirely depends on how
> > > the board has been designed.
> >=20
> > Are you referring just to the last property?
>=20
> Initially, yes, but the argument is for both...
>=20
> > This is copying what the driver unconditionally sets for the other
> >=20
> > SoCs at the moment (minus the H5 screwup):
> > 	mmc->caps      |=3D MMC_CAP_1_8V_DDR | MMC_CAP_3_3V_DDR;
> >=20
> > IIUC 1.8V operation requires a 1.8V regulator for vqmmc to actually
> > work, so this property alone won't enable anything.
> > But if it's just about the 1.8V property, I can of course move this to
> > the board dts files.
>=20
> ... Since we've seen boards with only 3.3v or 1.8v wired to vqmmc, so we
> should really just push this to the boards for new SoCs
>=20
> Maxime




