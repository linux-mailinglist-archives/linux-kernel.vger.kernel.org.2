Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59EE83DFC81
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 10:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236180AbhHDILj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 04:11:39 -0400
Received: from mout.gmx.net ([212.227.17.20]:55529 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236102AbhHDILi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 04:11:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628064669;
        bh=YvEcXrHPBfYzp2tdYOHNvNnbANlyDTHvf2AxPW3et7M=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Fy/Egp/3GARYqkIFltMKbJNDvxrQxAdZPd/FG+EPOeOPvcj5lDTc+2cyPjQ+rPcAh
         F+DRAdGc3p50UCEcZ84vi68k7TA2saYSj0wA0jf/pWtxOHfcLED1ILm3LKUvFlHQe+
         sJoNVLOemd4yH7Qax7tBT/ryvWmflmFxrIgLH+8s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.147.17] ([217.61.147.17]) by web-mail.gmx.net
 (3c-app-gmx-bap67.server.lan [172.19.172.67]) (via HTTP); Wed, 4 Aug 2021
 10:11:08 +0200
MIME-Version: 1.0
Message-ID: <trinity-8910c659-6e4e-4979-a6d0-eaf5b8bee213-1628064668849@3c-app-gmx-bap67>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Sungbo Eo <mans0n@gorani.run>
Cc:     linux-mediatek@lists.infradead.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Min Guo <min.guo@mediatek.com>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Aw: Re:  [PATCH 0/2] Add MUSB for MT7623
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 4 Aug 2021 10:11:08 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <f3607979-ea50-fc1c-0afe-a55881aa24f0@gorani.run>
References: <20210803151320.71531-1-mans0n@gorani.run>
 <trinity-0f9449b8-5114-46e5-9a4f-00b62155a938-1628010948338@3c-app-gmx-bs54>
 <f3607979-ea50-fc1c-0afe-a55881aa24f0@gorani.run>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:KDWodkr75906Bt6g62XmHQa9PoCrBrWNqNZQVvojYAf8r83q+NlJOQdWStEWgAwcp5Xsk
 UBrdYAoLIWiKBUNCkshM22OkDenDDKkXTdCGpNPHsRpT4Wx7NpCSfylBw3DGvsJI4iQBxUx3rFzg
 r5tr9NAliXV9Oz3JwDUN075FmTSILzA/ad/BSHs/OMYst7FzkqUB276NgPqNvZN4UtUbsXp71uhR
 cUGSp3BaI8LIYuB9lmspvlNrBFy6dCjcxg7VSUEUz63oilokVa9noH32eIIZ0jjs7CTnsx8PUGhj
 hY=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2BPuurnNY30=:oEguZKWjzcVKUemXYbFOBL
 qPt7dgNXyh4CiAnPe58jGKgbqpjJHmKk28h6ywQZiTkGw/2ijp0pXmY3Pd9BWnsNcODMOGcmW
 0+rkY3QRC7its2+Zh50j7bTrpvK5vu+mbqy334oM/S1rx9s/SMqRqkTFs16GwwSyAcaz17Ev1
 6K8Jkcy69W4GP/r7n9QtSinrHqqIY40ybdeVRYQVAa7w0qh+H7wwx9FEtd6X7+yUcGC6TryrX
 3qYLxMwyEz2svfG73RII2ks1B+7du3W8H+/66i50EBWSq3PJRaWoxSrh3Kqphpeduby2MfWqt
 7DiEDvbOKEQTzkqVLchJ3Aywuh1PPhLjTEMwAeTdsK4tjAM3NQqakUYWYITPpLTE2jfh5rR8e
 ovZmTOANBXXjFgFrJdLJznQvEaQ9rf4SmDel2dqrz57ODup77jFvX+F0BrxuU0wqANp2MYv5y
 ZtyzuyYRcGBkMCA0CfNSJ2xxDQRGEJ3chwGKAkNLVcs+HnfldVerRPecgj+RWQRptCoSsIWGD
 d5s2llHpqJrhGqrQM/Aq5jSihhW/6iARd/AwdW3tanMQQ6xksGpZIBqU8Aem/0B/dNOg5JuAF
 Nk64jvRBiF0/njrbEZsohO5rqb7nxWqX7bTV3+WMmfv7cxTElsURxCnLhpQ+tigo47vvKEbkW
 ATKEkpKzvu2k9ldzczf36Myc97SZVe07nMa6FoCnUSG4V/BQVfIQvTFSsAewqF7e2qWTQl3EX
 cROVamWwDr/Gt7pSJf7OdssHxUhfahXxi8Fy04IkvtkOvY5Rz8MAhRz/TnBhmZjLlvSo5zyVe
 o9TO4Xg4FX/pEc/f4+YrT/mtN36ZvBZFv3SqVaLjQrRUNjmp8k=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Gesendet: Mittwoch, 04. August 2021 um 02:14 Uhr
