Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2763E32D6B9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 16:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbhCDPdk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 4 Mar 2021 10:33:40 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:42203 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbhCDPdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 10:33:39 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MZkYx-1lFEqa1VX5-00Wjhz for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021
 16:31:07 +0100
Received: by mail-ot1-f43.google.com with SMTP id v12so26499885ott.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 07:31:07 -0800 (PST)
X-Gm-Message-State: AOAM533KKhRkyGAanh3xFHPyoNULS2Emhy9gd6uEnJ4rM6msLiqIHeTD
        dbKpxB558zXUHv/Y908gvmu92RraWhv2P/LaTTM=
X-Google-Smtp-Source: ABdhPJzlMu4XFdyVnD9hytIlowXXGFU41H5abzxoBv1GxGV5riUHWJk7l9y4vC3dE0f4RXteXOKokQ94laXC4xEr3Bw=
X-Received: by 2002:a9d:6b8b:: with SMTP id b11mr3870962otq.210.1614871866158;
 Thu, 04 Mar 2021 07:31:06 -0800 (PST)
MIME-Version: 1.0
References: <2daa39fa210d971863a6f9ac7c81849764e7a261.1614862233.git.christophe.leroy@csgroup.eu>
 <CAK8P3a2=qOG1iLhw2fi=r128bRMdfNx4BseXONiS7vrnbVvr6w@mail.gmail.com> <aca143f6-fcfc-d89f-bb00-26e90257fbf6@csgroup.eu>
In-Reply-To: <aca143f6-fcfc-d89f-bb00-26e90257fbf6@csgroup.eu>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 4 Mar 2021 16:30:49 +0100
X-Gmail-Original-Message-ID: <CAK8P3a02S+8rr4QCwAWF9bTJEK1Tdi0Py11=PVMTu0vARc9ruw@mail.gmail.com>
Message-ID: <CAK8P3a02S+8rr4QCwAWF9bTJEK1Tdi0Py11=PVMTu0vARc9ruw@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/32: remove bogus ppc_select syscall
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        halesh.sadashiv@ap.sony.com,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:hdu0FnzMMZon/yRJ6C+HUtrqP4foLSq+cKLH2W/HcXOR6b12Z8s
 HZoWZr2BZNS+GAk1sm59icjwZqU9357fmv/v+avfx92qGqznPVUD4DS0yqB5D+Q/vDoPY28
 Ev9VDsAX+DyY69XWhlow8VFawv2MUGrM90VHtBnJpZSrxG5pT/vLOR0TvFhLZxEhD0J3V7T
 YNEJjUOOzjFlTvsWM+J+A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Nr264Weve9U=:VkcDnbhxxZ5aSqL4YNg78p
 0AYp56Uofx1t19zXAdn/Ur0Zfk5FSMP0y7r6uz2doS/TznT29u6aY/WZYTnBT2isSRXfcM7e0
 fX8laNaA7mNITc/mZUV0fuNLMRVqRvPnte3IcFH3XHlTXHdvgYv/WGgECycQPgZnVvQweFpRi
 wlRYWPeG3cXBgDiuihN67urjzyNOKkcQqr5SO3IQsThDpWGqTT7mrBgqXKXpCeXkgfa2OEBgu
 UE4M+MsOLwpzgF/IvC1nRLLvpeU7SPjmS3u4fNUKwyQ0VYmIVaDrMIFuj3KstvzxOy3/ovs3P
 XbkPBSNa/ORpTB0PpPNtxiCYDTQ69giKLeE+LMkrasuQHN1mLtkO3gyULKYVYAv21UuAh5iqm
 D/TDnOqp+OIi1YX8GiC680hBweI0KWIl+2lPn8kfkqzWVcnzQRXO/0wI3PV9osuL7uAAyh4zE
 6iesfbYRV0jigHLIbM8lhFVgZER2JUmXR8l6uEeE83erGCCweeMwo7BDxTAAIAW9phqQ+L5jc
 5GtyTVM/F1PPie/SqIsDjPjW2jZqoGsLiQTn/ldJFa8ldWXi3bEeloM1tb56YP7Sw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 4, 2021 at 4:24 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> Le 04/03/2021 à 16:17, Arnd Bergmann a écrit :
> > On Thu, Mar 4, 2021 at 1:51 PM Christophe Leroy <christophe.leroy@csgroup.eu> wrote:
> >> ---
> >> First version was in 2008, at that time it was rejected, see
> >> http://patchwork.ozlabs.org/project/linuxppc-dev/patch/200809240839.14902.arnd@arndb.de/
> >
> > The patch from 2008 did two things:
> >
> > - it removed the ppc32 specific 'select' syscall at #82
> > - it fixed the generic '_newselect' syscall at #142
> >
> > Back then, the decision was to only address the second issue, which
> > got merged in commit dad2f2fb0fc7 ("powerpc: Fix wrong error code from
> > ppc32 select syscall").
> >
> > It is probably ok to remove the old select system call now, but
> > my changelog text no longer makes sense, as the patch has nothing
> > to do with the bug that was reported back then.
> >
>
> I understood that the original reported bug was that calling that version of select() with a
> negative value as first parametre would lead to a -EFAULT instead of -EINVAL. That's exactly the
> case here, if you set n = -1 you get into this (unsigned long)n > 4096 then the buffer is at
> 0xffffffff and access_ok() won't grand access to it so the return value will be -EFAULT instead of
> -EINVAL.
>
> Am I missing something ?

This is the behavior of the ppc_select() implementation, but as far as
I can tell,
the bug report was for the problem that this behavior would happen for both
syscall #82 and syscall #142 when the correct behavior would have been to
only do it for #82 but not for #142.

       Arnd
