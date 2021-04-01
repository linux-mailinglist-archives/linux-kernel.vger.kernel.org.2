Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CF83522DE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 00:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbhDAWpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 18:45:31 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:29743 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbhDAWpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 18:45:30 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617317130; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=A53yj3nIQFBVPr6/IX3KxkMn7wiNMdFKrKr0dqTJoro=; b=ENooTuWB5h4pCTW/RtfAPDTlZ4s5aZXjQu7CnTAxPuixohTwIrc6KGKSVuV9bcFjyPoDzBhl
 NX8XfXm1gBk1OZqsoaIdQ5G1rBwNfi6IWkTveJ8li/m/is7crijAEYbY02jau18nmpOK6RSG
 ewXPTuNRpc3yqLmTGqPzdRl3lM8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60664d028807bcde1d43dce1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 01 Apr 2021 22:45:22
 GMT
Sender: eberman=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BAFAFC433CA; Thu,  1 Apr 2021 22:45:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from eberman-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: eberman)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 939C8C433C6;
        Thu,  1 Apr 2021 22:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 939C8C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=eberman@codeaurora.org
From:   Elliot Berman <eberman@codeaurora.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     Elliot Berman <eberman@codeaurora.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Maennich <maennich@google.com>,
        Trilok Soni <tsoni@codeaurora.org>
Subject: [PATCH] Kbuild: Update config_data.gz only if KCONFIG_CONFIG materially changed
Date:   Thu,  1 Apr 2021 15:44:32 -0700
Message-Id: <1617317072-26770-1-git-send-email-eberman@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you update the timestamp of KCONFIG_CONFIG without actually changing
anything, config_data.gz is re-generated and causes vmlinux to re-link.
When Link Time Optimization is enabled, unnecessary re-linking of
vmlinux is highly desirable since it adds several minutes to build time.

Avoid touching config_data.gz by using filechk to compare the existing
config_data.gz and update only if it changed.

The .config can be touched, for instance, by a build script which
installs the default defconfig and then applies a defconfig fragment on
top.

For a simple example on my x86 machine, I modified x86 default defconfig to set
CONFIG_IKCONFIG=y and run:
  make -j50 defconfig tiny.config vmlinux
  make -j50 defconfig tiny.config vmlinux
With this patch, vmlinux is not re-built as a result of config_data.gz
change.

Signed-off-by: Elliot Berman <eberman@codeaurora.org>
---
 kernel/Makefile      | 2 +-
 scripts/Makefile.lib | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/Makefile b/kernel/Makefile
index 320f1f3..bd4e558 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -140,7 +140,7 @@ $(obj)/configs.o: $(obj)/config_data.gz
 
 targets += config_data.gz
 $(obj)/config_data.gz: $(KCONFIG_CONFIG) FORCE
-	$(call if_changed,gzip)
+	$(call filechk,gzip)
 
 $(obj)/kheaders.o: $(obj)/kheaders_data.tar.xz
 
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index a4fbaf8..81d3ec1 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -282,6 +282,8 @@ cmd_objcopy = $(OBJCOPY) $(OBJCOPYFLAGS) $(OBJCOPYFLAGS_$(@F)) $< $@
 quiet_cmd_gzip = GZIP    $@
       cmd_gzip = cat $(real-prereqs) | $(KGZIP) -n -f -9 > $@
 
+filechk_gzip = cat $(real-prereqs) | $(KGZIP) -n -f -9
+
 # DTC
 # ---------------------------------------------------------------------------
 DTC ?= $(objtree)/scripts/dtc/dtc
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

