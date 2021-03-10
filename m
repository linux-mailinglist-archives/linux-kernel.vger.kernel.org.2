Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F244333957
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 11:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbhCJKA2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 10 Mar 2021 05:00:28 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:43553 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhCJKAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 05:00:25 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MY6TD-1lEmqH2peH-00YUhe for <linux-kernel@vger.kernel.org>; Wed, 10 Mar
 2021 11:00:20 +0100
Received: by mail-oi1-f177.google.com with SMTP id x78so18494319oix.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 02:00:20 -0800 (PST)
X-Gm-Message-State: AOAM5310p15iC8s1AIoxkq9WmZCpOk9Q7+5dDn2tEmYVyhSpfbJuP9zA
        IHosXvBaqVkDL4jrr7zvxrKFrSPSV+CNYRcCXQA=
X-Google-Smtp-Source: ABdhPJz57LKzxKPOX8uFg4l8cQDX68aMXQSUFxgEEkBEVQzSWLTS5wn+SJ00u096OqMsz2UiKEGrsCkrnzqbLH7kTeM=
X-Received: by 2002:aca:bf44:: with SMTP id p65mr1764631oif.11.1615370419432;
 Wed, 10 Mar 2021 02:00:19 -0800 (PST)
MIME-Version: 1.0
References: <f08ef2b6f339ba19987cfef4307a4dd26b2faf97.1614933479.git.christophe.leroy@csgroup.eu>
 <CAK8P3a2b+u+8smkKWB-V2Non+nnZmNG4dNi6cGpM8weYuY5j6A@mail.gmail.com>
 <5811950d-ef14-d416-35e6-d694ef920a7d@csgroup.eu> <CAK8P3a34cnCk4=Xyxvib57JLN-ck4T0-FUZRAQT_L6MDKjE+-w@mail.gmail.com>
 <13737de5-0eb7-e881-9af0-163b0d29a1a0@csgroup.eu>
In-Reply-To: <13737de5-0eb7-e881-9af0-163b0d29a1a0@csgroup.eu>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 10 Mar 2021 11:00:03 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2W9H7k2S3Bk1323Ro2F=_m48wBy-tENd-MyNe3Z3azyQ@mail.gmail.com>
Message-ID: <CAK8P3a2W9H7k2S3Bk1323Ro2F=_m48wBy-tENd-MyNe3Z3azyQ@mail.gmail.com>
Subject: Re: [PATCH v3] powerpc/32: remove bogus ppc_select syscall
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:sPJOo4DBBvWyK+92IblkqpJ137qmDVRR83bo5EFIemUqstR7Czg
 ubmiaCSMpMA4xn8Ghbrt4QYTrZWvuG7fk3kOtNKv5naET+GxH7MF0+EIIxz6ZI5SLUNTiuY
 gu574yzFmQYVYlTUPPuSYbWmeyTXAJD+hvcHkQCbbZA8OCSy9WOaxKDPyC9jCR62r4/9fbs
 b+L4KyUfvq3nnnaxlnKWw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YkQ8qYAlAKE=:UtU4b8fZsJKDYHend6r4kq
 FcTQIN/EJ99gxRdhTAIn3VWFwiyohmJ9h+qVbQqQE53LPxSkEXLcKsH4IU8fEk+79kwf4deN9
 Dxh+Q9XRK0D7oAThpytHzdUzMYLa7Rv4gjVh0mTGQKWcPj8n48qO3LIUKwMeowFXFKESalr4L
 b2/lxUTjJx2eFKewayGTONMoF7sm7z2gSZye9CmU0IrjA9HAvOkUCJVcr27KLrWAec2UQc8TG
 xnQOzuxg1mQje/imkStUBcFxobJOmOEBpuGql8mQQGt9LR07Rb+oZQdNgEhR23h1WxzkpYkUg
 4UMJlKP8Ky8BWdWKKlVJnL9U2o3Sg5bOBfYpZd9E+RcSxeBL13pAZEK5ZbJpHpuiG38vk3wOh
 cpVimMyZoLfi6FFMHx1ZxcGQV1ILuyV+VOerUQWo/6miflEr7WaxLufY7bNYgOXMcL+zQIs+t
 o0iju4+LCefh/Iv/GuqmYwlCSYp1OLe86WNX16SI/++xFFG29pvT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 9, 2021 at 4:59 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> Le 05/03/2021 à 13:03, Arnd Bergmann a écrit :
> > On Fri, Mar 5, 2021 at 11:15 AM Christophe Leroy
> > <christophe.leroy@csgroup.eu> wrote:
> >> Le 05/03/2021 à 11:06, Arnd Bergmann a écrit :
>
> I had another look. In fact x86, arm and m68k still have the #82 syscall, but they don't have the
> hack we have on powerpc to "guess" that something is calling the old select with the arguments of
> the new select.

Makes sense. At least for x86, there are probably still some pre-glibc
binaries around
that would use the old select.

> As part of my series of user accesses cleanup, I'll replace the open coded stuff by a call to
> sys_old_select(), see below.

Nice!

> Maybe at the end we should keep the #82 syscall, but do we need to keep the powerpc hack really ?
> Maybe the best is to drop ppc_select() function but mention sys_old_select() instead of ni_syscall
> for entry #82 in the syscall table ?

I'd say we should either keep the powerpc hack intact (with your cleanup),
or remove the syscall entirely. I have been unable to find any indication of
who might have called the #82 syscall prior to mklinux DR2.1 and linuxppc R4,
so there is no way of knowing which of the two ABIs they were using either.

It was definitely ambiguous since the ancient kernels only had sys_select()
semantics at #82, but the existence of the hack tells us that there were at
least some binaries that wanted the sys_oldselect() semantics.

       Arnd
