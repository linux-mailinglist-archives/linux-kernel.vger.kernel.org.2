Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69663237CD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 08:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbhBXHSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 02:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbhBXHRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 02:17:42 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB587C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 23:17:01 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id c7so817321wru.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 23:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0E5yhifL1T90IrGyMkqbKkYPvAgoE+nUQWUj2LPWCP0=;
        b=CnMPkPlPebDewujqh7cktFnvBctn8KkHpVdBeAbQq4yPpO6boZ6J3uVQhOw81DHQXR
         mfGJUxQISlHrJEE0Iu7d0ao1dZZtXIa70y+SMYCH5oP6PWCV+xHRz8L3dR8WrfFeo/AI
         sP3Cy6ypf/ruE7Rn1ail8fCZxR27SG0ezFsrSKuxwiuROkCLDqonXflF/70s2MYtViEx
         LcK4LiA1qYngEN2Ub4i21CoSV/O+U+SU8GeQ9vdqViQsteFGZHdCihluhE9FskNe2puI
         nT9c0c/J9bASJYJRef/GgsRV51flVKlyKunZNQK5BcpaFcGbOEby3PBaVh52AIAH3KgV
         9Dgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0E5yhifL1T90IrGyMkqbKkYPvAgoE+nUQWUj2LPWCP0=;
        b=uKDh+ivCeewOIUeLxu1bgrlq9GHzqbskfkwbkMMQkIsKmLhQK2ohhIYM3bknz9Ag/6
         62VD5t+jaO6piJzsgcUBMhZPQ0qTd71liTiRcGjVSzehAsauvXN0cnqHEtYjNdOs+W3M
         +MuLFoCHJcH7X00+pUAtorPuTGRPBgenJJHJe+TUg95dc9TQGG3qwbrekXQzI+4une6z
         UBRj0zzFDtGYtbMH0CDVuJBzxGfl+EHHnEAhZC8L2MiEK+aebip5KJw/9IAQkGy6l2zw
         nehivL4OHkC/xXSs4Vv5bP+0i+9oV6v4HgDcF4weBEIEpTyG9jYJL2dlpYFwBXkzGYB1
         4hnQ==
X-Gm-Message-State: AOAM531j8EW2RofYqFHkxVE7D7YFrtNnqrvKN6fCdT8Flm/aSUE/I65x
        6VwzGzgEFMUMthxeg4p43o4=
X-Google-Smtp-Source: ABdhPJypZFTP90apxHS5NuiPUFUcAXaNgcvfUauvqg95MidGk51f/XpLoS23ssJDh1DQ9oB5MVchkA==
X-Received: by 2002:a05:6000:1543:: with SMTP id 3mr30716137wry.254.1614151020681;
        Tue, 23 Feb 2021 23:17:00 -0800 (PST)
Received: from macbook-pro-alvaro.lan (170.red-88-1-105.dynamicip.rima-tde.net. [88.1.105.170])
        by smtp.gmail.com with ESMTPSA id p9sm1330821wmg.10.2021.02.23.23.16.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2021 23:17:00 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH] nand: brcmnand: fix OOB R/W with Hamming ECC
From:   =?utf-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>
In-Reply-To: <32837cb2-f7ba-d59e-de66-051019b21e89@gmail.com>
Date:   Wed, 24 Feb 2021 08:16:58 +0100
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0670B343-C39E-4610-8061-A7F81F90B9F4@gmail.com>
References: <20210222201655.32361-1-noltari@gmail.com>
 <32837cb2-f7ba-d59e-de66-051019b21e89@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

> El 24 feb 2021, a las 4:46, Florian Fainelli <f.fainelli@gmail.com> =
escribi=C3=B3:
>=20
>=20
>=20
> On 2/22/2021 12:16 PM, =C3=81lvaro Fern=C3=A1ndez Rojas wrote:
>> Hamming ECC doesn't cover the OOB data, so reading or writing OOB =
shall
>> always be done without ECC enabled.
>> This is a problem when adding JFFS2 cleanmarkers to erased blocks. If =
JFFS2
>> clenmarkers are added to the OOB with ECC enabled, OOB bytes will be =
changed
>> from ff ff ff to 00 00 00, reporting incorrect ECC errors.
>>=20
>> Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
>=20
> Should there be a Fixes: tag provided here for back porting to stable =
trees?

I think so, but the fixed commit would be the first one, right?
27c5b17cd1b10564fa36f8f51e4b4b41436ecc32

> --=20
> Florian

Best regards,
=C3=81lvaro.=
