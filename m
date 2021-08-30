Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669083FB409
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 12:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236454AbhH3KqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 06:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236421AbhH3Kpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 06:45:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097FEC0617A8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 03:44:52 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630320290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=m6usKdrX8IxR3Iqz1D7AWqgHkFW5USFWmQfrLHHfk/g=;
        b=LK/HTXj6K40d+88fSuXGfBANMXKg+BbDXnjRehdegUMW6zoXQHZR0e2M4vY5Z0/IHdVNR4
        1CtXxmwWrE5QMgNnO/6kdH9VuMdVDiF23744cqta0V1DHSX6rEJzer3CSM+rZJfq7PucCq
        jSVdP3jty3+SKnFAaNMPw063bvlvkZ61/cMldhf3HCbJ+iKxIIu7PN+VMs0rlAnK7x2RGW
        DucgEqDQsN4DAxt2m4d62ekKHHEC5zLydT0jG08sUwdWqNslHTPdsNJomEdUutSY4519ot
        K5sl1a/pszyW4eeSfp0N8+wY3blvGy+6b5ku6Xhm0lUxm9T7Z0mhdYh9QjpLYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630320290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=m6usKdrX8IxR3Iqz1D7AWqgHkFW5USFWmQfrLHHfk/g=;
        b=sXdhK1sq377fkZ3Olp6yr9O0lR0wLVW7iQtwuROvktSWHFJqRvthqvuTQnA0UkZis5/oBT
        yAzLu6y+icAIE7DQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/misc for v5.15-rc1
References: <163031993120.58256.1250660796395121952.tglx@xen13.tec.linutronix.de>
Message-ID: <163031993985.58256.16849318566787748326.tglx@xen13.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 30 Aug 2021 12:44:50 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/misc branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-misc-2021-08=
-30

up to:  a729691b541f: x86/reboot: Limit Dell Optiplex 990 quirk to early BIOS=
 versions


A set of updates for the 86 reboot code:

  - Limit the Dell Optiplex 990 quirk to early BIOS versions to avoid the
    full 'power cycle' alike reboot which is required for the buggy BIOSes.

  - Update documentation for the reboot=3Dpci command line option and
    document how DMI platform quirks can be overridden.



Thanks,

	tglx

------------------>
Paul Gortmaker (3):
      x86/reboot: Document the "reboot=3Dpci" option
      x86/reboot: Document how to override DMI platform quirks
      x86/reboot: Limit Dell Optiplex 990 quirk to early BIOS versions


 Documentation/admin-guide/kernel-parameters.txt |  2 +-
 Documentation/x86/x86_64/boot-options.rst       | 11 ++++++++++-
 arch/x86/kernel/reboot.c                        |  3 ++-
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/=
admin-guide/kernel-parameters.txt
index bdb22006f713..34c8dd54518e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4777,7 +4777,7 @@
=20
 	reboot=3D		[KNL]
 			Format (x86 or x86_64):
-				[w[arm] | c[old] | h[ard] | s[oft] | g[pio]] \
+				[w[arm] | c[old] | h[ard] | s[oft] | g[pio]] | d[efault] \
 				[[,]s[mp]#### \
 				[[,]b[ios] | a[cpi] | k[bd] | t[riple] | e[fi] | p[ci]] \
 				[[,]f[orce]
diff --git a/Documentation/x86/x86_64/boot-options.rst b/Documentation/x86/x8=
6_64/boot-options.rst
index 5f62b3b86357..ccb7e86bf8d9 100644
--- a/Documentation/x86/x86_64/boot-options.rst
+++ b/Documentation/x86/x86_64/boot-options.rst
@@ -126,7 +126,7 @@ Idle loop
 Rebooting
 =3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-   reboot=3Db[ios] | t[riple] | k[bd] | a[cpi] | e[fi] [, [w]arm | [c]old]
+   reboot=3Db[ios] | t[riple] | k[bd] | a[cpi] | e[fi] | p[ci] [, [w]arm | [=
c]old]
       bios
         Use the CPU reboot vector for warm reset
       warm
@@ -145,6 +145,8 @@ Rebooting
         Use efi reset_system runtime service. If EFI is not configured or
         the EFI reset does not work, the reboot path attempts the reset using
         the keyboard controller.
+      pci
+        Use a write to the PCI config space register 0xcf9 to trigger reboot.
=20
    Using warm reset will be much faster especially on big memory
    systems because the BIOS will not go through the memory check.
@@ -155,6 +157,13 @@ Rebooting
      Don't stop other CPUs on reboot. This can make reboot more reliable
      in some cases.
=20
+   reboot=3Ddefault
+     There are some built-in platform specific "quirks" - you may see:
+     "reboot: <name> series board detected. Selecting <type> for reboots."
+     In the case where you think the quirk is in error (e.g. you have
+     newer BIOS, or newer board) using this option will ignore the built-in
+     quirk table, and use the generic default reboot actions.
+
 Non Executable Mappings
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index ebfb91108232..0a40df66a40d 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -388,10 +388,11 @@ static const struct dmi_system_id reboot_dmi_table[] __=
initconst =3D {
 	},
 	{	/* Handle problems with rebooting on the OptiPlex 990. */
 		.callback =3D set_pci_reboot,
-		.ident =3D "Dell OptiPlex 990",
+		.ident =3D "Dell OptiPlex 990 BIOS A0x",
 		.matches =3D {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 990"),
+			DMI_MATCH(DMI_BIOS_VERSION, "A0"),
 		},
 	},
 	{	/* Handle problems with rebooting on Dell 300's */

