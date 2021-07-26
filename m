Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5B23D50C0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 02:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhGYXr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 19:47:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:52556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230075AbhGYXrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 19:47:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09C9860720
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 00:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627259275;
        bh=5EChaJLtwzbVLsyJuV9buEjUeWDZmjFho5daWXnpViA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MppDXIdsiBMiySzBFpji3JswurhlZiUe4vRlRAsMMDXmb1oOYcXFlnh1ct7FL7/GO
         +yB+20IZLC8fgYfYELzwf+WwfjDSS0/6c3FOxwdHBvChATAFfviwTAaeIpEE5vDTgS
         rJKHJH3lNKZItUrFxKZqoqrJNWuQSbF+JuV/zi74WbTpbmRnV9vr7TYAkMEpSsi4cv
         HLTrYfjOWYcqCwdWMaFYxDMdCJxKnhzWr4S0WEZidBtds36Krmi+BSZ1Abq7iM6bVc
         0JTBxQk8q503JTxwlGg8fYDGpKsClKjfR7UIQHfmZyLSpvi2G3VEb8TXQVMfvMbJ1G
         FQ6UYY3V9bZ7g==
Received: by mail-ed1-f42.google.com with SMTP id y12so298359edo.6
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 17:27:54 -0700 (PDT)
X-Gm-Message-State: AOAM531Hb5hhQ+1DLKs7pE/ZsjazELT2wtKO0r8wb7g1C9JBP8laRP9y
        7RTdRsZU0ILv+H7Awi2eMN3BKptNp2myrE4RLw==
X-Google-Smtp-Source: ABdhPJxRxMiVcAhVNADQkv4nKSd6s3qZWXOhXefQlHs2yzs/g7fStJDFNaMTrIHfMGLrgfiBNRfAzU7erf01ulqv+y0=
X-Received: by 2002:a50:d71e:: with SMTP id t30mr6473038edi.72.1627259273649;
 Sun, 25 Jul 2021 17:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210710132431.265985-1-linux@fw-web.de> <456f0611-1fc7-75ac-ff45-9afd94190283@collabora.com>
 <trinity-02bc17fc-b458-4d17-baca-8afe30e4c92c-1626110171249@3c-app-gmx-bs28>
 <dbe23d2a-cd29-0782-1b7d-bcb5c6683607@collabora.com> <6EF00182-1FF4-4061-BCE4-E2AD7275211B@public-files.de>
In-Reply-To: <6EF00182-1FF4-4061-BCE4-E2AD7275211B@public-files.de>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 26 Jul 2021 08:27:42 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-2vJE_v2vV=fJqK9--yx=++P9x53T-g3Cv4qKfHhqbLg@mail.gmail.com>
Message-ID: <CAAOTY_-2vJE_v2vV=fJqK9--yx=++P9x53T-g3Cv4qKfHhqbLg@mail.gmail.com>
Subject: Re: Aw: Re: [PATCH] soc: mediatek: mmsys: fix HDMI output on mt7623/bananapi-r2
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Frank Wunderlich <linux@fw-web.de>,
        Collabora Kernel ML <kernel@collabora.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Frank:

Frank Wunderlich <frank-w@public-files.de> =E6=96=BC 2021=E5=B9=B47=E6=9C=
=8825=E6=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8A=E5=8D=881:06=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> >On 12.07.21 19:16, Frank Wunderlich wrote:
> >> Hi,
> >>
> >> it turns out that problem is the read+or of the new value
> >>
> >> i reverted my patch and changed
> >>
> >> reg =3D readl_relaxed(mmsys->regs + routes[i].addr) | routes[i].val;
> >> writel_relaxed(reg, mmsys->regs + routes[i].addr);
> >>
> >> to
> >>
> >> writel_relaxed(routes[i].val, mmsys->regs + routes[i].addr);
> >>
> >> and it works too, but maybe it breaks other platforms
>
> A gentle ping. Amy further comments which of both ways is the right one (=
restoring old output select function or write only without read+or)?

As I've discussed in [1], SOUT has many bits and need to be cleared
before set new value. Of course, write only could do the clear, but
for MOUT, it clear the bits that should not be cleared. If you want to
use the table, you need to implement the 'mask'.

[1] https://patchwork.kernel.org/project/linux-mediatek/patch/trinity-937eb=
fa3-d123-42de-a289-3ad0dbc09782-1625830110576@3c-app-gmx-bap43/

Regards,
Chun-Kuang.

>
> regards Frank
