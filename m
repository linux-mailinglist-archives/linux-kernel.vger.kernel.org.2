Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6700F44FD5A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 04:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbhKODIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 22:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbhKODIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 22:08:21 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330EBC061746;
        Sun, 14 Nov 2021 19:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=IMQeoZL0qGwZKQl++ld8piwgfGGupQVBvi8sKONISxs=; b=3ry5KtbwHJ57NfBbh0gvJTuCMv
        ZS5cRZ3twUKYFjFASPmk4G2i5InsIp2WJJ/OxdMeZLyCzcUnamv/YSgxJLyflnEvd7GnrldgxYJ+Q
        OLX/YtT0SGZv3n2Ccho/Z/lTWOAuXk2i7lpi2VQUlaN34sjo1vqwWk+szz4wCVTnJdofo6xN5WiP9
        HxLg351HBOWE1E7Rpzsn/We0JZQ185PjJ0QuNLgaxo4H+xi1vlPpXpxOwcuEzB87iaeIBeMS10sFE
        qdhmKyCh/0yAdTRiZ+LIVhwYx2pWDM8Tc7m+n91gqjd4Onox6gXOxUyV4O7ImrwzRZpY1VvbcHPhj
        nnsJd6xg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmSJ4-00EI7w-7n; Mon, 15 Nov 2021 03:05:18 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btmrvl_main: repair a non-kernel-doc comment
Date:   Sun, 14 Nov 2021 19:05:17 -0800
Message-Id: <20211115030517.17931-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not use "/**" to begin a non-kernel-doc comment.
Fixes this build warning:

drivers/bluetooth/btmrvl_main.c:2: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
---
 drivers/bluetooth/btmrvl_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20211102.orig/drivers/bluetooth/btmrvl_main.c
+++ linux-next-20211102/drivers/bluetooth/btmrvl_main.c
@@ -1,4 +1,4 @@
-/**
+/*
  * Marvell Bluetooth driver
  *
  * Copyright (C) 2009, Marvell International Ltd.
