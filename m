Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B20F3B4095
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 11:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhFYJei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 05:34:38 -0400
Received: from mout.gmx.net ([212.227.17.21]:40287 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230523AbhFYJeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 05:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624613519;
        bh=c4s3npKDwZv6b/q1SzXsWsCp8/0lbD8GagzJKn9ZWB4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=H1lJfD1vRIp1kzY0ewroxbWmdEwW9ixgTVfM8dMHHqMV33WP0/PNs81OF0d7Yd6PY
         Zi/S1UveBxgY6f4vlKTBr1eSEvwXpLdt/s9faKvzOTGDkuRDbZ848+pfsfLgdH9KrL
         jhJlGtBuLx5EyJpJaqeTV2zGHIstE9+ahc0hq0dU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.157.219] ([217.61.157.219]) by web-mail.gmx.net
 (3c-app-gmx-bs66.server.lan [172.19.170.210]) (via HTTP); Fri, 25 Jun 2021
 11:31:59 +0200
MIME-Version: 1.0
Message-ID: <trinity-1a7ab0b7-d895-49ab-b3b9-3bf426889418-1624613519415@3c-app-gmx-bs66>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Eric Woudstra <ericwouds@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: Aw: Re: Re: [PATCH] Fix mt7622.dtsi thermal cpu
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Jun 2021 11:31:59 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <YNWgVxvNbwNcT3B8@makrotopia.org>
References: <20210619121927.32699-1-ericwouds@gmail.com>
 <e30a2d01-a200-80cb-88d9-6aea62dd49f1@linaro.org>
 <56fb5540-fb86-4e6a-a596-1276026b37e5@gmail.com>
 <a4e41929-6ab4-fabb-741e-f25a5fd14e3b@linaro.org>
 <47261865-00e3-41eb-bb36-2b939f81f1e8@gmail.com>
 <fb633034-96e5-6165-b43f-290ae1a65cfd@linaro.org>
 <189b52d5-b103-43e1-a64f-1e627fbc75af@gmail.com>
 <173e6bab-9d21-eb28-9b91-a5f80c01fd03@linaro.org>
 <3dd22cf2-1186-4870-aa49-e5cddc18c6e9@gmail.com>
 <trinity-7580d955-3187-41e5-9297-1ac8f628a9d5-1624609003739@3c-app-gmx-bs66>
 <YNWgVxvNbwNcT3B8@makrotopia.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:mcYdBRprVpY4oUEHthoriHz4c4RGuCLxPwnDUj20+/cU9hXfLJoDGmTsQV0KVrHHFk4ID
 C5CwhbBPk5KASUTVJHxlhkXeN+je2H/pvbhAmWT2sXrioONmmA17anzdDXldW2eliP+N6rsx2FIx
 rb+I4G+X7R/eSqGFlbgkrSdUsCVVlcAEW/Sv4S9PXkFMmJEdvO4c0pnMyMD2U+b4woh9X1omkDMb
 vKKAT7NZ3Y5mMDXNp2nT5ol/N0T2kwK3QJXHa1777joWA27j1fUteAR4HHYvI8zzpsmH/6e6UmK7
 LI=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:aPAPN+zv5mU=:LL43kiOXYJ1e+szzmutz9K
 zH4JEOUjfjfTdw3Qe+YEOISUJ8knpjA4WwcBmMgsv49NCkW6XKdtVEkK0UIHKkyIHQJaHtmj9
 6zs3hJ1GIl+nb5JLVxPBzL+7E4XfpNZEMd2IblYxpUVbxpo22zsWRpuJ3ymbNIhrbK745R8KO
 K5MuxlsnjOBjaiOftwU2bVgePCNY1WJUhPnIA1h8z+QwUU/NVF6A4PJiOyNNSpIekKTvG9vhT
 TVX2sEFP0A/PjxhExG37uKA5x4AV7wrVnvO4L82s4+zVQBJdoVy0msRWYkGlhiX85AUTSBVtl
 orc1mPz7cB6QL6uWko0xyLLNp5jg+qrVL/7WOIEgk/kp0EhPMneVo07T9j/6LBLabBK1RWFWw
 mGLWWqrYZtAvHDLIyWb4uQkF/PAK1PJvKzYRiTkbm5c5wI8PblB7Ws615f/InmTk1g5CuFstP
 efWPvW4DwjIutfGF232T0gOgyGC3BsaX6vminEljrdsfdcje7T3eFLDfSWLBkz9IWEqtf9v0m
 CZ7MbJzoc1ZJATwSGxIJaocYZJzEUewgwo/ctlp6pgh4P4AdVFbchOoO2kmq4k8Ts8BvYZG9t
 /gC4aF56s+35SvzRMtVE6bwRTJri6skI/mw5RESBzVe/c0tnLc9luMU5KCOEhYlhHtE/t0qmO
 SPCUhG8bdCzQ2+sLHjb+LDYO4Sw3w2d2g4PYf9NFI4V8ADA/nE11qhmfSoaNGMS/vimIwCgv9
 9Y3Ll/qcUxEPBCoOW6qB64b1RuTZTb0Zio/HJbZcPJIR7bioHqPAwkrBlRnjwawRiFhq7SXDD
 3oySbFNDIeH2N648oJDgGprn92xmxh4pJ85NtfYtEBIc5be8r0=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Gesendet: Freitag, 25. Juni 2021 um 11:22 Uhr
> Von: "Daniel Golle" <daniel@makrotopia.org>

> On Fri, Jun 25, 2021 at 10:16:43AM +0200, Frank Wunderlich wrote:
> > Daniel from openwrt have some other mt7622 Boards maybe he can test th=
e Fan approach below
>
> I got Linksys E8450 aka. Belkin RT3200 ( https://fcc.io/K7S-03571 ) as
> well as Ubiquiti UniFi 6 LR ( https://fcc.io/SWX-U6LR ). Both got quite
> massive customized heatsinks (see internal photos on FCC submission),
> which results in much better heat dissipation than just having the
> naked chip like on the BPi-R64.
> Hence I also can't test the fan approach on boards other than the R64.

Do your both mt7622 boards miss the fan-socket or is it not connected to p=
wm3? then we need to move the fan-parts to mt7622-bananapi-r64.dts instead=
 of mt7622.dtsi

regards Frank
