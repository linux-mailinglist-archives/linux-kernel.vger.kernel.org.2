Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811323FC665
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 13:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241400AbhHaLJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 07:09:33 -0400
Received: from mout.gmx.net ([212.227.17.20]:56247 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241366AbhHaLJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 07:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630408097;
        bh=Q3naRGFUOjCanc3SPmyynPd1C68uqCO9v6By/oLNW38=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=kVsBeUZNmAPdaHNjse2sCbByppVde/dWY7PXtV4t/LrCMMOvP60GIoJRGoRa22QZJ
         cZOB2XUkIXPJbyu28As0fL7Qw9I/tIAgZHxCnZt4KZoRoHTe51QJWjcr1gWgeJINVO
         Vhisjj03G5J+Q0gprH68HeJVL8hKojfMWengWYZg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [80.245.77.109] ([80.245.77.109]) by web-mail.gmx.net
 (3c-app-gmx-bap45.server.lan [172.19.172.115]) (via HTTP); Tue, 31 Aug 2021
 13:08:17 +0200
MIME-Version: 1.0
Message-ID: <trinity-2f57e648-cb42-4116-b3d0-6fcdbaae81b6-1630408097512@3c-app-gmx-bap45>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Sungbo Eo <mans0n@gorani.run>
Cc:     linux-mediatek@lists.infradead.org,
        =?UTF-8?Q?Chunfeng_Yun_=28=E4=BA=91=E6=98=A5=E5=B3=B0=29?= 
        <Chunfeng.Yun@mediatek.com>, "b-liu@ti.com" <b-liu@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Aw: Re: [PATCH v4 1/2] arm: dts: mt7623: add musb device nodes
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 31 Aug 2021 13:08:17 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <3d57ae38-9d8f-05e3-c5b3-58db73879f16@gorani.run>
References: <20210822041333.5264-1-mans0n@gorani.run>
 <20210830155903.13907-1-mans0n@gorani.run>
 <20210830155903.13907-2-mans0n@gorani.run>
 <16f980b95e1f32bb8eb32448f1615bafdc51b792.camel@mediatek.com>
 <14C40B35-3607-49C6-970B-441F9093125A@public-files.de>
 <3d57ae38-9d8f-05e3-c5b3-58db73879f16@gorani.run>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:HA2wZfkN2riithVmFwnSZ1/BfJwDAEJS8KaCZjTcOXMuMyr9Gv/w9eOyIEvnZbjTlkOb2
 vumjUULx8/phJD0+woWFe1xD7+8R+XLKYMF83XtNeqqBI813PI4r6hvfNVW1TDkbUFa2EwbPE9ip
 GBNsRWIGFnfeTEA8x4VRpZr2BGweCPlo5xVDymNE2/CZmJLnpmZlDJhUhDwC4mo/7h3xHu01P4t1
 IiBGIlVGyTabd4CwcHfa4FMKX8x/D6esWx4SFYd3NRNG50QU15EEvPhzJ8iHC8hjkhT1O5NgECJC
 C8=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Poez8dKN2Fw=:TmHdTsCV04OMxVmZdrDObR
 ljsE7K/UT/WJY4VBRUIYbDjME8YThAhmAavEdnbOV+S2kHr7jpKWPFZ4zVwabv8CsGfJ8Zm6R
 QR0FgcQVrUocmDWdT9Sbp3AReNMesw0s0uhWfm4R+u8N+R5vYkkk70SSqiSQGo4a6pDvywMTB
 WPBhhOa9PcUaM2W0iUXviEg+0OyW63WpxeBtYOiMjrHeOEQG46i+lDNZ0W8kGNPZwEUy0Dr7h
 eky56x0gJxbdswAHByKqPrGKAkmdsAH8F9HIou6Jh9YdiUbLVKhOV7uJ45+nJxuU/vUchmK5j
 mg11k/W2Y0Jcagxf45gjj6WWMk8tiDWpWrPw9ISn2s51nzRjGt+WmbdH5N+xYWbsZE4Rjbqyw
 y2OyV3jV8zzM8rq5KyA5XrqeAEcG8MXv/zuXGOq/bnL1rAalmuLEPxC3x+Hu84lY9UwqyHo5t
 fgyqh20CQG53CgF/BJIVzMi5gJlvnuzv/U3Nc1/Rh084XWC+9q7Mi0aK0/h/f13Zyoll5xc24
 yZo7oDieGt2NlZ8GnXIUpes/4MnmmxHppiW1Y/+vbK4gZCobuNaKEwYOj1kQ60me4s/xu/2uE
 /2xHc1sPDZnPIQbbz68YA7Z0TIoQvHrtiF2HW2+IOq/GTwktdExMkOZo/g+aMjeQefH5mWQvm
 GnqvhV6uVq0stZ+qkP1GuSTtT13FSvwrLIO6S1MZMPyaCngvF8y2TDdAUujtp1L/u7/mGwQTf
 /dsSYvFhX64gNL6ZL2sTN+BmCMuITrto0dmmPXMr2AapkINAm16IDK+zDByXfjcGnr7jf2FYA
 Hz+fGpon/jpPamoPSf98b8PABwQzfJyjzLuKO24ZfK3lI3pyzc=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Gesendet: Dienstag, 31=2E August 2021 um 13:02 Uhr
> Von: "Sungbo Eo" <mans0n@gorani=2Erun>
> On 2021-08-31 17:59, Frank Wunderlich wrote:
> > Am 31=2E August 2021 08:27:18 MESZ schrieb "Chunfeng Yun (=E4=BA=91=E6=
=98=A5=E5=B3=B0)" <Chunfeng=2EYun@mediatek=2Ecom>:

> > I don't see [1] (ack from rob) in [2]/[3]
>=20
> You can find it here=2E
> https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/gregkh/usb=2Egit/log=
/?h=3Dusb-next
>=20
> >=20
> > @sungbo: please leave dt-bindings patch in series=2E
>=20
> I'll keep it for a while, then=2E

ok, then it is not needed again=2E=2E=2Ehave not searched in usb-tree=2E

> > You need no new version only for adding tags (acked,tested or reviewed=
)=2E
> > Only for code-changes,but then add tags from previous versions=2E
>=20
> Got it=2E Thanks for the tip=2E :)
>=20
> > Imho it is better to take my musb patch [4]
> > into the series as well to make depency cleaner
>=20
> Okay, I'll take it in the next version=2E

okay, if dt-bindings is already in usb-tree wait what maintainers (matthia=
s/rob) says about adding my patch to a new version of your series or if thi=
s is clear now :)

> > [1] https://patchwork=2Ekernel=2Eorg/project/linux-mediatek/patch/2021=
0808123840=2E176738-2-mans0n@gorani=2Erun/
> > [2] https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/robh/linux=2Eg=
it/log/?h=3Dfor-next
> > [3] https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/matthias=2Ebgg=
/linux=2Egit/log/?h=3Dfor-next
> > [4] https://patchwork=2Ekernel=2Eorg/project/linux-mediatek/patch/2021=
0830145958=2E108605-1-linux@fw-web=2Ede/
> > regards Frank
> >=20
>
