Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274FE42789F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 11:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbhJIJ6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 05:58:44 -0400
Received: from mout.web.de ([212.227.17.12]:52681 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231853AbhJIJ6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 05:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1633773405;
        bh=Zo5JvUyWLGeW3CGXIvjBIxjiMTVXy0P1pfwH3RQzSSM=;
        h=X-UI-Sender-Class:To:Subject:From:Date;
        b=U9ITZcm0iwdMz0vWZCM4alYdY2gFjjMcwhuR88J8DpSDRbTLqjdtY+0MKwFU2wJlk
         9lGSm9WyOO+X5l0cKfDP+gdCxTrRd7pbpPqvaJwLm/KVXEnt8SwBtGk3oSPelpASqQ
         MnNQIJihuXQ5obRmSr9OOumgKQ6sXmRp9UUI+Ozo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([178.9.154.36]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MC1nQ-1mQJPI43kG-008rIV for
 <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 11:56:45 +0200
To:     linux-kernel@vger.kernel.org
Subject: Unwanted activation of root-processes getting highly activated
From:   secret <andreas-stoewing@web.de>
Date:   Sat, 9 Oct 2021 11:58:22 +0000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <202110091158.27436.andreas-stoewing@web.de>
X-Provags-ID: V03:K1:AO52xnoRFL8crzi+QaHqNDsi6TkpBf5M+8hD68d8zkhu3g/dBQQ
 fNUq/cbVZOFZWRCJIfDDmxS/3H8fkdhQabS7NYpHlsM8AGWPnuINbUYTfEKL20NaHtng2Ld
 2dR/ClP4ncCJBRZm1VjFoSbQF6f9dT8ibWwb51MfWnUPDM76MS7h6MJpvXCKTRcyaO4z3s1
 kgW4jZXQ4pXXEMalhWI8A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tRtgcfH+MqQ=:Jun+2OtRHpexyXKFdnUTsq
 mQPdvaB0U0UMgQ0gY+S6vByjamU8HYjBcwe8FMwwlq39iKemJiXMJzYfmlxyNF+3QPOUKd9S9
 d6ij9UcyH3auMBvPweZXTzj33n+aIZ6ZN2x6Mp7ikaFseuQWIyol/Y3C1M9J3mPPFv0Rlct9N
 mgS4BViomBfvc2Q+sGhAIP3c8HVw8a/7zccdhTOQwJGAyqXTaXNuJihsQa0x/5AJUzcPMOR/n
 cG9vbLMSZFe+TuEWqjkWxplgKYmd5u68aN80thyQ6/tNc9X4Gg/PGtcoV74qkeFnFLRgSBsiZ
 1uZkLcB+8QMc3JsnuEyY6MI5cHlxPeYloS4khvh2HVTrimnDsyXCSDIepghGzc7U8TsKrD8sM
 YYVZgY5JYu/PXiPit7sv2P0BtMso4AsSV3dIXVG9NTh8CYRd/iMcVqYgeNA+es0O6jM8N8WwP
 dzw3sJ+/TpBj9WZArDY3DFQVo2ZhIeK6Xjm+YBSPCiVfrBGSf1SeB+TwpH5ShP/jMeCEOIZR0
 dvQg9Su1BBreN+vjt2wiI99HseIU0pJeVNSeKc1LHAQvrlb/iEl4B5GM9bBRvaR+b3tWYuT/k
 LOuPuEvMJmXCs3E0DWf5CGDYNVqaDN/t1lAm3rPhERZuVD9QnUrfnq6zDv1Wk6unwiQAfKnMu
 a8BIUeAqsTHWWRSWPR53iM79vT5KlogZ0ItPuFuQTwfQX3FmvIzRxjG10MqcR2ARQal5i/ypS
 R9M508f7siRFvyHmJjg77AxRUdCZspjyvU5Ma+nDmEJdlacBMSXAU1e+kiye6U5wLcZgdcs7T
 WahIt3tizcOQC01/EoDrve28FIQgeNsHv6UVFmUKhbV/91theSQfK/B4tMdygMu4dcNCAAB/X
 VkCyVWkPl+avRG47+9Ph8NT5saOAhaD9+p0e7fUyVUtZTDPAbhOAuicU8Y845OOB2vb7e2DPS
 dc4Ocn14yZP0e6/qL6UFCBACx4ah5uvjCOB3QO0empErqfiiMHm9yUj0LL3EtstH5x8yGXLEa
 d4qsKoe8bBRRcg/+97DC8nKt6ITyPc/RX3kmzBYL3mi8aqzU0YPLp6vjRveEsL2n7XbASLzpp
 Vd2RVm5VuSOf7E=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Such processes get always activated. But I have never seen them in such
dangerous high activity as described below!

Regards,
Andreas (Gooken)

Date: 08.10.2021

Subject/Betreff: Unwanted activation of root-processes reading and writing=
 out
the whole SSD/harddrive ! / Kernel-5.4.134 (pclos, AppArmor / Tor (OpenSuS=
E)
usw. etc.: Freigabe von Informationen, Ausf=FChren von Code mit h=F6heren
Privilegien und beliebiger Kommandos in Linux, Erzeugung, Lesen und
=DCberschreiben beliebiger Dateien

Hi, Greg, dear Linux experts and friends,

this is one of the most dangerous and worst things, Linux can happen!
Refering to the actual kernel 5.4.134 ( now up to the actual version 5.4.1=
51
and higher, additional remark from 10.08.2021), there still is a problem w=
ith
unexpectedly activated, highly active root-processes (making the tower-LED
causing readwrites onto harddiscs and making the SSD/harddrive blink serio=
us-
madly hard for about up to 20 minutes). The whole SSD/harddrive seems to g=
et
read out and overwritten!

The unwanted, highly by tor (pclos, mga7) resp. firejail activated kernel-
root-processes are named

kworker/u2:1-kcryptd/253:2 (escpecially this one, CPU: gt; 10%)
kworker/0:1H-kblockd
dmcrypt_write/2 and
jbd2/dm2--8

This occurs since kernel around 5.4.13, whenever I start browsing (with Pa=
le
Moon), activating firejail and tor.

Please patch the kernel-5.4 to prevent it in future!
Regards
Andreas St=F6wing (Gooken-producer, Gooken: https://gooken.safe-ws.de/gook=
en)

Appendix
libapparmor.so.required by firejail (OpenSuSE 15.X) needed by tor (rosa201=
6.1,
mga7) must be the cause for the activation as much as high activity of som=
e
root-processes!
I have got no other explanation.
Kernel security module apparmor itself got deactivated within the kernel b=
y my
boot-parameters "security=3Dnone" and "apparmor=3Dnone".

After tor and firejail version got changed from OpenSuSE 15.X to mga7
(firejail) resp. to CentOS el7 (Tor), so that libapparmor.so.1  is not
required anymore, such root-processes did not get activated resp. active t=
oo
much!<BR>
But they did appear unexpectedly again in kernel-5.4.151 !
<BR><BR>
So I still await your patches for kernel-5.4.
In my opinion, Linux is killing spy-software and rubbish, if you won&#180;=
t
patch it !

Regards
Gooken
