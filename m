Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A3E3BD469
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 14:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbhGFMIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 08:08:53 -0400
Received: from mout.gmx.net ([212.227.15.18]:46429 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240926AbhGFLuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 07:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625572008;
        bh=nqG/g6YoDQ3Cr6IxntXpO3+qXORMb4BY7rzWo7WkW9o=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hVUNmBNDK8n1tDtAWPKLzYEepW3qVB7V3TXF+yWMbceWhCdC/P6aqo5mJ0fyuXyJE
         BAOvpIIi/AaVEQB4oTZfz4a2sZU6ekcGvs8pI8sl5DZKwl8WkZpXM58sRfhZimmLEV
         vWtTa7WepmZtqv4hPG1+IDoedccKFXecjRmvoW5c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [80.245.79.159] ([80.245.79.159]) by web-mail.gmx.net
 (3c-app-gmx-bs60.server.lan [172.19.170.144]) (via HTTP); Tue, 6 Jul 2021
 13:40:32 +0200
MIME-Version: 1.0
Message-ID: <trinity-9886112a-f7f2-4ae8-8e09-39c73c04b751-1625571632221@3c-app-gmx-bs60>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Aw: Re: BUG: MTK DRM/HDMI broken on 5.13 (mt7623/bpi-r2)
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 6 Jul 2021 13:40:32 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <YOQ8ktv1MypezrEy@phenom.ffwll.local>
References: <trinity-cc8f5927-9aaf-43ae-a107-6a6229f1b481-1625565279264@3c-app-gmx-bs60>
 <YOQ8ktv1MypezrEy@phenom.ffwll.local>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:yBMlpo5tuOYEw1oNXBnbTgKo35sOzSkMHe7TQ5KITpGJHZSzeG9nbJyWqN2crVp5Kun95
 iDAZMR3ksjB1FOOG7jTfcLf2PaLG1r6mMQMqkehqP2CmMQbypxlhiBAwNna1RC/fIrUGVfmmZYvc
 zEzmMQBMXJXAWobQC6V1eQpx59exnwB5OMMzFJ3N3QLLW/+hTgPs/UYWD7mtNztam/U08x6AIagq
 HCpD+dagdZSWrcnGhkqrnlsU4vBFCRZ6prJO7Hk+giFEg5QPyvXu1bgWzuwuty9dWNhsXRUoQI4y
 0E=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:J3g4ZVn/Qag=:5LgzFe0Ql1yKNWlBSFnV67
 R7YRamA/7Af8s6e4yuD4iGG7kYF32Qqm/tycBEzGDu4yHY6GqYgaWZIKHzm+Kvj9GE+1gHXNI
 9LpLyHW2Emho1vLy+O2tU3Aa12gXuXATZvXsSHZ95ewwAO1DGVPEm3IiM062bqIo29POZDMrF
 5a3HV4F0goWbfDp3DvTcRjZpmZej5szmK3b41Zk1fzxjBulMZK9mbniYiH+zrxbUGo04JlZj7
 uxNTaEmWMiEhDTnQM9TfPBMk/iCcQE062jeZfTr3qDLcQ2HPwB8Btbe/X+nJ4JHAIyZf0Q/jB
 oxI8cYJZCT/dfHagB8+BR4LEpEoj2KgY0KgYrZ5b+LgLybFqfGxNgwndsXxdXnIenLKA5tcOj
 A0PXfuS6Dkyv+9uC6+0oG/tmDMedThrHSmgkYSzm8ftAMB2UCAHrKp6Td1hkON8mzVPCJAIgp
 VYs+hWM20nJ1jCka6k2d33n5QUdD+QTZ0pX764nhTtVkr2H3TKCVcWEnHtBdxsZZgFuIYQZNK
 6B55PX3YE9+Y5hQurI9TvJCB3lNCHKDrstk02wyZOV6Bb9FGIaDAtW5RzlV1+MEwybAcxl2BJ
 w4+m9Djk+T4+Y3bIg4Av2SYM4R8OKLOQlTmvOEdQSTKeMbEFDj/1x70IE5BRZc27eDLb7PKpi
 luCl/Xmll5zlkNVhaqyQzykzOtr9WqwCf94FyT1zz6eHicJJ0P11/Nz+PMFNzbdgZsn23E4/7
 2Q6Sulf/DOEeFjYgtRiHIEGABUMNuI2TPzQn1jetsj0VfmMubDZuX7HV1Z+k0IWR2PCw/zFsN
 jcGLCqF1K25oKPZGWHywFUaFd/lIN5UwNyNHFpbuWKlf57hWEw=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel

> Gesendet: Dienstag, 06. Juli 2021 um 13:20 Uhr
> Von: "Daniel Vetter" <daniel@ffwll.ch>
> An: "Frank Wunderlich" <frank-w@public-files.de>
> Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Rip=
ard" <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "Dav=
id Airlie" <airlied@linux.ie>, "Daniel Vetter" <daniel@ffwll.ch>, dri-deve=
l@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Chun-Kuang Hu" <ch=
unkuang.hu@kernel.org>, "Philipp Zabel" <p.zabel@pengutronix.de>, linux-me=
diatek@lists.infradead.org, "Matthias Brugger" <matthias.bgg@gmail.com>
> Betreff: Re: BUG: MTK DRM/HDMI broken on 5.13 (mt7623/bpi-r2)
>
> On Tue, Jul 06, 2021 at 11:54:39AM +0200, Frank Wunderlich wrote:
> > Hi,
> >
> > i've noticed that HDMI is broken at least on my board (Bananapi-r2,mt7=
623) on 5.13.
> >
> > after some research i noticed that it is working till
> >
> > commit 2e477391522354e763aa62ee3e281c1ad9e8eb1b
> > Author: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> > Date:   Tue Mar 30 13:09:02 2021 +0200
> >
> >     drm/mediatek: Don't support hdmi connector creation
> >
> >
> > which is the last of mtk-drm-next-5.13 [1] so i guess a problem with c=
ore-patches
> >
> > dmesg shows the following:
> >
> > [    7.071342] mediatek-drm mediatek-drm.1.auto: bound 14007000.ovl (o=
ps mtk_dis
> > p_ovl_component_ops)
> > [    7.080330] mediatek-drm mediatek-drm.1.auto: bound 14008000.rdma (=
ops mtk_di
> > sp_rdma_component_ops)
> > [    7.089429] mediatek-drm mediatek-drm.1.auto: bound 1400b000.color =
(ops mtk_d
> > isp_color_component_ops)
> > [    7.098689] mediatek-drm mediatek-drm.1.auto: bound 14012000.rdma (=
ops mtk_di
> > sp_rdma_component_ops)
> > [    7.107814] mediatek-drm mediatek-drm.1.auto: bound 14014000.dpi (o=
ps mtk_dpi
> > _component_ops)
> > [    7.116338] mediatek-drm mediatek-drm.1.auto: Not creating crtc 1 b=
ecause com
> > ponent 9 is disabled or missing
> > ....
> > [   38.403957] Console: switching to colour frame buffer device 160x64
> > [   48.516398] [drm:drm_crtc_commit_wait] *ERROR* flip_done timed out
> > [   48.516422] [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* [=
CRTC:41:cr
> > tc-0] commit wait timed out
> > [   58.756384] [drm:drm_crtc_commit_wait] *ERROR* flip_done timed out
> > [   58.756399] [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* [=
CONNECTOR:
> > 32:HDMI-A-1] commit wait timed out
> > [   68.996384] [drm:drm_crtc_commit_wait] *ERROR* flip_done timed out
> > [   68.996399] [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* [=
PLANE:33:p
> > lane-0] commit wait timed out
> > [   68.996423] [drm:mtk_drm_crtc_atomic_begin] *ERROR* new event while=
 there is
> > still a pending event
> > [   69.106385] ------------[ cut here ]------------
> > [   69.106392] WARNING: CPU: 2 PID: 7 at drivers/gpu/drm/drm_atomic_he=
lper.c:151
> > 1 drm_atomic_helper_wait_for_vblanks.part.0+0x2a0/0x2a8
> > [   69.106414] [CRTC:41:crtc-0] vblank wait timed out
> >
> > so i guess the breaking commit may be this:
> >
> > $ git logone -S"drm_crtc_commit_wait" -- drivers/gpu/drm/
> > b99c2c95412c 2021-01-11 drm: Introduce a drm_crtc_commit_wait helper
> >
> > in drivers/gpu/drm/drm_atomic{,_helper}.c
> >
> > but i cannot confirm it because my git bisect does strange things (aft=
er
> > defining 5.13 as bad and the 2e4773915223 as good, second step is befo=
re
> > the good commit till the end, last steps are 5.11...). sorry, i'm stil=
l
> > new to bisect.
>
> drm history runs in parallel with the main tree, so occasionally the
> version that's reported as baseline is confusing and older than what you
> might expect. Just trust git bisect, it's doing the right thing, and mak=
e
> sure you test exactly the kernel you're supposed to test. Compiling with
> CONFIG_LOCALVERSION_AUTO helps a lot to make sure you're really booting
> into the right sha1.

my build-script adds sha1 to filename (for tftp-usage) and kernelinfo (una=
me -a)

> > the fix is targeting to 5.12-rc2, is guess because CK Hu's tree is bas=
ed
> > on this...but the fix was not included in 5.12-rc2 (only after
> > 5.12.0...got it by merging 5.12.14)
>
> Yeah that can also happen because of all the non-linear trees involved i=
n
> linux development.

how to find the real breaking commit?

> > maybe you can help me?
>
> So now I'm confused, you're talking about a fix, or is it still broken i=
n
> latest upstream?
> -Daniel

it is still broken, as i did not found the root cause...only a guess based=
 on errors in dmesg...git bisect points me afair to mt76 wifi-driver which=
 is completely unrelated...as i said, the fix i defined as "last good" was=
 no more there after 2nd bisect step.

The fix i set as last good was fixing 5.12 issue (handling connector/creat=
ing bridge without it), but 5.13 has a new one (atomic timeout,drivers/gpu=
/drm/drm_atomic{,_helper}.c) which i cannot trace to the breaking commit.

regards Frank
