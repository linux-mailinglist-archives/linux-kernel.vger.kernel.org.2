Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58FBF3C9660
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 05:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbhGODTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 23:19:24 -0400
Received: from foss.arm.com ([217.140.110.172]:46052 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231854AbhGODTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 23:19:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E00B21042;
        Wed, 14 Jul 2021 20:16:28 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.214.103])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C43593F7D8;
        Wed, 14 Jul 2021 20:16:25 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>, nd@arm.com,
        Jia He <justin.he@arm.com>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Chen Lin <chen.lin5@zte.com.cn>, linux-usb@vger.kernel.org
Subject: [PATCH RFC 10/13] usb: gadget: simplify the printing with '%pD' specifier
Date:   Thu, 15 Jul 2021 11:15:30 +0800
Message-Id: <20210715031533.9553-11-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210715031533.9553-1-justin.he@arm.com>
References: <20210715031533.9553-1-justin.he@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the behavior of '%pD' is changed to print the full path of file,
the log printing in fsg_common_create_lun() can be simplified.

Given the space with proper length would be allocated in vprintk_store(),
it is worthy of dropping kmalloc()/kfree() to avoid additional space
allocation. The error case is well handled in d_path_unsafe(), the error
string would be copied in '%pD' buffer, no need to additionally handle
IS_ERR().

Cc: Felipe Balbi <balbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Chen Lin <chen.lin5@zte.com.cn>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Jia He <justin.he@arm.com>
---
 drivers/usb/gadget/function/f_mass_storage.c | 28 ++++++++------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
index 4a4703634a2a..04d4e8a0f6fd 100644
--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -2738,7 +2738,6 @@ int fsg_common_create_lun(struct fsg_common *common, struct fsg_lun_config *cfg,
 			  const char **name_pfx)
 {
 	struct fsg_lun *lun;
-	char *pathbuf, *p;
 	int rc = -ENOMEM;
 
 	if (id >= ARRAY_SIZE(common->luns))
@@ -2790,22 +2789,17 @@ int fsg_common_create_lun(struct fsg_common *common, struct fsg_lun_config *cfg,
 			goto error_lun;
 	}
 
-	pathbuf = kmalloc(PATH_MAX, GFP_KERNEL);
-	p = "(no medium)";
-	if (fsg_lun_is_open(lun)) {
-		p = "(error)";
-		if (pathbuf) {
-			p = file_path(lun->filp, pathbuf, PATH_MAX);
-			if (IS_ERR(p))
-				p = "(error)";
-		}
-	}
-	pr_info("LUN: %s%s%sfile: %s\n",
-	      lun->removable ? "removable " : "",
-	      lun->ro ? "read only " : "",
-	      lun->cdrom ? "CD-ROM " : "",
-	      p);
-	kfree(pathbuf);
+	if (fsg_lun_is_open(lun))
+		pr_info("LUN: %s%s%sfile: %pD\n",
+			lun->removable ? "removable " : "",
+			lun->ro ? "read only " : "",
+			lun->cdrom ? "CD-ROM " : "",
+			lun->filp);
+	else
+		pr_info("LUN: %s%s%sfile: (no medium)\n",
+			lun->removable ? "removable " : "",
+			lun->ro ? "read only " : "",
+			lun->cdrom ? "CD-ROM " : "");
 
 	return 0;
 
-- 
2.17.1

