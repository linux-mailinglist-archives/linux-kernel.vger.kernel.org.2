Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B160D3DF3B2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 19:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237849AbhHCRQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 13:16:46 -0400
Received: from mout.gmx.net ([212.227.17.21]:54319 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237864AbhHCRQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 13:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628010948;
        bh=dCJAv9vYWkTYWaiwSK/+b0SL2G2WQhBtdtJ5pV7ILXA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=FdJ3+lq26JPK4sjOBdkQbQcMGS/IA0JWMonWIDr2iDhxqQjpZnzJmyB85za40bFA9
         WVtTmYE1Iqdy9xsvjurI7bj4sEnjg6p//hSY8M1jWF/0SLqlABJN2pCkkP0veZ0CMG
         2pJbespqfcCKuy1JV9rf7OfwcnpCFOfqC6d9KFN4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.158.209] ([217.61.158.209]) by web-mail.gmx.net
 (3c-app-gmx-bs54.server.lan [172.19.170.138]) (via HTTP); Tue, 3 Aug 2021
 19:15:48 +0200
MIME-Version: 1.0
Message-ID: <trinity-0f9449b8-5114-46e5-9a4f-00b62155a938-1628010948338@3c-app-gmx-bs54>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Sungbo Eo <mans0n@gorani.run>
Cc:     linux-mediatek@lists.infradead.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Min Guo <min.guo@mediatek.com>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sungbo Eo <mans0n@gorani.run>
Subject: Aw: [PATCH 0/2] Add MUSB for MT7623
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 3 Aug 2021 19:15:48 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20210803151320.71531-1-mans0n@gorani.run>
References: <20210803151320.71531-1-mans0n@gorani.run>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:+x7Po+to3M3ZmemoEJPeIaz/yToRmM77Y8roaUamiJB5bHZ9lcF8YCvW8QPjr6E1Y8xb1
 pvYshKflbK9f/JSMfAzqalhvzJBDx+Hex7cOF8IDdH1Py6xfEtzZRJqJZDd/qFW+YmkPUjwtE6OM
 5XVinLUdJkG8zB59VzQFU0Zt/gwYN1UuKBt2Vhm1+eX0ekpdLUdwb8+9drpdk0CpOSj5PNg7+dgW
 /st6ZkIeppKKLJxkDFZ7ToE/dKhlTE0Acc9UlhKNlAE+8+UF0e6Rl9HNSQpQQbNxm5h3U5Mffvdt
 1g=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Fu8vFzkOtVI=:L1rPZNcoU/50dnRWKL4Wzt
 Hq6raVPuRSDGLAWdfqbq9DhWTYl5AZG/6lYejiG+K6oM/LnGrkICKDjDYVD5/+SZGUPvCEx6X
 wvwxccElGNQ0IMiCwc0N+0rrkCauPQn/ExFbSrAGAG1+glfN2Oegjgna/Riowq1DdPMpRwNYE
 v13UoIpvXXyI8Yz3udFp/Ac9DycAT1CekTnAXqp1b6SecrJ7RO9TFvMtgzAU3za1ZgeZ+gPl5
 lMDvbzDBxy9uG7g9JhdrLnZzc+Kg2bQ8wWms2xuiJu7/0YpG90xHr7hK2Xol3kmPeOk7VNcYU
 p+n8v3eXKDwGJ5+jwd2C6tF166Md03V1ef+a4t5tcjqHSCRSeuyvSUstvU5pOh9whdd5yAlYy
 nsYJZfQxBaIbsRjpwuX+palyzkGWlsE0w6M/iU0sK243wOQBvkDtaLxyLhlUTIJ4WBLDMN/uQ
 ItsJP7VGfk4t96OXRIbYld8hHC+lrWf8o/4Y2vRT0IxpURCFdkYNxGjNriO6DC53IbAwBlOAG
 hGQoNabU5xvgCNfc4xx6KbrGmE6ZWbUTXyIq0cO3SeezQhJUpK30dobkFx4B1MvM2kRtZH8FU
 RjaR+B2z7Qt+QvEC8KrCavWzWD2sBZRGUNFP03+1BflP9BFuQKBvncGbg7erLmVWuWfXmdGXY
 I7+HaVskRzPPRmSYic5ZW4+TszYEAGinlQzigTiXC4uqdZ82u9MGO6QUrLzaJpuXNsLomuOBb
 n8u8VOdQEcc7V9uH34O9Jj3xvZZl/R8PZ1TLg69EsG20iR3KVN0oP/ylEkNlbrPG5125njHdu
 1lEw87Qr2YxA1aJNyNTH0z2ve9GOfgwifTUPASwHjCIS4muLDw=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Gesendet: Dienstag, 03. August 2021 um 17:13 Uhr
