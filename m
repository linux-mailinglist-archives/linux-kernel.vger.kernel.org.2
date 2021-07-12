Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBAB93C59A2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347939AbhGLJGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 05:06:33 -0400
Received: from mout.gmx.net ([212.227.15.18]:56291 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351457AbhGLIOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 04:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626077468;
        bh=JMgyay+YyzCR7cAHs9mF7PoljaYXpFKpYzGhoYj6ySs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=jiXTB2QZoVu1buvDckNv8rMN2n8KbDsE01Vh/TJJ2KOaWPsE4DTAObtWrh3psjZOk
         2C8oOsSDA6boztueZFoRkSh9EX49p+0RWB4lKrAlLWwD/xmMHOiRjvRpRZu+oLKt6k
         sVj42IUtrjM5r4+BLlf2rMjxREjT2qhCFH1dUjRw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [157.180.225.139] ([157.180.225.139]) by web-mail.gmx.net
 (3c-app-gmx-bs28.server.lan [172.19.170.80]) (via HTTP); Mon, 12 Jul 2021
 10:11:08 +0200
MIME-Version: 1.0
Message-ID: <trinity-2d1b055a-73b0-4a15-9677-08fd13fd486d-1626077468706@3c-app-gmx-bs28>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     chunkuang Hu <chunkuang.hu@kernel.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        David Airlie <airlied@linux.ie>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Collabora Kernel ML <kernel@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Aw: Re: Re: Re: BUG: MTK DRM/HDMI broken on 5.13 (mt7623/bpi-r2)
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 12 Jul 2021 10:11:08 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <CAAOTY_-yi5NP_U-m==ZHeBNC9-6NrjUacKWdmmgVXZjH+sFZKw@mail.gmail.com>
References: <trinity-cc8f5927-9aaf-43ae-a107-6a6229f1b481-1625565279264@3c-app-gmx-bs60>
 <25d61873-38ae-5648-faab-03431b74f777@collabora.com>
 <trinity-e6443313-a436-4e9d-a93c-1bef1cce135d-1625736911475@3c-app-gmx-bap19>
 <trinity-3f4f4b55-7e39-4d80-8fc3-7d0e2b3026de-1625758259993@3c-app-gmx-bap19>
 <trinity-fd86a04e-81b6-45f0-8ab4-5c21655bdf53-1625824929532@3c-app-gmx-bap43>
 <CAFqH_52OdB+H+yLh-b8ndbS_w3uwFyQEkZ-y2RQ2RnKnMEt6vQ@mail.gmail.com>
 <trinity-ac304676-173c-42c6-837c-38e62971ede0-1625827104214@3c-app-gmx-bap43>
 <trinity-937ebfa3-d123-42de-a289-3ad0dbc09782-1625830110576@3c-app-gmx-bap43>
 <CAAOTY_-yi5NP_U-m==ZHeBNC9-6NrjUacKWdmmgVXZjH+sFZKw@mail.gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:xkpAQRS+6hCibb8IREI/4+UQBOmHX66bpR+hfwPP9SZMr+UzKW47NfS8x+VrAsKc4Ee5V
 sIYOpYqt00E6MnbGXUEbYNR8D1Zb5iXk3A7u8WZJxQaLQ31WsFcV65jqxqMbdmZNGIfmfFO2knQR
 l33LYvxaOw+3bw1BE5fAQxl9rCVJmr4U+W6DpVwcBAG2f/Akxl9QpPBlUyVlzcaHtsxieRTPn3fC
 tcir/G8tjeb1Ouz7HEKFPXmzNL/L/CAHcd/CaMK/0iElTmacIp7HFjyzhPQ7VPPGdPB5toqPtgjP
 J8=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:H9QCYfZhSGs=:W7cfrvRAps8n+FW/OAKwdS
 iHxEnjulsqPZzWiVhu5n3Ia7k3tCAv4joj0nrsa1qBgUmu0nYCe8FLU6Ub7N5DaDuT7FGGvQn
 51yvZ3KBZ2/s9+xSexf50nthtcFraIOecX26xaWgYW6my9wgObmCFHwkWEdkMYOaNVzgoAusp
 /tOOhLG7m+Wflrh2MCcjDNKkD6uA+hQ5vEVWYCaV+s+0H5MsaYUGA9BUbjc/WwhCcQ6RUB1ET
 ynYMr0Dd0eOqRKRxtzYz29ti2W400016aLbone4X2tmy9bIz4TZB/ccx7fJvMaUIEGP0V7GL+
 EWFQD8EqZs6Yv2uMX6MtxqVxFEsq6Do5XdIpE9BJ8/i1RgVGGLykigqelZMQIBFA1BWo5thxz
 kXcRKDWLjs69li/A9Gsit/97cZIqdV5lTc1IR0IiG3WOpQTClszM6qYjl17949OCX47szg2uz
 1ollY2XbCxPn/SW5U0jLqQXfR98z3ho5ucND7Lcp2FcOvczlnViXBhyhHtHfjFasgjfpNtyUP
 rvqIDJW3j0uo8o2wXym5mLLMayrfLawbeOWpDjJCiIyH9IdJC3Lzc9SIMr+Z4Gn6E10csHqI6
 P2aOZIi76e09tYNloftsw0qRqIOX9LghYaL688hWlhJWWLZgEHljX6yY+/fsRnivX4wxeevQL
 f4F//ttTtiFL9mk08aJnfYuIihCXQ1dLOnIBTZtsdTibhg8yOacpaBNGvCTDVoXbxR8v0QPm6
 mEOH4IO3BzOPj4En32ukb3vkzsWf+xO6b2DIkKffNzaOffYqADcdOiCtn9gO9pU7/Pw/T8vS2
 04CoVBBivmnUa1TXL4oT2rxFvNRCPfuwsn5QuafxuX5sQfv99k=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

HDMI is broken again in 5.14-rc1 (of course i have applied my patch [1])

now i've got a NULL pointer dereference

[   21.883641] PC is at mtk_dpi_bridge_atomic_check+0x38/0x78
[   21.889158] LR is at drm_atomic_bridge_chain_check+0x150/0x30c

"dpi" is  not set correctly in mtk_dpi_bridge_atomic_check

this function is new since

commit ec8747c52434b69cea2b18068e72f051e23d3839
    drm/mediatek: dpi: Add bus format negotiation

i do not see where bridge->driver_private is set, but in other function it=
 is solved like this:

bridge_to_dpi(bridge)

this fixes the NULL-pointer dereference, and system starts to xserver, but=
 i do not see fbcon...it looks like drm is now initialized later (~ at log=
in prompt on serial console). i stopped lightdm and still do not see login=
prompt on hdmi, so it looks like fbcon is broken

send out fix for NULL issue, but fbcon ist still unclear...but i see this =
in dmesg:

dmesg | grep -i fbcon
[    0.000000] Kernel command line: root=3D/dev/mmcblk0p2 rw rootwait earl=
yprintk console=3DttyS0,115200 video=3D1280x1024 console=3Dtty1 fbcon=3Dma=
p:0
[    0.000000] Unknown command line parameters: fbcon=3Dmap:0
[    7.040167]     fbcon=3Dmap:0

and no framebuffer/fb0 in dmesg

regards Frank

[1] https://patchwork.kernel.org/project/linux-mediatek/patch/202107101324=
31.265985-1-linux@fw-web.de/
