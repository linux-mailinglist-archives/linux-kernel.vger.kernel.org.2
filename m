Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9853D48BD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 19:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhGXQ0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 12:26:02 -0400
Received: from mout.gmx.net ([212.227.15.19]:37759 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229845AbhGXQ0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 12:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627146376;
        bh=45e0H0Lk78ezpdCHaXHQi6m/MsRnxorf6VPy1DfA5rg=;
        h=X-UI-Sender-Class:Date:In-Reply-To:References:Subject:Reply-to:To:
         CC:From;
        b=k6Tue3gwJ6yzegHJFgwwcNIfP5QpSB/PhMLA0dvuX0o7hOPPW9+Cohd0EgET33ADU
         2t7ztArwdbcCPu/zFoesd0xTOgkw4m1eANnOwNgxBrhoiEz+WQLPfd3zi0XgCnoo5F
         qWIGinmGQXH7hgDfXbg1K1fcTGUh0TeeJqrdY5mY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from frank-s9 ([217.61.144.209]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5G9n-1l71if2i17-011BVY; Sat, 24
 Jul 2021 19:06:16 +0200
Date:   Sat, 24 Jul 2021 19:06:11 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <dbe23d2a-cd29-0782-1b7d-bcb5c6683607@collabora.com>
References: <20210710132431.265985-1-linux@fw-web.de> <456f0611-1fc7-75ac-ff45-9afd94190283@collabora.com> <trinity-02bc17fc-b458-4d17-baca-8afe30e4c92c-1626110171249@3c-app-gmx-bs28> <dbe23d2a-cd29-0782-1b7d-bcb5c6683607@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: Aw: Re: [PATCH] soc: mediatek: mmsys: fix HDMI output on mt7623/bananapi-r2
Reply-to: frank-w@public-files.de
To:     linux-mediatek@lists.infradead.org,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Frank Wunderlich <linux@fw-web.de>,
        linux-arm-kernel@lists.infradead.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Collabora Kernel ML <kernel@collabora.com>
From:   Frank Wunderlich <frank-w@public-files.de>
Message-ID: <6EF00182-1FF4-4061-BCE4-E2AD7275211B@public-files.de>
X-Provags-ID: V03:K1:4FhZ1GklljU1021mGj9Ps5PKAoEI+UWnutXSedKAVhllFTdL6qE
 c1CqIwzfV3VC1imKUiJZBa2LZrDoeu81zvP/hOKF/nujp85aegg/n3/tKnl8R3s3l2J1dyP
 ReYdVoamgPbMSrCq/g8UplSje/TIqUUO/5sR0DGlVCrWrPhsj87eIuAB4Mq3bFvizVtlsle
 uABYORqkd1W6W50CWxbeg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gfZr4u6469E=:2UmEpvl+OhZS14QzOalCMU
 OnlmbM91s4cRo5JYTmRLFMiA75U6gBKCM8/x7i+F8saSi40jfUIs5yQkc77/xCJ9O2btbmNYP
 bt++S1a4YXn+SiE7RRku9fPX22xdFwDBD8gOJKeCUewH7XjfOKqQeYCAJBl+5s65unGPxEQLq
 B9Jfz4YDJGFWlYJZUB7uhLQg3US4e6ODoCIYS2vRBQEA8mdSGHLUfsLV8FnGG6+6MOxz4TRZx
 bbnN3XFeo2kMHTvuZkrK2q2jhEqaSWVVpqOQPYpBGEXIpjjC7VQjvcu/UX2+2wbhTRPt5gOFk
 t8KovDLE9Te+Zb7mnp51LCkUYXzQOnzXqySziomcstLH5tXRhaKxoEIbJSh5qY6p+L/NRt6xu
 r/hosbLzlTt0nXny/SpTq7+undBqHpzfIprTQbemnIUdU/Vua3joZ1RpNAk/CF5brqGcwWGjq
 yh3e0IMkhkdIVKthIvJLwJa75X6oyxpd5M0pK5Ir/jle2Dk0T1/ov63ieLdmHbI3amBt1YNmk
 ChPnVaiZC4mzlb6UdO8LHI+6j1OG/zgPjOyYVgoDKqOSYV424gti6dQAuXxBvbn8xhIjaXzGs
 qDrWD8ZGefvcf4uuBrQTtCuqgcOFWIPcYv9XroRd0O7j65wTToolV7JrJ6MWqQWQjt6QSR5Ak
 dDI7d6I1bLxF5JvghMtsQkjAzK26fFFYP61i1gqg+1L9YaVBA6VacEywmkIXFmjFXTXp+JoAf
 ft00rR92KDHkoYPU2zhxXrOT2N8N96O37TDIe2I5cqNbMOqVsZq/To6SOBuf3CLkuLcJHNncu
 91tkrVFx3Sorg78DJpwuSHqOIvYIuzQW8PDvA2qtI7UoB+3HZMEG/WDIEh1Jmn5BnhGsVIuCk
 zeRedyIEAvcR8n8czXdhwQJGV7hxfcEfkwppwLWiSSsw5s+wZ3wfuTGLS4eJR+clRqjIcvcAw
 jNU7A54lY6mSFqkqEl8ObhSavXv28rlmG8ZG4UWetrDT6AXg4pFpCIrFPAFXJA1gFnPKEpIG4
 m0mwULvM6n4V9mL6WDS2VnGkpuobZuT4ZHz5g6QrO55nQAh/3G0DPraZsGbqezPGASY8SHVnZ
 ig0vxqstt0R1XOHTJ3IBFD7LHqHqkI4ZIamXs7dgC9tYm32UHoWMSm5hA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On 12=2E07=2E21 19:16, Frank Wunderlich wrote:
>> Hi,
>>=20
>> it turns out that problem is the read+or of the new value
>>=20
>> i reverted my patch and changed
>>=20
>> reg =3D readl_relaxed(mmsys->regs + routes[i]=2Eaddr) | routes[i]=2Eval=
;
>> writel_relaxed(reg, mmsys->regs + routes[i]=2Eaddr);
>>=20
>> to
>>=20
>> writel_relaxed(routes[i]=2Eval, mmsys->regs + routes[i]=2Eaddr);
>>=20
>> and it works too, but maybe it breaks other platforms

A gentle ping=2E Amy further comments which of both ways is the right one =
(restoring old output select function or write only without read+or)?

regards Frank
