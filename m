Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1BBD3FDD85
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 15:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244612AbhIAN4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 09:56:13 -0400
Received: from mga04.intel.com ([192.55.52.120]:2865 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232598AbhIAN4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 09:56:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10093"; a="216906150"
X-IronPort-AV: E=Sophos;i="5.84,369,1620716400"; 
   d="scan'208";a="216906150"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 06:55:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,369,1620716400"; 
   d="scan'208";a="541807065"
Received: from powerlab.fi.intel.com (HELO powerlab..) ([10.237.71.25])
  by fmsmga002.fm.intel.com with ESMTP; 01 Sep 2021 06:55:13 -0700
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org,
        Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH] tracing: synth events: increase max fields count
Date:   Wed,  1 Sep 2021 16:55:13 +0300
Message-Id: <20210901135513.3087062-1-dedekind1@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Sometimes it is useful to construct larger synthetic trace events. Increase
'SYNTH_FIELDS_MAX' (maximum number of fields in a synthetic event) from 32 to
64.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 kernel/trace/trace_synth.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_synth.h b/kernel/trace/trace_synth.h
index 4007fe95cf42..b29595fe3ac5 100644
--- a/kernel/trace/trace_synth.h
+++ b/kernel/trace/trace_synth.h
@@ -5,7 +5,7 @@
 #include "trace_dynevent.h"
 
 #define SYNTH_SYSTEM		"synthetic"
-#define SYNTH_FIELDS_MAX	32
+#define SYNTH_FIELDS_MAX	64
 
 #define STR_VAR_LEN_MAX		MAX_FILTER_STR_VAL /* must be multiple of sizeof(u64) */
 
-- 
2.31.1

