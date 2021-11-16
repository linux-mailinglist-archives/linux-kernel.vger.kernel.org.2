Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B7B452EDE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 11:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbhKPKUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 05:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbhKPKUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 05:20:14 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D21C061746;
        Tue, 16 Nov 2021 02:17:16 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id g18so17720379pfk.5;
        Tue, 16 Nov 2021 02:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bK/sBg1C1mqhkenG14RiC+8MTOJxXLOUrcmyZaUVyW4=;
        b=fO6qLwGdeF5+TEv117IqCHwmxC6wAcvUAmkScjX8pIPgSOWX7lZXnzKtt9/0DJQzf7
         guxUyJk3eZXcPtWEU38OBSKX7PSliXkdE882G/uW4iL7TP/snLRrDeP4058Hwlogwwra
         bfVV/UaE7brD+/lCt0ibdRLOlVUMwFoCxnS2becACEJ1nLFryZG/MxXD+jiCwNcucmH0
         iU1j7qzfoRwuNi0+aDLXBarYqIoZAUi2CSgK+Z+ol76b0L5lFnhEr2CRoiXHyrxPI5gh
         vjSn1tgkeOmaVb3fJWXN95OEgQmcqs23fVbSmSy6Wch6ZSVTf9xmz8Emon3Nm7zMw9/C
         +p/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bK/sBg1C1mqhkenG14RiC+8MTOJxXLOUrcmyZaUVyW4=;
        b=W8ByzpIKEFFr5Bwco4XdonEl5SJsBaNtfx1EJjT3ANNrU7WqR4Di1GK66dPc+D2gkR
         epklyLKrhOROuNUqTVResJUQh/+8zr/H+4NXrR/4MfUpslJnGKmsxRk6lXQGlk4tX0S1
         T02+0XOt9nDay181ufJzVV0y7tvrjTOqdAuYAYWOdYiX8uWE1lwPo+10dkksXyoMGW7s
         MYH18jEZ53K7+6oD0TlALhj77Y7HoKWAHWzBKDpri7Ut/GzgubgTizyMsc9gsniJMyxA
         zljxoM4hvz6Brr4nDNbZQtaPiCTZ+MJ+s9XW1BWHinShBRUTZQal1/rG5HR9G5KgEtGe
         ZcJQ==
X-Gm-Message-State: AOAM533RhVgI6rhOYylH2FaihdO0LqrnqQHfaH5Nn9Rx/TUjQQMSGXak
        z+7Gt5cfvt6ayBRxfp93naw=
X-Google-Smtp-Source: ABdhPJwcPgRjL6cWhG7a5Aah8i0pQlt+CeWTnvNnrq5EfYPd9UdjMvWVAjqqcMK7Dt73jhnKjln5Ig==
X-Received: by 2002:a05:6a00:a8e:b0:480:ab08:1568 with SMTP id b14-20020a056a000a8e00b00480ab081568mr39520666pfl.28.1637057836076;
        Tue, 16 Nov 2021 02:17:16 -0800 (PST)
Received: from localhost.lan (p4899162-ipngn25301marunouchi.tokyo.ocn.ne.jp. [122.18.9.162])
        by smtp.gmail.com with ESMTPSA id lp12sm2350797pjb.24.2021.11.16.02.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 02:17:15 -0800 (PST)
Received: from localhost (localhost [IPv6:::1])
        by localhost.lan (Postfix) with ESMTPSA id 7B272900949;
        Tue, 16 Nov 2021 10:17:13 +0000 (GMT)
Date:   Tue, 16 Nov 2021 10:17:13 +0000
From:   Vincent Pelletier <plr.vincent@gmail.com>
To:     Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        David Abdurachmanov <david.abdurachmanov@sifive.com>
Subject: Re: [PATCH] riscv: dts: sifive unmatched: Name gpio lines.
Message-ID: <20211116101713.77a0df69@gmail.com>
In-Reply-To: <11612716.TMCrJ2abzX@diego>
References: <f6512cc50dc31a086e00ed59c63ea60d8c148fc4.1637023980.git.plr.vincent@gmail.com>
        <11612716.TMCrJ2abzX@diego>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, 16 Nov 2021 10:39:04 +0100, Heiko St=C3=BCbner <heiko@sntech.de> wr=
ote:
> Hi Vincent,
>=20
> Am Dienstag, 16. November 2021, 01:52:56 CET schrieb Vincent Pelletier:
> > Follow the pin descriptions given in the version 3 of the board schemat=
ics.
> >=20
> > Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com> =20
>=20
> when sending a patch series with "git format-patch -6" and friends will
> automcatically generate x/y additions like "[PATCH 1/6]" and so on.
>=20
> Please try to keep them around when sending, as automated tools for patch
> handling like "b4", stumble when they encounter a patch series without th=
em.

Actually my intent was to not make this a series, as in my understanding
independent patches should/may be submitted separately from each other.
They just happen to be stacked, and in this order, in my working copy,
but should not functionally have any dependency on one another (I
believe they should even apply cleanly in any order).

It is only after sending that I realised that
  git send-email --no-thread [...] v5.16-rc1..riscv_for_upstream
still decided to thread the emails...
Which indeed makes my use of "--no-numbered" a mistake. Sorry for not
checking --dry-run output more closely.

> In this case a
>=20
> 	b4 am f6512cc50dc31a086e00ed59c63ea60d8c148fc4.1637023980.git.plr.vincen=
t@gmail.com
>=20
> [first patch in the series]
> will actually only retrieve the last patch
>=20
> 	"[PATCH] riscv: dts: sifive unmatched: Link the tmp451 with its power su=
pply."
>=20
> as it thinks it's a new version of the first one.
>=20
>=20
> Thanks
> Heiko
>=20
> > ---
> >  arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch=
/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> > index 4f66919215f6..305a086e5207 100644
> > --- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> > +++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> > @@ -245,4 +245,8 @@ &pwm1 {
> > =20
> >  &gpio {
> >  	status =3D "okay";
> > +	gpio-line-names =3D "J29.1", "PMICNTB", "PMICSHDN", "J8.1", "J8.3",
> > +		"PCIe_PWREN", "THERM", "UBRDG_RSTN", "PCIe_PERSTN",
> > +		"ULPI_RSTN", "J8.2", "UHUB_RSTN", "GEMGXL_RST", "J8.4",
> > +		"EN_VDD_SD", "SD_CD";
> >  };
> >  =20
>=20
>=20
>=20
>=20




--=20
Vincent Pelletier
GPG fingerprint 983A E8B7 3B91 1598 7A92 3845 CAC9 3691 4257 B0C1
