Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23753ED642
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 15:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240039AbhHPNTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 09:19:20 -0400
Received: from foss.arm.com ([217.140.110.172]:44114 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238575AbhHPNHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 09:07:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F6251FB;
        Mon, 16 Aug 2021 06:07:13 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.41.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 945273F66F;
        Mon, 16 Aug 2021 06:07:12 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, jolsa@kernel.org, linux-perf-users@vger.kernel.org
Cc:     James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] tools build: Fix feature detect clean for out of source builds
Date:   Mon, 16 Aug 2021 14:07:05 +0100
Message-Id: <20210816130705.1331868-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the clean target when using O= isn't cleaning the feature
detect output. This is because O= and OUTPUT= are set to canonical
paths. For example in tools/perf/Makefile:

  FULL_O := $(shell cd $(PWD); readlink -f $(O) || echo $(O))

This means that OUTPUT ends in a / and most usages prepend it to a file
without adding an extra /. This line that was changed adds an extra /
before the 'feature' folder but not to the end, resulting in a clean
command like this:

  rm -f /tmp/build//featuretest-all.bin ...

After the change the clean command looks like this:

  rm -f /tmp/build/feature/test-all.bin ...

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/build/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/build/Makefile b/tools/build/Makefile
index 5ed41b96fcde..6f11e6fc9ffe 100644
--- a/tools/build/Makefile
+++ b/tools/build/Makefile
@@ -32,7 +32,7 @@ all: $(OUTPUT)fixdep
 
 # Make sure there's anything to clean,
 # feature contains check for existing OUTPUT
-TMP_O := $(if $(OUTPUT),$(OUTPUT)/feature,./)
+TMP_O := $(if $(OUTPUT),$(OUTPUT)feature/,./)
 
 clean:
 	$(call QUIET_CLEAN, fixdep)
-- 
2.28.0

