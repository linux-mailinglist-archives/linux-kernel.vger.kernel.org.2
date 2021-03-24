Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A04347F77
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 18:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237299AbhCXRem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 13:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237206AbhCXReK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 13:34:10 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9786BC0613E2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:34:10 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a7so34228749ejs.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sGXBjiCFdgwpvHzqPWC3/RPSg9lntmzEIWbK3MkoU6U=;
        b=V3k9oO55MjjZsX1qHzmUi4k1DuLQl/bW1r8/NSBz9AV1Y59ZREKF/pGfgheG7lx+v4
         ggpEUOSwS5OX9re9xERe7vz6yaR6zNOGOGIoxTjMzzSMe/9TDCqIJPIa+tq6f9xiDTP/
         MhFgQYSPl1ZFZzi7W2P7tpdnGXsyp1a5aUMRXu5o5SW3KHNDfQjSfYbHUoASovtIH/XS
         /8f4lsEyvKnASydlj2+jRntf/Onsc1qrDdsOJj4rJSrdV1F6Y+KsUZzns6e65XeuupoR
         HhVN5Rlwcx6YvF38ClCmMpvgRZdQV0NFa0wfXCKK79EkRefOifnO6VMA00c1onOviab4
         uNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sGXBjiCFdgwpvHzqPWC3/RPSg9lntmzEIWbK3MkoU6U=;
        b=A+UO6iJTtBEoAVeRjE3NDMsjnCcoOiXBJrGx7z1B+Lk4bpicnYvGXR/DxonqhBzrQu
         5DAtNjghSvaRaOhkYrZXugo7GrFNH3lbGfENrOtYt5R5w9ENVb2EDQc02Lu32uC6/SSc
         w0Qkt8Mg0dJzFBD5Qh6bD/oJu/A4xMU7XzJ2+/KWs+s5Porng82MzymlivCoRtyYkt7e
         ouca0V6eY2ZYfzci0lbAtD/EfkaJtq43soTUxqscxpXPPDkM1Gsc7Z43+IaXSyZR/+Gm
         Qs938ptWIJEcRouQxyxHF8I26CExXs5PCCz8IBChNC7IYXb+jbBufFuCVxWDN48GUuOY
         2uMQ==
X-Gm-Message-State: AOAM533c8Ja5UsZYdZ9Ui7tnmvTFnTmz3/i1hN9jQLc9gMVK/xnnmSok
        RubdCxL2N7tRDdTFszA6Tvtk7g==
X-Google-Smtp-Source: ABdhPJwCM4qapUK3Em/x+G38ky1Ltx5JRSDQ/uZ3IWpyDINUgpkRcfHgaHTT/NjdsDcbmFXyrEOHsw==
X-Received: by 2002:a17:906:f9db:: with SMTP id lj27mr4964835ejb.399.1616607249278;
        Wed, 24 Mar 2021 10:34:09 -0700 (PDT)
Received: from dell.default ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id p19sm1466367edr.57.2021.03.24.10.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 10:34:08 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 01/25] HID: intel-ish-hid: Remove unused variable 'err'
Date:   Wed, 24 Mar 2021 17:33:40 +0000
Message-Id: <20210324173404.66340-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210324173404.66340-1-lee.jones@linaro.org>
References: <20210324173404.66340-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/hid/intel-ish-hid/ishtp/client.c: In function ‘ishtp_cl_disconnect’:
 drivers/hid/intel-ish-hid/ishtp/client.c:266:6: warning: variable ‘err’ set but not used [-Wunused-but-set-variable]

Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/hid/intel-ish-hid/ishtp/client.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp/client.c b/drivers/hid/intel-ish-hid/ishtp/client.c
index 1cc157126fce7..c81a1f8a92685 100644
--- a/drivers/hid/intel-ish-hid/ishtp/client.c
+++ b/drivers/hid/intel-ish-hid/ishtp/client.c
@@ -263,7 +263,6 @@ EXPORT_SYMBOL(ishtp_cl_unlink);
 int ishtp_cl_disconnect(struct ishtp_cl *cl)
 {
 	struct ishtp_device *dev;
-	int err;
 
 	if (WARN_ON(!cl || !cl->dev))
 		return -ENODEV;
@@ -283,7 +282,7 @@ int ishtp_cl_disconnect(struct ishtp_cl *cl)
 		return -ENODEV;
 	}
 
-	err = wait_event_interruptible_timeout(cl->wait_ctrl_res,
+	wait_event_interruptible_timeout(cl->wait_ctrl_res,
 			(dev->dev_state != ISHTP_DEV_ENABLED ||
 			cl->state == ISHTP_CL_DISCONNECTED),
 			ishtp_secs_to_jiffies(ISHTP_CL_CONNECT_TIMEOUT));
-- 
2.27.0

