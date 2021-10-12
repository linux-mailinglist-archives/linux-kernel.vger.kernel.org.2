Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B597C42A156
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 11:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235757AbhJLJqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 05:46:16 -0400
Received: from mout.web.de ([217.72.192.78]:47955 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235581AbhJLJqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 05:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1634031852;
        bh=whkdE4B9xV53aFAl8prS48FIENaK0cTAtkpYL0iPJhs=;
        h=X-UI-Sender-Class:To:Subject:From:Date;
        b=Vf56MsTxqIDU3Objt1hThjuN5E8NC2YrWjk3qjs9M/TNiFnMVwTIp1g5/U296R7qQ
         F3zB/2pXCkL2PhtGJBupKizX9dSfqqeV0eqHyx47NfHQLIJCnnfomAhyhE4tDOLO6U
         CGhDju8GjAKhefGelLpV/ZqQApJdjc62LBnbdVVQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([146.60.72.88]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M3T5g-1mrtfg0gbY-00r1cE for
 <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:44:12 +0200
To:     linux-kernel@vger.kernel.org
Subject: Unwanted activation of root-processes getting highly activated
From:   secret <andreas-stoewing@web.de>
Date:   Tue, 12 Oct 2021 11:45:52 +0000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <202110121145.55865.andreas-stoewing@web.de>
X-Provags-ID: V03:K1:raCBSXsRcurrkH9ogg3x7EITBT2oSlcw3SBNbXH/1Qlz2Pfuy7a
 T4mPYF+s0TCSBgbq2dQSvj2DTpror573dHqiBN+2/B2CKU6qJW+1Yoo5TgiqGms5Oao3Fpv
 pGVOHe4o22qRUrX2KrL0y5kfbFM5Nq4t5q5hn6SY0PiXXg2+ewdU6W908PqfH1u6sb0Q7gY
 Nw6zjNeLYXeq3UIWgtQ6w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z8ui8f5eZoA=:jcvsfWe1Ch+ehMFOQEZ61m
 hCHC78yq1kZ+154aQVoxquC+5T7f99oTEcrJLimZjzooIWIvrv7Z7zzhtqwLmrcPOG9d0YJPO
 8/jiYYBnGqLqLE5nRujZPo3Npet8mYGhkm3af2Xj96s0vqlfmruFZEPOpr9Sy8Yx2nuoifxUa
 ORarBOi69aWuRtNT2ztHpUReOSe+0IGZ3k9N8S/3W7ba1oZUTzIjKToaTB5AtVtKj/hfh07ZA
 I2xQCqj1cVD17TWTXL0iTybkUfeAlM6+x/WPe8VUWWu7SvVoaE8e5+q2GrgTbDWSRBJ2XybBv
 0oQH1oMGDXSt8XuRaYYSb9JHidMmR3rRymCksn8QZ3YY+R9yXNF/RGMmPgp32zmamA5wk1c9H
 mBxqo7gP3hPo3E/evERZPk5c/bmNoc483hgSBOhA+fgQOApIkvemyKSxfUMn7T28nzlbWiQJK
 nS6KFCrl5TY5pJt8FZkmjT6WOGP82d91KLLLKvs5F7YlNc9jhBLDDc78FI0DXanJkcn7/TMXb
 KYJVv5DrOQgYuN5pykjhY2wjVwmw/cJXm2mfy8ZqEGDHk2c+lHCMsVI/s2wsRPM7Pz/VUdv1Q
 wvc9rSwXiYeCIYZMTa0+D1Fa8mSFBxL9jjD6WjjSn8TTVE1evptfNOAikM6kr5v8hX07dX1rv
 nnzMmXeEr9buIzn0SzpTEWs1l60i9TaIHw21KE20fLDZxlSr3JXDOo8YMLiiDeSOBg4+21YaG
 hjmm18kxQc4dJN67AX+C6F6Q5naA8HvumJ8ujEGrZg38fVzLV+jl3maAgQUW1zNOruKfilcmL
 iLN+au1qCI9D7QDQ2AFROxWMgPmGGIKoFreEVHarcokrlGU5ro5VU7krdoyWqwJMMRApwR6an
 4vOTRRC3CO67Q11x96olqIlmHCBI577XbonabvWRb0BX8ANE7iy7eSXopXS3KSzPQyVPluC0j
 w5ZfAKaYjPdHeF2roF5oRl3dal8yiR7kQm18S0V5o1Z5trNmxE1ocdMCi2mht7HmPQVSLRaTF
 75q9DediZ0cN9utE6/IM0ZcwK2mPn3XSXKT1DlfBT3hmdmWToBR/qk+ecbZr9uDU9s+D5U0/v
 sGIbn2uVPZfDSA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, no, it does not have to do with the kernel-installation as I told you =
my
Email before for it happened again this day!

Regards
Andreas

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
