Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5603D5478
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 09:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbhGZG7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 02:59:43 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:33235 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbhGZG7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 02:59:42 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M6m5o-1lzgwe1Se6-008K0X for <linux-kernel@vger.kernel.org>; Mon, 26 Jul
 2021 09:40:10 +0200
Received: by mail-wm1-f48.google.com with SMTP id m38-20020a05600c3b26b02902161fccabf1so7510727wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 00:40:10 -0700 (PDT)
X-Gm-Message-State: AOAM531uDZC3zM1gbrG5YaRNM3lEGZRqL0drLvePo5dM0qePIVAmW1F9
        kfkczh8/j0ZyT+w3V4hln9Wqpm15U8cML0tEPx4=
X-Google-Smtp-Source: ABdhPJyUu+zpKQgLCzD92xlTKJ+CdL+Qe3BKBoET07REAC9wsTFKxyxXX9p30cgRZ0s2LdofhlqDl1W4NQEu0QxiHko=
X-Received: by 2002:a7b:ce10:: with SMTP id m16mr6487271wmc.75.1627285210031;
 Mon, 26 Jul 2021 00:40:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210725104618.365790-1-geert@linux-m68k.org> <db2de193-a10-598-a21e-3a305b91d191@linux-m68k.org>
 <CAMuHMdWrg7zUC+iMjXS=RS=Fa7ZVS-0iycjQ2UP6W0pHzdGxKQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWrg7zUC+iMjXS=RS=Fa7ZVS-0iycjQ2UP6W0pHzdGxKQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 26 Jul 2021 09:39:53 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3N61zpEphfPoPWgAK3iGx2Cqo3HL1jrce=Kz9iuML1Og@mail.gmail.com>
Message-ID: <CAK8P3a3N61zpEphfPoPWgAK3iGx2Cqo3HL1jrce=Kz9iuML1Og@mail.gmail.com>
Subject: Re: [PATCH] m68k: Fix asm register constraints for atomic ops
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Finn Thain <fthain@linux-m68k.org>,
        Greg Ungerer <gerg@uclinux.org>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Brendan Jackman <jackmanb@google.com>,
        kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:AcLtqXJH29gnyR63QTBZV0Mkg5vUCTERKCMJHMftLf9Ih0mkuTw
 YYJ+MVyW5uMlKpwLNYWE3fOstV2wh5HknRyzJqcsm527TEj7yQT/GyLGbwCJt1NIMyf4VAC
 5W0c0vnSD2qMNJzW+lqK1ZJV0irhrZiZZENkxPTr2NTEB7oqA70oFWUE9Tef7GeCtV2ZwXm
 XAYRAtSq86gQvRrBPOHPQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PfbtwHBE7/c=:q2qHUQh5BO7/2MqZmvIpt3
 mbCNeYd44VzxP4uhOzTSA51DZV5JHg97TJeF/V71xlQ2x2WfyhX9t/quiolBjZkdAAbxRWDLO
 e2PA8a2wp/628I64W4ueVXi6pJt0z0kYU0m1mLFdcfxR8xxPGraidbsGpAiOKZz9UyLrkva/r
 WUBbAkrUZv25w/m1tu4llTViN1qf4OZtOWJ+zlVIKHy+cECd4kATrHpCsownCtoAm0Amg4oso
 eeseyGc/58/sYnthdFVHPmenXXpdfwHZSUAlHOGZiCxbEpps2a8eKuThmL3zUubZt+Vt3jAyL
 yJrlfeh/AknUGQSBaPVt3hQsFXyjhJ5BVrlioyeTUM2KYa+mcNJJVkZiUXohRrOgOXVsD0iuI
 kbP36MOM6Z7sNjcOF3Krl7AiPhE6XKZbbCGQa4abarqLpQ/vBgJ1UyQrS32dQnjDeCe+NMuSc
 +I4pHkoFyDWYtu4xty2tHQcDQeHHFrK61KP9AjhmUOQxt3olzk8Lj7VPffSjzBxenpr07+Z6U
 h0jKzoW5m7uGy25SZrHH8DPXd4nyQr5gF22ukzR8ienV2aAauXRSTJKoT9zRSCwS82FvAwJlc
 Ny/XR5rYF93Io1eA8jBZu4k1wgMCdUasQmiiw2/wB20r0MlG/c7yX3LuoOViJq7frhUY31w4e
 yrwdZJx+i7VFZmaiOxShVoAHveWHNhoO+70t5yVEEmWXCJbKJ5tRTlxJHLqlWAPI9Qu3UVGKk
 IK55X0KMSU/f05aRYsFu/ELlx5ynyIuugTE7QsbUxdEDqGkblIP+Q+jihSeAuv4aY1nrC/EPl
 bs7fo2wd5LN5SDP/Diw8L8T5DKW32z6NmSciALw5hS9vRB/AxKtdxYIwjKzsEL1+qnUorPPAY
 Zi1uz16jPf7/5fxQjmkThz7OQ2e1Lwr/wknLptJ2jSzWuMlgXcodVcQZcGB1umVAAaTrxmrm7
 1jEXNJGmyC7OdG+vKJZFVp+PgqGXH0fxfUCAW4rxe796u5q9/6bk5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 9:34 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Finn,
>
> On Mon, Jul 26, 2021 at 1:45 AM Finn Thain <fthain@linux-m68k.org> wrote:
> > On Sun, 25 Jul 2021, Geert Uytterhoeven wrote:
> > > Fixes: d839bae4269aea46 ("locking,arch,m68k: Fold atomic_ops")
> > > ...
> > > Technically, the issue was present before, but I doubt adding pre-v3.18
> > > Fixes tags would make any difference for stable...
> >
> > There is a better way to constrain backporting, that is Cc:
> > stable@vger.kernel.org # 3.12+
>
> I don't want to constrain backporting.

I would recommend adding the plain

Cc: stable@vger.kernel.org

line to the footer to make it unambiguous that you want it backported then,
plus moving the explanation above the --- line. You can never be too explicit
with those.

      Arnd
