Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387E4324B97
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 08:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235323AbhBYHy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 02:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbhBYHyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:54:53 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A4FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 23:54:13 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id o10so4442315wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 23:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/YTWgHJSzDoLcdRHp3K06tTL/4voTQM5gU7wWtCbIhs=;
        b=X9oY7LgKI8IICMXKkoWol/GMZJkZNjUPRisxcOjqbWEpjFZo+59sbSQqp9xe7+GGw1
         /wpo5nXwa8TfzQEMX4dcNmXllvS5Omeg3Cwcw1dZ2Nz8EYDKLgib3SZxKCDfUKsCvKmN
         /JdKMqfEdj2mLW/ksaGxa9gfnluFw05I6olmE6lBSloHxBdp5CEBBvC0f+Jn2VsOMpe6
         KCrrxQR9oBNya4XpjW5MeIAjfkDJgvoR/IjjKwDmhsUBTD3IfFQXzoamqHXLji4Aq1XG
         bE9u4P1NnQ0E40JKsfchTMEXK4C02EfDDC9Y6akI0AJz142TgN1LII4XHIc282lpcu5t
         hAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/YTWgHJSzDoLcdRHp3K06tTL/4voTQM5gU7wWtCbIhs=;
        b=KGK1rq6tHcoo8XgtBLnz8/MVzHrv8XmoGjo9DQzbbuqd86mqqooCllilw8aZD3ipTM
         Lo0hUEUwbflYfkc068ABKxNFdMPwNdcbSf0Byaobiy1FPSRgQ3kfTdtlFRhcJNpuYa6z
         hVNzu4BVBXDBvCP+PKM4MN8cWYVmKPH3zFhAe0rbilN+ZIpEeydoWkV+ZkfVcscenuv7
         gu+xk1DQ17sjpKhiEBwuSGg08rUyt5aKgoEtxrucKAgSA9GfSBJ65axgygL0HqoVf7GW
         6mZzMvyYzbPU5jBvPwpPnoIdEHY7neT2QhqHXfgwJ95VSrOSWpM5zutl3r4ZT0C/j8R5
         Z5hg==
X-Gm-Message-State: AOAM532OaxB5Za3cCeva0z73dMd8NwVpKn1edh3zGzXOTWGolf1869cE
        M8oV4AGl4u8RdZYDHmzMcXU=
X-Google-Smtp-Source: ABdhPJz0IELhpxpt5w7rC65AC6Uu+FtdxGUxq5GrLncfYR0FdKcAZEswxwvCeaCNCpIxFwPTlovmZQ==
X-Received: by 2002:a7b:c083:: with SMTP id r3mr1904293wmh.177.1614239651927;
        Wed, 24 Feb 2021 23:54:11 -0800 (PST)
Received: from macbook-pro-alvaro.lan (170.red-88-1-105.dynamicip.rima-tde.net. [88.1.105.170])
        by smtp.gmail.com with ESMTPSA id z9sm6873830wrv.56.2021.02.24.23.54.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Feb 2021 23:54:11 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v2] nand: brcmnand: fix OOB R/W with Hamming ECC
From:   =?utf-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>
In-Reply-To: <20210225084838.34bbdbff@xps13>
Date:   Thu, 25 Feb 2021 08:54:09 +0100
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4DF5654C-1412-4E89-BF21-60C649EEDF4F@gmail.com>
References: <20210222201655.32361-1-noltari@gmail.com>
 <20210224080210.23686-1-noltari@gmail.com>
 <CAN8TOE_Eg6zYqy8wLtrNcTiCQdcihM7wGM5JHw=bh4=b1CL-_A@mail.gmail.com>
 <20210225084838.34bbdbff@xps13>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

> El 25 feb 2021, a las 8:48, Miquel Raynal <miquel.raynal@bootlin.com> =
escribi=C3=B3:
>=20
> Hi =C3=81lvaro,
>=20
> Brian Norris <computersforpeace@gmail.com> wrote on Wed, 24 Feb 2021
> 13:01:13 -0800:
>=20
>> On Wed, Feb 24, 2021 at 12:02 AM =C3=81lvaro Fern=C3=A1ndez Rojas
>> <noltari@gmail.com> wrote:
>>> Fixes: 27c5b17cd1b1 ("mtd: nand: add NAND driver "library" for =
Broadcom STB NAND controller") =20
>>=20
>> FWIW, I could believe this was broken. We weren't testing Hamming ECC
>> (nor JFFS2) at the time, so it could easily have obvious bugs like
>> this.
>=20
> Right, you should probably limit the backport to the time when raw
> accessors got introduced/fixed.

What do you mean?
Those accessors have been there since the first commit =
(27c5b17cd1b10564fa36f8f51e4b4b41436ecc32):
=
https://github.com/torvalds/linux/blob/27c5b17cd1b10564fa36f8f51e4b4b41436=
ecc32/drivers/mtd/nand/brcmnand/brcmnand.c#L1896-L1899

>=20
> Thanks,
> Miqu=C3=A8l

Best regards,
=C3=81lvaro.=
