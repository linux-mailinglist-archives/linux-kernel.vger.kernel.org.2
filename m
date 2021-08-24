Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6EFB3F58C4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 09:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbhHXHQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 03:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbhHXHQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 03:16:44 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17266C061575
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 00:16:01 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id t190so22109794qke.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 00:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nO6QiAuYOKzYLFYQBkUMt83uxXuhMKn+vcrDe8N7Myw=;
        b=NQCYPJsFE+cz8oLZHaLKvY1hapGUvckIn/W+LHhbvL5Fp1vemWnh1xrf3aQDcJ5eOe
         yv91HjjzPxo7qNua6HdCAyiRs6bl+HUJpQnjqmC++f08jJUMbHYq4e7UnwPuodVKG6fB
         5TuhgxQfUyHCgptMWAYv1pCsxxNXZmqDLzbSWhX52I3xajobS4nm/aBf+D96fTP2SCJd
         e+bQ9k+dTFT++1xCNvr+4yzWquIP0xF60rMfmmb0Asn7h0CjUo7E7CLy0JbSUVgBHUqy
         9tlZcnsEz19hWmpduZjuq2LNsNfd+nNkqBRAh7biLIG6cpPmIoK1UkdI4JDQoh8IoXjY
         MsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nO6QiAuYOKzYLFYQBkUMt83uxXuhMKn+vcrDe8N7Myw=;
        b=L86SG7AIFm35SuyKyZZMDsOR8LFaCVvJkT+pG34hWiW9vVeL5Rqo9B+jhpY/qwylVq
         ad6GbIpsxBkINLfU+imkWlMr8q2+HLyd2kkkii/6t2RBZQTvjtHhCsqk82nOOGdqbtR1
         DTOsZPdojRG+ZPQ/XOoOk+YN0DwABKaxboGOyy+GTQ8zQMbaCNMzm6ac0XwiT06egJnW
         EyPIjuGtTHjOJPal9fqTvyDuRMFsNaHz7cUV4UyIrBk8EldWKLmpDrcBFgmyBVSWHf+0
         r7yibMgtAsLBalNleuRp0TAp9htvdtM0rCsqExy/RCY2D68Y5X+ZGsx5H5T+CeRNKyH+
         +Zvw==
X-Gm-Message-State: AOAM530zWVNW0yVvmEH5GjjBbX2mLcpekds3zb7ywmaYTc3jV0zwYtNd
        VFa3iCAkKOkLtn+blx9PnigLz//TDQNplXWu4T8=
X-Google-Smtp-Source: ABdhPJz1r887+fiHyImSLRfbYswX0aTfUiZbEql2lYXW6rOZPN0K63Xp580mRKNZSBrtbO4LPH+VibGz8+k96mxl12s=
X-Received: by 2002:a05:620a:1655:: with SMTP id c21mr26076061qko.187.1629789360322;
 Tue, 24 Aug 2021 00:16:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210808072643.GA5084@ubuntu> <20210816093126.442f74a1@xps13>
 <CAE9cyGQ+Bb3rQxiF4My9zXwg_+QYifaCckE=C6spAtN9_4dBFQ@mail.gmail.com>
 <20210819100334.6af2d86e@xps13> <CAE9cyGSF2vTCptSZd3uMFaZPD=as=PwZY14S+zDhzjWCmsfmpQ@mail.gmail.com>
 <20210823172413.0bc4ab3a@xps13>
In-Reply-To: <20210823172413.0bc4ab3a@xps13>
From:   Kestrel seventyfour <kestrelseventyfour@gmail.com>
Date:   Tue, 24 Aug 2021 09:15:49 +0200
Message-ID: <CAE9cyGTKFcMuxePo2SgxkBe_cWvP5nZ_SDcnuUtwaE5o9oVq3g@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: rawnand: xway: No hardcoded ECC engine, use
 device tree setting
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miqu=C3=A8l,

Am Mo., 23. Aug. 2021 um 17:24 Uhr schrieb Miquel Raynal
<miquel.raynal@bootlin.com>:
>
> Hi Kestrel,
>
> Kestrel seventyfour <kestrelseventyfour@gmail.com> wrote on Mon, 23 Aug
> 2021 13:19:43 +0200:
>
> > Hi Miqu=C3=A8l,
> >
> > Am Do., 19. Aug. 2021 um 10:03 Uhr schrieb Miquel Raynal
> > <miquel.raynal@bootlin.com>:
...
> >
> > thank you for your response.
> > If I remove the nand-ecc-xxx properties in the device tree, the device =
with
> > the Toshiba NAND chip is working. However, the device with the Micron
> > NAND fails with NO ECC functions supplied; hardware ECC not possible,
> > seems to be at line 5367 or equivalent.
> > https://elixir.bootlin.com/linux/latest/source/drivers/mtd/nand/raw/nan=
d_base.c#L5367
> >
> > It looks like the micron nand driver supports on die only if its
> > specified int the
> > Device tree:
> > https://elixir.bootlin.com/linux/latest/source/drivers/mtd/nand/raw/nan=
d_micron.c#L511
> > The Micron NAND driver probably needs to set the ECC type to ON DIE if =
the
> > variable ondie contains the supported attribute?!
>
> You're right but I don't see any easy upstream-able solution here.
> Changing the behavior in the Xway driver would certainly break users,
> changing the behavior in the Micron driver would certainly break even
> more users. The root cause being an absence of proper description (the
> integration changed). Honestly I feel stuck, maybe you can try to
> register your device, if it fails, change the integration in the driver
> (to an ondie ecc engine) then retry?
>
> Thanks,
> Miqu=C3=A8l

Do you think adding something like below at the following location
https://elixir.bootlin.com/linux/latest/source/drivers/mtd/nand/raw/xway_na=
nd.c#L223
would be upstreamable (with or without device tree property?)?

        err =3D nand_scan(&data->chip, 1);
        if (err /* && of_property_read_bool(np, "lantiq,retry-on-die") */) =
{
                data->chip.ecc.engine_type =3D NAND_ECC_ENGINE_TYPE_ON_DIE;
                err =3D nand_scan(&data->chip, 1);
                if (err) return err;
        }

It still throws the kernel warning on first try, but the second try then wo=
rks.

Thanks Daniel.
