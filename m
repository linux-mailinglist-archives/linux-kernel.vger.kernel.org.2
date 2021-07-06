Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB243BC8BC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 11:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbhGFJ5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 05:57:43 -0400
Received: from mout.gmx.net ([212.227.15.15]:37943 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231271AbhGFJ5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 05:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625565279;
        bh=HfI1fnAl8yXB7R6zw/6uGgLzJrfs1z8CTgu8YasTu8A=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=MSlfUBxlZvS9mg5TyrL+qgBsEYkpw4pJrf77rmAC5efOCMZRz1SimhrVBzBlfzexm
         N0Vc0qlII3AwMyvyBydEaA3hHmZZ80sWLMbCshTfUFT2bI7V4ONGaTvyKJb0bgLnFS
         7MBKVYOKio+OM1q8fonyXBi4c68oVIXrGC7TcR/c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [80.245.79.159] ([80.245.79.159]) by web-mail.gmx.net
 (3c-app-gmx-bs60.server.lan [172.19.170.144]) (via HTTP); Tue, 6 Jul 2021
 11:54:39 +0200
MIME-Version: 1.0
Message-ID: <trinity-cc8f5927-9aaf-43ae-a107-6a6229f1b481-1625565279264@3c-app-gmx-bs60>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: BUG: MTK DRM/HDMI broken on 5.13 (mt7623/bpi-r2)
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 6 Jul 2021 11:54:39 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:OoEQiM/tnR+cNPyCdrhP49bAjgvwQ+lcL2OS2XXYultpQRZ3iKmx2n0JXV3n3Fd/VHVP9
 URFMBbMlD29B8YWbPuG94J3F5zWccIqeUBT1b3/QLw7EcLA1JrI3PjO+FQx3imeyC8zgfU+KOerU
 SBvcaufgt9H7rbyrAH7vebZLBS9lGqXs77pGRfMkntQEsAfeL8lO7PqFYuVKbfqsm2saOSxPGiZz
 1ywjhxyBlAPnO/j9ixwng5+18VP/dFCoD3JyS/5IHrvnwd1vKJnHRUax54UOu+AonufbuKYhQFcx
 Nc=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NiH7UObdIF4=:Bg0EwcLfhCF2bM3KUv6JSd
 Q39d+oRzZNlz2GzCi6t2BMIrQIiPhiBUPc+0wnnrteIX6OuFa45YuJBgPrfIBXx6tguKBCp49
 TGWem2GBYxZzGvsBFmWJaAF+PZ1qESJlVy8Erlqquwecq4q5ec2f4NZHwL+6bXn6MQh94FTb/
 7VCcOdZyhkZO12oi2vioRCcbwlqJBQt93keYwD5q9PXa8u2ES4hzaLLkfRKigJffBXop14S7w
 ndcMLVDhRQ7RoEmE0z2jLSVoHqogiW4s/4lx5h2SfSX4GjxKOZYcdan9jjHgyljizL6ZqnSHk
 vwlmTHtLChPXl7RdigxxPSyrmPsUH0CaPXY2O6i1obnMglJjNTehzP28kTKvH7KgE/1YGNe5F
 Shf/BUgVaLsdnU239JwpE7RIaZI5legkv8qnx5icFi/uZL0oXWHIzGkkV2uWeXE6JvcX/HV71
 0q1qoLQb/ONFD9IFKO1+L0UDKuymVbAOXZAOxqvYXYXL4NhSMFA4aNdoAc+oqZmqdzzsJMnuS
 jkrlfwdVRbCwremdvuZFG1yW6qXDPaIT/LV9PRnZR9a5GXNhcCZsf/nWPPbcw8C81mY+5EMB0
 G87A0GZyvJboKu0tRvYvq71SZ4cDqgxutnJA5PwydKQbCxKiS75ao4pj7Hy78hw2KYOe1041Z
 kEJQh3d7E+fMzyvRIHjiTrdZrFlFt02GNS+gu9Tvot+F/VfteqJIdJkTFVu8T5NP7KR6wj+oY
 nkDj8u7qnn14WAyEqge63SRfsb/Yx6NNhTzlhkAoCTUHv8qr31k9Hcqpg/LhlnIrLwcqOm8I9
 uk9Inzb0MBA89p4qj/3aVdcWSy1ZeHIldpXz6EqZ4EWd1qPCV8=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i've noticed that HDMI is broken at least on my board (Bananapi-r2,mt7623)=
 on 5.13.

after some research i noticed that it is working till

commit 2e477391522354e763aa62ee3e281c1ad9e8eb1b
Author: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Date:   Tue Mar 30 13:09:02 2021 +0200

    drm/mediatek: Don't support hdmi connector creation


which is the last of mtk-drm-next-5.13 [1] so i guess a problem with core-=
patches

dmesg shows the following:

[    7.071342] mediatek-drm mediatek-drm.1.auto: bound 14007000.ovl (ops m=
tk_dis
p_ovl_component_ops)
[    7.080330] mediatek-drm mediatek-drm.1.auto: bound 14008000.rdma (ops =
mtk_di
sp_rdma_component_ops)
[    7.089429] mediatek-drm mediatek-drm.1.auto: bound 1400b000.color (ops=
 mtk_d
isp_color_component_ops)
[    7.098689] mediatek-drm mediatek-drm.1.auto: bound 14012000.rdma (ops =
mtk_di
sp_rdma_component_ops)
[    7.107814] mediatek-drm mediatek-drm.1.auto: bound 14014000.dpi (ops m=
tk_dpi
_component_ops)
[    7.116338] mediatek-drm mediatek-drm.1.auto: Not creating crtc 1 becau=
se com
ponent 9 is disabled or missing
....
[   38.403957] Console: switching to colour frame buffer device 160x64
[   48.516398] [drm:drm_crtc_commit_wait] *ERROR* flip_done timed out
[   48.516422] [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* [CRTC=
:41:cr
tc-0] commit wait timed out
[   58.756384] [drm:drm_crtc_commit_wait] *ERROR* flip_done timed out
[   58.756399] [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* [CONN=
ECTOR:
32:HDMI-A-1] commit wait timed out
[   68.996384] [drm:drm_crtc_commit_wait] *ERROR* flip_done timed out
[   68.996399] [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* [PLAN=
E:33:p
lane-0] commit wait timed out
[   68.996423] [drm:mtk_drm_crtc_atomic_begin] *ERROR* new event while the=
re is
still a pending event
[   69.106385] ------------[ cut here ]------------
[   69.106392] WARNING: CPU: 2 PID: 7 at drivers/gpu/drm/drm_atomic_helper=
.c:151
1 drm_atomic_helper_wait_for_vblanks.part.0+0x2a0/0x2a8
[   69.106414] [CRTC:41:crtc-0] vblank wait timed out

so i guess the breaking commit may be this:

$ git logone -S"drm_crtc_commit_wait" -- drivers/gpu/drm/
b99c2c95412c 2021-01-11 drm: Introduce a drm_crtc_commit_wait helper

in drivers/gpu/drm/drm_atomic{,_helper}.c

but i cannot confirm it because my git bisect does strange things (after d=
efining 5.13 as bad and the 2e4773915223 as good, second step is before th=
e good commit till the end, last steps are 5.11...). sorry, i'm still new =
to bisect.

the fix is targeting to 5.12-rc2, is guess because CK Hu's tree is based o=
n this...but the fix was not included in 5.12-rc2 (only after 5.12.0...got=
 it by merging 5.12.14)

maybe you can help me?

regards Frank

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git=
/log/?h=3Dmediatek-drm-next-5.13
