Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6389359982
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 11:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbhDIJmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 05:42:16 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:54299 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbhDIJmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 05:42:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617961320; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=GhkW5Zg2f2g7C1BSTPmGT4t4CeZirppfzGYegJuxzqs=; b=ou2B56iRSGGJO0FhZHBtXrIIiityl0jACQncWPeyBZtKIUqWK1NDgVPCmIBZtAxnitS5e2Uj
 pKjDzC6pSb7PCITjpkhkNEn9EIi1n3T/4/wdbBDcutWKXLiAdUVIVfVbsLG3LVaZjf+8Ypw3
 VEssZSzdWoJQ2cEFfuhVaJ9+fXo=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 6070216687ce1fbb56961b96 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 09 Apr 2021 09:41:58
 GMT
Sender: hangl=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 619BEC43461; Fri,  9 Apr 2021 09:41:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from hangl-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hangl)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E0731C433CA;
        Fri,  9 Apr 2021 09:41:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E0731C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=hangl@codeaurora.org
From:   Hang Lu <hangl@codeaurora.org>
To:     tkjos@google.com, gregkh@linuxfoundation.org
Cc:     tkjos@android.com, maco@android.com, arve@android.com,
        joel@joelfernandes.org, christian@brauner.io, hridya@google.com,
        surenb@google.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, Hang Lu <hangl@codeaurora.org>
Subject: [PATCH 1/2] binder: fix the missing BR_FROZEN_REPLY in binder_return_strings
Date:   Fri,  9 Apr 2021 17:40:45 +0800
Message-Id: <1617961246-4502-2-git-send-email-hangl@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617961246-4502-1-git-send-email-hangl@codeaurora.org>
References: <1617961246-4502-1-git-send-email-hangl@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add BR_FROZEN_REPLY in binder_return_strings to support stat function.

Fixes: ae28c1be1e54 ("binder: BINDER_GET_FROZEN_INFO ioctl")
Signed-off-by: Hang Lu <hangl@codeaurora.org>
---
 drivers/android/binder.c          | 3 ++-
 drivers/android/binder_internal.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index e1a484a..be34da3 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -5559,7 +5559,8 @@ static const char * const binder_return_strings[] = {
 	"BR_FINISHED",
 	"BR_DEAD_BINDER",
 	"BR_CLEAR_DEATH_NOTIFICATION_DONE",
-	"BR_FAILED_REPLY"
+	"BR_FAILED_REPLY",
+	"BR_FROZEN_REPLY",
 };
 
 static const char * const binder_command_strings[] = {
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index 2872a7d..a507166 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -155,7 +155,7 @@ enum binder_stat_types {
 };
 
 struct binder_stats {
-	atomic_t br[_IOC_NR(BR_FAILED_REPLY) + 1];
+	atomic_t br[_IOC_NR(BR_FROZEN_REPLY) + 1];
 	atomic_t bc[_IOC_NR(BC_REPLY_SG) + 1];
 	atomic_t obj_created[BINDER_STAT_COUNT];
 	atomic_t obj_deleted[BINDER_STAT_COUNT];
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

