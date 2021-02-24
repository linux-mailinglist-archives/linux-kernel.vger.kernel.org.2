Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75150323805
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 08:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbhBXHpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 02:45:13 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:34512 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230315AbhBXHpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 02:45:08 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614152688; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=x99euNNRJLLgAM+BgTQQDetLzkrbH3jmkzxNTvi0kBk=; b=oKhZMBBnTyWIWJJwMNiY69tThAdX3e/fr/uRtyt7c69jIvAHKimGhp+LycNLq7sYtP4bCDqt
 y6pY9hpi/bmOUyrhENOURZv6FyEWEYXSCASKL6LBv/hcfpVKPRGdxdXFslU9rOlwHEXaNsqb
 1PlSHMAA+ACeBYnoV6Qt+RFfdeE=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 603603f0ba08663830dd51c2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 24 Feb 2021 07:44:48
 GMT
Sender: mojha=qti.qualcomm.com@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 33088C43462; Wed, 24 Feb 2021 07:44:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mojha-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E9E9AC433C6;
        Wed, 24 Feb 2021 07:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E9E9AC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=qti.qualcomm.com
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mojha@qti.qualcomm.com
From:   Mukesh Ojha <mojha@qti.qualcomm.com>
To:     linux-kernel@vger.kernel.org
Cc:     keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, Huang Yiwei <hyiwei@codeaurora.org>,
        Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH 2/2] pstore: Add buffer start check during init
Date:   Wed, 24 Feb 2021 13:14:26 +0530
Message-Id: <1614152666-30137-2-git-send-email-mojha@qti.qualcomm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614152666-30137-1-git-send-email-mojha@qti.qualcomm.com>
References: <1614152666-30137-1-git-send-email-mojha@qti.qualcomm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Yiwei <hyiwei@codeaurora.org>

In a scenario of panic, when we use DRAM to store log instead
of persistant storage and during warm reset when we copy these
data outside of ram. Missing check on prz->start(write position)
can cause crash because it can be any value and can point outside
the mapped region. So add the start check to avoid.

Signed-off-by: Huang Yiwei <hyiwei@codeaurora.org>
Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
---
change in v2:
 - this is on top of first patchset.

 fs/pstore/ram_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index 0da012f..a15748a 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -514,7 +514,7 @@ static int persistent_ram_post_init(struct persistent_ram_zone *prz, u32 sig,
 	sig ^= PERSISTENT_RAM_SIG;
 
 	if (prz->buffer->sig == sig) {
-		if (buffer_size(prz) == 0) {
+		if (buffer_size(prz) == 0 && buffer_start(prz) == 0) {
 			pr_debug("found existing empty buffer\n");
 			return 0;
 		}
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