> Von: "Sungbo Eo" <mans0n@gorani.run>

> > thanks for working on it. do both otg-roles (host/client) work on your=
 device?
>
> Yes, I tested it with host mode and device mode.
> I also tried manual role-switch via sysfs and it worked with some prior =
setup.
> Note that my device has a USB Type-A connector and not micro B, so I can=
't help with id pin stuff...

> > but usb-stick is not powered (led of the stick is off) and of course i=
 see no mass-storage device.
>
> I observed the same symptom (but different error log).
>
> [    2.722253] musb-hdrc musb-hdrc.1.auto: VBUS_ERROR in a_idle (80, <Se=
ssEnd), retry #0, port1 00000104
>
> In my case adding `regulator-always-on;` in the regulator node solved th=
e problem temporarily.
> But after that I switched to relying on pinctrl.

i've found out that usb-stick is powered if i first connect otg-cable and =
then the stick to the cable...regulator always on does not change anything=
 for me (only supporess "disabling vusb" message on boot). traceback on po=
weroff is still there.

role switch happen on inserting stick into cable, not before (insert cable=
 into r2) as i expected.

need to figure out which CONFIG options i need to get USB-Stick as mass st=
orage working.

i wonder why it works on your board without the vusb/connector subnodes

> +&pio {
> +       musb_pins: musb {
> +               pins-musb {
> +                       pinmux =3D <MT7623_PIN_237_EXT_SDIO2_FUNC_DRV_VB=
US>;
> +               };
> +       };
> +};

imho it's the same gpio used for regulator, right? whats the difference?
i tried this instead of the regulator-node =3D> not powered (cable first, =
then stick).

> +&usb3 {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&musb_pins>;
> +       status =3D "okay";
> +
> +       dr_mode =3D "host";
> +
> +       connector {
> +               compatible =3D "usb-a-connector";
> +       };
> +};
>
> root@OpenWrt:~# lsusb -t
> /:  Bus 03.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dmusb-hdrc/1p, 480M
>     |__ Port 1: Dev 2, If 0, Class=3D, Driver=3Dusb-storage, 480M
> /:  Bus 02.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci-mtk/1p, 5000M
> /:  Bus 01.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci-mtk/1p, 480M
>
> I tested device mode with legacy CDC composite device module.
> You can also take more complicated configfs approach, though.
> https://elinux.org/images/e/ef/USB_Gadget_Configfs_API_0.pdf
>
> +       dr_mode =3D "host";
> -       dr_mode =3D "peripheral";
>
> root@OpenWrt:/# insmod g_cdc
> [   64.565254] using random self ethernet address
> [   64.569711] using random host ethernet address
> [   64.575966] usb0: HOST MAC 26:36:2d:e5:8f:6f
> [   64.580501] usb0: MAC 92:d7:f9:c7:88:01
> [   64.584409] g_cdc gadget: CDC Composite Gadget, version: King Kameham=
eha Day 2008
> [   64.592454] g_cdc gadget: g_cdc ready
>
> I also tried usb-role-switch,
>
> -       dr_mode =3D "host";
> +       usb-role-switch;
>
> After boot the initial mode of musb is "none", and it did not turn vbus =
on even if I set it to host mode.
> Later I found out that I need to load any gadget driver before setting i=
t to host mode.
>
> # echo peripheral > /sys/devices/platform/11200000.usb/musb-hdrc.1.auto/=
mode
> # insmod g_cdc
> # echo host > /sys/devices/platform/11200000.usb/musb-hdrc.1.auto/mode
>
> That's all I know. Please let me know if I skipped some details.
> Thanks.
>
> >
> > and now i'm back on the traceback on power down i've reported Author o=
f musb driver some time ago
> >
> > [  156.785185] WARNING: CPU: 0 PID: 1 at drivers/power/reset/mt6323-po=
weroff.c:4
> > [  156.795156] Unable to power off system
> >
> > [  156.884496] [<c0cca1ec>] (warn_slowpath_fmt) from [<c090562c>] (mt6=
323_do_pw)
> > [  156.893203]  r8:c3296d40 r7:00000024 r6:0ccccb60 r5:c10fe3d8 r4:000=
00000
> > [  156.900030] [<c09054b0>] (mt6323_do_pwroff) from [<c010ba68>] (mach=
ine_power)
> > [  156.908558]  r8:fee1dead r7:c1312590 r6:92f61d00 r5:00000000 r4:432=
1fedc
> > [  156.915385] [<c010ba34>] (machine_power_off) from [<c01524bc>] (ker=
nel_power)
> >
> > i guess it's related to the usb_vbus.
> >
> > regards Frank
> >
>
