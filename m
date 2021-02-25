Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913B7325193
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 15:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhBYOfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 09:35:08 -0500
Received: from mga07.intel.com ([134.134.136.100]:51634 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229919AbhBYOeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 09:34:37 -0500
IronPort-SDR: VncrEkIW1CzjfwoGpcJt7Ew4mytvO7fQB+0LJO/+uZtfyY1G4nP3bKr/C/LyvLnhnvLoaN4E71
 bxpRq64k2J8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9905"; a="249599584"
X-IronPort-AV: E=Sophos;i="5.81,205,1610438400"; 
   d="scan'208";a="249599584"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2021 06:33:55 -0800
IronPort-SDR: 5hOqb448r80JPOcGcWTmbLuw32zVDPinUN8H55F5pcA9v166xEDX3WjDAYC7QQB4FWijIC9k+I
 XIDErPx4+5aw==
X-IronPort-AV: E=Sophos;i="5.81,205,1610438400"; 
   d="scan'208";a="404298979"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2021 06:33:53 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH] mtd: mtdcore: constify name param in mtd_bdi_init
Date:   Thu, 25 Feb 2021 16:33:29 +0200
Message-Id: <20210225143329.430012-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bdi name is not modified by the function, it should be const.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/mtd/mtdcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index db5167eacaa4..80fb69453ebe 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -2177,7 +2177,7 @@ static int mtd_proc_show(struct seq_file *m, void *v)
 /*====================================================================*/
 /* Init code */
 
-static struct backing_dev_info * __init mtd_bdi_init(char *name)
+static struct backing_dev_info * __init mtd_bdi_init(const char *name)
 {
 	struct backing_dev_info *bdi;
 	int ret;
-- 
2.26.2

