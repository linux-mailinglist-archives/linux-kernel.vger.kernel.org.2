Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9236C3F408B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 18:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbhHVQjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 12:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhHVQjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 12:39:21 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2043EC061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 09:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ba8p3NHduFboRwTPOHIS4Fa/8DzUP4/khcU64B14N20=; b=QYepBj3HdxeYhJL9nt2f4lv1yd
        lY2Jx1IMcIjXspjNtmaMuHZQs8o9Tv/xL0mNlohlpjFFgeEdMs6Yi3SkeDM9C0/J2CiJm8Mv/XRI/
        5A5jukfXeIAmUWwhZp+lEENouxLd7XGGJfq/RlKou/mLP90ddL0zuGhvfiNgYdXRVHiSuB9aFJUwI
        BubS4JFZ/XV5OTKPXl049NLQVrlUI6N5Jf82N2eUhGulVhNz0FsjpNhbdV0P9SIgiul2FwAUH25KL
        BytUcVfuaHyaCEG7onrOe5TlTGda2rW+UkmcHMNjoIXDChDdqPg4xrtWx5d7t4sF+BhhtoyzajWUj
        Ptve67fg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mHqUZ-00EMCd-Dm; Sun, 22 Aug 2021 16:38:39 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Aditya Srivastava <yashsri421@gmail.com>,
        Kai Vehmanen <kai.vehmanen@nokia.com>
Subject: [PATCH] HSI: cmt_speech: unmark comments as kernel-doc
Date:   Sun, 22 Aug 2021 09:38:38 -0700
Message-Id: <20210822163838.15964-1-rdunlap@infradead.org>
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
Cc: Kai Vehmanen <kai.vehmanen@nokia.com>
---
 drivers/hsi/clients/cmt_speech.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20210820.orig/drivers/hsi/clients/cmt_speech.c
+++ linux-next-20210820/drivers/hsi/clients/cmt_speech.c
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
