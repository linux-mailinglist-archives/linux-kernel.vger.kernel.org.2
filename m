Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D97431B7AA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 11:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhBOKxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 05:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhBOKwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 05:52:47 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17B0C061756
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 02:52:06 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id z32so4510838qtd.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 02:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DCasf8LNJD3cpLAIKwcnQnDK/FG08P6hSVCIDrM0RYw=;
        b=bR3APCUVPyfLWINvrsY4rBV0tJPJ2vJxl2MMA4PfaJ9+ToWe+gmABk6gZvl30hLPiT
         Q34qAj8AovuCyXI6WNPkM8emBbiL1eVMqTYKLakHTfx7Z2S/QZ6QhkbLxpeiX3plotSj
         2RvernIzAgYaTwhQ2V1J8vPJl8dDd8BV/yiak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DCasf8LNJD3cpLAIKwcnQnDK/FG08P6hSVCIDrM0RYw=;
        b=uDJv2N4w1u6JjUUZq/uZ+yf//ieZuDl0e726YfQ+bZY0lJPBUTwoMerTAvfP1DgXOX
         /3FQ897uubr2KBm/BfrlTsZmpszUB2DBFaXy4mjM232h+XKWJF79Pz4idE+MRSe/aUcU
         2WIJlNOsoO49tyHMRxErQXZvNiaHvcgFwIkRq3FJueOZPeBUMubQ4pvC/o2/0q2A79O8
         PaXUGyBO/qOFmOJjtyM1UJXRQouy4jwszZLLvbETj6Qgipc6AoG2zwQPkmteQB+X5E3t
         5fAbJRvZ4aQMMfbNPW6j/0xfcaDEzXA+AuXIjQHRX9prj9roaFGnk15zCewxeJDFChrs
         HZqg==
X-Gm-Message-State: AOAM530aiaPzk68FVdFipWYihgrCQpbgkjzYfxC/BlgblNt/9nnT4b61
        mZRYP4FeZ8e/tDjmEjs41eYzqqM6MHOp1oizTzrczg==
X-Google-Smtp-Source: ABdhPJxBW6NjQrjDEqO6MyiBnClPreVbGfoQc5q2VUQgBvJ8XJWDhokzI83V1C9hl0pmFiDPDXNm4SEGE/ZEEXaT0bU=
X-Received: by 2002:ac8:5dc8:: with SMTP id e8mr13664866qtx.249.1613386325969;
 Mon, 15 Feb 2021 02:52:05 -0800 (PST)
MIME-Version: 1.0
References: <20210213095724.3411058-1-daniel@0x0f.com> <20210215112409.1a755bf0@xps13>
In-Reply-To: <20210215112409.1a755bf0@xps13>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Mon, 15 Feb 2021 19:53:13 +0900
Message-ID: <CAFr9PXkh+attaCc6C2UxB=qvXksWriWOaaoEndy4k6SGE0QOHQ@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: spinand: add support for Foresee FS35ND01G-S1Y2
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On Mon, 15 Feb 2021 at 19:24, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Can you please add a changelog here when you send a new version of a
> patch?

Sorry, I was going to add a cover letter but elsewhere got told that
one isn't needed for a single patch..

Basically I changed FS35ND01G to FS35ND01G-S1Y2 as that's the proper
part number for the chip I have and there seem to be a few variations
of this.
Aside from that I fixed up the hex numbers to be uppercase and added
the oob layout callbacks.

> > +static int fs35nd01g_s1y2_ooblayout_free(struct mtd_info *mtd, int section,
> > +                                 struct mtd_oob_region *region)
> > +{
> > +     if (section > 3)
> > +             return -ERANGE;
> > +
> > +     /*
> > +      * No ECC data is stored in the accessible OOB so the full 16 bytes
> > +      * of each spare region is available to the user. Apparently also
> > +      * covered by the internal ECC.
>
> How is this even possible? ECC must be stored somewhere, maybe it is
> not possible to retrieve it but I guess you cannot use the 32 bytes of
> OOB for user data. Can you please verify that?

This worried me too as I could not find the OOB layout anywhere.
They simply list there being 4 512 byte main areas and then 4 16 byte
spare areas. The only other note is that the first byte of spare0 is
used for the bad block marker.

I contacted Longsys but they didn't get back to me.
So what I did here was I started googling strings within the datasheet
to find other chips that are probably the same IP inside and I found
the FM25G01.
It's datasheet shares a lot of the same text and the flash layout
diagrams etc are the same.
It has the same table for the flash layout. 4 512 byte areas and 4 16
byte spare areas. It has the same note for the bad block marker and
then one additional note:

"2. Spare area 800H to 83FH is all available for user.
 ECC parity codes are programmed in
additional space and not user accessible."

It would seem that the pages are actually bigger than 2K + 64 or there
is some other place they keep the ECC.
Or both datasheets are lying. Somewhere else in the datasheets it says
that writes to the ECC area will be ignored but that doesn't make a
lot of sense if the ECC area isn't user accessible in the first place.

I didn't think about it at the time but I can take a dump of the OOB
area of my FS35ND01G-S1Y2 to confirm it's all 0xff except for any
factory marked bad blocks.

Thanks,

Daniel
