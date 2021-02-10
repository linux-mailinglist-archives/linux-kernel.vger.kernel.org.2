Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519913163CB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 11:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhBJK1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 05:27:46 -0500
Received: from mout.gmx.net ([212.227.15.15]:58537 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230235AbhBJKO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 05:14:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612951993;
        bh=Vq6dWL7Zxrr7pAP49IZthRSzIUA5WpcrslIVeeGno20=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
        b=iFHNfCHcDQD0WDEjoht8O6Enf6rV9gdxdG+z/bLoQmBgdA2nwKM8LPOC/utxPzXhn
         JTUanBPLwDmdagb9qKVq9giE5Yu7MoUE7asz5/yK6ON7BFq8ck5nOmN2jNn0wfwbM4
         XHay3JrJdz6NFzFDH5lfDydq5621S73slReTUh+0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.218.231]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MkYXs-1lcluh0Mko-00m0KS; Wed, 10
 Feb 2021 11:13:13 +0100
Message-ID: <1d663cd74af91e23f4f24ebbdd65ef3ba72c15fc.camel@gmx.de>
Subject: drm/nouneau: 5.11 cycle regression bisected to 461619f5c324
 "drm/nouveau: switch to new allocator"
From:   Mike Galbraith <efault@gmx.de>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     nouveau@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Dave Airlie <airlied@redhat.com>
Date:   Wed, 10 Feb 2021 11:13:12 +0100
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1HXL5IfZ2qpNdgLAcAlpZ3nzIPILydFUVIXY8HO/DUXJ5re9Cqe
 4dvppVsmevD5Q2pzyTdPfyBMQS02ydgxwA9Dhtz6Snh82Nv+maD/A7S+h6L4H6S2R32rx5P
 hdsE2uUVXbvMzoXCnE2RJusGVLGZdxHQdcSjLbEEWSAsjoW/jow0eSQ6AtQdFI/34k4UNnU
 qWKnhnimcrLZWYiS4a6kg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OFJhlb/OE08=:7AQMcP/uaQP77nCnzK8r6x
 0hgafCbBJQH3IW41WdxV4eEWSlqD1TRT+tIGhEkR+cJacAKPSLtzc1I0RpQk4i4iV5fZT9pBB
 gYUFmMByMr5LrcwwmwrCHrp7sFiJ9oIetco5u+xMj2pRWSUDw00PzsjFawpOIc32JrMP7OgdS
 /b/sHqesDP4Zu95ICASwv6u7GyVXKM9M6fb+u3zl+mwawk/GVqMQ/AIvGfGkH2esJqjUmrTcb
 P3TxifAt1wB3GdHaLD2fmxoV7I9Y51i1LslzWLeNtcnFqJTgeuFlluDdCZM3Oc3C9lgdWoiSe
 b1wMkF+U+vW7KqmEMn+NsrJI83jCpjjSQXu0m9yQJiHz3+SLibLMEt1srF7EhDW1hK4EGg2qD
 1z3PDCnIBSLoqf0OKqXQs3WxiF83X5QLm0a9XS2Qrt40+cPeo82+4Q9r4roPNyw9OYEJzhHIT
 FwwoWBF24zXj7LAtFJEhhtzoFfwR5g6jc4TA60O7n04AMIp8xq71v08LiRtIuRxmG7crYJ/bf
 R08+LBEdclPlnKL2P4mMGFMAMQuQYiNQt8+7Y/pjfxcHxjv6hqTfGrYaHSc4NdDF60OqHUmO2
 KsIa+R4/tHJMJpE6bU9RYg9J4i7yGW9tR59GJjYADW5TrhyBqKS6sVmYyzglaFvmjetGvgPXI
 1LLsJ/wJOoI+PQd9Lcv3EqOEi5MP9nQCxoPsThaeQGE8MCwtgEp8K14lq5IzHRJdYf1EAI7JC
 7hp8cOAS6O88wgrMju7mhcU0ztex1pqTOGEnG3yrwtlhlkajCv/KG7hzkmNeawlG+VtG87fdP
 Zd2VzhJco6JrpWddaYkitgQ3zNQDpmiPnjJlfbCKhus7W/fPV367WvqD5RH6oxTVhK15yv6f1
 YVDpf+llK77aPR1SwSow==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

The symptom is tasks stuck waiting for lord knows what by calling
sched_yield() in a loop (less than wonderful, sched_yield() sucks).
After boot to KDE login, I immediately see tracker-extract chewing cpu
in aforementioned loop. Firing up evolution and poking 'new' to
compose, WebKitWebProcess joins in the yield loop fun.

Hand rolled reverts of 256dd44b "drm/ttm: nuke old page allocator" and
the fingered commit cures the problem for me at 207665fd in the bisect
log below, and at master and tip HEAD.

