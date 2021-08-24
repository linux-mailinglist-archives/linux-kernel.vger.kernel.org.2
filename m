Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B166B3F583A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 08:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbhHXGae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 02:30:34 -0400
Received: from mout.gmx.net ([212.227.17.20]:44859 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232706AbhHXGaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 02:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629786579;
        bh=bC3qDrP6IQ+wYFkxYdopfoIcYZE1Lo9Y5dYZP+Iv9cs=;
        h=X-UI-Sender-Class:Subject:References:To:From:Date:In-Reply-To;
        b=AXMaPrsuQWXm11t2+4VMHjgmRS5SMTIi1RNzP05daIQ25u3fIEMdOwugwjggKXBNz
         HSq4mw7PdT6EGjQ7+NhmnV11n2V9mf9VyFziP6nOtG6ySXutBGbms3HogN3CGE434t
         CFbLsHjtENaRfy5VTmYC7y1JpbV9MCCcjj0ltlDI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.3] ([77.119.215.146]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqs0X-1mnMuZ3bHN-00mqeV for
 <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 08:29:38 +0200
Subject: Problem with mounting nfs shares after sudden poweroutage, fstab
 mount procedure jumbles nfs mounts
References: <c556a713-beb8-25d1-7ca1-98d680300f6c@gmx.net>
To:     linux-kernel@vger.kernel.org
From:   Thomas Korimort <tomkori@gmx.net>
X-Forwarded-Message-Id: <c556a713-beb8-25d1-7ca1-98d680300f6c@gmx.net>
Message-ID: <8321deeb-bc95-886c-21ad-9717b3782ea8@gmx.net>
Date:   Tue, 24 Aug 2021 08:29:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <c556a713-beb8-25d1-7ca1-98d680300f6c@gmx.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:N4lLzB4C9QWjMufi88zNTR+IFM2/tvMoPHvigVnpIZcE3Ho3Moh
 ExtUBCR71XM6+HlgJocUvXbU2bxV0l/7QisZ0O/h4JnXAIgzFQUVi0WIJiqAQjU20gvUUTH
 pDfSpEQiUxx01uR1Eac0EWtKj2GWD9cIAUKd+Um31E9/Zbb1oBOUlGEX2srCstHLzk44tV5
 zujuukLjDCC/KamHrmGOQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:V9kvTV5es8Y=:Va/r7wmMBr5H3hnM97VnEk
 yhvY3ERripoYYy1Gdp4wbyLdrpS2VbVSEF2RrPOSMI0kx4qEIoxpEM+Yk8hZaXaf1/B/xAC5P
 cwcIeEd0j1BUC+MD3nP3NOg0A7zbcwjrskbkTKESLwKMLFvhuWiwp8S0XL2PpWDuvJHl7irUg
 I0lSj6Gt5OETH+zbqvxr0eb+ziJXdl6D7ybcNhCJAIjjr2Q/8gHEVIluut6V7kwQnkTZxpxfm
 qnrdH8dSkz8P0DV6BYPU7OmRrrfHHj0vACy2UkFTu73l122BPzHoFW5V3ZbTO+ytqjU+OWiUV
 f7QZGuoK+ty7ni9Y/wWAcHorPVeT5OPFRBmeq4Vrtk8D/VqJnoC5QokQlumeJrsBKFBBUw58r
 sY/rT1Qb9/HrcB0Koa6q9LS4CvSARlk88RPzVp2IejxfNXz0du2eWPgdgR6IaaOjXyrhkIUAt
 Aubsi/QP5L6K4ffYF/nOokOwBuo+dKxm5UXXL9+nw1Qx/2/CY/IQ+Ah4IGO8BlLebhvU2KB+O
 vPeVGM+VXEMUOMYM+aWbFRFQlNXNYswEHN4bKXdHySsW7GYIvR4gLhrPMbwcYlOffXPat5gep
 T9U3X38G9J3ES3uE91TrJ7LlkUfzSMfE/5QGYHDq5zXpTgnUB9cjwv37FcrcQ4TATDkrdDzrW
 MvVDJV4JQvyBAjy1TGdiUIqIj3KeIXS1olmIRsL+M1xkbCXHmRlR+bGSexILsIbNiMm6Sehsf
 IOW9EmwD2a57B5nMVOzQFA14AXtWYduUxeT1mS0/M1hZpVSOPHgBJQ3jxc++L51oW/Rb6Mw1x
 3ooGgiL5Ckp7J1HwWpNGJjvCinVTxi/A9wQc3VQD+j//3MMX00JLO8e5RpNJjX5vQjBdeHT5v
 FiQ5Wo2D/JUSTEcogfkV4eryHWVSgwaJLQpd8v6G+fd+LFLrSyvwJIj3DzVaXSAry7ZMyv9JO
 QJgt5K0grvl7ThX6Sbim89YcslW8/tC2Fxbkc5tQug+tvJMrR8uMvtAlC7RNE+Rjm6l5cR4nF
 /3yRC5HFLUzV/Ass8WmdJ4nMNYB7Ce4XUrw2SN83N2ZRU92VR9h7fVflUpNMJpVYKefOm5r+v
 7uTn0cwqr7ZzXTu3S9nvG59Vkrn7eiUY2cSF93LaikT+zU4K1bRW5+rWA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I am already experiencing this for the second time and i feel that this
is a strange issue: I have an AMD Ryzen desktop PC with Debian Bullseye
(before Buster) and a JBOD disk tower with four fully occupied slots. On
my desktop i mount the 4 disks with ext4 file system as NFS shares via
/etc/fstab, which used to work nicely before the most recent sudden
power outage. After that the drives had to be checked and the inodes
repaired. The file system of one disk in use was destroyed and restored
through backup by copying the backup on the repaired disk. I also
changed the file permissions and ownership after the copy procedure
after a reboot. After that the mount procedure during system startup
happening in /etc/fstab did not mount anymore my nfs shares correctly.
The kernel mount procedure is waiting for 2 drives to mount and then
jumbles the nfs mounts somehow.

My /etc/fstab has this four entries related to the nfs shares:

10.10.10.2:/mnt/WD01 =C2=A0=C2=A0=C2=A0 /mnt/WD01=C2=A0=C2=A0=C2=A0 nfs=C2=
=A0=C2=A0=C2=A0 rw,auto,nofail=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 0
10.10.10.2:/mnt/WD02=C2=A0=C2=A0=C2=A0 /mnt/WD02=C2=A0=C2=A0=C2=A0 nfs=C2=
=A0=C2=A0=C2=A0 rw,auto,nofail=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 0
10.10.10.2:/mnt/WD03=C2=A0=C2=A0=C2=A0 /mnt/WD03=C2=A0=C2=A0=C2=A0 nfs=C2=
=A0=C2=A0=C2=A0 rw,auto,nofail=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 0
10.10.10.2:/mnt/WD04=C2=A0=C2=A0=C2=A0 /mnt/WD04=C2=A0=C2=A0=C2=A0 nfs=C2=
=A0=C2=A0=C2=A0 rw,auto,nofail=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 0

and the actual mount in /proc/mounts lists like this

10.10.10.2:/mnt/WD04 /mnt/WD04 nfs4
rw,relatime,vers=3D4.2,rsize=3D524288,wsize=3D524288,namlen=3D255,hard,pro=
to=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D10.10.10.1,local_l=
ock=3Dnone,addr=3D10.10.10.2
0 0
10.10.10.2:/mnt/WD03 /mnt/WD03 nfs4
rw,relatime,vers=3D4.2,rsize=3D524288,wsize=3D524288,namlen=3D255,hard,pro=
to=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D10.10.10.1,local_l=
ock=3Dnone,addr=3D10.10.10.2
0 0
10.10.10.2:/mnt/WD02 /mnt/WD02 nfs4
rw,relatime,vers=3D4.2,rsize=3D524288,wsize=3D524288,namlen=3D255,hard,pro=
to=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D10.10.10.1,local_l=
ock=3Dnone,addr=3D10.10.10.2
0 0
10.10.10.2:/mnt/WD03 /mnt/WD01 nfs4
rw,relatime,vers=3D4.2,rsize=3D524288,wsize=3D524288,namlen=3D255,hard,pro=
to=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,clientaddr=3D10.10.10.1,local_l=
ock=3Dnone,addr=3D10.10.10.2
0 0

One can see that /mnt/WD03 gets mounted under /mnt/WD01 and there is no
mount entry for /mnt/WD01. The content of the two mounts seems to be
that of /mnt/WD01 (WD01 is a hand-maintained mirror of /mnt/WD02). What
is wrong here? Reboot does not change anything. This strange
constellation is carried over from reboot to reboot and i don't know
where i can find the run state or similar file that is jumbled up and
that is transferring the wrong mount information from reboot to reboot.
I looked in /var/run, /tmp aso. for files related to the kernel mount
procedure and fstab.

The mount procedure is waiting for 1,5 minutes for mounting WD01 and
WD03 and then jumbles the mounts. The drives itself are okay on my
Raspberry Pi 4 (Vanilla Debian Bullseye arm64 via image-specs script
some days ago) nfs server 10.10.10.2 and exportfs also lists ok
(10.10.10.1 exports are rw, others ro, other export options are sync and
no_root_squash for all exports):

/mnt/WD01=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 10.10.10.1
/mnt/WD02=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 10.10.10.1
/mnt/WD03=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 10.10.10.1
/mnt/WD04=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 10.10.10.1
/mnt/WD01=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 192.168.0.0/24
/mnt/WD01=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 192.168.1.0/24
/mnt/WD01=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 10.10.10.0/24

WD01 is exported into multiple IP adress spaces for my different router
and network switch configurations. It was working nicely till yesterday
before the sudden power outage and disk recovery.

Exactly this problem happened to me with my old Debian Buster desktop
installation and led to the same problem, when i had to replace a
harddisk and after a power outage. It seems to be a recurring problem
over the last decade of years as well as the famous pulseaudio sequencer
problem.

Greetings, Thomas Korimort.
