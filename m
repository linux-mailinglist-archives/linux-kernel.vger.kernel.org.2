Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984A03D46A8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 11:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbhGXIrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 04:47:07 -0400
Received: from mout.web.de ([217.72.192.78]:51207 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234845AbhGXIrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 04:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1627118856;
        bh=rQ0zLLbV4rmQOTYDB5GEFnVTG0xM+LwhDNygBv0FcTI=;
        h=X-UI-Sender-Class:To:Subject:From:Date;
        b=nWDzkRP3XFAt+Zw/aeCuE3LymcUJZHHkqtwus9CBgnvxQmmeT4nIIJ4ljkeCjvq0a
         onkAMrkBT+o2M1nfx6bTIAhDapn9gdzU3Jeochwjd8lc+wr3iXPsNCCbkxiHsVs0hh
         dz80o/OdjdOxX6e03lIcMtXceVjy0ePPQmIg9HGc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([178.9.208.165]) by smtp.web.de
 (mrweb103 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0LfRvZ-1lIDsf2Rcf-00p0zL for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021
 11:27:36 +0200
To:     linux-kernel@vger.kernel.org
Subject: ???UNSURE??? Re: Kernel 5.10.52
From:   secret <andreas-stoewing@web.de>
Date:   Sat, 24 Jul 2021 11:27:34 +0000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <202107241127.37992.andreas-stoewing@web.de>
X-Provags-ID: V03:K1:4KelIeMm5W1lnSJbewDVf+4TBmQhpEmIAutP1uQdY4EQC05CCfA
 sslrWla9JrFGqje7eq2Pm7tkl6XU5Ijt5cKMvUxn6E1Tm5B3u0IdKGdDDPF+pvuSr3xhyFX
 S/e1JCdKCQMr51+V9zt+uRaeERmUSiwqZBdAsJKM+/sMy0ZKnMuvfdEvw2wYcRA/5MoN/OO
 e2BbjV04ng/yTHjAGtjHQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UAD/RQ7w12Q=:0hosS2nMCfkwrRUXkXS6+r
 rwk4YGZ/+/ml2VqbD4CO+TrrGXA5kt8SNMsIrRUdkhtF0lWq/VH/X9YMMKTVlWpttYi/O8Vmr
 8hi75mgOKLWxxXTnZQZvIiWN5J4t69EvWbYmPvKImnKmlOb97z9EjdBiZxIFET6A7LfIGqNFR
 XsW56g3fO2XjTEt4rmt6/DbLdNiaw1mfox1B+UhGH993dHcd/ylN37YdefqNvjV6QyS8UfWOq
 0FmJSx6bbozTTSt4HKGGV//Ez/M2SqbC0yOw9DFO8cMMjUlXOIcEV2WEb93YIxzqtZ8e9xhuK
 r+3pLpETzSQwElP1sYsfa9PusnFyjR0NZp3Ta2r1nWZ06Ns2EedHQGC+9187wcF8UiW5bky00
 uvKTFgsuKTV8wNHpBJG5tQONec9hpAjbmkAQr0yePJF8qbXRfsG3n+e0H2915SCEHzHxcera3
 PDn6ui9Wwe1EwdY+/YqNkn4yZ3d6uVXIn7Pl8YAI5sK5XeAKkGzEBKe0wvSI4CY+MqE0JuN6O
 IK2tniK0HY0RPdC8kyN9Zyly3E3GlEBO8ygZQBAyzY18Vnj3aV+axKDxYizHotmQbR17OPobB
 oITWdyQcwo4RVUoZNS6LhzEfgnoelixLpck1R+aRqS1jPG7bqNVX5lCPl9jLRCf7LMKEqWxBX
 2hq32K5sBOJvLfdKHP92b3NMWaBK7fDqH9rrtxunMMKldvAVu3iz7rIxhqXmlPuSunEE+NSZv
 B+yRrVFf06pX8w3RffVcDi0Pee/OkhQD4S2rMAPuWRfLOZXpfQq/fAxxp4ddSSTk34aRqauVw
 4jjQLbdvCz86totFt0dqQol2vlA2p7/21bvk0sfrOxAVOrnCa/6K3ZGg7JJSmaCzPzITN+bdf
 AEwJL2UY+xSCeeiODqackJiWQ03zjtCL0sTeXUjswkH8tPPfm6AEm82TrNnB6uoStQM2fkCzf
 mMbD0AK0cL8Nu1us5ehkxtEHTON0ImYnJV+sHJWe6xf2uaPmGMietPMkhuD6520tEU3JUr9YU
 CmPuFzQ1xhuS2nMjZiQR3OjEXQoccdCpz2r69pnd735O9mLP9bMwbg6crPxph9vVNnnoRrE+M
 i1JeMavu6HYn1+hI0KaJiHuy8pBEHSAcqkg36r54pHf0obG0gSo9Wt7+Q==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 24.07.2021

Hi, Greg, dear Linux experts and friends,

refering to kernel 5.4, the problem with the highly active root-processes
(making the tower-LED for readwrites blink so serious hard)
listed below, tor needs the mentioned time (of about 5 to 10 minutes) to b=
uild
up a first secure connections too!

libapparmor.so.1 required by firejail (OpenSuSE 15.X) needed by tor
(rosa2016.1, mga7) must be the cause for the behaviour of the processes! I
have got no other explanation.

Kernel security module apparmor itself got deactivated within the kernel b=
y my
boot-parameters "secure=3Dnone" and "apparmor=3Dnone".

After tor and firejail version got changed from OpenSuSE 15.X to mga7, suc=
h
root-processes did not get activated!

Now everything works fine!

But I still awaint your patches for kernel-5.4.134...

Regards
Andreas St=F6wing, M=F6nchengladbach







=2D-----------------------


Back to my e-mail refering to kernel 5.4.134 (pclos)

The unwanted, highly activated root-processes by tor (pclos, mga7) are


kworker/u2:1-kcryptd/253:2 (escpecially this one, CPU: > 10%)
kworker/0:1H-kblockd
dmcrypt_write/2
jbd2/dm2--8

This occurs since kernel around 5.4.130.

Please patch the kernel-5.4 to prevent it in future!
Regards,

Andreas St=F6wing



Hi,

This is the friendly email-bot of Greg Kroah-Hartman's inbox.  I've
detected that you have sent him a direct question that might be better
sent to a public mailing list which is much faster in responding to
questions than Greg normally is.

Please try asking one of the following mailing lists for your questions:

  For udev and hotplug related questions, please ask on the
  linux-hotplug@vger.kernel.org mailing list

  For USB related questions, please ask on the linux-usb@vger.kernel.org
  mailing list

  For PCI related questions, please ask on the
  linux-pci@vger.kernel.org or linux-kernel@vger.kernel.org mailing
  lists

  For serial and tty related questions, please ask on the
  linux-serial@vger.kernel.org mailing list.

  For staging tree related questions, please ask on the
  devel@linuxdriverproject.org mailing list.

  For general kernel related questions, please ask on the
  kernelnewbies@nl.linux.org or linux-kernel@vger.kernel.org mailing
  lists, depending on the type of question.  More basic, beginner
  questions are better asked on the kernelnewbies list, after reading
  the wiki at www.kernelnewbies.org.

  For Linux stable and longterm kernel release questions or patches to
  be included in the stable or longterm kernel trees, please email
  stable@vger.kernel.org and Cc: the linux-kernel@vger.kernel.org
  mailing list so all of the stable kernel developers can be notified.
  Also please read Documentation/process/stable-kernel-rules.rst in the
  Linux kernel tree for the proper procedure to get patches accepted
  into the stable or longterm kernel releases.

If you really want to ask Greg the question, please read the following
two links as to why emailing a single person directly is usually not a
good thing, and causes extra work on a single person:
	http://www.arm.linux.org.uk/news/?newsitem=3D11
	http://www.eyrie.org/~eagle/faqs/questions.html

After reading those messages, and you still feel that you want to email
Greg instead of posting on a mailing list, then resend your message
within 24 hours and it will go through to him.  But be forewarned, his
email inbox currently looks like:
	912 messages in /home/greg/mail/INBOX/
so it might be a while before he gets to the message.

Thank you for your understanding.

The email triggering this response has been automatically discarded.

thanks,

greg k-h's email bot