There's a "things that make ya go hmm" aspect to this thing though.  If
you look at the bisect log below, the starting "bad" is 207665fd.  That
commit DOES NOT exhibit the yield loop symptom immediately out of the
box, but DOES after applying the much needed fix...

	660a59953f4f "drm/nouveau: fix multihop when move doesn't work"

...to prevent an earlier regression from quickly appearing, one which
Dave will likely recall having fixed.  Relevant?  No idea, but seems
worth mentioning.

Box: aging generic i4790 box with its equally aged Nvidia GTX 980.


461619f5c3242aaee9ec3f0b7072719bd86ea207 is the first bad commit
commit 461619f5c3242aaee9ec3f0b7072719bd86ea207
Author: Christian K=F6nig <christian.koenig@amd.com>
Date:   Sat Oct 24 13:13:25 2020 +0200

    drm/nouveau: switch to new allocator

    It should be able to handle all cases now.

    Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
    Reviewed-by: Dave Airlie <airlied@redhat.com>
    Reviewed-by: Madhav Chauhan <madhav.chauhan@amd.com>
    Tested-by: Huang Rui <ray.huang@amd.com>
    Link: https://patchwork.freedesktop.org/patch/397082/?series=3D83051&r=
ev=3D1

 drivers/gpu/drm/nouveau/nouveau_bo.c  | 30 ++----------------------------
 drivers/gpu/drm/nouveau/nouveau_drv.h |  1 -
 2 files changed, 2 insertions(+), 29 deletions(-)

git bisect start
# good: [2c85ebc57b3e1817b6ce1a6b703928e113a90442] Linux 5.10
git bisect good 3f995f8e0b540342612d3f6b1fc299f5bf486987
# bad: [207665fd37561f97591e74d0ee80f24bdf06b789] Merge tag 'exynos-drm-ne=
xt-for-v5.11' of git://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm=
-exynos into drm-next
git bisect bad 207665fd37561f97591e74d0ee80f24bdf06b789
# good: [f8394f232b1eab649ce2df5c5f15b0e528c92091] Linux 5.10-rc3
git bisect good f8394f232b1eab649ce2df5c5f15b0e528c92091
# good: [b3bf99daaee96a141536ce5c60a0d6dba6ec1d23] drm/i915/display: Defer=
 initial modeset until after GGTT is initialised
git bisect good b3bf99daaee96a141536ce5c60a0d6dba6ec1d23
# good: [dfbbfe3c17651fa0fcf2658fb90317df08e52bb2] drm/amd/display: Add fo=
rmats for DCC with 2/3 planes.
git bisect good dfbbfe3c17651fa0fcf2658fb90317df08e52bb2
# bad: [112e505a76de69f8667e2fe8da38433f754364a8] Merge drm/drm-next into =
drm-misc-next
git bisect bad 112e505a76de69f8667e2fe8da38433f754364a8
# bad: [49a3f51dfeeecb52c5aa28c5cb9592fe5e39bf95] drm/gem: Use struct dma_=
buf_map in GEM vmap ops and convert GEM backends
git bisect bad 49a3f51dfeeecb52c5aa28c5cb9592fe5e39bf95
# bad: [d7e0798925ea9272f8c8e66ceb1f7c51823e50ab] dt-bindings: display: br=
idge: Intel KeemBay DSI
git bisect bad d7e0798925ea9272f8c8e66ceb1f7c51823e50ab
# bad: [c489573b5b6ce6442ad4658d9d5ec77839b91622] Merge drm/drm-next into =
drm-misc-next
git bisect bad c489573b5b6ce6442ad4658d9d5ec77839b91622
# bad: [8567d51555c12d169c4e0f796030051fff1c318d] drm/vmwgfx: switch to ne=
w allocator
git bisect bad 8567d51555c12d169c4e0f796030051fff1c318d
# good: [5144eead3f8c80ac7f913c07139442fede94003e] drm: xlnx: Use dma_requ=
est_chan for DMA channel request
git bisect good 5144eead3f8c80ac7f913c07139442fede94003e
# good: [e93b2da9799e5cb97760969f3e1f02a5bdac29fe] drm/amdgpu: switch to n=
ew allocator v2
git bisect good e93b2da9799e5cb97760969f3e1f02a5bdac29fe
# bad: [461619f5c3242aaee9ec3f0b7072719bd86ea207] drm/nouveau: switch to n=
ew allocator
git bisect bad 461619f5c3242aaee9ec3f0b7072719bd86ea207
# good: [0fe3cf3a53b5c1205ec7d321be1185b075dff205] drm/radeon: switch to n=
ew allocator v2
git bisect good 0fe3cf3a53b5c1205ec7d321be1185b075dff205
# first bad commit: [461619f5c3242aaee9ec3f0b7072719bd86ea207] drm/nouveau=
: switch to new allocator

