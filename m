Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD68F41B66D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 20:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242116AbhI1ShS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 14:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhI1ShR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 14:37:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2E4C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 11:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=40bUCuVCFcd5OYLICpvhHEvyyz8Qm/qp260OS/gYGQ0=; b=ykmulKGnks2qJMCUT5QQV+RUcN
        P15CIbZLz7hZFkNt68V0WbZkVctDEVT1N5G745PB/gxXv4twLvNZy/jfQom0tXOLhrs4bnjBwvuev
        sLJXKa890pQRmTX0enOtaKxV5LinVzuK18o22D31WDQf0HhdumwRsmnBx8MP5vvp6wpCLj+W4Oaqs
        tMfHqvNqO6rHw4t1FVOZoyjPvhl35Iy0ReTlmuLi3tFhVljaIp/IEtaU/wQ5OaykaShDP0yZOveF4
        Rsm+lvOtLHw7hQXbC08oMCwkn7ibf+qA9uWHiINnLpc5wtBV7ArZb3LOjvmspv9WzAeJQp9zt+wET
        wbhtPBtw==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mVHx3-008Tq0-4h; Tue, 28 Sep 2021 18:35:37 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Aditya Srivastava <yashsri421@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v2] HSI: cmt_speech: unmark comments as kernel-doc
Date:   Tue, 28 Sep 2021 11:35:36 -0700
Message-Id: <20210928183536.30645-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build warnings from the kernel test robot:

drivers/hsi/clients/cmt_speech.c:831: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Block until pending data transfers have completed.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Aditya Srivastava <yashsri421@gmail.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
v2: Drop #Cc: Kai Vehmanen <kai.vehmanen@nokia.com> [bounce]
    Add Pavel's Ack.

 drivers/hsi/clients/cmt_speech.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20210928.orig/drivers/hsi/clients/cmt_speech.c
+++ linux-next-20210928/drivers/hsi/clients/cmt_speech.c
@@ -827,7 +827,7 @@ static int check_buf_params(struct cs_hs
 	return r;
 }
 
-/**
+/*
  * Block until pending data transfers have completed.
  */
 static int cs_hsi_data_sync(struct cs_hsi_iface *hi)
@@ -850,7 +850,7 @@ static int cs_hsi_data_sync(struct cs_hs
 			r = -ERESTARTSYS;
 			goto out;
 		}
-		/**
+		/*
 		 * prepare_to_wait must be called with hi->lock held
 		 * so that callbacks can check for waitqueue_active()
 		 */
