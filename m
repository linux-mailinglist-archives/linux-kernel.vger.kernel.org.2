Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEF43BA13F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 15:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbhGBNc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 09:32:27 -0400
Received: from mout.gmx.net ([212.227.17.21]:54057 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230509AbhGBNc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 09:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625232593;
        bh=0pPKDkUz1pPYTbB6hfJBMjr/11P2VHRbeLmqegK3/zY=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=SrET+NU6ZEKMOPDSL8b8swtsX0gRlQ/sh7aWRSATa72XC9pyxymAYz1ssd+eW+QmY
         5LcCalVOoJBwTwOHmloiXe46pUh03sfSKOal+bTkEsMY6WpOPUvuqAQAK5AJOqE3HP
         TrGopGUmXW/WoXOwHzEfXsOGcA/AJusn7Enc3E2c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.252] ([5.166.175.171]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MPXhK-1lcoXT1q2E-00McmL; Fri, 02
 Jul 2021 15:29:53 +0200
To:     linux-kernel@vger.kernel.org
Cc:     leah.rumancik@gmail.com
From:   "Artem S. Tashkinov" <aros@gmx.com>
Subject: Re: [PATCH v4] ext4: wipe ext4_dir_entry2 upon file deletion
Message-ID: <b99d8632-6e3d-b557-0ca4-7416a9d818d5@gmx.com>
Date:   Fri, 2 Jul 2021 13:29:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q/axTz+LtqflhB2k9qjeeIKnYaHhNyy6itvePialiEp4WZ8/Joe
 plzqCxqQYRmMBfKfRc8ukGehOCH3mQ1ugLm/2pr0VS0uNn0uVWGlb5VRbDVJofi0fnRNEJ5
 xlRD7V9QqL3GWvoYXBIt5u9BC6RIFV2XFuLVFBdBXZHYZk59u+YneyZRTmiXX5pgbnnP0k0
 7V0mDa64s7e28Bw11SKFw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tU17AUReTxE=:Gk/MaCzY8Py6el0yGNhUiR
 7aOTY71eUXIdnkC+pzoKfl51Ms7GdOPtfczgGzbSQ6O2tuQBFGKdAbjOBHHbsGwERWcsNNqVm
 OyL2pMaZPi61ko4FjyrtrD2KvnbXjdu97n+jcg5khnr/5/OAu1TMPuEKCDgmm9okBNrRph0zR
 tt+rSSSoVGbBb/Q8cT+eR5/ReOZYVU36NjXWvaRnUHIHUI5yrSgUyMPQHRCMc5LTiz9xhuJLj
 ibzPIuY08IrM1pANjgLZ90Sm7LXrelJK4OmljWmTJT/ByB0yHwB89Edh5yaueTmPtK6s1IHn/
 W2Bp3q0aJ7E5aX3TQnWNEmL3MIbqU8M0GTkR3SpsG7pjF+vBi8g/qzpAUNRzqyCsIe/PRiQfe
 uM0WCEttjE9s/W/GFZwXQBXyIVkeHFsF570Shyit5eqqWsTBmYcOJuXj3B3WJgyQsBla4k3ps
 OGO41XXG2BMODPuj1j5UWmkRmekRXXPZ3em8SvDuX7E7w7+DiiBbMUuWH/kX2c9klZS199+4F
 DuvgphWGQf51UgI/JB1BFNQbrcV8x3ZrxFExZvIU2dxf3fvBpBnUEFMRHwFO1XM1Piu+o9phw
 TwRJJM+5GMHZ7MXzTYLpTQSu7UwQ6yyWZhOPM/ABoJ9YrPyLkhRTiFrxTIgfhsEJ/LUB34+4X
 lf6o8pNfkq8hv8flsumA3DJ1Weioko/OwWNRO6gXm95yN3DwatGgG434WKiu6aeZALXG344aZ
 2NE9pa3DJuXKi6VaV53em18AfsJimDgNAC1Qbd/V6tpSiLR7hhu9in1252UuKHpRfpiDiGz5O
 3xOu5QaJcRXzTjZPufqgDnk94exj1fLxDT/YJgZxs4JtYoS5ZAd4X45Z/7wi3hlZ/UOED1jmi
 WWtjk7dcJDKHxIiwrtBkRvsLanPeMPADtxjJ8ppPcL0fEplBsEvJTz7OU/GxUIra3HuMm3SEz
 m0uTgQZdDmDeD6ozpo31tqCdGuilPGElgoCANngj1DEVwFcXhKJI6WTYDgAbaoFlqDf4jW2xf
 w7ZdlOf4yIDv8lITxOU4vXB12ZNA02CuBJXd274Kzp5E5fxAYSaIN0y1/gDvLaKokaphYah8U
 4TgEYWxtaihkYfOhkXemKxVWyUJVmkoixwU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm curious about the nature of this feature. Does it make restoring
accidentally deleted files more difficult or even impossible? OK, data
remains but the patch description makes it sound like all the metadata
is being wiped completely.

 > Upon file deletion, zero out all fields in ext4_dir_entry2
 > besides rec_len. In case sensitive data is stored in filenames,
 > this ensures no potentially sensitive data is left in the directory
 > entry upon deletion. Also, wipe these fields upon moving a directory
 > entry during the conversion to an htree and when splitting htree
 > nodes.

If it's the case, is it possible to make this new security feature user
configurable? I'm OK with it being on by default but I'd be glad if
there were a mount option to disable it.

Best regards,
Artem
