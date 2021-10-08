Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D222B426D33
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 17:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242896AbhJHPFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 11:05:15 -0400
Received: from mout.web.de ([217.72.192.78]:35987 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242175AbhJHPFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 11:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1633705397;
        bh=3R3mBzzGUL/YB2mbcVYhoFKRkUk0wVNN7isx4+oPMmA=;
        h=X-UI-Sender-Class:To:Subject:From:Date;
        b=pFBiXZY0AuJEEwv0tUSoUDb3ARDF0d60NwXYBixM2eVGX7iWaHhiWtdq3v5fqkUIZ
         No45lUL5Mv8a/wCAEI1EEWnLSuDhJTZ8fNlk+3ehV08JXjpW4FcjFwgVm8aJfmUNpu
         e3wpWckamgQyV5DAQEe2q6szXJ1w7xeZsqQCOTF4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([178.9.168.248]) by smtp.web.de
 (mrweb101 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0Ljrdd-1nAezs0pBJ-00btjU for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021
 17:03:17 +0200
To:     linux-kernel@vger.kernel.org
Subject: Unwanted activation of root-processes getting highly activated
From:   secret <andreas-stoewing@web.de>
Date:   Fri, 8 Oct 2021 17:04:55 +0000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <202110081704.58659.andreas-stoewing@web.de>
X-Provags-ID: V03:K1:VntlmNsOXkemaPUbETqdYEW9hkMn3e8qLFkEZj1Q4wQSrq+wmQD
 eGP1PqdOmyuKCtxiBv2GNE0DAUunKhrNJuooJU4HuRK8j5Ia6UPwegraNbPqA4eh7e2aptW
 D7a/ETQgkkwc/owRigaZMxmjQypxKaNsiMZ5BU8r97uDfy6R74PEqZfi5qrYmjV/xjszG4h
 Z6Ozp20YBWwhrkA9tzLqQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8TDFa/9ejXA=://TpY/KbGLc0EC9R1s//in
 BJtSAEhgpsQiB+xiqOhKkIw0Xotk03Mrychii3bGwV17iZl1PnJiIOL1d4kFoSENWzOgkX6xx
 gsnzUIjd5Bf7n+YNLB78xINMgk49SlXi+QGr1HpVXyGlfSGtAyRqZfsMJWkwZj6TSsw1fYl50
 b8YhAE91Io/p4fpgQHGfzRbcoAeT1JCPrMx0cIUiXq9gIH6Z45aL1B1hmiYPocujTIQ9IYFWm
 J3H5ulwqT19FughNpFwHmg10PrboNZwddkfoeXi/xYQk17n/E4jiMI/6nIMLTTCMx3PPD9wmb
 HOHdHuPYZUWIUy5T4EtkdcuZ19gBfnpUxnjq+YNRYuSlI8FwCHIlwAOm4SUDuSgELcqK+wXJI
 vad0heJQTK7iceFnBeq+Ny1v+gbBOvJD4nrVJEoMjGwTmNpBq1fCCevmrGck4pE9nqcXJgWti
 TX8PV+9A4VrNBaqPyKPh6zTplg9VSRZr/gSH6iCDdi7zsAz4kjbFzXEBGCawWaFkLFp45qlcD
 NcrCyKjEMkJzVqh+Al8iuodNa8TOu1uHGtFsLCbinI0M0bcRf92y7uU7C9DlACXcFVfIIv9aN
 ag1GNDPQ8OumI8FbSjEkdq9vH7bwIQc12femd6r5Jgq6lHEv3B6WQoP+xN6Yw7p5sD7vFDTwN
 AjajyWq2IpPQjUQZQ2M2cgfKpP/+HCYgSaLtwucuy1pOjW8rkh5safoBjCmpU1cAtKXSzQplZ
 /St7238yjF1/ZC1kt336iqyssxCb2x+KKisOL+ZT42wvudvNDQQO88eEI2NjoiSb9mHA9778o
 MOWQVL3rbXEV+aPFLT3xW3IICEpXEnfMNlZ0hIuv/e9nb6df69bmBxj2WmzZDugyWWvQaMq8s
 IDq/1W3HaxGqPj7TGR7RLOpE4OKwFHL+fKT5+fpMktLJmMIvbjJQ8FYjVxrEJ0XxVHZtpYSN5
 LLg/d/9fa8qx0cAHKjtKnxJE5LU8V8miyHy5bF5otf+RGLcn+exnj6XPF4uLksiY6a06QSvzV
 DMPeYypeURGfovUEspjHlZSeAJldndPNtqoo4144jbgIdr+k9D2BQ+G8gHPQVxyEWgNN22+Wr
 ndBd65i6PU8Rns=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
