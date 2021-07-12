Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8767E3C5BDB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 14:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbhGLMHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 08:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbhGLMHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 08:07:48 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CC4C0613E5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 05:05:00 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:f017:d84b:501f:cdd7])
        by laurent.telenet-ops.be with bizsmtp
        id UC4y250013dzGBx01C4ysE; Mon, 12 Jul 2021 14:04:58 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m2ugD-000YCi-Nk; Mon, 12 Jul 2021 14:04:57 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m2ugD-00HHcR-56; Mon, 12 Jul 2021 14:04:57 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: defconfig: Update defconfigs for v5.14-rc1:
Date:   Mon, 12 Jul 2021 14:04:56 +0200
Message-Id: <20210712120456.4119260-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  - Enable modular build of the new Netfilter base hook dump support,
  - Drop CONFIG_SCSI=y (selected by ATA, as enabled since commit
    b90257bfddbd01f3 ("m68k: use libata instead of the legacy ide
    driver")),
  - Disable CIFS_STATS2 (defaults to enabled since commit
    0d52df81e07739db ("cifs: enable extended stats by default")),
  - Enable modular build of the glob self-test (visible since commit
    b90257bfddbd01f3 ("m68k: use libata instead of the legacy ide
    driver")),
  - Drop CONFIG_TEST_LIST_SORT=m (auto-enabled since commit
    ebd09577be6c15ee ("lib/test: convert lib/test_list_sort.c to use
    KUnit")),
  - Enable modular build of the new test for the scanf() family of
    functions.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Perhaps we do want to keep the changed default for CONFIG_CIFS_STATS2?

To be queued in the m68k tree for v5.15.
---
 arch/m68k/configs/amiga_defconfig    | 6 ++++--
 arch/m68k/configs/apollo_defconfig   | 4 +++-
 arch/m68k/configs/atari_defconfig    | 6 ++++--
 arch/m68k/configs/bvme6000_defconfig | 4 +++-
 arch/m68k/configs/hp300_defconfig    | 4 +++-
 arch/m68k/configs/mac_defconfig      | 6 ++++--
 arch/m68k/configs/multi_defconfig    | 6 ++++--
 arch/m68k/configs/mvme147_defconfig  | 4 +++-
 arch/m68k/configs/mvme16x_defconfig  | 4 +++-
 arch/m68k/configs/q40_defconfig      | 6 ++++--
 arch/m68k/configs/sun3_defconfig     | 4 +++-
 arch/m68k/configs/sun3x_defconfig    | 4 +++-
 12 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index 0a2cacf7be08255c..5f536286f5fce88d 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -84,6 +84,7 @@ CONFIG_IPV6_ILA=m
 CONFIG_IPV6_VTI=m
 CONFIG_IPV6_GRE=m
 CONFIG_NETFILTER=y
+CONFIG_NETFILTER_NETLINK_HOOK=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_ZONES=y
 # CONFIG_NF_CONNTRACK_PROCFS is not set
@@ -323,7 +324,6 @@ CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_DUMMY_IRQ=m
 CONFIG_RAID_ATTRS=m
-CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=m
 CONFIG_BLK_DEV_SR=y
@@ -502,6 +502,7 @@ CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
 CONFIG_NFSD_V3=y
 CONFIG_CIFS=m
+# CONFIG_CIFS_STATS2 is not set
 # CONFIG_CIFS_DEBUG is not set
 CONFIG_CODA_FS=m
 CONFIG_NLS_CODEPAGE_437=y
@@ -616,6 +617,7 @@ CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC32_SELFTEST=m
 CONFIG_CRC64=m
 CONFIG_XZ_DEC_TEST=m
+CONFIG_GLOB_SELFTEST=m
 CONFIG_STRING_SELFTEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
@@ -624,7 +626,6 @@ CONFIG_WW_MUTEX_SELFTEST=m
 CONFIG_EARLY_PRINTK=y
 CONFIG_KUNIT=m
 CONFIG_KUNIT_ALL_TESTS=m
-CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_MIN_HEAP=m
 CONFIG_TEST_SORT=m
 CONFIG_TEST_DIV64=m
@@ -636,6 +637,7 @@ CONFIG_TEST_STRING_HELPERS=m
 CONFIG_TEST_STRSCPY=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
+CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index 4dc6dcfaf28ab323..d9568644051adb24 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -80,6 +80,7 @@ CONFIG_IPV6_ILA=m
 CONFIG_IPV6_VTI=m
 CONFIG_IPV6_GRE=m
 CONFIG_NETFILTER=y
+CONFIG_NETFILTER_NETLINK_HOOK=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_ZONES=y
 # CONFIG_NF_CONNTRACK_PROCFS is not set
@@ -458,6 +459,7 @@ CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
 CONFIG_NFSD_V3=y
 CONFIG_CIFS=m
+# CONFIG_CIFS_STATS2 is not set
 # CONFIG_CIFS_DEBUG is not set
 CONFIG_CODA_FS=m
 CONFIG_NLS_CODEPAGE_437=y
@@ -580,7 +582,6 @@ CONFIG_WW_MUTEX_SELFTEST=m
 CONFIG_EARLY_PRINTK=y
 CONFIG_KUNIT=m
 CONFIG_KUNIT_ALL_TESTS=m
-CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_MIN_HEAP=m
 CONFIG_TEST_SORT=m
 CONFIG_TEST_DIV64=m
@@ -592,6 +593,7 @@ CONFIG_TEST_STRING_HELPERS=m
 CONFIG_TEST_STRSCPY=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
+CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index ac57c699f03bfac7..55fa03710ccca852 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -87,6 +87,7 @@ CONFIG_IPV6_ILA=m
 CONFIG_IPV6_VTI=m
 CONFIG_IPV6_GRE=m
 CONFIG_NETFILTER=y
+CONFIG_NETFILTER_NETLINK_HOOK=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_ZONES=y
 # CONFIG_NF_CONNTRACK_PROCFS is not set
@@ -324,7 +325,6 @@ CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_DUMMY_IRQ=m
 CONFIG_RAID_ATTRS=m
-CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=m
 CONFIG_BLK_DEV_SR=y
@@ -491,6 +491,7 @@ CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
 CONFIG_NFSD_V3=y
 CONFIG_CIFS=m
+# CONFIG_CIFS_STATS2 is not set
 # CONFIG_CIFS_DEBUG is not set
 CONFIG_CODA_FS=m
 CONFIG_NLS_CODEPAGE_437=y
@@ -605,6 +606,7 @@ CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC32_SELFTEST=m
 CONFIG_CRC64=m
 CONFIG_XZ_DEC_TEST=m
+CONFIG_GLOB_SELFTEST=m
 CONFIG_STRING_SELFTEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
@@ -613,7 +615,6 @@ CONFIG_WW_MUTEX_SELFTEST=m
 CONFIG_EARLY_PRINTK=y
 CONFIG_KUNIT=m
 CONFIG_KUNIT_ALL_TESTS=m
-CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_MIN_HEAP=m
 CONFIG_TEST_SORT=m
 CONFIG_TEST_DIV64=m
@@ -625,6 +626,7 @@ CONFIG_TEST_STRING_HELPERS=m
 CONFIG_TEST_STRSCPY=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
+CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
index 2c3f428338469686..7620db3e33e7fabc 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -77,6 +77,7 @@ CONFIG_IPV6_ILA=m
 CONFIG_IPV6_VTI=m
 CONFIG_IPV6_GRE=m
 CONFIG_NETFILTER=y
+CONFIG_NETFILTER_NETLINK_HOOK=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_ZONES=y
 # CONFIG_NF_CONNTRACK_PROCFS is not set
@@ -451,6 +452,7 @@ CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
 CONFIG_NFSD_V3=y
 CONFIG_CIFS=m
+# CONFIG_CIFS_STATS2 is not set
 # CONFIG_CIFS_DEBUG is not set
 CONFIG_CODA_FS=m
 CONFIG_NLS_CODEPAGE_437=y
@@ -573,7 +575,6 @@ CONFIG_WW_MUTEX_SELFTEST=m
 CONFIG_EARLY_PRINTK=y
 CONFIG_KUNIT=m
 CONFIG_KUNIT_ALL_TESTS=m
-CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_MIN_HEAP=m
 CONFIG_TEST_SORT=m
 CONFIG_TEST_DIV64=m
@@ -585,6 +586,7 @@ CONFIG_TEST_STRING_HELPERS=m
 CONFIG_TEST_STRSCPY=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
+CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index 5b1898d4b249a467..113a02d47ebbfae9 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -79,6 +79,7 @@ CONFIG_IPV6_ILA=m
 CONFIG_IPV6_VTI=m
 CONFIG_IPV6_GRE=m
 CONFIG_NETFILTER=y
+CONFIG_NETFILTER_NETLINK_HOOK=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_ZONES=y
 # CONFIG_NF_CONNTRACK_PROCFS is not set
@@ -460,6 +461,7 @@ CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
 CONFIG_NFSD_V3=y
 CONFIG_CIFS=m
+# CONFIG_CIFS_STATS2 is not set
 # CONFIG_CIFS_DEBUG is not set
 CONFIG_CODA_FS=m
 CONFIG_NLS_CODEPAGE_437=y
@@ -582,7 +584,6 @@ CONFIG_WW_MUTEX_SELFTEST=m
 CONFIG_EARLY_PRINTK=y
 CONFIG_KUNIT=m
 CONFIG_KUNIT_ALL_TESTS=m
-CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_MIN_HEAP=m
 CONFIG_TEST_SORT=m
 CONFIG_TEST_DIV64=m
@@ -594,6 +595,7 @@ CONFIG_TEST_STRING_HELPERS=m
 CONFIG_TEST_STRSCPY=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
+CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index 9606ccd8dafa8956..a8e006e8da6688fc 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -78,6 +78,7 @@ CONFIG_IPV6_ILA=m
 CONFIG_IPV6_VTI=m
 CONFIG_IPV6_GRE=m
 CONFIG_NETFILTER=y
+CONFIG_NETFILTER_NETLINK_HOOK=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_ZONES=y
 # CONFIG_NF_CONNTRACK_PROCFS is not set
@@ -315,7 +316,6 @@ CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_DUMMY_IRQ=m
 CONFIG_RAID_ATTRS=m
-CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=m
 CONFIG_BLK_DEV_SR=y
@@ -482,6 +482,7 @@ CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
 CONFIG_NFSD_V3=y
 CONFIG_CIFS=m
+# CONFIG_CIFS_STATS2 is not set
 # CONFIG_CIFS_DEBUG is not set
 CONFIG_CODA_FS=m
 CONFIG_NLS_CODEPAGE_437=y
@@ -596,6 +597,7 @@ CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC32_SELFTEST=m
 CONFIG_CRC64=m
 CONFIG_XZ_DEC_TEST=m
+CONFIG_GLOB_SELFTEST=m
 CONFIG_STRING_SELFTEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
@@ -604,7 +606,6 @@ CONFIG_WW_MUTEX_SELFTEST=m
 CONFIG_EARLY_PRINTK=y
 CONFIG_KUNIT=m
 CONFIG_KUNIT_ALL_TESTS=m
-CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_MIN_HEAP=m
 CONFIG_TEST_SORT=m
 CONFIG_TEST_DIV64=m
@@ -616,6 +617,7 @@ CONFIG_TEST_STRING_HELPERS=m
 CONFIG_TEST_STRSCPY=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
+CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index 3175ba5007e1f5d2..b6655907a1f3cc3f 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -98,6 +98,7 @@ CONFIG_IPV6_ILA=m
 CONFIG_IPV6_VTI=m
 CONFIG_IPV6_GRE=m
 CONFIG_NETFILTER=y
+CONFIG_NETFILTER_NETLINK_HOOK=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_ZONES=y
 # CONFIG_NF_CONNTRACK_PROCFS is not set
@@ -344,7 +345,6 @@ CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_DUMMY_IRQ=m
 CONFIG_RAID_ATTRS=m
-CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=m
 CONFIG_BLK_DEV_SR=y
@@ -567,6 +567,7 @@ CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
 CONFIG_NFSD_V3=y
 CONFIG_CIFS=m
+# CONFIG_CIFS_STATS2 is not set
 # CONFIG_CIFS_DEBUG is not set
 CONFIG_CODA_FS=m
 CONFIG_NLS_CODEPAGE_437=y
@@ -681,6 +682,7 @@ CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC32_SELFTEST=m
 CONFIG_CRC64=m
 CONFIG_XZ_DEC_TEST=m
+CONFIG_GLOB_SELFTEST=m
 CONFIG_STRING_SELFTEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
@@ -689,7 +691,6 @@ CONFIG_WW_MUTEX_SELFTEST=m
 CONFIG_EARLY_PRINTK=y
 CONFIG_KUNIT=m
 CONFIG_KUNIT_ALL_TESTS=m
-CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_MIN_HEAP=m
 CONFIG_TEST_SORT=m
 CONFIG_TEST_DIV64=m
@@ -701,6 +702,7 @@ CONFIG_TEST_STRING_HELPERS=m
 CONFIG_TEST_STRSCPY=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
+CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
index 793085f00c99f551..563ba47db8c68dd0 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -76,6 +76,7 @@ CONFIG_IPV6_ILA=m
 CONFIG_IPV6_VTI=m
 CONFIG_IPV6_GRE=m
 CONFIG_NETFILTER=y
+CONFIG_NETFILTER_NETLINK_HOOK=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_ZONES=y
 # CONFIG_NF_CONNTRACK_PROCFS is not set
@@ -450,6 +451,7 @@ CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
 CONFIG_NFSD_V3=y
 CONFIG_CIFS=m
+# CONFIG_CIFS_STATS2 is not set
 # CONFIG_CIFS_DEBUG is not set
 CONFIG_CODA_FS=m
 CONFIG_NLS_CODEPAGE_437=y
@@ -572,7 +574,6 @@ CONFIG_WW_MUTEX_SELFTEST=m
 CONFIG_EARLY_PRINTK=y
 CONFIG_KUNIT=m
 CONFIG_KUNIT_ALL_TESTS=m
-CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_MIN_HEAP=m
 CONFIG_TEST_SORT=m
 CONFIG_TEST_DIV64=m
@@ -584,6 +585,7 @@ CONFIG_TEST_STRING_HELPERS=m
 CONFIG_TEST_STRSCPY=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
+CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
index 56fbac7943b2ee8c..9f1b44de4706e1b0 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -77,6 +77,7 @@ CONFIG_IPV6_ILA=m
 CONFIG_IPV6_VTI=m
 CONFIG_IPV6_GRE=m
 CONFIG_NETFILTER=y
+CONFIG_NETFILTER_NETLINK_HOOK=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_ZONES=y
 # CONFIG_NF_CONNTRACK_PROCFS is not set
@@ -451,6 +452,7 @@ CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
 CONFIG_NFSD_V3=y
 CONFIG_CIFS=m
+# CONFIG_CIFS_STATS2 is not set
 # CONFIG_CIFS_DEBUG is not set
 CONFIG_CODA_FS=m
 CONFIG_NLS_CODEPAGE_437=y
@@ -573,7 +575,6 @@ CONFIG_WW_MUTEX_SELFTEST=m
 CONFIG_EARLY_PRINTK=y
 CONFIG_KUNIT=m
 CONFIG_KUNIT_ALL_TESTS=m
-CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_MIN_HEAP=m
 CONFIG_TEST_SORT=m
 CONFIG_TEST_DIV64=m
@@ -585,6 +586,7 @@ CONFIG_TEST_STRING_HELPERS=m
 CONFIG_TEST_STRSCPY=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
+CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index 0e15431b65e2ac44..1993433d08406eeb 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -78,6 +78,7 @@ CONFIG_IPV6_ILA=m
 CONFIG_IPV6_VTI=m
 CONFIG_IPV6_GRE=m
 CONFIG_NETFILTER=y
+CONFIG_NETFILTER_NETLINK_HOOK=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_ZONES=y
 # CONFIG_NF_CONNTRACK_PROCFS is not set
@@ -314,7 +315,6 @@ CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_DUMMY_IRQ=m
 CONFIG_RAID_ATTRS=m
-CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=m
 CONFIG_BLK_DEV_SR=y
@@ -469,6 +469,7 @@ CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
 CONFIG_NFSD_V3=y
 CONFIG_CIFS=m
+# CONFIG_CIFS_STATS2 is not set
 # CONFIG_CIFS_DEBUG is not set
 CONFIG_CODA_FS=m
 CONFIG_NLS_CODEPAGE_437=y
@@ -583,6 +584,7 @@ CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC32_SELFTEST=m
 CONFIG_CRC64=m
 CONFIG_XZ_DEC_TEST=m
+CONFIG_GLOB_SELFTEST=m
 CONFIG_STRING_SELFTEST=m
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 CONFIG_MAGIC_SYSRQ=y
@@ -591,7 +593,6 @@ CONFIG_WW_MUTEX_SELFTEST=m
 CONFIG_EARLY_PRINTK=y
 CONFIG_KUNIT=m
 CONFIG_KUNIT_ALL_TESTS=m
-CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_MIN_HEAP=m
 CONFIG_TEST_SORT=m
 CONFIG_TEST_DIV64=m
@@ -603,6 +604,7 @@ CONFIG_TEST_STRING_HELPERS=m
 CONFIG_TEST_STRSCPY=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
+CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
index 3490a05f29b82d40..56dbc63cef5bc48b 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -74,6 +74,7 @@ CONFIG_IPV6_ILA=m
 CONFIG_IPV6_VTI=m
 CONFIG_IPV6_GRE=m
 CONFIG_NETFILTER=y
+CONFIG_NETFILTER_NETLINK_HOOK=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_ZONES=y
 # CONFIG_NF_CONNTRACK_PROCFS is not set
@@ -453,6 +454,7 @@ CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
 CONFIG_NFSD_V3=y
 CONFIG_CIFS=m
+# CONFIG_CIFS_STATS2 is not set
 # CONFIG_CIFS_DEBUG is not set
 CONFIG_CODA_FS=m
 CONFIG_NLS_CODEPAGE_437=y
@@ -574,7 +576,6 @@ CONFIG_TEST_LOCKUP=m
 CONFIG_WW_MUTEX_SELFTEST=m
 CONFIG_KUNIT=m
 CONFIG_KUNIT_ALL_TESTS=m
-CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_MIN_HEAP=m
 CONFIG_TEST_SORT=m
 CONFIG_TEST_DIV64=m
@@ -586,6 +587,7 @@ CONFIG_TEST_STRING_HELPERS=m
 CONFIG_TEST_STRSCPY=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
+CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index 4e92c8c332fc5f97..6bd1bba81ac32876 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -74,6 +74,7 @@ CONFIG_IPV6_ILA=m
 CONFIG_IPV6_VTI=m
 CONFIG_IPV6_GRE=m
 CONFIG_NETFILTER=y
+CONFIG_NETFILTER_NETLINK_HOOK=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_ZONES=y
 # CONFIG_NF_CONNTRACK_PROCFS is not set
@@ -452,6 +453,7 @@ CONFIG_ROOT_NFS=y
 CONFIG_NFSD=m
 CONFIG_NFSD_V3=y
 CONFIG_CIFS=m
+# CONFIG_CIFS_STATS2 is not set
 # CONFIG_CIFS_DEBUG is not set
 CONFIG_CODA_FS=m
 CONFIG_NLS_CODEPAGE_437=y
@@ -574,7 +576,6 @@ CONFIG_WW_MUTEX_SELFTEST=m
 CONFIG_EARLY_PRINTK=y
 CONFIG_KUNIT=m
 CONFIG_KUNIT_ALL_TESTS=m
-CONFIG_TEST_LIST_SORT=m
 CONFIG_TEST_MIN_HEAP=m
 CONFIG_TEST_SORT=m
 CONFIG_TEST_DIV64=m
@@ -586,6 +587,7 @@ CONFIG_TEST_STRING_HELPERS=m
 CONFIG_TEST_STRSCPY=m
 CONFIG_TEST_KSTRTOX=m
 CONFIG_TEST_PRINTF=m
+CONFIG_TEST_SCANF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_TEST_UUID=m
 CONFIG_TEST_XARRAY=m
-- 
2.25.1

