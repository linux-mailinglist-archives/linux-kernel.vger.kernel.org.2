Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0383936FB7E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 15:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbhD3Nbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 09:31:43 -0400
Received: from mout.gmx.net ([212.227.17.22]:35337 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230047AbhD3Nbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 09:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619789440;
        bh=wBWV1n40caDOgrQ2BfyJAqo0nMeqSBjp9jDoQLpvWHM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ghF7UPIJNA0JfQgR6cQD+g/WrjD2mNmkMTWtc+i1ysnKCw8mz6o4SSLkuYFhMNExU
         eg4ptKk1bntw/zkqWBxYBg8Rz4ZBRg6Zr1MrdthtGkSntIi8L8r2JLzQNUmi4jpXpJ
         PZMS9LJ5bOGfVE2SKETtMy5mQV2cZlOrfuaADgS0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [157.180.225.50] ([157.180.225.50]) by web-mail.gmx.net
 (3c-app-gmx-bap03.server.lan [172.19.172.73]) (via HTTP); Fri, 30 Apr 2021
 15:30:39 +0200
MIME-Version: 1.0
Message-ID: <trinity-5166e76d-779d-4b05-870b-59971bd1571c-1619789439850@3c-app-gmx-bap03>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org, Bin Liu <b-liu@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        David Miller <davem@davemloft.net>,
        DENG Qingfang <dqfext@gmail.com>
Subject: Aw: Re: [PATCH] musb: mediatek: rename driver
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 30 Apr 2021 15:30:39 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <YIv969BCnPgXzrcg@kroah.com>
References: <20210430124317.97376-1-linux@fw-web.de>
 <YIv969BCnPgXzrcg@kroah.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:O2hp7OW+fifRI8eAdwQTGlSRc7RQGQRHjGKV7R+/sfpy5gS5/3HrXkKQT+/QdPXYlj0cx
 jb1M3oKXGQUTU6Jw656MGBfepLAMqcqq3H/TAoCwGASuAN6sV2EzXgCYYhcYzH15I/64jtnHj8tp
 dI+bLsar/LUg245vGdek/qNb+QPSe0pwYfb76G80fw3HerDmyOwwVf608ElQMODVxOkERnY/yLRa
 SyFJLYNe32O3839JWez1ljV1ebiTkSFQmrg8nxZNg6y0ihsEko3lkM3aVlRd4lxCTBVXooLBFVe9
 5I=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vG56YfbUZuM=:bj8W/P3We5md9A0oKJW09R
 jTPqjDabgXGHdAlPgSsnVXy4PgxdlAVJmG/ZP3016sB6XZjDdCszTimYBl5YqkhAWXNRcTDpd
 lA8hcOam3O0Ih9dWXnyDKaIINl7ods7yasDBBb4JFZrNOCaaVqzZEGfZinUCf+o584pIT+XgC
 fD/DFXYJMGupqzDIVd8CI+V8NIzCLiTRIU3TpeW3w2YmqaUvcIPQ5iBE+VD6I0ps7WW1Moq4r
 PI16/CwJyV+76npULFPkjfEQcn+8hxxCGckkurfm9iXjG5d/+8TMVEdhW2WbTz9hKcuAGSl6P
 PtJwD0WXW3mV1bRMtUmf5EQ90gFy0+nl4Ow+lAzs3k1hz1vlnFxEy4nfY+tegaGFrvAZjBS2Q
 rxopa7/pgK3RQHYUPdyCgXbhvPgJO8bINPi3JvG32DdXODm7RfoZ7ypHFtDaKo6jIXAInrmPd
 lAXDMvpLRGlpypXA2NJTMR0VF7o9xiPnX4vqqjYZz3XJdqfTQTKhDUgQmkjfWt6woLAPBvr5i
 RSjaID0mxKsLeazhcfh+TM1TPzAHrofkFxIncbUf4J9w3Z/TP9Qjv492ReDX98xjUIEeAnkTA
 QxM02RAedKz17tt8OS7073efxerGtN4xBjbzLZcE0eqSp3vUsYHrGjmLeZV6ZK9SklHRwd7LX
 Zix4uciA5OomNivSTdfgjM4Ays7cPLfRzTrXmA0fKnk/EwXvHB4h9Pmu0RU3a0/R/l4q6dhOT
 cLbNLIz7hEAqWI5FiTsk33pvRJdRYta1b5NtTEadRFLiWer1lHCLCE7FbmtfhGTZAJsO0Srmf
 3nPBUa0bjGSWU4ErKJulBjud6FxLiG3O6wkdidAOWcux6Rf4UfBzn3yBv0ijXQvo3Cq2w0qWt
 e1TyprCbQnXyLYuBBJpds88WLa/VGIYrw8WukP4pBPQmQlbQJEmwzlXKbh02Xf3Bm2SqhNS8/
 UadVRkQ2Izg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Grek

the problem is that the name mediatek.ko does not point to musb-subsystem.=
 I had discussed with Min Gao (author of this driver) some time ago about =
this as the name may conflict with other modules (don't remember which was=
 that).
We have searched issue using the driver on my board (not yet resolved).

if the module is loaded it shows (based on name) only "mediatek" and user =
does not know that is the mediatek musb driver, not very good in my eyes a=
s mediatek is a vendor designing many different hardware and so drivers. I=
mho the module-name should at least give a clue to the subsystem to avoid =
confusion/conflicts

Now the discussion comes up again here for a new driver:
https://patchwork.kernel.org/project/linux-mediatek/cover/20210429062130.2=
9403-1-dqfext@gmail.com/#24148777

so i decided to rebase and post my patch created in past to clean this up.

and yes this can result in user-space issues depending on the name...becau=
se of this i have not added stable-tag ;)

regards Frank


> Gesendet: Freitag, 30. April 2021 um 14:54 Uhr
> Von: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>

> On Fri, Apr 30, 2021 at 02:43:17PM +0200, Frank Wunderlich wrote:
> > From: Frank Wunderlich <frank-w@public-files.de>
> >
> > currently unspecific mediatek.ko is built,
> > change this by adding subsystem
>
> I am sorry, I do not understand this changelog text.  What are you doing
> here and why?
>
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > ---
> >  drivers/usb/musb/Makefile                   | 2 +-
> >  drivers/usb/musb/{mediatek.c =3D> musb_mtk.c} | 0
>
> Why rename this file, will that not break existing setups that expect
> the module to be named this?
>
> thanks,
>
> greg k-h

