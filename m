Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F7D44FD7C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 04:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236729AbhKODeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 22:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236726AbhKODeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 22:34:18 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0151FC061746
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 19:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=f+ih54rkpqkynjNb9XKVa9oK6y3rvQTWCjJ+JZc70E8=; b=DhxIqvlv4/PMsP98vUTrV3WfTD
        L07Aa0NA+SMdhPmGMJpwtbgcWrDZ4kh0gUt58HOEjfQcSnJZwVp1ZW15fdLey4DfQ44Bx/Cv15yua
        +xgCxI6pwpvDzSgyP8TcQ2z1DE9RbcNld0tQ+Y0K/2s/v1OOtAKa4outTuCGGnCPa7+jq+wHyX2Nv
        83r74UZ9eTEAt2BIO8ZQMWlrWbx9SohMQlOOd+dNRUzIhaWKM5peV4Wl1TonKV04ZMm6QLvqLEN/u
        fF+KYcJDfTN60l3/LBIKi/YzbGWbd01TiEy0pV4gFjtNl43HGszid23ZvAjixcjWldHUB5JSmLGcG
        kbIPGewA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmSiG-00EJ9u-Kl; Mon, 15 Nov 2021 03:31:20 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Leo Yan <leo.yan@linaro.org>, Ruyi Wang <wangruyi@huawei.com>,
        Kaihua Zhong <zhongkaihua@huawei.com>
Subject: [PATCH] mailbox: hi3660: convert struct comments to kernel-doc notation
Date:   Sun, 14 Nov 2021 19:31:19 -0800
Message-Id: <20211115033119.11175-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert hi3660 struct comments to kernel-doc notation and fix
other kernel-doc warnings:

drivers/mailbox/hi3660-mailbox.c:47: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Hi3660 mailbox channel information
drivers/mailbox/hi3660-mailbox.c:62: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Hi3660 mailbox controller data
hi3660-mailbox.c:53: warning: contents before sections
hi3660-mailbox.c:67: warning: contents before sections

Fixes: 41c0e939d70d ("mailbox: Add support for Hi3660 mailbox")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Ruyi Wang <wangruyi@huawei.com>
Cc: Kaihua Zhong <zhongkaihua@huawei.com>
---
 drivers/mailbox/hi3660-mailbox.c |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

--- linux-next-20211102.orig/drivers/mailbox/hi3660-mailbox.c
+++ linux-next-20211102/drivers/mailbox/hi3660-mailbox.c
@@ -44,14 +44,13 @@
 #define MBOX_MSG_LEN			8
 
 /**
- * Hi3660 mailbox channel information
+ * struct hi3660_chan_info - Hi3660 mailbox channel information
+ * @dst_irq:	Interrupt vector for remote processor
+ * @ack_irq:	Interrupt vector for local processor
  *
  * A channel can be used for TX or RX, it can trigger remote
  * processor interrupt to notify remote processor and can receive
- * interrupt if has incoming message.
- *
- * @dst_irq:	Interrupt vector for remote processor
- * @ack_irq:	Interrupt vector for local processor
+ * interrupt if it has an incoming message.
  */
 struct hi3660_chan_info {
 	unsigned int dst_irq;
@@ -59,16 +58,15 @@ struct hi3660_chan_info {
 };
 
 /**
- * Hi3660 mailbox controller data
- *
- * Mailbox controller includes 32 channels and can allocate
- * channel for message transferring.
- *
+ * struct hi3660_mbox - Hi3660 mailbox controller data
  * @dev:	Device to which it is attached
  * @base:	Base address of the register mapping region
  * @chan:	Representation of channels in mailbox controller
  * @mchan:	Representation of channel info
  * @controller:	Representation of a communication channel controller
+ *
+ * Mailbox controller includes 32 channels and can allocate
+ * channel for message transferring.
  */
 struct hi3660_mbox {
 	struct device *dev;
