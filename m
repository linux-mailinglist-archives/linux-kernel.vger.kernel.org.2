Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936A83F747C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 13:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240140AbhHYLmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 07:42:12 -0400
Received: from smtpbg702.qq.com ([203.205.195.102]:58847 "EHLO
        smtpproxy21.qq.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232199AbhHYLmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 07:42:07 -0400
X-QQ-mid: bizesmtp38t1629891673tm1qrncp
Received: from localhost.localdomain (unknown [124.126.19.250])
        by esmtp6.qq.com (ESMTP) with 
        id ; Wed, 25 Aug 2021 19:41:12 +0800 (CST)
X-QQ-SSF: 0140000000200040D000B00A0000000
X-QQ-FEAT: Me8y4DzRu2SGEc2zGWSKdHMwzN80H5FxPZB8ya1EUmPAG8RijeR4JVWKvb5qt
        bzs4cr9uOq8a9ePwol9hhFv0gY55bw3s3py/IjUFIn5vOSuj8Vd9XpZxK/K7dkX+IN6OyMW
        LQd3njIQJzvosvB5KG1/NB03ctmgv/7H/ZxGAw355rytzZqA/e8LW9+K/vxUoTCQacN3XAf
        bJ31DBrLWYxfRKzpnXnaEOnYKeAXmgWqxznU6+S+RzWIBfkEHrduCbqt7eINexuI4paJN8Z
        vo7fNtDAjyfa6iIuDXNUfpf1YpvAvQhKwWjljJQPZrBWtKreL+D7wjdcUz04RyxePNchxet
        nYP1qoHNr4+jzS+VnMZSrTlS83qM3ZKmg97j8af
X-QQ-GoodBg: 2
From:   zhaoxiao <zhaoxiao@uniontech.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org
Cc:     hpa@zytor.com, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org,
        zhaoxiao <zhaoxiao@uniontech.com>
Subject: [PATCH] x86: xen: platform-pci-unplug: use pr_err() and pr_warn() instead of raw printk()
Date:   Wed, 25 Aug 2021 19:41:11 +0800
Message-Id: <20210825114111.29009-1-zhaoxiao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we have the nice helpers pr_err() and pr_warn(), use them instead
of raw printk().

Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
---
 arch/x86/xen/platform-pci-unplug.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/x86/xen/platform-pci-unplug.c b/arch/x86/xen/platform-pci-unplug.c
index 96d7f7d39cb9..e84bff542539 100644
--- a/arch/x86/xen/platform-pci-unplug.c
+++ b/arch/x86/xen/platform-pci-unplug.c
@@ -19,6 +19,9 @@
 #define XEN_PLATFORM_ERR_PROTOCOL -2
 #define XEN_PLATFORM_ERR_BLACKLIST -3
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+
 /* store the value of xen_emul_unplug after the unplug is done */
 static int xen_platform_pci_unplug;
 static int xen_emul_unplug;
@@ -30,13 +33,13 @@ static int check_platform_magic(void)
 
 	magic = inw(XEN_IOPORT_MAGIC);
 	if (magic != XEN_IOPORT_MAGIC_VAL) {
-		printk(KERN_ERR "Xen Platform PCI: unrecognised magic value\n");
+		pr_err("Xen Platform PCI: unrecognised magic value\n");
 		return XEN_PLATFORM_ERR_MAGIC;
 	}
 
 	protocol = inb(XEN_IOPORT_PROTOVER);
 
-	printk(KERN_DEBUG "Xen Platform PCI: I/O protocol version %d\n",
+	pr_debug("Xen Platform PCI: I/O protocol version %d\n",
 			protocol);
 
 	switch (protocol) {
@@ -44,12 +47,12 @@ static int check_platform_magic(void)
 		outw(XEN_IOPORT_LINUX_PRODNUM, XEN_IOPORT_PRODNUM);
 		outl(XEN_IOPORT_LINUX_DRVVER, XEN_IOPORT_DRVVER);
 		if (inw(XEN_IOPORT_MAGIC) != XEN_IOPORT_MAGIC_VAL) {
-			printk(KERN_ERR "Xen Platform: blacklisted by host\n");
+			pr_err("Xen Platform: blacklisted by host\n");
 			return XEN_PLATFORM_ERR_BLACKLIST;
 		}
 		break;
 	default:
-		printk(KERN_WARNING "Xen Platform PCI: unknown I/O protocol version\n");
+		pr_warn("Xen Platform PCI: unknown I/O protocol version\n");
 		return XEN_PLATFORM_ERR_PROTOCOL;
 	}
 
@@ -155,12 +158,12 @@ void xen_unplug_emulated_devices(void)
 	 * been compiled for this kernel (modules or built-in are both OK). */
 	if (!xen_emul_unplug) {
 		if (xen_must_unplug_nics()) {
-			printk(KERN_INFO "Netfront and the Xen platform PCI driver have "
+			pr_info("Netfront and the Xen platform PCI driver have "
 					"been compiled for this kernel: unplug emulated NICs.\n");
 			xen_emul_unplug |= XEN_UNPLUG_ALL_NICS;
 		}
 		if (xen_must_unplug_disks()) {
-			printk(KERN_INFO "Blkfront and the Xen platform PCI driver have "
+			pr_info("Blkfront and the Xen platform PCI driver have "
 					"been compiled for this kernel: unplug emulated disks.\n"
 					"You might have to change the root device\n"
 					"from /dev/hd[a-d] to /dev/xvd[a-d]\n"
@@ -200,7 +203,7 @@ static int __init parse_xen_emul_unplug(char *arg)
 		else if (!strncmp(p, "never", l))
 			xen_emul_unplug |= XEN_UNPLUG_NEVER;
 		else
-			printk(KERN_WARNING "unrecognised option '%s' "
+			pr_warn("unrecognised option '%s' "
 				 "in parameter 'xen_emul_unplug'\n", p);
 	}
 	return 0;
-- 
2.20.1



