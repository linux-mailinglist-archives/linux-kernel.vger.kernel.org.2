Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5703EE6E9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 08:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238112AbhHQGwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 02:52:49 -0400
Received: from hazard.jcu.cz ([160.217.1.6]:45076 "EHLO hazard.jcu.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230094AbhHQGwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 02:52:44 -0400
Received: by hazard.jcu.cz (Postfix, from userid 1000)
        id 7D6E53139D0; Tue, 17 Aug 2021 08:52:10 +0200 (CEST)
Date:   Tue, 17 Aug 2021 08:52:10 +0200
From:   Jan Marek <jmarek@jcu.cz>
To:     linux-kernel@vger.kernel.org
Cc:     regressions@lists.linux.dev
Subject: [REGRESSION][BISECTED] Corrupted files on CIFS in 5.x kernels
Message-ID: <20210817065210.iposihe4yuutfijy@hazard.jcu.cz>
References: <20210812064542.omomndvwlsfgqgqz@hazard.jcu.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wgmsen6kpo5mh5li"
Content-Disposition: inline
In-Reply-To: <20210812064542.omomndvwlsfgqgqz@hazard.jcu.cz>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wgmsen6kpo5mh5li
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello lkml,

I've did a bisect to find 'bad' commit, and I've found, that problem
commit is:

# first bad commit: [e8506d25f740fd058791cc12a6dfa9386ada6b96] smb3: make d=
efault i/o size for smb3 mounts larger

It seems, that problem is somewhere in cifs?

Detailed information about mounting this cifs filesystem:

fstab:

//some.machine/jmarek       /mnt/smb   cifs    _netdev,credentials=3D/etc/c=
red_file,forceuid,forcegid,uid=3Droot,gid=3Droot,vers=3D1.0 3 0

some.machine runs Samba (sorry, I don't know, which version,
server administrator is just now on vacancy).

Questions are welcome.

I can test patches, if you will need.

Sincerely
Jan Marek

Dne =C4=8Ct, srp 12, 2021 at 08:45:42 CEST napsal Jan Marek:
> Hello lkml,
>=20
> I have problem with two "network" filesystems in 5.x kernels.
>=20
> I've Debian Buster server with Postfix and Dovecot, users have
> Maildir mailboxes on CEPHfs. Backup of these mailboxes are making
> by the borgbackup to the remote machine, using CIFS.
>=20
> Debian Buster have "normal" distro kernel v. 4.19 (in my case
> 4.19.194-3), which works fine. I've tried to use kernel from
> buster-backports, linux-image-5.10.0-0.bpo.8-amd64, which is
> 5.10.46-2~bpo10+1.
>=20
> From time of booting this kernel, I've problems with massive corruption
> of dovecot index files on CEPHfs. I've tried to set up dovecot in
> the similar manner, as for NFS filesystem, although mailboxes are not
> sharing by multiple machines, but it not works.
>=20
> As the second problem, I've cannot do borg backup of mailboxes to
> CIFS directory - borgbackup had problem with corrupted archives.
>=20
> When I reboot back to 4.19.194-3, problems disappeared.
>=20
> I've tried to reproduce from my work computer, where I have
> Debian Buster and kernel 5.12.0-19.2-liquorix-amd64, which is
> 5.12-28.1~buster, and there is the same problem with CIFS
> filesystem and borg backup. You can easily reproduce it:
>=20
> 1) mount CIFS filesystem
> 2) make directory on it
> 3) try to init borg archive direcory from this directory
>=20
> In my case:
>=20
> mount /mnt/smb
> cd /mnt/smb/tmp
> mkdir tmp
> borg init -e none tmp
>=20
> I've got this (the same problem, as on email machine):
> Inconsistency detected. Please run "borg check /mnt/smb/tmp/tmp" - althou=
gh likely this is "beyond repair".
> Traceback (most recent call last):
>   File "/usr/lib/python3/dist-packages/borg/archiver.py", line 4455, in m=
ain
>     exit_code =3D archiver.run(args)
>   File "/usr/lib/python3/dist-packages/borg/archiver.py", line 4387, in r=
un
>     return set_ec(func(args))
>   File "/usr/lib/python3/dist-packages/borg/archiver.py", line 154, in wr=
apper
>     return method(self, args, repository=3Drepository, **kwargs)
>   File "/usr/lib/python3/dist-packages/borg/archiver.py", line 276, in do=
_init
>     with Cache(repository, key, manifest, warn_if_unencrypted=3DFalse):
>   File "/usr/lib/python3/dist-packages/borg/cache.py", line 380, in __new=
__
>     return local()
>   File "/usr/lib/python3/dist-packages/borg/cache.py", line 374, in local
>     lock_wait=3Dlock_wait, cache_mode=3Dcache_mode)
>   File "/usr/lib/python3/dist-packages/borg/cache.py", line 467, in __ini=
t__
>     self.sync()
>   File "/usr/lib/python3/dist-packages/borg/cache.py", line 851, in sync
>     self.chunks =3D create_master_idx(self.chunks)
>   File "/usr/lib/python3/dist-packages/borg/cache.py", line 786, in creat=
e_master_idx
>     master_index_capacity =3D int(len(self.repository) / ChunkIndex.MAX_L=
OAD_FACTOR)
>   File "/usr/lib/python3/dist-packages/borg/repository.py", line 1009, in=
 __len__
