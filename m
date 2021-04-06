Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3EC355F0C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 00:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344576AbhDFWur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 18:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344281AbhDFWu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 18:50:27 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA09C061762
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 15:50:19 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x22so21770763ybi.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 15:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=Oh9gQc9FxkOOr6m1SlSa7AzCZn8dzyUsrSaGNuqfpq4=;
        b=UXREyiJYnQipVxQ+Qy+sDhopb/Ly+Ghq7LDGBf8ODRndoTCOmZF30p4tHaYsRfLk0Q
         oWntMPoIzgJfWBKYTGKFlysQqT5HiT0T+xDHSVsARZDzvl2qHxsqARzXEXlxqq7kTWe8
         Ogwa4InQErV/XCC19e02tsvPCaHFrxtIWkhmqWIhYbjnosdu1cgCB88XoTDP1PukHHfl
         cDXr5pRM8nufyTEqZ8OTok82BSI+Nz5t7QTSzRMzrR8PzMWbkQg8TJRd1Xp5M9m1IkgO
         chRQ5c4NFrCgloZjliO/LX3Ve/W/PPL2jLku9kAMNd0sq5AmxwuEVQpcHIPUheKv79iL
         gfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=Oh9gQc9FxkOOr6m1SlSa7AzCZn8dzyUsrSaGNuqfpq4=;
        b=CQfNmmMd6dnpJMlHCjBFtrTqaBk94u/ppnP06HJcAtLEINBaBA8Yk1DVWll56Hhe+n
         y0u4tZixm1OtmNKsCQHM73ktt7IIzI2rFFPcRdKGgGdIGhhxTh+6fnJWza0e4syEHO7c
         REup7qd1TfaE8ifMgav9w1xmpq+01pVwVD9Bg4WevnhYJF7Zt7eEHT5Z0AiOxLGLCm6I
         bGLz1N37IjRvDeTk0BWmBD0A6x9j7aKeoYjVS4J835XYkqZrEkUAF5ZIVCnTYr1Ebhae
         BTQAG+2TVMD1mUXeLo9TV8F19MS9GLU5apoCpYCgOG5KK/BW6lVSqyPDTXaz+axNKQU2
         mI4A==
X-Gm-Message-State: AOAM532OsN074yhCRH1qKbZCliZMx68ZRyLlrAd6RjHcQrlTlBBc3zm3
        wDaMWw9il6igt1uCKqE2FiZ29i6OEjs=
X-Google-Smtp-Source: ABdhPJzy50MVzew6CiucoLtIec+dAe/cp5LYPaMjWfzHEfKrfAPLQiTmEDhRPyt08PaWtXLKFnHEFDKhbdY=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:24a1:90fb:182b:777c])
 (user=seanjc job=sendgmr) by 2002:a25:e004:: with SMTP id x4mr436617ybg.499.1617749418312;
 Tue, 06 Apr 2021 15:50:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  6 Apr 2021 15:49:50 -0700
In-Reply-To: <20210406224952.4177376-1-seanjc@google.com>
Message-Id: <20210406224952.4177376-7-seanjc@google.com>
Mime-Version: 1.0
References: <20210406224952.4177376-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v2 6/8] crypto: ccp: Use the stack and common buffer for
 status commands
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the dedicated status_cmd_buf and instead use a local variable for
PLATFORM_STATUS.  Now that the low level helper uses an internal buffer
for all commands, using the stack for the upper layers is safe even when
running with CONFIG_VMAP_STACK=y.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/crypto/ccp/sev-dev.c | 27 ++++++++++++---------------
 drivers/crypto/ccp/sev-dev.h |  1 -
 2 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index bb0d6de071e6..e54774b0d637 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -315,15 +315,14 @@ static int sev_platform_shutdown(int *error)
 
 static int sev_get_platform_state(int *state, int *error)
 {
-	struct sev_device *sev = psp_master->sev_data;
+	struct sev_user_data_status data;
 	int rc;
 
-	rc = __sev_do_cmd_locked(SEV_CMD_PLATFORM_STATUS,
-				 &sev->status_cmd_buf, error);
+	rc = __sev_do_cmd_locked(SEV_CMD_PLATFORM_STATUS, &data, error);
 	if (rc)
 		return rc;
 
-	*state = sev->status_cmd_buf.state;
+	*state = data.state;
 	return rc;
 }
 
@@ -361,15 +360,14 @@ static int sev_ioctl_do_reset(struct sev_issue_cmd *argp, bool writable)
 
 static int sev_ioctl_do_platform_status(struct sev_issue_cmd *argp)
 {
-	struct sev_device *sev = psp_master->sev_data;
-	struct sev_user_data_status *data = &sev->status_cmd_buf;
+	struct sev_user_data_status data;
 	int ret;
 
-	ret = __sev_do_cmd_locked(SEV_CMD_PLATFORM_STATUS, data, &argp->error);
+	ret = __sev_do_cmd_locked(SEV_CMD_PLATFORM_STATUS, &data, &argp->error);
 	if (ret)
 		return ret;
 
-	if (copy_to_user((void __user *)argp->data, data, sizeof(*data)))
+	if (copy_to_user((void __user *)argp->data, &data, sizeof(data)))
 		ret = -EFAULT;
 
 	return ret;
@@ -469,21 +467,20 @@ EXPORT_SYMBOL_GPL(psp_copy_user_blob);
 static int sev_get_api_version(void)
 {
 	struct sev_device *sev = psp_master->sev_data;
-	struct sev_user_data_status *status;
+	struct sev_user_data_status status;
 	int error = 0, ret;
 
-	status = &sev->status_cmd_buf;
-	ret = sev_platform_status(status, &error);
+	ret = sev_platform_status(&status, &error);
 	if (ret) {
 		dev_err(sev->dev,
 			"SEV: failed to get status. Error: %#x\n", error);
 		return 1;
 	}
 
-	sev->api_major = status->api_major;
-	sev->api_minor = status->api_minor;
-	sev->build = status->build;
-	sev->state = status->state;
+	sev->api_major = status.api_major;
+	sev->api_minor = status.api_minor;
+	sev->build = status.build;
+	sev->state = status.state;
 
 	return 0;
 }
diff --git a/drivers/crypto/ccp/sev-dev.h b/drivers/crypto/ccp/sev-dev.h
index e1572f408577..0fd21433f627 100644
--- a/drivers/crypto/ccp/sev-dev.h
+++ b/drivers/crypto/ccp/sev-dev.h
@@ -46,7 +46,6 @@ struct sev_device {
 	unsigned int int_rcvd;
 	wait_queue_head_t int_queue;
 	struct sev_misc_dev *misc;
-	struct sev_user_data_status status_cmd_buf;
 	struct sev_data_init init_cmd_buf;
 
 	u8 api_major;
-- 
2.31.0.208.g409f899ff0-goog

