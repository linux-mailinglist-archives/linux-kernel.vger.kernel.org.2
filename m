Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463F2428283
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 18:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbhJJQXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 12:23:38 -0400
Received: from mout.web.de ([212.227.17.11]:54849 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229488AbhJJQXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 12:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1633882897;
        bh=+WR0VrBDxYO4jCXfQEyF8JpjTVXPV1E2CmW8EsxVoHk=;
        h=X-UI-Sender-Class:To:Subject:From:Date;
        b=qpkCiIK43dqg2hhQcUwVFLI8odC8PHuBOnX55xd2rEIKQB6YVtD0B+r66+LpT6JjP
         CYuECOWhMICPw+3oGmAwro0OokNMeacGnZyAQJvDgmucGhByc4Xz6oz5SiA0iyoLW7
         LmX1dZlN6kaEVn/8gZdufYFJdTaYUMR62gE9YLMg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([146.60.78.212]) by smtp.web.de
 (mrweb102 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MYeuk-1mD8mg36Ys-00VSRS for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021
 18:21:36 +0200
To:     linux-kernel@vger.kernel.org
Subject: Unwanted activation of root-processes getting highly activated
From:   secret <andreas-stoewing@web.de>
Date:   Sun, 10 Oct 2021 18:23:17 +0000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <202110101823.20369.andreas-stoewing@web.de>
X-Provags-ID: V03:K1:v+dNKjOaGKcgqrHkkUi0HLRgOGvck2nutWsakt2dq6W+Udwahc6
 OwVqHr7Tf1hScUg1HKjNS25r7eqwbnal6cmzp85kgRMZbS9L1IRiURgsggjw++ZesXwl11m
 /DMuyYBk6pP4gBYNJjwewOrjUistZwzWaTPZZQGaW5RO9vqr6olYIMgdYD7BczrhNaQ7EtB
 Z/OjIm5abgmtcQafySCnw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QhWZ51xBmvY=:F6LAWUVrNNR0c1E2ebbk2x
 TIyrlGRFz68Gxj9NLKURq4dvkcbzKaAMV/LoDAQdyrJFxuxy/fHpnb4pP5QlmYyoJ7BwNfB0+
 TpPi2AH13UTbiJSid0Cgv5yCc6MP3YWF+YCi5SmDeyj2XCgOPn5yojAzyGiLgfZOq+WNVAdYR
 JS2q/X/c6/Qx0Qykmlk9SrO1Tfpuj5VDVdZDFCVvGxTlpYslVoUaGVVeZssfIXgxgJBhEdivN
 02qGmavNbnsmD6CSymtttlG/wpq/Qr2UmoFYZvyBPHRmb+gnseQwMjh3IkCpqliAiaTSBDwF5
 YbNi7ergNZOJeULU4FBd1BKmA9uRIfrxPbX/Dt5m15vKnBrD7FEx2ibRbXMPGI1U0Gua45Aag
 fTidYF+5rTBawS5u2UXhdFBrRWmOxr9wHz5aXy6xkmMCjUp7XsNzqXr/ylidCNjCVQPlhi8Bq
 idMyx+yE52v36xeaFPYEe27w7DcSKICvi+pAJznbQYr4mm7M79pIr8cpzH6NdEHkXF5H8aif4
 Oto1y/Vt64SP1lTqhxkhvG9ID/5dvn4WSXHmkr+Q82+Eu5lkEJyiPIpxgewuRl1z5YG43viiG
 tKB/lXc7ODSKU3vewZJTpKyi357u4kUXiu8mWoTLi6vVQE01iU6mfZHpGUHwBOc9WjIhuVjiB
 /ot6PK6E8O7Xdpgl1ssvWIQ51ChElvHGix1ko1HrLsLWak+FWsTNVavv1anQrzo/vsBj6YEtZ
 F++BiCtbfUzW0mudBp7xVyIZD0OBES/QsWDdp1/De9k3iL2rxnYKhJ55MWksiV+tLQB16GhYd
 gbvu+P4NrJQ5Xh/Jyeh4uaLLKR3wSvhG0tgZf0BEJLR12WXvY9hyQylFFAL6KQvzW9Qxt/KNm
 ooRGsVAlUvTHUvDfBkkKYmvV2xMqg0HN/gyOaz8rZc2Fh4isYe3S4A05OT7cIwIuXiR9SNztJ
 yW/p4tq99zRCHtKQjZm0qffK+GZ4gQ1/1cHliqcjIY1GVEPkH7JVvBA6lXc4uRGmO6G9pLneK
 ETk/lZ58wCUKNKXrknj/1rjB03Rnb5jZJivElupnVHrX1RJmDSoElaebPW8MtoAi+vIx1KVIx
 p/WRgYwyVNpD3E=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

concerns: Kernel-5.4.130 - Kernel-5.4.152

Below problem must have to do with the installation of a new kernel-versio=
n.

I removed the old kernel(-version) and its modules completely from
SSD/harddisk, before the system got restarted, so that listed root-process=
es
always act hyperactive whenever Pale Moon (within sandbox firejail and Tor=
)
gets started.

So this might be a good hint for the belonging patch of this kernel.

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
