Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843603E9EF0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 08:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbhHLGxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 02:53:13 -0400
Received: from hazard.jcu.cz ([160.217.1.6]:45054 "EHLO hazard.jcu.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230316AbhHLGxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 02:53:12 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Aug 2021 02:53:12 EDT
Received: by hazard.jcu.cz (Postfix, from userid 1000)
        id 576EC19E3A9; Thu, 12 Aug 2021 08:45:42 +0200 (CEST)
Date:   Thu, 12 Aug 2021 08:45:42 +0200
From:   Jan Marek <jmarek@jcu.cz>
To:     linux-kernel@vger.kernel.org
Subject: Corrupted files on "network" filesystem in 5.x kernels
Message-ID: <20210812064542.omomndvwlsfgqgqz@hazard.jcu.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gyco445cfsle77ql"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gyco445cfsle77ql
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello lkml,

I have problem with two "network" filesystems in 5.x kernels.

I've Debian Buster server with Postfix and Dovecot, users have
Maildir mailboxes on CEPHfs. Backup of these mailboxes are making
by the borgbackup to the remote machine, using CIFS.

Debian Buster have "normal" distro kernel v. 4.19 (in my case
4.19.194-3), which works fine. I've tried to use kernel from
buster-backports, linux-image-5.10.0-0.bpo.8-amd64, which is
5.10.46-2~bpo10+1.

=46rom time of booting this kernel, I've problems with massive corruption
of dovecot index files on CEPHfs. I've tried to set up dovecot in
the similar manner, as for NFS filesystem, although mailboxes are not
sharing by multiple machines, but it not works.

As the second problem, I've cannot do borg backup of mailboxes to
CIFS directory - borgbackup had problem with corrupted archives.

When I reboot back to 4.19.194-3, problems disappeared.

I've tried to reproduce from my work computer, where I have
Debian Buster and kernel 5.12.0-19.2-liquorix-amd64, which is
5.12-28.1~buster, and there is the same problem with CIFS
filesystem and borg backup. You can easily reproduce it:

1) mount CIFS filesystem
2) make directory on it
3) try to init borg archive direcory from this directory

In my case:

mount /mnt/smb
cd /mnt/smb/tmp
mkdir tmp
borg init -e none tmp

I've got this (the same problem, as on email machine):
Inconsistency detected. Please run "borg check /mnt/smb/tmp/tmp" - although=
 likely this is "beyond repair".
Traceback (most recent call last):
  File "/usr/lib/python3/dist-packages/borg/archiver.py", line 4455, in main
    exit_code =3D archiver.run(args)
  File "/usr/lib/python3/dist-packages/borg/archiver.py", line 4387, in run
    return set_ec(func(args))
  File "/usr/lib/python3/dist-packages/borg/archiver.py", line 154, in wrap=
per
    return method(self, args, repository=3Drepository, **kwargs)
  File "/usr/lib/python3/dist-packages/borg/archiver.py", line 276, in do_i=
nit
    with Cache(repository, key, manifest, warn_if_unencrypted=3DFalse):
  File "/usr/lib/python3/dist-packages/borg/cache.py", line 380, in __new__
    return local()
  File "/usr/lib/python3/dist-packages/borg/cache.py", line 374, in local
    lock_wait=3Dlock_wait, cache_mode=3Dcache_mode)
  File "/usr/lib/python3/dist-packages/borg/cache.py", line 467, in __init__
    self.sync()
  File "/usr/lib/python3/dist-packages/borg/cache.py", line 851, in sync
    self.chunks =3D create_master_idx(self.chunks)
  File "/usr/lib/python3/dist-packages/borg/cache.py", line 786, in create_=
master_idx
    master_index_capacity =3D int(len(self.repository) / ChunkIndex.MAX_LOA=
D_FACTOR)
  File "/usr/lib/python3/dist-packages/borg/repository.py", line 1009, in _=
_len__
    self.index =3D self.open_index(self.get_transaction_id())
  File "/usr/lib/python3/dist-packages/borg/repository.py", line 376, in ge=
t_transaction_id
    self.check_transaction()
  File "/usr/lib/python3/dist-packages/borg/repository.py", line 365, in ch=
eck_transaction
    raise self.CheckNeeded(msg)
borg.repository.Repository.CheckNeeded: Inconsistency detected. Please run =
"borg check /mnt/smb/tmp/tmp" - although likely this is "beyond repair".

Platform: Linux hazard 5.12.0-19.2-liquorix-amd64 #1 ZEN SMP PREEMPT liquor=
ix 5.12-28.1~buster (2021-07-22) x86_64
Linux: debian 10.10
Borg: 1.1.9  Python: CPython 3.7.3
PID: 3320  CWD: /mnt/smb/tmp
sys.argv: ['/usr/bin/borg', 'init', '-e', 'none', 'tmp']
SSH_ORIGINAL_COMMAND: None

You can try repair this archive directory, but it didn't happend:

borg check tmp

Data integrity error: Invalid segment entry size 0 - too small [segment 1, =
offset 17]
Completed repository check, errors found.

On local filesystems, there is no problem, everythink works fine
- tested on ext4, JFS and XFS.

It seems, there is problem with caching of this filesystems?

Questions are welcome.

Sincerely
Jan Marek
--=20
Ing. Jan Marek
University of South Bohemia
Academic Computer Centre
Phone: +420389032080
http://www.gnu.org/philosophy/no-word-attachments.cs.html

--gyco445cfsle77ql
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQUTxPtzAjqwmJlmbXiFFMStj9tyQUCYRTDkQAKCRDiFFMStj9t
ydwfAP0Rm69vm5J+xlTIJuvpKPe8WOINfom5V3fXTYQNTiToXgEA375bdgzF9u13
7ro3xKiQwVV+M+y1wBa4jNPCq4JI5wU=
=WuzB
-----END PGP SIGNATURE-----

--gyco445cfsle77ql--