>     self.index =3D self.open_index(self.get_transaction_id())
>   File "/usr/lib/python3/dist-packages/borg/repository.py", line 376, in =
get_transaction_id
>     self.check_transaction()
>   File "/usr/lib/python3/dist-packages/borg/repository.py", line 365, in =
check_transaction
>     raise self.CheckNeeded(msg)
> borg.repository.Repository.CheckNeeded: Inconsistency detected. Please ru=
n "borg check /mnt/smb/tmp/tmp" - although likely this is "beyond repair".
>=20
> Platform: Linux hazard 5.12.0-19.2-liquorix-amd64 #1 ZEN SMP PREEMPT liqu=
orix 5.12-28.1~buster (2021-07-22) x86_64
> Linux: debian 10.10
> Borg: 1.1.9  Python: CPython 3.7.3
> PID: 3320  CWD: /mnt/smb/tmp
> sys.argv: ['/usr/bin/borg', 'init', '-e', 'none', 'tmp']
> SSH_ORIGINAL_COMMAND: None
>=20
> You can try repair this archive directory, but it didn't happend:
>=20
> borg check tmp
>=20
> Data integrity error: Invalid segment entry size 0 - too small [segment 1=
, offset 17]
> Completed repository check, errors found.
>=20
> On local filesystems, there is no problem, everythink works fine
> - tested on ext4, JFS and XFS.
>=20
> It seems, there is problem with caching of this filesystems?
>=20
> Questions are welcome.
>=20
> Sincerely
> Jan Marek
> --=20
> Ing. Jan Marek
> University of South Bohemia
> Academic Computer Centre
> Phone: +420389032080
> http://www.gnu.org/philosophy/no-word-attachments.cs.html



--=20
Ing. Jan Marek
University of South Bohemia
Academic Computer Centre
Phone: +420389032080
http://www.gnu.org/philosophy/no-word-attachments.cs.html

--wgmsen6kpo5mh5li
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQUTxPtzAjqwmJlmbXiFFMStj9tyQUCYRtclQAKCRDiFFMStj9t
ycAHAP95RzG9xm7wcSHwAtai3bPfRGHUgS6JRajEcztTOzXjqAD/ZICLWmalcWc+
/XchAzu3WS66H3WtogWCPA2Q406yLQI=
=QMav
-----END PGP SIGNATURE-----

--wgmsen6kpo5mh5li--
