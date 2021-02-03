Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA5530DC21
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbhBCODS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:03:18 -0500
Received: from mga11.intel.com ([192.55.52.93]:52289 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232412AbhBCOBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:01:55 -0500
IronPort-SDR: hXWRG2tKTrhIRcbJH7pf2F/9JT+pl3DyT+6c/rhAHoTLUZYtuywvNRE3gHlQU4cS+BKUVxQwv3
 tYt7BHIqq/Lw==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="177535216"
X-IronPort-AV: E=Sophos;i="5.79,398,1602572400"; 
   d="scan'208";a="177535216"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 05:58:49 -0800
IronPort-SDR: qJ+pZ2CCgfSbZdLglje0WBUZhlXOJ2wWnPtNEh27fXOnUD+p9PZ8gX/hESE6I7Oq67eyvhc4Mq
 1kA/5cyexr9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,398,1602572400"; 
   d="scan'208";a="406659106"
Received: from nntpdsd52-183.inn.intel.com ([10.125.52.183])
  by fmsmga004.fm.intel.com with ESMTP; 03 Feb 2021 05:58:46 -0800
From:   Alexander Antonov <alexander.antonov@linux.intel.com>
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        namhyung@kernel.org, irogers@google.com, mingo@redhat.com,
        peterz@infradead.org, alexander.antonov@linux.intel.com
Subject: [PATCH v4 5/5] perf: Update .gitignore file
Date:   Wed,  3 Feb 2021 16:58:30 +0300
Message-Id: <20210203135830.38568-6-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210203135830.38568-1-alexander.antonov@linux.intel.com>
References: <20210203135830.38568-1-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After a "make -C tools/perf", git reports the following untracked file:
perf-iostat

Add this generated file to perf's .gitignore file.

Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
---
 tools/perf/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index bf1252dc2cb0..421f27e2b9af 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -19,6 +19,7 @@ perf.data.old
 output.svg
 perf-archive
 perf-with-kcore
+perf-iostat
 tags
 TAGS
 cscope*
-- 
2.19.1

