Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A933F43DC43
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 09:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhJ1Hor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 03:44:47 -0400
Received: from mout.web.de ([217.72.192.78]:53055 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbhJ1Hoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 03:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1635406938;
        bh=L2kgvRs2063IzlHuMG6Vb1/ETWsJ7VeQnvW161zbcAM=;
        h=X-UI-Sender-Class:To:Subject:From:Date;
        b=rs9ljhdRd5z9yQp2MQLHY7FHX5kyFQiif/4kablReS9ADGv3i7CrXMFQFH1Vn/saH
         GoS01KpNrNdXzLoaamBZ0Ap7iR8vVSWxSACMQGJEQvT8shBiQoQo4BlWHf2nyzjutH
         Vp9yP1NKO+i4jpENXMIfU59y/FmoDDEncLBriI+o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([178.9.210.138]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MNfU1-1mHS532HH9-00OyOi for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021
 09:42:18 +0200
To:     linux-kernel@vger.kernel.org
Subject: Unwanted activation of root-processes getting highly activated
From:   secret <andreas-stoewing@web.de>
Date:   Thu, 28 Oct 2021 09:44:20 +0000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <202110280944.23199.andreas-stoewing@web.de>
X-Provags-ID: V03:K1:N/Kus1AkEbgyVxkGNx6Cqw1HaL66oDfX0ImBqEPaV96Q8AV1wAJ
 ms7DVABAAHlAObq8PJt485cNMrj7Aw5ip8w5/mtgfNhWG5XOd37hnvhRW7N2zpIKA0PqJva
 RHE4T9h2redzqjl3Q/T2KDP5/43ZRyyQwCcHDfI3/Qs7YrM4QeQ8kFmMRqAH+/GKAkQCSIp
 GAnQNO7NL95YCcZZJAM/w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sKXPc32SOE0=:Uj/0911gQYBynEucYvpnaG
 jOjG3Mmf+LQ46murTe9mV18zMckkCV33Sp7dYWUAg88WmUc6Kf218FlFUUCnSjMqhYatIcR0k
 JG/CtDUeNoo9v6ZcxJwC8Ay5PqMruSxJEdIPZwxx4o6MezusKIdpixXb/fobn8kPUn2lMQoFH
 YDey1murU8+/a/+9Hw8eB0aor62U6+PsTyak/4Ou6FlikRTct7sHoEstdiqXd6RVt4tlYCnBd
 ITFFE5iuPLhEtrMS5CYPyArR795pJTwzRXog3Id9Obrnop9F67GB4HRMPjslwC7EUlaQCO/D+
 9mXCnrqUBMPEzj4Eg/lt+Qhs+p+mY73y312w1zKxjGugPlaQNfJOaPeYvIMiSoESRQGLv4DgC
 h2xyuWcCyC4ToAQpfozMAtLIhdou81r7zMH/weqtthzKYc6PRcT+Bq8r5ORIw7jN5iDrVg2iu
 S6rJMJTm+HHMstDbEuDFxP9+7Y9uK8yuNPY/oJsjmY67Huy/o5iggSI8OWnJ7M3GSmk1yAVBu
 gqP9XzaLVanU3D1wciSHE9zanA/aPPNZtzO62fkzbUXFV3QYtZ+rWiFUCcV9yR+RBf4hFb7ei
 tp2LpH4OORT1/qwxxv6ADVApOmRQOp90jDx2VWCB8oi87aQmdIW9UUV24DySloWJwKhFG8JjP
 4Y5LvHeoWI30hlTvhZS/fNLldCZI9TrKFjdkY6J/EBBJ1hvExeqecWlGJOM626kruA9IrhkPT
 kIRZLrE56tTui/7W5d4O7pp0zDnDjCTiWN2Z+d1evYThbfnivFC8c6pojXtS1akf65Su2KDj/
 N2ohzxgkBNy6VEG5nwgawuDYmMh563uQJvWchCHThWzs9qCyhWAtAPWY7ABV8Pk2zMATR9m8j
 di0Xo6Alg1W2FGeyA6jod76bmTrKuIakQcYPtDH79d5ZePuOnZWTHL/k20tg1wNsRaiwZpjap
 XFpsDmTw14vOeTGaS9LptUQ3TSxmCqBQEpkgFXI2wVo8L0Z3Q6jicLKdOvEhAntLp/7/q2Tt2
 VFLPIMhTFoe1m4axx4zHXd+WlnKTb8EcvrfNPAkmFxCY4J+6ly0sxG4VLQGlJ/0uy8XiTvHwj
 Uxaj2f8t/qaATM=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.27.2021
Hello, today it manages us (Gooken) to prevent the highly active kernel-
processes from above after a look into the home-directory of tor
(/home/surfuser).
There the size of a file increases all the times during the activation of =
tor
surrounded by firejail (that causes the high activity of the kernel-
processes), it is named:

cached-microdesc-consensus

and its size was incredible high (much over 100 MB)!

It prevents Tor from building up any connection, so I had to wait up to 20
minutes.

Deleting it did not help: This file occured and larges its size again.

So we set integrity on it (this file) by "chattr +i";. Now the problem
described next indeed got solved, Tor immediately builds up connections,
kernel-processes activity lowered to the current percentage far below 10
percent and the tower-LED for readwrites stopped blinking,
but nevertheless this is not really a good solution,
tor or firejail and kernel (here 5.4) of course still have to get patched =
! (
!!! )

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