> Von: "Sungbo Eo" <mans0n@gorani.run>
> An: linux-mediatek@lists.infradead.org
> Cc: "Chunfeng Yun" <chunfeng.yun@mediatek.com>, "Greg Kroah-Hartman" <gr=
egkh@linuxfoundation.org>, "Rob Herring" <robh+dt@kernel.org>, "Matthias B=
rugger" <matthias.bgg@gmail.com>, "Min Guo" <min.guo@mediatek.com>, "Frank=
 Wunderlich" <frank-w@public-files.de>, devicetree@vger.kernel.org, linux-=
usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vg=
er.kernel.org, "Sungbo Eo" <mans0n@gorani.run>
> Betreff: [PATCH 0/2] Add MUSB for MT7623
>
> These patches add support for the MUSB controller on Mediatek MT7623.
> Tested on Mercury RUSH-318AC Wi-Fi router.
>
> I got to know this from a BPI-R2 forum post [1], and managed to make it =
work on OpenWrt snapshot.
> I'd like to know if this also works on BPI-R2, I can happily share the d=
etails if needed.
> And I've just copy & pasted nodes from mt2701, please let me know if I m=
issed some big differences between SoCs...
>
> [1] http://forum.banana-pi.org/t/bpi-r2-otg-port/10551

thanks for working on it. do both otg-roles (host/client) work on your dev=
ice?

unfortunately at least host-mode does not work (do not know how to test cl=
ient mode). i guess because iddig and vusb nodes are missing.

i took your Patchset and enabled the usb-node for bpi-r2.

+&usb3 {
+       status =3D "okay";
+};

and added these config-symbols:

+CONFIG_USB_CONN_GPIO=3Dy
+CONFIG_USB_MUSB_HDRC=3Dy
+CONFIG_USB_MUSB_MEDIATEK=3Dy
+CONFIG_NOP_USB_XCEIV=3Dy
+CONFIG_USB_CONFIGFS=3Dy
+#CONFIG_USB_CONFIGFS_MASS_STORAGE=3Dy
+#CONFIG_PHY_MTK_TPHY=3Dy
+CONFIG_USB_GADGET=3Dy
+CONFIG_USB_MUSB_DUAL_ROLE=3Dy
+CONFIG_USB_INVENTRA_DMA=3Dy

btw. imho otg-node should be named usb0 as other dts (kernel 4.4) also use=
 usb0, else i think it's confusing.

in my last attempt i had these below usb-node in boards devicetree:

+       usb_vbus: regulator@0 {
+               compatible =3D "regulator-fixed";
+               regulator-name =3D "usb_vbus";
+               regulator-min-microvolt =3D <5000000>;
+               regulator-max-microvolt =3D <5000000>;
+               gpio =3D <&pio 237 GPIO_ACTIVE_HIGH>;
+               enable-active-high;
+       };
+
+       connector{
+               compatible =3D "gpio-usb-b-connector", "usb-b-connector";
+               type =3D "micro";
+               id-gpios =3D <&pio 44 GPIO_ACTIVE_HIGH>;
+               vbus-supply =3D <&usb_vbus>;
+       };

after adding these i see the connection of otg-cable with usb-stick in dme=
sg:

[   53.656304] usb-conn-gpio 11200000.usb:connector: repeated rot
[   53.696324] usb-conn-gpio 11200000.usb:connector: repeated role: host

but usb-stick is not powered (led of the stick is off) and of course i see=
 no mass-storage device.

and now i'm back on the traceback on power down i've reported Author of mu=
sb driver some time ago

[  156.785185] WARNING: CPU: 0 PID: 1 at drivers/power/reset/mt6323-powero=
ff.c:4
[  156.795156] Unable to power off system

[  156.884496] [<c0cca1ec>] (warn_slowpath_fmt) from [<c090562c>] (mt6323_=
do_pw)
[  156.893203]  r8:c3296d40 r7:00000024 r6:0ccccb60 r5:c10fe3d8 r4:0000000=
0
[  156.900030] [<c09054b0>] (mt6323_do_pwroff) from [<c010ba68>] (machine_=
power)
[  156.908558]  r8:fee1dead r7:c1312590 r6:92f61d00 r5:00000000 r4:4321fed=
c
[  156.915385] [<c010ba34>] (machine_power_off) from [<c01524bc>] (kernel_=
power)

i guess it's related to the usb_vbus.

regards Frank

