Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECA33B2BDD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 11:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbhFXJ4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 05:56:23 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:46174 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbhFXJ4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 05:56:20 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 6439E1C0B79; Thu, 24 Jun 2021 11:54:00 +0200 (CEST)
Date:   Thu, 24 Jun 2021 11:53:59 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, intel-gfx@lists.freedesktop.org
Subject: 5.13-rc6 on thinkpad X220: graphics hangs with recent mainline
Message-ID: <20210624095359.GA29649@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'm getting graphics problems with 5.13-rc:

Debian 10.9, X, chromium and flightgear is in use. Things were more
stable than this with previous kernels.

Any ideas?

Best regards,
								Pavel

[185233.329693] wlp3s0: deauthenticated from 5c:f4:ab:10:d2:bb (Reason: 16=
=3DGROUP_KEY_HANDSHAKE_TIMEOUT)
[185234.040352] wlp3s0: authenticate with 5c:f4:ab:10:d2:bb
[185234.043836] wlp3s0: send auth to 5c:f4:ab:10:d2:bb (try 1/3)
[185234.046652] wlp3s0: authenticated
[185234.049087] wlp3s0: associate with 5c:f4:ab:10:d2:bb (try 1/3)
[185234.052667] wlp3s0: RX AssocResp from 5c:f4:ab:10:d2:bb (capab=3D0x411 =
status=3D0 aid=3D1)
[185234.055398] wlp3s0: associated
[185300.784992] i915 0000:00:02.0: [drm] Resetting chip for stopped heartbe=
at on rcs0
[185300.888694] i915 0000:00:02.0: [drm] fgfs[27370] context reset due to G=
PU hang
[185472.274563] usb 2-1.1: USB disconnect, device number 3
[185472.274578] usb 2-1.1.2: USB disconnect, device number 5
[185472.281518] hid-generic 0003:04F2:0111.0003: usb_submit_urb(ctrl) faile=
d: -19
[185472.299837] hid-generic 0003:04F2:0111.0003: usb_submit_urb(ctrl) faile=
d: -19
[185472.305986] hid-generic 0003:04F2:0111.0003: usb_submit_urb(ctrl) faile=
d: -19
[185472.328012] hid-generic 0003:04F2:0111.0003: usb_submit_urb(ctrl) faile=
d: -19
[185472.333738] usb 2-1.1.3: USB disconnect, device number 6
[185673.454821] usb 2-1.1: new high-speed USB device number 7 using ehci-pci
[185673.563486] usb 2-1.1: New USB device found, idVendor=3D1a40, idProduct=
=3D0101, bcdDevice=3D 1.11
[185673.563502] usb 2-1.1: New USB device strings: Mfr=3D0, Product=3D1, Se=
rialNumber=3D0
[185673.563509] usb 2-1.1: Product: USB 2.0 Hub
[185673.564488] hub 2-1.1:1.0: USB hub found
[185673.564595] hub 2-1.1:1.0: 4 ports detected
=2E..
[207277.385543] wlp3s0: deauthenticated from 5c:f4:ab:10:d2:bb (Reason: 16=
=3DGROUP_KEY_HANDSHAKE_TIMEOUT)
[207278.062061] wlp3s0: authenticate with 5c:f4:ab:10:d2:bb
[207278.068175] wlp3s0: send auth to 5c:f4:ab:10:d2:bb (try 1/3)
[207278.070985] wlp3s0: authenticated
[207278.075545] wlp3s0: associate with 5c:f4:ab:10:d2:bb (try 1/3)
[207278.080793] wlp3s0: RX AssocResp from 5c:f4:ab:10:d2:bb (capab=3D0x411 =
status=3D0 aid=3D1)
[207278.084081] wlp3s0: associated
[207564.046469] i915 0000:00:02.0: [drm] Resetting chip for stopped heartbe=
at on rcs0
[207564.150293] i915 0000:00:02.0: [drm] fgfs[25729] context reset due to G=
PU hang
[209075.178776] wlp3s0: deauthenticated from 5c:f4:ab:10:d2:bb (Reason: 16=
=3DGROUP_KEY_HANDSHAKE_TIMEOUT)
[209075.841872] wlp3s0: authenticate with 5c:f4:ab:10:d2:bb
[209075.845305] wlp3s0: send auth to 5c:f4:ab:10:d2:bb (try 1/3)
[209075.851186] wlp3s0: authenticated
[209075.852537] wlp3s0: associate with 5c:f4:ab:10:d2:bb (try 1/3)
[209075.855972] wlp3s0: RX AssocResp from 5c:f4:ab:10:d2:bb (capab=3D0x411 =
status=3D0 aid=3D1)
[209075.858522] wlp3s0: associated
[210159.723726] PM: suspend entry (deep)
[210159.741497] Filesystems sync: 0.017 seconds
[210159.743585] Freezing user space processes ... (elapsed 0.009 seconds) d=
one.
[210159.753345] OOM killer disabled.
[210159.753349] Freezing remaining freezable tasks ... (elapsed 0.003 secon=
ds) done.
[210159.757357] printk: Suspending console(s) (use no_console_suspend to de=
bug)
[210159.945365] sd 2:0:0:0: [sdb] Synchronizing SCSI cache
[210159.945443] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[210159.945651] sd 0:0:0:0: [sda] Stopping disk
[210159.947225] sd 2:0:0:0: [sdb] Stopping disk
[210160.019791] wlp3s0: deauthenticating from 5c:f4:ab:10:d2:bb by local ch=
oice (Reason: 3=3DDEAUTH_LEAVING)
[210160.021158] e1000e: EEE TX LPI TIMER: 00000011
[210161.245106] PM: suspend devices took 1.488 seconds
[210161.266601] ACPI: EC: interrupt blocked
[210161.305431] ACPI: Preparing to enter system sleep state S3
[210161.313532] ACPI: EC: event blocked
[210161.313535] ACPI: EC: EC stopped
[210161.313537] PM: Saving platform NVS memory
[210161.313548] Disabling non-boot CPUs ...
=2E..
[224698.957159] wlp3s0: associated
[229707.724067] wlp3s0: deauthenticated from 5c:f4:ab:10:d2:bb (Reason: 16=
=3DGROUP_KEY_HANDSHAKE_TIMEOUT)
[229708.370607] wlp3s0: authenticate with 5c:f4:ab:10:d2:bb
[229708.373732] wlp3s0: send auth to 5c:f4:ab:10:d2:bb (try 1/3)
[229708.376501] wlp3s0: authenticated
[229708.379997] wlp3s0: associate with 5c:f4:ab:10:d2:bb (try 1/3)
[229708.383773] wlp3s0: RX AssocResp from 5c:f4:ab:10:d2:bb (capab=3D0x411 =
status=3D0 aid=3D1)
[229708.386423] wlp3s0: associated
[229756.518759] i915 0000:00:02.0: [drm] Resetting chip for stopped heartbe=
at on rcs0
[229756.622596] i915 0000:00:02.0: [drm] fgfs[2648] context reset due to GP=
U hang

--=20
http://www.livejournal.com/~pavelmachek

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYNRWNwAKCRAw5/Bqldv6
8n4yAJ989SGpxrjxzHaH1f2PKCNVIuxQ4gCfeap8C3sLbT45u4y7vTmk1LpsGTM=
=l7gv
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
