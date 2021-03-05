Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA4532E79D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 13:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhCEMEd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 5 Mar 2021 07:04:33 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:34203 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhCEMEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 07:04:05 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N1cvQ-1lkyhX1H6u-0121Ta for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021
 13:04:03 +0100
Received: by mail-oi1-f175.google.com with SMTP id o3so2216149oic.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 04:04:03 -0800 (PST)
X-Gm-Message-State: AOAM533bU83Hrvy2auK09E7ZuiP/tfEYTy+7ybFJx9ao7u6z5R4P5aMG
        c0Y2H+XhgBVxJ02569hhOshnQrZQJpytjDzThA4=
X-Google-Smtp-Source: ABdhPJzvwNIaEW00Aml4Gt9DByl41wlsXQXcSHXEPeKAsXC8bMoOquef8BfTOVyLV4/l6Byf5f01UCfsF2Iye6vPn94=
X-Received: by 2002:aca:4fd3:: with SMTP id d202mr6517268oib.11.1614945842125;
 Fri, 05 Mar 2021 04:04:02 -0800 (PST)
MIME-Version: 1.0
References: <f08ef2b6f339ba19987cfef4307a4dd26b2faf97.1614933479.git.christophe.leroy@csgroup.eu>
 <CAK8P3a2b+u+8smkKWB-V2Non+nnZmNG4dNi6cGpM8weYuY5j6A@mail.gmail.com> <5811950d-ef14-d416-35e6-d694ef920a7d@csgroup.eu>
In-Reply-To: <5811950d-ef14-d416-35e6-d694ef920a7d@csgroup.eu>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 5 Mar 2021 13:03:45 +0100
X-Gmail-Original-Message-ID: <CAK8P3a34cnCk4=Xyxvib57JLN-ck4T0-FUZRAQT_L6MDKjE+-w@mail.gmail.com>
Message-ID: <CAK8P3a34cnCk4=Xyxvib57JLN-ck4T0-FUZRAQT_L6MDKjE+-w@mail.gmail.com>
Subject: Re: [PATCH v3] powerpc/32: remove bogus ppc_select syscall
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Paul Mackerras <paulus@samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:DzM2LCgOquX2bYOHe1YZfQc83Q6UY0UnY0QLnq/1EkU6yU5wqs+
 oxJWfwzBiXkCpe2VDsS2pjWxKONhUByRI3mH/WPlSLnl1UjeKIq+y9yCkviDgbkFfzQFiRq
 mjjzduT0tz7gXIVe5cBVTG+4s+lzO0JXGc/4ZhyQ5AbPzUK0sSXComwbXd1pTZTKAfkgfqk
 imzM4863RMp10CQE4dV3w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QEty6f2nQPg=:ifByCzVuoi1XZKm3F7bCuJ
 3WZYObiScj1CSmBN3aPKRBBOTgXZs/0YgtHyCuzs+EisDNBpjPXncI5AfBM43VnANNPap8x+M
 3d0mK1oranVO3w8dxae79F/iV0rLRfVV1XbcCw2AXpsSRWp4I5k+S9XpY+L235Us8owbHB0rX
 0AxtoIpKO2f2KCeTP7iCGm4BOXM4C6hoj9qoxqThw0i6exKWxmhUL4VhuZvBkPHM7vYC+hEyV
 eLh29tR1zyIZPtI0CPTB3FViS/SGgdO2WVQR4xSldDwBF3E2714ST2LsUM5abftiRlc0+SsDp
 Xv/8F1xAVVBT1ynzP2DOuv/JgUyeZKFbzNTiGbyiiVpeVSJXzBAH5g6MNuHZ/AOxx4H/cQ+N4
 T5S2XKwbICZEr8I5fKGNpxt6rdihFk+BD53hwxloTCP7b0HYt1wD0Od4ZSIpQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 5, 2021 at 11:15 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> Le 05/03/2021 à 11:06, Arnd Bergmann a écrit :
> > On Fri, Mar 5, 2021 at 9:40 AM Christophe Leroy <christophe.leroy@csgroup.eu> wrote:
> > - glibc support for ppc32 gets merged during the linux-2.5 days, supporting
> >    only #142 with the new behavior.

It turns out to be older than I said. This was actually in glibc-1.94
from 1997, so during
the linux-2.1 days, not 2.5!

> Whaou, nice archeology, thanks. Do you mind if I copy the history you established ?

That's fine, please copy it.

> In your commit, you said 2.3.48. Here in the history you say 2.1.48. Which one is correct ?

2.1.48 is correct.

> Regardless of whethere binaries are broken or not for other reason, is that worth expecting an
> almost 25 yr old binary to run on future kernels ? If one is able to put the necessary effort to
> port you hardware to the latest kernel, can't he really port the binary as well ?

I think the questions of supporting old hardware with new software and
supporting old
binaries on modern kernels are largely orthogonal. The policy we have
is that we don't
break existing user setups, and it really seems unlikely that anyone
still uses pre-1997
executables for anything that requires a modern kernel!

I now checked the oldest mklinux I could find (DR2.1 from 1997), and
even has the
modern glibc and linux-2.0.28 kernel patched to provide the modern semantics at
syscall #142 for glibc, with the same (already unused) compatibility hack at #82
that we still have for ppc32 today. This made mklinux DR2.1 binaries
incompatible
with mainline linux-2.0 kernels, but they might still work with modern kernels,
regardless of whether we remove support for binaries that worked with mainline
linux-2.0.

       Arnd
