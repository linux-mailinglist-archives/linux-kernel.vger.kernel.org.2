Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417AF3D4040
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 20:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbhGWRp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 13:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhGWRp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 13:45:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3850C061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 11:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=FdJYjO8+QZ13HyTECNvwxjvmS4UXDVXSz+EmKnAnmlo=; b=ZXjxVszFNZf+Sk/EvHvXrLXRo5
        +2EDEs8U8OBE/2U3ClvUXJYOZTuDyLVc1x1/UIOMVBoW27mzKXg1GwOuBfrE9P133KaGvPfEP8sq8
        ubC6RytcKEdpLqaoIutDEBhrhcMwdErP2xSLd/Tr/fG1ykijtjhjOhksbRhhOuFpiFfTcwQu0RUT+
        ArrUxZYt3ZoDvUNsP8qWQophYvEOSlGBstBFF8B7PQXbJzxDFBAu3OmrO+aITCBa4MFMZwWKXZCjH
        fRMufJD1peRlArFCIAxLnvNgUyUF+9gjKUZUwpA/RsWbZ2BouoeUhk/00vzzFs1acX7gRA1Bml+mx
        fWrOEslQ==;
Received: from [2601:1c0:6280:3f0::aefb] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6zs0-005fyz-9a; Fri, 23 Jul 2021 18:26:00 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Aditya Srivastava <yashsri421@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH] mailbox: sti: quieten kernel-doc warnings
Date:   Fri, 23 Jul 2021 11:25:58 -0700
Message-Id: <20210723182558.13172-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kernel-doc struct notation for the mailbox structs to prevent
these kernel-doc warnings:

   drivers/mailbox/mailbox-sti.c:39: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * STi Mailbox device data
   drivers/mailbox/mailbox-sti.c:63: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * STi Mailbox platform specific configuration
   drivers/mailbox/mailbox-sti.c:74: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * STi Mailbox allocated channel information

Also move the field descriptions ahead of the function description as
is expected in kernel-doc. This prevents another kernel-doc warning.

Fixes: 9ef4546cbd7e ("mailbox: Add support for ST's Mailbox IP")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Aditya Srivastava <yashsri421@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>
CC: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Jassi Brar <jassisinghbrar@gmail.com>
---
 drivers/mailbox/mailbox-sti.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- linux-next-20210723.orig/drivers/mailbox/mailbox-sti.c
+++ linux-next-20210723/drivers/mailbox/mailbox-sti.c
@@ -36,12 +36,7 @@
 #define MBOX_BASE(mdev, inst)   ((mdev)->base + ((inst) * 4))
 
 /**
- * STi Mailbox device data
- *
- * An IP Mailbox is currently composed of 4 instances
- * Each instance is currently composed of 32 channels
- * This means that we have 128 channels per Mailbox
- * A channel an be used for TX or RX
+ * struct sti_mbox_device - STi Mailbox device data
  *
  * @dev:	Device to which it is attached
  * @mbox:	Representation of a communication channel controller
@@ -49,6 +44,11 @@
  * @name:	Name of the mailbox
  * @enabled:	Local copy of enabled channels
  * @lock:	Mutex protecting enabled status
+ *
+ * An IP Mailbox is currently composed of 4 instances
+ * Each instance is currently composed of 32 channels
+ * This means that we have 128 channels per Mailbox
+ * A channel an be used for TX or RX
  */
 struct sti_mbox_device {
 	struct device		*dev;
@@ -60,7 +60,7 @@ struct sti_mbox_device {
 };
 
 /**
- * STi Mailbox platform specific configuration
+ * struct sti_mbox_pdata - STi Mailbox platform specific configuration
  *
  * @num_inst:	Maximum number of instances in one HW Mailbox
  * @num_chan:	Maximum number of channel per instance
@@ -71,7 +71,7 @@ struct sti_mbox_pdata {
 };
 
 /**
- * STi Mailbox allocated channel information
+ * struct sti_channel - STi Mailbox allocated channel information
  *
  * @mdev:	Pointer to parent Mailbox device
  * @instance:	Instance number channel resides in
