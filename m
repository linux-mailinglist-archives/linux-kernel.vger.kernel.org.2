Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54432411020
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 09:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbhITHeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 03:34:25 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:34395 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhITHeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 03:34:24 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N3bb1-1mtcOx36OJ-010Zga; Mon, 20 Sep 2021 09:32:56 +0200
Received: by mail-wr1-f43.google.com with SMTP id t8so27109059wrq.4;
        Mon, 20 Sep 2021 00:32:56 -0700 (PDT)
X-Gm-Message-State: AOAM531hk5+HT73wXA8eYhlhNp8FBWxFXuFt2v+C/L2HWwwpdHTqxJuq
        IUdaS8l+kPSW8ESk/eSXFszxCewhNPk1sAZbWZw=
X-Google-Smtp-Source: ABdhPJyimA2Jzw4uMg1dAW3G32BpgHPWMW8BnFnTK9SD71UWG9hij9LLQvX2OpdKqbpa1SoifoQmgNZluBOPekYxK9Y=
X-Received: by 2002:adf:c10b:: with SMTP id r11mr26845091wre.336.1632123176348;
 Mon, 20 Sep 2021 00:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <590154f2ab113088346ae76c3f13f8b1cbebccbb.1631942274.git.christophe.jaillet@wanadoo.fr>
 <CAK8P3a3umbVdPv1omKd5p1gH3JzUEB_MJrK0xQmXok8iSY_haA@mail.gmail.com> <4cb6f731-7f4d-21d0-c88d-37664ea35002@wanadoo.fr>
In-Reply-To: <4cb6f731-7f4d-21d0-c88d-37664ea35002@wanadoo.fr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Sep 2021 09:32:40 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2CBvw_GP372R+p8f4_pa82sMuQ5iHk4Nb2dJCzm_Fivw@mail.gmail.com>
Message-ID: <CAK8P3a2CBvw_GP372R+p8f4_pa82sMuQ5iHk4Nb2dJCzm_Fivw@mail.gmail.com>
Subject: Re: [PATCH v2] misc: genwqe: Remove usage of the deprecated
 "pci-dma-compat.h" API
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>, gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:qmkbuobykVwsdT/EAIDxcm8/HJG37f9L3hS3lZLLC9aYpveTvuU
 fqn0B+ZOupwrApgoGrC1/N7B9ibEhOspc9Ug71iTiGsyBZcza89Uzc2Qz/Yswtw19CS7Qjd
 AcnmwPb6BOFP3s+TokBS8WgBnZJOzL55bibL95KK+KZ0V4B/KnPBORmrC2qQoDguhD222kX
 OUIL+fkmiQR3KehR2/3bw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QFTkohQTF+Q=:iw10WVD2L/UXShUYeAEmlT
 OXsah/ZyeNMMDQEnG2DFa9VkxHq4yP/JJo2qHIx9NjV49wIyPAD5UBqoEUTQOuU5wN2aEyb9O
 QFbs0P9+F20sAO3kXu35qVuKaU120Q+xXX+MAsI04HpNfX3VwUEHIl8CmJGSEAz8z6J8eE6d3
 E379YdixS+/1v8DKY6526o0KnHt9L8dCPLwiZU/iXep8zMzsqeBaT8EkvatSuABsHdqZ6klJH
 32IxG6wfAFZiH8ohAD9b5/TVGujx9Ldf3VDvvkXULCTj6b42ocxz4h1TBWnqF/IQEDA8IchSe
 4VYjHwd45RZqdXlKjoe8DwQXicSF2qL1Xh7guPmq/TDP6fx4JvpaEbtvQeMJFXxD+PGR5XY0I
 Lmdgg1oWIJI8VjOThVYrk9oXlHHOuvE4zFlbsXjmwN6IgogfzYP7Ua2vDP0LVorslw5uVcyXa
 BRY37ppkgHEHgss9HUdVxJOpVpiveZ8IcOnf+ILNspKDJmjQc3J2Ty33bW0ePykXeizrrOc9z
 o3D5dtdVjQ/n4m2+yqldk71ymzZlom8Pi51GcaTtYqtdg3PNRfVyDGEOBpR2snH4/t3AyEtaY
 FPTfCPhy/fmYTzDbn+36oG72AGFKNG72+lbb+5N+3cWLSAEcQWow1PGKphLq18WF1wGnkD/dD
 Mnh66oYdwCFNVNFVmDdkW8iNpbnGhqKY8UEWDRWXU6bNmPb8xTI+4OECuDTqhQTR2QOvjwXMS
 dZ/UBgFBGCiwimXewU4oYfXTIwCZdf4lMrGqYQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2021 at 3:10 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:

>
> considering that the 3 patches that you have just review are done, the
> diffsat of what is remaining is:
>
>    32 files changed, 309 insertions(+), 272 deletions(-)
>
>
> All corresponding patches have already been proposed.
> Most of the patches are not that old (i.e. < 1 month)
>
> They all *look* trivial to me, *EXCEPT* the ones for message/fusion.

Agreed, nice work getting this far!

> I've tried to split the latter in small series in the hope of easing review.
> Moreover the drivers/message/fusion directory seems to be inactive since
> a few months. I don't know if it is just related to the summer or if
> this code is for some reason stalled.
> This is funny, because the very start for me of this clean-up effort was
> related to an issue in memory allocation in message/fusion fixed by
> Christoph Hellwig :)

It is fairly old code that predates the git history, with the last two
device IDs
added in 2007 and 2011, so I would not expect it to be very active.
It's also part of the SCSI subsystem, so I think you just need to resend
it to the scsi maintainers (cc the listed driver maintainers) asking for it to
get merged unless the maintainers have a specific objection.

Once the fusion-mpt stuff is merged, I'd call it endgame and suggest
you send the remaining 12 patches and the removal of the header file
as a series to Andrew Morton, Cc all the driver maintainers to give them
a final notice: each maintainer can then either apply their trivial patch
for linux-next, or Andrew applies it, with the header removal coming last.

         Arnd
