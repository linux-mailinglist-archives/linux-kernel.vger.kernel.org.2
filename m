Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E841A428278
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 18:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhJJQSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 12:18:11 -0400
Received: from mout.web.de ([217.72.192.78]:47177 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230267AbhJJQSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 12:18:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1633882570;
        bh=0opQ9AY/9U6mool7ArIdhZrHt0L+YlvRWRHnB/gewZw=;
        h=X-UI-Sender-Class:To:Subject:From:Date;
        b=VAtFqngFKFbPJpgWrG5uH50QX82JU1625zD+WB3DrijnUg/vquShSYUDHKY9p3pqA
         a/U9gaH9zNaPMTT6FQJ0Q92yBfuSHlih5G/JCCRyoErC2viko9X8NZVEq/5P/pNVNF
         ROHUx9MaYYzSeHSXTCOdbujEduQoJ9JmK533InqY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([146.60.78.212]) by smtp.web.de
 (mrweb103 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MbyMU-1mId6l34Lu-00JKva for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021
 18:16:09 +0200
To:     linux-kernel@vger.kernel.org
Subject: Unwanted activation of root-processes getting highly activated
From:   secret <andreas-stoewing@web.de>
Date:   Sun, 10 Oct 2021 18:17:24 +0000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <202110101817.28015.andreas-stoewing@web.de>
X-Provags-ID: V03:K1:tDfHvd9RWtecD0Q/gXTplBdP5YSuWrXlHPX3hutaDIDvYs61Irt
 Mq1gX847VgWPXSXrOQRWmrzuPLlRtBZWBTti86D9zIpsl2ms3m+b/CZeglVn3TXK/Qh7MdO
 jctE4lWUjN3PxjvXmtcpLlsV9Z/1yNBIgJiOupL/BAz7cECGKRwUON98bJHiaGMIbr3GCnv
 JW7tL/QSDY3Rn74OKu0/Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:R3V37JKZy0M=:xV3kUVLl9I+wb4qulOOLHQ
 RN8G97On7HFhb6ar+HLxCdsmJNFw8kplvjfvT4/ZIP2PpLVARMS3gQIihg6uGj+dohknj7shE
 prWxV78bdhXXw/p0ZU+EPCGUQ93toPc56XKLFgjh71dbBPatYgoljM7UQ0rx6JAwkbPTMhUpC
 Zod2SV5lvp9iKqwFOqf041GCO3zvCi3L9rmCVb5ZRrYYH062SxouWLQwzRlMnBZK4y20whkxT
 WwdxJp9iBNeMO0UvK0Yuro2QzQumC0ckmuO5GsrakvTt2HjA6uCiiJNmLNcbzXduKEDO4WAG1
 igoVFevHCGsBqbCogF83OITk6GVCXIbuXKVyKvzF3AUupkcMFq15YT3xzFkUwiEcQkGYKvkO+
 B7oQSzL4hXzjjmWLWWGuOQ9DnbRRv2yckdRchlpmH8l1rAp08HApILacvjN0aYuJtgP04hu5Z
 FhOdeEXpDY72BEFgtWm9aw+Mx+ogoe62ZEk6xyGaips37cU/qTzQZNqMRiOQPNNNbcZNs63CM
 HPV5u/AupeYSp8x1UhkTBso8GVdTdeTeky1UjeQF75K47UmbmHkCw+A2M6oE4iZ8nh9W7qCqV
 4EBWrZw6x7US2CQ4X0jTwrUReH/F/vGbXwTVFlbpCXG7APZ7Fun2DmG/5FU7r4zx0UVkHkymm
 KNEJA26bxbr6ATXKFCTD4dvOq3GVcKzTIQaGtkPJDRsQfkubKQMpDSLmoh1u3SBlLw+3uHotD
 KKX1Y/iSlYbf7lYR1qK4x+4uRf+mFiXp6HtmKkdz+vJPrnmN3BInW14t8UWBml27/y4WA8r54
 nW8Sve0eIlRzQtO5a5SrHUAgpgKBKS9Sx+dDz5HDgL9uDiD/9rTNZawm4R3LGlltR6ugbEF5X
 4BsI69odmjGZsnWys22JJjOUtYaVZS25l8RIpg086BsXp3Ao59mVwFdGZ4Ur5LvOgngrKeBw0
 03oUD7drl+Iess22zlrjtzWTlMkvcMY70/7mYLIi7LEn8ltJqCCxUZVYYbJBgBZpUAcyUGx7z
 VJgEJGhWIVapMMrpc7FBYp27DhAhvQ6/mTuSUtF4U0btIVfyH8TczHdk1cEbXATayZb2VZYXF
 0OHAAq9eDv/ZfM=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

concerns: Kernel-5.4.130 - Kernel-5.4.152

Below problem must have to do with the installation of a new kernel-versio=
n.

I removed the old kernel(-version) and its modules completely from
SSD/harddisk before the system got restarted, so that listed root-processe=
s
always act hyperactive whenever Pale Moon (within sandbox firejail and Tor=
)
get started.

So this hint might help you to patch the kernel.

Regards,
Andreas
(Gooken)

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
