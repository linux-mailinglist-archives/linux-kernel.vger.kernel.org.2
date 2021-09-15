Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A8540CA20
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 18:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhIOQco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 12:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhIOQcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 12:32:43 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46A1C061764;
        Wed, 15 Sep 2021 09:31:23 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id g21so5786231edw.4;
        Wed, 15 Sep 2021 09:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EFqug29mO3vbFWGSrI/1RvpvL9yEVHmFJFSMpcyO/D0=;
        b=UXufWIgN+iIt2kTGcgk2/QvgWZXZxZmsFdb+oZHQ/ZaIWInpXjpPT1TO19otc7dapr
         xCU8SGOLOJYNO5DtjYXx6VtC2Xcph0fy1/m13VC658uw+4m8WeYnejuSuN7uoijpZeCH
         7osLtNe+9H1/WyAHbX+HjTYIq/x3wnIkv1eU/dBIyIawdUue/tJd7U0FVmKSUBcc/hp8
         jqNASK8RoNT0KmuKhxlyqzbLtiH70OqW4gHyWCbo83Q1CifY0i0RfxFMa2nsIHo4vYVf
         hWyE0fkxO4errp83fDAqDSfZT3Y1Av30dnq9UnfXumsucC/J6eprSfHOhY/T+7rzs951
         DKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EFqug29mO3vbFWGSrI/1RvpvL9yEVHmFJFSMpcyO/D0=;
        b=n8zWKQHUGb4Lj6r73qW33F5BKWoS8NqK8M5oE1nZ1N5ESIL7f3JknLLiiQ2cMny1Vj
         1KR7WC3U9ylBpLEf1zmU9LLThrWpZL2gzlE32xLuwEkk97OJ9LjvbJPiyof4Ql1esZ7t
         VoiTMFWADU1af5Jj/vcvb/1xgiSdkeugE6EwDoHeQhjwD0VVwqFgkB3z5NqfGZ/GyoM5
         t7T2JnfP7DyDSOhZ3fetjuWX4HyBe11K4Eta2P6O8uywZWTVre8FjtVrppmn6ucc8Ds4
         XVWa1eQlkz+ckC1J3AQzpgdyuOUrQBpTFpQ+b8Iz64QGL1SPGNQajjGVDpYSAk+jMknu
         Ih2w==
X-Gm-Message-State: AOAM532CEm1mElvSm+MgLdRX4SOUIJ1nAE5HW+xIIz2IsoSFEvtyFRuq
        MtKEY6bFX22JMwQ0cObUzrw=
X-Google-Smtp-Source: ABdhPJyNT5tuWqL5VdFq6b5f10J9qWPN4RnW1uZ2pn60g/i01gH6ZIFSvdpUuCcq2ox80ka2Twlc0Q==
X-Received: by 2002:a05:6402:1c87:: with SMTP id cy7mr892737edb.311.1631723482246;
        Wed, 15 Sep 2021 09:31:22 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id kt19sm207194ejb.26.2021.09.15.09.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 09:31:21 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Dang Huynh <danct12@disroot.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] arm64: dts: allwinner: pinetab: Add HDMI support
Date:   Wed, 15 Sep 2021 18:31:20 +0200
Message-ID: <2776109.MaXvng3DlT@kista>
In-Reply-To: <4816863.IXWdtHWlKd@melttower>
References: <20210914193732.3047668-1-danct12@disroot.org> <2558517.IGp7HM5rsX@kista> <4816863.IXWdtHWlKd@melttower>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 15. september 2021 ob 07:47:31 CEST je Dang Huynh napisal(a):
> On Wednesday, September 15, 2021 3:26:51 AM +07 Jernej =C5=A0krabec wrote:
> > > +&simplefb_hdmi {
> > > +	vcc-hdmi-supply =3D <&reg_dldo1>;
> >=20
> > You have to set status to okay here.

Sorry, this is actually the job of bootloader, so it's all good.

> >=20
> > With that fixed, you can add:

No fixing needed for R-b tag.

> > Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> >=20
> > Best regards,
> > Jernej
> >=20
>=20
> Is it really needed? The DE2 HDMI driver can be loaded and make this pret=
ty=20
> much obsolete.

DE2 and HDMI driver could read current settings from that node and implemen=
t=20
flicker free transition. However, that's not supported yet. Another use cas=
e is=20
to optimize kernel size to minimum for storing it in SPI flash by removing =
DRM=20
driver if simplefb is good enough.

Anyway, patch looks good. Thanks!

Best regards,
Jernej


