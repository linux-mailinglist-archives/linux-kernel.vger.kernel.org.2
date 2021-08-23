Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859D53F5004
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 20:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhHWSAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 14:00:43 -0400
Received: from mout.gmx.net ([212.227.17.22]:53495 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230187AbhHWSAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 14:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629741597;
        bh=bC3qDrP6IQ+wYFkxYdopfoIcYZE1Lo9Y5dYZP+Iv9cs=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=X5rIWdPx4FX9dgDcYC5CwX0Tf+hmoj6dtfjISnP63W/dTJIs3vMw6xWUZY8N6mduN
         fj5tEanSI00ifHTLf+B2YcushB+JLOdIYygibNyOZ8ZYfeLKaptks8txnVLkCwvSTq
         1YT0p+1QC30R9Dauqazs2MQ4o7Aukws3YqlVc17Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.3] ([77.119.215.146]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJVDM-1mby2n1KbA-00Jptp for
 <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 19:59:57 +0200
To:     linux-kernel@vger.kernel.org
From:   Thomas Korimort <tomkori@gmx.net>
Subject: Problem with mounting nfs shares after sudden poweroutage, fstab
 mount procedure jumbles nfs mounts
Message-ID: <c556a713-beb8-25d1-7ca1-98d680300f6c@gmx.net>
Date:   Mon, 23 Aug 2021 19:59:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:A14bPbq8sBXex0ScymZEj7z6nYjJu/LxzCpRvfJRZrXIX9JQA24
 EIbtRNbCTaLppqfVPIBNs4740P3+PocGxj4LXRCUomNloSYBtksgM9yrh0Vka1X8JiqDmde
 vYK2if5pHDI5MXggPME0MLC+JVJumsfcffdfQLDjS+lnYCwnMYWCS/dN793ulYgdn/wuGR0
 +mhYxRT9FJuOb28XDaaWw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:A7ExfEQyDM4=:20aZKtd9kQcT3hUiwtY7Jb
 1nl+iugbp768tivD35OcwZeKWZ3ojBgztwdcAtHq/qgiZujd8SeFmpdOU4yyh2JjcXte6qrH2
 b5pvkQC/nECpdQwRLmHQQxPntgHjkmqR/q1JI1kFp0fPYRJSs94aw/ynl5wP31FnOraqVnEfE
 t+4ULrj07m+LM6fwF/6vZJyrsvBYKE+8rlfYAYKwdhTQDmDudfbVe14HjMRMrwu5Ku7pGvnAp
 4Jr1ZyTVZtUXs/xJNiQHGdkvFszHGAYIwezQAaP4SIdAzLuHcOXA5WGrjRdp0JmTweXuCAv7u
 sFWkCzWEKTSo6jj0Pdwzy6YT9+kel2DEthGVv90bRaM7gsMvX8uAHDa2thU9+TJVxYYWLjhu0
 5LjjA9Mj/L0Kvjx8fCkHX8hn1D8qXR0XCH7oXXI+kJkSJX1K7riFBXLjdgTxVe3yjbuVQ6lmy
 1dD4rd7WBL7CP/6M7RwTvyngB/u1Z5FizAWrOjzuyqV3K53pInNsaTSXb6m2INR8/gklh5W5I
 PQywhb1uSSp2OoRP4O6KPZSi+wHdciV67GmkKEHb0VavgWPDuyz96TQXtl0pvvCIOIUu5wmmo
 qNRjfqLOuO3AAloXp8DaiwJXqYhn9p6xs7SIneiXpSihPl66mGTpXWXsbl9GSwIG+JPx23Icc
 GXskoinH0qZ1lTCE3eFDNA0+YIoek5XgNV4myuggRqdC8NfWQkvGbx+TKa+DU4M6D/TydJr7O
 vsq6RBAA/mm8Lmj5mo3IH7oGzvGDVOgQuj7hVtw4JzZLY9pbR+xGXAHbYFmf2plTyI7DeO5rf
 Zj4Ttmp330utsVayRlar+V9+Xxr37YtgMETsON7Gkx0iNx9jHWfHlNr2sw6ASsua0xNJuqXpu
 qmgEFWgT8iMu7Wyx49b1nt1CBQTRj/94kCB27QCub1M2wXvka/1DhbQWFyfmTopwBb2cYrF/N
 XHumqF5EK7lWu8ZiZu50H89LYw/eX5NZhJqGoPZK3LrVQOHvQqRbedVYM5GiPE5WvgFyHTuec
 lS0U17u0qi4bPGVrOonjf1bKGG6sBIW8hCWgtnSBsrPLWEJTnhZpRNfdCr1MSRa6zh/AITdqI
 j15mL+wg32ko4QzonbhX7zjkDkoCK8THctZSFCXTHpad/wzE6OSCXlyjg==
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
