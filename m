Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE313B8DF5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 08:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbhGAHAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 03:00:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:38373 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234250AbhGAHAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 03:00:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10031"; a="230133377"
X-IronPort-AV: E=Sophos;i="5.83,313,1616482800"; 
   d="scan'208";a="230133377"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 23:58:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,313,1616482800"; 
   d="scan'208";a="476554428"
Received: from pg-vnc06.altera.com ([10.142.129.88])
  by fmsmga004.fm.intel.com with ESMTP; 30 Jun 2021 23:58:17 -0700
From:   Joyce Ooi <joyce.ooi@intel.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Joyce Ooi <joyce.ooi@intel.com>,
        Ley Foon Tan <lftan.linux@gmail.com>
Subject: [PATCH] MAINTAINERS: Replace Ley Foon Tan as Altera Mailbox maintainer
Date:   Thu,  1 Jul 2021 14:57:35 +0800
Message-Id: <20210701065735.159336-1-joyce.ooi@intel.com>
X-Mailer: git-send-email 2.13.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces Ley Foon Tan as Altera Mailbox maintainer as she has
moved to a different role.

Signed-off-by: Joyce Ooi <joyce.ooi@intel.com>
---
 MAINTAINERS |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 66d047d..b0258b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -792,7 +792,7 @@ F:	Documentation/devicetree/bindings/i2c/i2c-altera.txt
 F:	drivers/i2c/busses/i2c-altera.c
 
 ALTERA MAILBOX DRIVER
-M:	Ley Foon Tan <ley.foon.tan@intel.com>
+M:	Joyce Ooi <joyce.ooi@intel.com>
 S:	Maintained
 F:	drivers/mailbox/mailbox-altera.c
 
-- 
1.7.1

