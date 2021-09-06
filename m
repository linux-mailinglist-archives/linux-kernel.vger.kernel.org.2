Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB8240175E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 09:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240352AbhIFH43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 03:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240297AbhIFH42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 03:56:28 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02EAC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 00:55:23 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so3771831pjc.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 00:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Xf56OLSp+hppzWvWhEGSXjWhxDg/ErT9f349mtnYmE=;
        b=Tj/b5umNNUQO9OTj3KVUsNndVD9R/+79WMav7vc/xEFnF8t6aarL8lMZq2aqHDGjCK
         ccCjcuxmO+xSG+V1DpEK/wSnmGUtxvRS7In/KdYAdecRoFxbTVPjHkMJhX1og+8YJtaC
         OLziIHDZfUChb6k7TVrMezl5ZwtSGzqPzoYTQg4s2nYvNQyXISHO0HeOxBs6f8ad4BLt
         zQIqvCluOoylVSb2kc/zCJtLB4aF9PnF1gOhDpZ+nCqm2OsEIGsvyInV7GyNTUgoO+X1
         h1701OZ+VbZSUDUHA7PgUN50uYWh65fuh9owuw2BMzW/e2BF0BOAevtd8BEoSCpMPMaW
         f9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Xf56OLSp+hppzWvWhEGSXjWhxDg/ErT9f349mtnYmE=;
        b=BBxXChcpB9OW+pOWvUrDB94JWV4kKRW0Ghwl4vqUtYWyiD/WJ8PJ9p5nsBSsomzN1X
         rcSEBfrOLwr1zY6hDAdAULklAQmE7dvHuOTENfOfk3UDcn7C3hU1LcJbXI6+M4NCOcgd
         4vUtDd5kZ4c7m73BGykq/cHiti2SDbTt54uUDVeOPYg4YPdcqNIEe2zi2CjljitgAftI
         MllsyTz92dXN3pmCqEqlcys4YYNU8JYAHY07l86BwKFNT3XsASyKCAPo7GXdaELU2dEy
         Qqg7LIXyEJpaFHCSvdN7VLe71UdjIlE/PbJXPVAL1yngiDGN4oUjUD406DzU/O7/hE4u
         HCZg==
X-Gm-Message-State: AOAM533bcZGyBUG0r7/Wqgy/mt6Llbuq46EIW84lWiW3ZaIcUysmh00g
        Cs1HuTIaLCynHUPJqnurZYY=
X-Google-Smtp-Source: ABdhPJxd0pw9THgbbgqH1OA2JXyGSDCt9tbjRnSLlddXY9HZasP9LDEct/XwtdvVy+oXt3MppnsVUg==
X-Received: by 2002:a17:902:a503:b029:12b:2429:385e with SMTP id s3-20020a170902a503b029012b2429385emr9853168plq.64.1630914923382;
        Mon, 06 Sep 2021 00:55:23 -0700 (PDT)
Received: from localhost.localdomain ([111.207.172.18])
        by smtp.gmail.com with ESMTPSA id u10sm6789616pfn.147.2021.09.06.00.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 00:55:22 -0700 (PDT)
From:   zhaoxiao <long870912@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org
Cc:     hpa@zytor.com, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org,
        zhaoxiao <long870912@gmail.com>
Subject: [PATCH] x86: xen: platform-pci-unplug: use pr_err() and pr_warn() instead of raw printk()
Date:   Mon,  6 Sep 2021 15:55:16 +0800
Message-Id: <20210906075516.15066-1-long870912@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we have the nice helpers pr_err() and pr_warn(), use them instead
of raw printk().

Signed-off-by: zhaoxiao <long870912@gmail.com>
---
 arch/x86/xen/platform-pci-unplug.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/x86/xen/platform-pci-unplug.c b/arch/x86/xen/platform-pci-unplug.c
index 96d7f7d39cb9..6586eaf59c00 100644
--- a/arch/x86/xen/platform-pci-unplug.c
+++ b/arch/x86/xen/platform-pci-unplug.c
@@ -19,6 +19,8 @@
 #define XEN_PLATFORM_ERR_PROTOCOL -2
 #define XEN_PLATFORM_ERR_BLACKLIST -3
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 /* store the value of xen_emul_unplug after the unplug is done */
 static int xen_platform_pci_unplug;
 static int xen_emul_unplug;
@@ -30,13 +32,13 @@ static int check_platform_magic(void)
 
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
@@ -44,12 +46,12 @@ static int check_platform_magic(void)
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
 
@@ -155,12 +157,12 @@ void xen_unplug_emulated_devices(void)
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
@@ -200,7 +202,7 @@ static int __init parse_xen_emul_unplug(char *arg)
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

