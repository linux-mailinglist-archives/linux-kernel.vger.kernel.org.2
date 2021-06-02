Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6513994B2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 22:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhFBUlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 16:41:11 -0400
Received: from mout.gmx.net ([212.227.15.15]:34661 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229541AbhFBUlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 16:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1622666364;
        bh=qPN21NCT+HHcm9R8yZvFBBtIw+Myk1emvASQT+MMASc=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=Nb1wng+qjZc1JAnIMp2b2oBiipTV6VCrY77ZaHZGwLm60H0Rxx0vs1wmS/nTyxZM0
         9o5b1lztB+RoXyJMAWBELwA3SWDOJqV/dLajE/BnQqQ8sZNXnLqVWA0E1OBsfOOx2A
         6iooycWwuoUbOU3bjn7oOG3jEg7isN0z4EjhnPRU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [93.194.223.136] ([93.194.223.136]) by web-mail.gmx.net
 (3c-app-gmx-bs30.server.lan [172.19.170.82]) (via HTTP); Wed, 2 Jun 2021
 22:39:24 +0200
MIME-Version: 1.0
Message-ID: <trinity-28ae5c84-2f2a-41bc-b4cf-feb825ec538d-1622666364612@3c-app-gmx-bs30>
From:   Roman <klangrausch@wolke7.net>
To:     linux-kernel@vger.kernel.org
Subject: Allen&Heath Xone43C: USB communication
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 2 Jun 2021 22:39:24 +0200
Importance: normal
Sensitivity: Normal
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
X-Provags-ID: V03:K1:1gwpd1mAHbvpo4GOO8JwkRDV9utBOllS3Yby/OhlhDUgyXpSs/Bhujknv2yQEhPzD7fav
 bLewlMGxtu5PPPMDgm99xpAOSPjpxIEzJDfsZk07//IjK+X/kFLFHmdqsCw0/BpyN4A9j+24PKJw
 ru+BiBcxOazcNvUbCbIzvKYwmArWpIkdL0Py9rWOsB3ISC/ZHZsXLEZUcUmuWReLXSPYaxRPe08G
 nAXDzY/VPbVQS7qudtCMNTCy0o3MIQwhSZEu5WT+RM0csh+IFnQa7I+NXtbuGm7jmvUOqDjBPcI9
 mE=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z80NaGKnJvQ=:mwLrXMw6tL24ZuUR3zii9H
 lgHEoWHwRp4GaVzAV91DD8Dp4fRKLadaRiSwkOBeSt7IQvcpABH1VzDUU/hs1tO6N49rNFLRc
 +vwLA76udC9+XTfCcsQ6SRSwQHyZP4QFGQ1KqlhY60gZd/7RS+YzjfrBlphlrZmRdWWO1tD/o
 4HU9NM1Szn5hv/RaVfB7H5/gh0nl527ybQ0PuHMKOiVSMcAy0rEi5yugUA39She2Ai7p9TkLn
 Fn++KMDNI1B87zHc7ocwcBks19puyRJA0pukNQZDbJQZdNRdgXslLtARvJ5w7z+Ak4Ep2kSGq
 DgbSoRhic3yLkXfiDIUSZFgGAolTki/bLknBcnuBq5hRT4C5OrUYqgpa8JbVxUI5on1dNwD2W
 Xau3WVWoDpVBeq9pQi9sMxGtBiR+B4mlkOv+drUT11ZgjaEb3SzJWN2Yf7uCM8pNGR6zwdDPg
 IpkDVB4nPD9wypXczd5wI+o5uLMhGIdmeWthwaA7/DdatvrqVHx0RTKBCGrfEmb6fukEG5leL
 nyvCsgLXksdTm5E3y4htT4A9lWICErc1d4VY4qa/qKyJaHYhJnOh9KJclwY9mxcBPyTG84XH9
 1cQMQBgMFEw/f8MfJ0WaWWN6RckV0X1zC9L3GWOeJIwkVBvmKb289nKfgch2oFFUHk+aZbCot
 uAsNs4+Hbd8ln8Oo4r63jC71VcPJpgc/6t5TNa/7qNqcKLyCWhFXl8l+tCp90GMNr6dLT/KZj
 uDFBZZcKc5JZ5IczVxn5kDa+dkvQ8p16hJyqmY/Cfufx0C1Jng/d+VBkJp0aGPeq0U23acZMB
 HsW7mE2qDs7Imy49/eGLYlUEXt/QsxW8JgnoclWt1piNoRdk1H34F3226Ydy6WOKaNbbt7NtM
 dvog29XE440v1VTBa46w==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all, hello list,
I am not sure whether this is the correct list, since it's not strictly an
ALSA affair (fw to kernel-devel)=2E Recent progress on driver support for
Pioneer devices encouraged me to dissect USB communication with an
Allen&Heath Xone43C, a mixer with USB interface=2E It does feature 16 chan=
nels
(8 in, 8 out), but only 4 (2 in, 2 out) show up, 2 of which remain automag=
ically
silent=2E There is no linux driver yet, and maybe I can help?

Addresses are:
0x80 =C2=A0 =C2=A0Endpoint 0 (in)
0x00 =C2=A0 =C2=A0Endpoint 0 (out)
0x81 =C2=A0 =C2=A0Endpoint 1 (in) =C2=A0=C2=A0 Interface 2=2E1 and Interfa=
ce 2=2E2 (vendor spec)
0x02 =C2=A0 =C2=A0Endpoint 2 (out)=C2=A0  Interface 1=2E1 and Interface 1=
=2E2 (vendor spec)
0x85 =C2=A0 =C2=A0Endpoint 5 (in) =C2=A0=C2=A0 Interface 1=2E1
0x83 =C2=A0 =C2=A0Endpoint 3 (in) =C2=A0=C2=A0 Interface 3 MIDI
0x04 =C2=A0 =C2=A0Endpoint 4 (out)=C2=A0  Interface 3 MIDI
=C2=A0
----------------------------------
=C2=A0
I have a sniff here:
https://drive=2Egoogle=2Ecom/file/d/1UPXCN-r7jc9hfm1d-Hip8vckSs2RQNtC/view=
?usp=3Dsharing
=C2=A0
---------------------------------

USB info:
=C2=A0
Bus 001 Device 006: ID 22f0:000f Allen&Heath Xone:43C
Device Descriptor:
=C2=A0 bLength =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A018
=C2=A0 bDescriptorType =C2=A0 =C2=A0 =C2=A0 =C2=A0 1
=C2=A0 bcdUSB =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2=2E00
=C2=A0 bDeviceClass =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0239 Miscellaneous De=
vice
=C2=A0 bDeviceSubClass =C2=A0 =C2=A0 =C2=A0 =C2=A0 2
=C2=A0 bDeviceProtocol =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 Interface Association
=C2=A0 bMaxPacketSize0 =C2=A0 =C2=A0 =C2=A0 =C2=A064
=C2=A0 idVendor =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x22f0
=C2=A0 idProduct =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x000f
=C2=A0 bcdDevice =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02=2E00
=C2=A0 iManufacturer =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 Allen&Heath
=C2=A0 iProduct =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02 X=
one:43C
=C2=A0 iSerial =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3 n=
o serial number
=C2=A0 bNumConfigurations =C2=A0 =C2=A0 =C2=A01
=C2=A0 Configuration Descriptor:
=C2=A0 =C2=A0 bLength =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 9
=C2=A0 =C2=A0 bDescriptorType =C2=A0 =C2=A0 =C2=A0 =C2=A0 2
=C2=A0 =C2=A0 wTotalLength =C2=A0 =C2=A0 =C2=A0 0x0126
=C2=A0 =C2=A0 bNumInterfaces =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04
=C2=A0 =C2=A0 bConfigurationValue =C2=A0 =C2=A0 1
=C2=A0 =C2=A0 iConfiguration =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00
=C2=A0 =C2=A0 bmAttributes =C2=A0 =C2=A0 =C2=A0 =C2=A0 0xc0
=C2=A0 =C2=A0 =C2=A0 Self Powered
=C2=A0 =C2=A0 MaxPower =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00mA
=C2=A0 =C2=A0 Interface Descriptor:
=C2=A0 =C2=A0 =C2=A0 bLength =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 9
=C2=A0 =C2=A0 =C2=A0 bDescriptorType =C2=A0 =C2=A0 =C2=A0 =C2=A0 4
=C2=A0 =C2=A0 =C2=A0 bInterfaceNumber =C2=A0 =C2=A0 =C2=A0 =C2=A00
=C2=A0 =C2=A0 =C2=A0 bAlternateSetting =C2=A0 =C2=A0 =C2=A0 0
=C2=A0 =C2=A0 =C2=A0 bNumEndpoints =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0
=C2=A0 =C2=A0 =C2=A0 bInterfaceClass =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 Audio
=C2=A0 =C2=A0 =C2=A0 bInterfaceSubClass =C2=A0 =C2=A0 =C2=A01 Control Devi=
ce
=C2=A0 =C2=A0 =C2=A0 bInterfaceProtocol =C2=A0 =C2=A0 =C2=A00
=C2=A0 =C2=A0 =C2=A0 iInterface =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00
=C2=A0 =C2=A0 =C2=A0 AudioControl Interface Descriptor:
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bLength =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A011
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorType =C2=A0 =C2=A0 =C2=A0 =C2=A036
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorSubtype =C2=A0 =C2=A0 =C2=A01 (HEAD=
ER)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bcdADC =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 1=2E00
=C2=A0 =C2=A0 =C2=A0 =C2=A0 wTotalLength =C2=A0 =C2=A0 =C2=A0 0x0035
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bInCollection =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 3
=C2=A0 =C2=A0 =C2=A0 =C2=A0 baInterfaceNr(0) =C2=A0 =C2=A0 =C2=A0 =C2=A01
=C2=A0 =C2=A0 =C2=A0 =C2=A0 baInterfaceNr(1) =C2=A0 =C2=A0 =C2=A0 =C2=A02
=C2=A0 =C2=A0 =C2=A0 =C2=A0 baInterfaceNr(2) =C2=A0 =C2=A0 =C2=A0 =C2=A03
=C2=A0 =C2=A0 =C2=A0 AudioControl Interface Descriptor:
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bLength =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A012
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorType =C2=A0 =C2=A0 =C2=A0 =C2=A036
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorSubtype =C2=A0 =C2=A0 =C2=A02 (INPU=
T_TERMINAL)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bTerminalID =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 1
=C2=A0 =C2=A0 =C2=A0 =C2=A0 wTerminalType =C2=A0 =C2=A0 =C2=A00x0101 USB S=
treaming
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bAssocTerminal =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A00
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bNrChannels =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 2
=C2=A0 =C2=A0 =C2=A0 =C2=A0 wChannelConfig =C2=A0 =C2=A0 0x0003
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Left Front (L)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Right Front (R)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 iChannelNames =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 iTerminal =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 0
=C2=A0 =C2=A0 =C2=A0 AudioControl Interface Descriptor:
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bLength =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 9
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorType =C2=A0 =C2=A0 =C2=A0 =C2=A036
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorSubtype =C2=A0 =C2=A0 =C2=A03 (OUTP=
UT_TERMINAL)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bTerminalID =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 2
=C2=A0 =C2=A0 =C2=A0 =C2=A0 wTerminalType =C2=A0 =C2=A0 =C2=A00x0602 Digit=
al Audio Interface
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bAssocTerminal =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A00
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bSourceID =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 1
=C2=A0 =C2=A0 =C2=A0 =C2=A0 iTerminal =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 0
=C2=A0 =C2=A0 =C2=A0 AudioControl Interface Descriptor:
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bLength =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A012
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorType =C2=A0 =C2=A0 =C2=A0 =C2=A036
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorSubtype =C2=A0 =C2=A0 =C2=A02 (INPU=
T_TERMINAL)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bTerminalID =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 3
=C2=A0 =C2=A0 =C2=A0 =C2=A0 wTerminalType =C2=A0 =C2=A0 =C2=A00x0602 Digit=
al Audio Interface
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bAssocTerminal =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A00
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bNrChannels =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 2
=C2=A0 =C2=A0 =C2=A0 =C2=A0 wChannelConfig =C2=A0 =C2=A0 0x0003
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Left Front (L)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Right Front (R)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 iChannelNames =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 iTerminal =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 0
=C2=A0 =C2=A0 =C2=A0 AudioControl Interface Descriptor:
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bLength =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 9
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorType =C2=A0 =C2=A0 =C2=A0 =C2=A036
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorSubtype =C2=A0 =C2=A0 =C2=A03 (OUTP=
UT_TERMINAL)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bTerminalID =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 4
=C2=A0 =C2=A0 =C2=A0 =C2=A0 wTerminalType =C2=A0 =C2=A0 =C2=A00x0101 USB S=
treaming
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bAssocTerminal =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A00
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bSourceID =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 3
=C2=A0 =C2=A0 =C2=A0 =C2=A0 iTerminal =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 0
=C2=A0 =C2=A0 Interface Descriptor:
=C2=A0 =C2=A0 =C2=A0 bLength =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 9
=C2=A0 =C2=A0 =C2=A0 bDescriptorType =C2=A0 =C2=A0 =C2=A0 =C2=A0 4
=C2=A0 =C2=A0 =C2=A0 bInterfaceNumber =C2=A0 =C2=A0 =C2=A0 =C2=A01
=C2=A0 =C2=A0 =C2=A0 bAlternateSetting =C2=A0 =C2=A0 =C2=A0 0
=C2=A0 =C2=A0 =C2=A0 bNumEndpoints =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0
=C2=A0 =C2=A0 =C2=A0 bInterfaceClass =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 Audio
=C2=A0 =C2=A0 =C2=A0 bInterfaceSubClass =C2=A0 =C2=A0 =C2=A02 Streaming
=C2=A0 =C2=A0 =C2=A0 bInterfaceProtocol =C2=A0 =C2=A0 =C2=A00
=C2=A0 =C2=A0 =C2=A0 iInterface =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00
=C2=A0 =C2=A0 Interface Descriptor:
=C2=A0 =C2=A0 =C2=A0 bLength =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 9
=C2=A0 =C2=A0 =C2=A0 bDescriptorType =C2=A0 =C2=A0 =C2=A0 =C2=A0 4
=C2=A0 =C2=A0 =C2=A0 bInterfaceNumber =C2=A0 =C2=A0 =C2=A0 =C2=A01
=C2=A0 =C2=A0 =C2=A0 bAlternateSetting =C2=A0 =C2=A0 =C2=A0 1
=C2=A0 =C2=A0 =C2=A0 bNumEndpoints =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2
=C2=A0 =C2=A0 =C2=A0 bInterfaceClass =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 Audio
=C2=A0 =C2=A0 =C2=A0 bInterfaceSubClass =C2=A0 =C2=A0 =C2=A02 Streaming
=C2=A0 =C2=A0 =C2=A0 bInterfaceProtocol =C2=A0 =C2=A0 =C2=A00
=C2=A0 =C2=A0 =C2=A0 iInterface =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00
=C2=A0 =C2=A0 =C2=A0 AudioStreaming Interface Descriptor:
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bLength =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 7
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorType =C2=A0 =C2=A0 =C2=A0 =C2=A036
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorSubtype =C2=A0 =C2=A0 =C2=A01 (AS_G=
ENERAL)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bTerminalLink =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 1
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bDelay =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A01 frames
=C2=A0 =C2=A0 =C2=A0 =C2=A0 wFormatTag =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0001 =
PCM
=C2=A0 =C2=A0 =C2=A0 AudioStreaming Interface Descriptor:
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bLength =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A011
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorType =C2=A0 =C2=A0 =C2=A0 =C2=A036
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorSubtype =C2=A0 =C2=A0 =C2=A02 (FORM=
AT_TYPE)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bFormatType =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 1 (FORMAT_TYPE_I)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bNrChannels =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 2
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bSubframeSize =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 3
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bBitResolution =C2=A0 =C2=A0 =C2=A0 =C2=A0 24
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bSamFreqType =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A01 Discrete
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tSamFreq[ 0] =C2=A0 =C2=A0 =C2=A0 =C2=A048000
=C2=A0 =C2=A0 =C2=A0 Endpoint Descriptor:
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bLength =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 9
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorType =C2=A0 =C2=A0 =C2=A0 =C2=A0 5
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bEndpointAddress =C2=A0 =C2=A0 0x02 =C2=A0EP 2=
 OUT
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bmAttributes =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A05
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Transfer Type =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Isochronous
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Synch Type =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 Asynchronous
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Usage Type =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 Data
=C2=A0 =C2=A0 =C2=A0 =C2=A0 wMaxPacketSize =C2=A0 =C2=A0 0x0126 =C2=A01x 2=
94 bytes
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bInterval =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 4
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bRefresh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A00
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bSynchAddress =C2=A0 =C2=A0 =C2=A0 =C2=A0 133
=C2=A0 =C2=A0 =C2=A0 =C2=A0 AudioStreaming Endpoint Descriptor:
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bLength =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 7
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorType =C2=A0 =C2=A0 =C2=A0 =
=C2=A037
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorSubtype =C2=A0 =C2=A0 =C2=A0=
1 (EP_GENERAL)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bmAttributes =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x01
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Sampling Frequency
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bLockDelayUnits =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 2 Decoded PCM samples
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wLockDelay =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
0x0000
=C2=A0 =C2=A0 =C2=A0 Endpoint Descriptor:
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bLength =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 9
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorType =C2=A0 =C2=A0 =C2=A0 =C2=A0 5
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bEndpointAddress =C2=A0 =C2=A0 0x85 =C2=A0EP 5=
 IN
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bmAttributes =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A01
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Transfer Type =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Isochronous
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Synch Type =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 None
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Usage Type =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 Data
=C2=A0 =C2=A0 =C2=A0 =C2=A0 wMaxPacketSize =C2=A0 =C2=A0 0x0003 =C2=A01x 3=
 bytes
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bInterval =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 4
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bRefresh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A05
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bSynchAddress =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0
=C2=A0 =C2=A0 Interface Descriptor:
=C2=A0 =C2=A0 =C2=A0 bLength =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 9
=C2=A0 =C2=A0 =C2=A0 bDescriptorType =C2=A0 =C2=A0 =C2=A0 =C2=A0 4
=C2=A0 =C2=A0 =C2=A0 bInterfaceNumber =C2=A0 =C2=A0 =C2=A0 =C2=A01
=C2=A0 =C2=A0 =C2=A0 bAlternateSetting =C2=A0 =C2=A0 =C2=A0 2
=C2=A0 =C2=A0 =C2=A0 bNumEndpoints =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1
=C2=A0 =C2=A0 =C2=A0 bInterfaceClass =C2=A0 =C2=A0 =C2=A0 255 Vendor Speci=
fic Class
=C2=A0 =C2=A0 =C2=A0 bInterfaceSubClass =C2=A0 =C2=A0 =C2=A00
=C2=A0 =C2=A0 =C2=A0 bInterfaceProtocol =C2=A0 =C2=A0 =C2=A00
=C2=A0 =C2=A0 =C2=A0 iInterface =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00
=C2=A0 =C2=A0 =C2=A0 Endpoint Descriptor:
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bLength =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 9
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorType =C2=A0 =C2=A0 =C2=A0 =C2=A0 5
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bEndpointAddress =C2=A0 =C2=A0 0x02 =C2=A0EP 2=
 OUT
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bmAttributes =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A05
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Transfer Type =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Isochronous
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Synch Type =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 Asynchronous
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Usage Type =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 Data
=C2=A0 =C2=A0 =C2=A0 =C2=A0 wMaxPacketSize =C2=A0 =C2=A0 0x0200 =C2=A01x 5=
12 bytes
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bInterval =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 1
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bRefresh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A00
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bSynchAddress =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0
=C2=A0 =C2=A0 Interface Descriptor:
=C2=A0 =C2=A0 =C2=A0 bLength =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 9
=C2=A0 =C2=A0 =C2=A0 bDescriptorType =C2=A0 =C2=A0 =C2=A0 =C2=A0 4
=C2=A0 =C2=A0 =C2=A0 bInterfaceNumber =C2=A0 =C2=A0 =C2=A0 =C2=A02
=C2=A0 =C2=A0 =C2=A0 bAlternateSetting =C2=A0 =C2=A0 =C2=A0 0
=C2=A0 =C2=A0 =C2=A0 bNumEndpoints =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0
=C2=A0 =C2=A0 =C2=A0 bInterfaceClass =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 Audio
=C2=A0 =C2=A0 =C2=A0 bInterfaceSubClass =C2=A0 =C2=A0 =C2=A02 Streaming
=C2=A0 =C2=A0 =C2=A0 bInterfaceProtocol =C2=A0 =C2=A0 =C2=A00
=C2=A0 =C2=A0 =C2=A0 iInterface =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00
=C2=A0 =C2=A0 Interface Descriptor:
=C2=A0 =C2=A0 =C2=A0 bLength =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 9
=C2=A0 =C2=A0 =C2=A0 bDescriptorType =C2=A0 =C2=A0 =C2=A0 =C2=A0 4
=C2=A0 =C2=A0 =C2=A0 bInterfaceNumber =C2=A0 =C2=A0 =C2=A0 =C2=A02
=C2=A0 =C2=A0 =C2=A0 bAlternateSetting =C2=A0 =C2=A0 =C2=A0 1
=C2=A0 =C2=A0 =C2=A0 bNumEndpoints =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1
=C2=A0 =C2=A0 =C2=A0 bInterfaceClass =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 Audio
=C2=A0 =C2=A0 =C2=A0 bInterfaceSubClass =C2=A0 =C2=A0 =C2=A02 Streaming
=C2=A0 =C2=A0 =C2=A0 bInterfaceProtocol =C2=A0 =C2=A0 =C2=A00
=C2=A0 =C2=A0 =C2=A0 iInterface =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00
=C2=A0 =C2=A0 =C2=A0 AudioStreaming Interface Descriptor:
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bLength =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 7
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorType =C2=A0 =C2=A0 =C2=A0 =C2=A036
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorSubtype =C2=A0 =C2=A0 =C2=A01 (AS_G=
ENERAL)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bTerminalLink =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 4
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bDelay =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A01 frames
=C2=A0 =C2=A0 =C2=A0 =C2=A0 wFormatTag =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0001 =
PCM
=C2=A0 =C2=A0 =C2=A0 AudioStreaming Interface Descriptor:
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bLength =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A011
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorType =C2=A0 =C2=A0 =C2=A0 =C2=A036
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorSubtype =C2=A0 =C2=A0 =C2=A02 (FORM=
AT_TYPE)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bFormatType =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 1 (FORMAT_TYPE_I)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bNrChannels =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 2
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bSubframeSize =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 3
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bBitResolution =C2=A0 =C2=A0 =C2=A0 =C2=A0 24
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bSamFreqType =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A01 Discrete
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tSamFreq[ 0] =C2=A0 =C2=A0 =C2=A0 =C2=A048000
=C2=A0 =C2=A0 =C2=A0 Endpoint Descriptor:
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bLength =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 9
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorType =C2=A0 =C2=A0 =C2=A0 =C2=A0 5
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bEndpointAddress =C2=A0 =C2=A0 0x81 =C2=A0EP 1=
 IN
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bmAttributes =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A05
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Transfer Type =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Isochronous
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Synch Type =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 Asynchronous
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Usage Type =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 Data
=C2=A0 =C2=A0 =C2=A0 =C2=A0 wMaxPacketSize =C2=A0 =C2=A0 0x0126 =C2=A01x 2=
94 bytes
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bInterval =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 4
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bRefresh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A00
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bSynchAddress =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 AudioStreaming Endpoint Descriptor:
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bLength =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 7
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorType =C2=A0 =C2=A0 =C2=A0 =
=C2=A037
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorSubtype =C2=A0 =C2=A0 =C2=A0=
1 (EP_GENERAL)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bmAttributes =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x01
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Sampling Frequency
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bLockDelayUnits =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 2 Decoded PCM samples
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wLockDelay =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
0x0000
=C2=A0 =C2=A0 Interface Descriptor:
=C2=A0 =C2=A0 =C2=A0 bLength =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 9
=C2=A0 =C2=A0 =C2=A0 bDescriptorType =C2=A0 =C2=A0 =C2=A0 =C2=A0 4
=C2=A0 =C2=A0 =C2=A0 bInterfaceNumber =C2=A0 =C2=A0 =C2=A0 =C2=A02
=C2=A0 =C2=A0 =C2=A0 bAlternateSetting =C2=A0 =C2=A0 =C2=A0 2
=C2=A0 =C2=A0 =C2=A0 bNumEndpoints =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1
=C2=A0 =C2=A0 =C2=A0 bInterfaceClass =C2=A0 =C2=A0 =C2=A0 255 Vendor Speci=
fic Class
=C2=A0 =C2=A0 =C2=A0 bInterfaceSubClass =C2=A0 =C2=A0 =C2=A00
=C2=A0 =C2=A0 =C2=A0 bInterfaceProtocol =C2=A0 =C2=A0 =C2=A00
=C2=A0 =C2=A0 =C2=A0 iInterface =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00
=C2=A0 =C2=A0 =C2=A0 Endpoint Descriptor:
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bLength =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 9
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorType =C2=A0 =C2=A0 =C2=A0 =C2=A0 5
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bEndpointAddress =C2=A0 =C2=A0 0x81 =C2=A0EP 1=
 IN
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bmAttributes =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A05
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Transfer Type =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Isochronous
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Synch Type =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 Asynchronous
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Usage Type =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 Data
=C2=A0 =C2=A0 =C2=A0 =C2=A0 wMaxPacketSize =C2=A0 =C2=A0 0x0200 =C2=A01x 5=
12 bytes
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bInterval =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 1
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bRefresh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A00
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bSynchAddress =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0
=C2=A0 =C2=A0 Interface Descriptor:
=C2=A0 =C2=A0 =C2=A0 bLength =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 9
=C2=A0 =C2=A0 =C2=A0 bDescriptorType =C2=A0 =C2=A0 =C2=A0 =C2=A0 4
=C2=A0 =C2=A0 =C2=A0 bInterfaceNumber =C2=A0 =C2=A0 =C2=A0 =C2=A03
=C2=A0 =C2=A0 =C2=A0 bAlternateSetting =C2=A0 =C2=A0 =C2=A0 0
=C2=A0 =C2=A0 =C2=A0 bNumEndpoints =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2
=C2=A0 =C2=A0 =C2=A0 bInterfaceClass =C2=A0 =C2=A0 =C2=A0 =C2=A0 1 Audio
=C2=A0 =C2=A0 =C2=A0 bInterfaceSubClass =C2=A0 =C2=A0 =C2=A03 MIDI Streami=
ng
=C2=A0 =C2=A0 =C2=A0 bInterfaceProtocol =C2=A0 =C2=A0 =C2=A00
=C2=A0 =C2=A0 =C2=A0 iInterface =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00
=C2=A0 =C2=A0 =C2=A0 MIDIStreaming Interface Descriptor:
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bLength =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 7
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorType =C2=A0 =C2=A0 =C2=A0 =C2=A036
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorSubtype =C2=A0 =C2=A0 =C2=A01 (HEAD=
ER)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bcdADC =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 1=2E00
=C2=A0 =C2=A0 =C2=A0 =C2=A0 wTotalLength =C2=A0 =C2=A0 =C2=A0 0x0041
=C2=A0 =C2=A0 =C2=A0 MIDIStreaming Interface Descriptor:
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bLength =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 6
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorType =C2=A0 =C2=A0 =C2=A0 =C2=A036
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorSubtype =C2=A0 =C2=A0 =C2=A02 (MIDI=
_IN_JACK)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bJackType =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 1 Embedded
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bJackID =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 1
=C2=A0 =C2=A0 =C2=A0 =C2=A0 iJack =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0
=C2=A0 =C2=A0 =C2=A0 MIDIStreaming Interface Descriptor:
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bLength =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 6
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorType =C2=A0 =C2=A0 =C2=A0 =C2=A036
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorSubtype =C2=A0 =C2=A0 =C2=A02 (MIDI=
_IN_JACK)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bJackType =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 2 External
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bJackID =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 2
=C2=A0 =C2=A0 =C2=A0 =C2=A0 iJack =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0
=C2=A0 =C2=A0 =C2=A0 MIDIStreaming Interface Descriptor:
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bLength =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 9
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorType =C2=A0 =C2=A0 =C2=A0 =C2=A036
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorSubtype =C2=A0 =C2=A0 =C2=A03 (MIDI=
_OUT_JACK)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bJackType =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 1 Embedded
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bJackID =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 3
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bNrInputPins =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A01
=C2=A0 =C2=A0 =C2=A0 =C2=A0 baSourceID( 0) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A02
=C2=A0 =C2=A0 =C2=A0 =C2=A0 BaSourcePin( 0) =C2=A0 =C2=A0 =C2=A0 =C2=A0 1
=C2=A0 =C2=A0 =C2=A0 =C2=A0 iJack =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0
=C2=A0 =C2=A0 =C2=A0 MIDIStreaming Interface Descriptor:
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bLength =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 9
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorType =C2=A0 =C2=A0 =C2=A0 =C2=A036
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorSubtype =C2=A0 =C2=A0 =C2=A03 (MIDI=
_OUT_JACK)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bJackType =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 2 External
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bJackID =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 4
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bNrInputPins =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A01
=C2=A0 =C2=A0 =C2=A0 =C2=A0 baSourceID( 0) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A01
=C2=A0 =C2=A0 =C2=A0 =C2=A0 BaSourcePin( 0) =C2=A0 =C2=A0 =C2=A0 =C2=A0 1
=C2=A0 =C2=A0 =C2=A0 =C2=A0 iJack =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0
=C2=A0 =C2=A0 =C2=A0 Endpoint Descriptor:
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bLength =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 9
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorType =C2=A0 =C2=A0 =C2=A0 =C2=A0 5
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bEndpointAddress =C2=A0 =C2=A0 0x83 =C2=A0EP 3=
 IN
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bmAttributes =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A02
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Transfer Type =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Bulk
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Synch Type =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 None
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Usage Type =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 Data
=C2=A0 =C2=A0 =C2=A0 =C2=A0 wMaxPacketSize =C2=A0 =C2=A0 0x0200 =C2=A01x 5=
12 bytes
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bInterval =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 1
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bRefresh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A00
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bSynchAddress =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIDIStreaming Endpoint Descriptor:
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bLength =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 5
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorType =C2=A0 =C2=A0 =C2=A0 =
=C2=A037
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorSubtype =C2=A0 =C2=A0 =C2=A0=
1 (GENERAL)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bNumEmbMIDIJack =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 1
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 baAssocJackID( 0) =C2=A0 =C2=A0 =C2=A0 =
3
=C2=A0 =C2=A0 =C2=A0 Endpoint Descriptor:
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bLength =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 9
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorType =C2=A0 =C2=A0 =C2=A0 =C2=A0 5
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bEndpointAddress =C2=A0 =C2=A0 0x04 =C2=A0EP 4=
 OUT
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bmAttributes =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A03
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Transfer Type =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Interrupt
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Synch Type =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 None
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Usage Type =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 Data
=C2=A0 =C2=A0 =C2=A0 =C2=A0 wMaxPacketSize =C2=A0 =C2=A0 0x0010 =C2=A01x 1=
6 bytes
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bInterval =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 4
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bRefresh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A00
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bSynchAddress =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0
=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIDIStreaming Endpoint Descriptor:
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bLength =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 5
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorType =C2=A0 =C2=A0 =C2=A0 =
=C2=A037
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bDescriptorSubtype =C2=A0 =C2=A0 =C2=A0=
1 (GENERAL)
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bNumEmbMIDIJack =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 1
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 baAssocJackID( 0) =C2=A0 =C2=A0 =C2=A0 =
1
Device Qualifier (for other device speed):
=C2=A0 bLength =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A010
=C2=A0 bDescriptorType =C2=A0 =C2=A0 =C2=A0 =C2=A0 6
=C2=A0 bcdUSB =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2=2E00
=C2=A0 bDeviceClass =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00
=C2=A0 bDeviceSubClass =C2=A0 =C2=A0 =C2=A0 =C2=A0 0
=C2=A0 bDeviceProtocol =C2=A0 =C2=A0 =C2=A0 =C2=A0 0
=C2=A0 bMaxPacketSize0 =C2=A0 =C2=A0 =C2=A0 =C2=A064
=C2=A0 bNumConfigurations =C2=A0 =C2=A0 =C2=A01
Device Status: =C2=A0 =C2=A0 0x0001
=C2=A0 Self Powered
=C2=A0
---
Best wishes,
Roman
