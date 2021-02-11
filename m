Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E38B319466
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 21:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbhBKUYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 15:24:24 -0500
Received: from mga17.intel.com ([192.55.52.151]:30262 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231546AbhBKUVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 15:21:46 -0500
IronPort-SDR: OH+ebiavPyO5RbtHJPyfogljTImlHTUJ3HMPANC6+l5RKuffhh3b/rtADj/Zc3ycqZLTWAidx1
 XTJLwSEnP4xg==
X-IronPort-AV: E=McAfee;i="6000,8403,9892"; a="162067834"
X-IronPort-AV: E=Sophos;i="5.81,171,1610438400"; 
   d="scan'208";a="162067834"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 12:21:31 -0800
IronPort-SDR: rDm1FDmo50dhhZRRAD7NqnJXakcKxngsGp1ZSvEU7MDcocy0szhndlsgbBR9zg5JthFxdLmlsO
 OM+Vt7o2kkbA==
X-IronPort-AV: E=Sophos;i="5.81,171,1610438400"; 
   d="scan'208";a="397591494"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 12:21:30 -0800
Subject: [PATCH] driver core: auxiliary bus: Remove unneeded module bits
From:   Dave Jiang <dave.jiang@intel.com>
To:     gregkh@linuxfoundation.org
Cc:     Dave Ertman <david.m.ertman@intel.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 11 Feb 2021 13:21:29 -0700
Message-ID: <161307488980.1896017.15627190714413338196.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove module bits in the auxiliary bus code since the auxiliary bus
cannot be built as a module and the relevant code is not needed.

Cc: Dave Ertman <david.m.ertman@intel.com>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/base/auxiliary.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
index d8b314e7d0fd..adc199dfba3c 100644
--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -265,8 +265,3 @@ void __init auxiliary_bus_init(void)
 {
 	WARN_ON(bus_register(&auxiliary_bus_type));
 }
-
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("Auxiliary Bus");
-MODULE_AUTHOR("David Ertman <david.m.ertman@intel.com>");
-MODULE_AUTHOR("Kiran Patil <kiran.patil@intel.com>");


