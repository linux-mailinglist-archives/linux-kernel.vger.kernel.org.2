Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682E94214D6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 19:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238135AbhJDRJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 13:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbhJDRJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 13:09:51 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D3BC061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 10:08:01 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 187so10665813pfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 10:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s/Yqng5x9YIQ0jYrqDwwVm+g+gndOeLDlhfdAlLYOg8=;
        b=DvpTjrnjHjDMkT6k9fgpECRbxkgfQf5s5IfSkZFWszVW/3b/qOXEENYGlVsypJi8Ka
         Y+yTFLo2hAfOyzvqll3/M/RYhDDYnt4IL86hllCMC/VZFzcrTj1YCtEX8EErpsCcpO3n
         ZjIqL2sNRXfAviTMiRXid+XkKELYNs440JOiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s/Yqng5x9YIQ0jYrqDwwVm+g+gndOeLDlhfdAlLYOg8=;
        b=Cd+so41R0ZQyhkOJiK3e5yCpZSL9eLtzO3v0wSaEz1y5cKrCf6Snj4ht8picG5RFce
         yeF0XaRgS9PbXkKbfKMBjvnDop1zXjcVfv/TKv7qQSe+kW+28d1/OeYOkYlKjKFByKlQ
         IMEmtzcbm7GjHrY1KCJCNI28WjFGzrv4mRFzxwrs6BWM849mnRM8HaMPqOonT/UIe9L5
         s4y62fj5d678u3sted+yezQYzL71UAO55PjDL48Tq/8Kp/nrsJg9cNYR4zKzO7izS0N3
         1wLYzcgdW1Z5gxBPjFtZ9QcsrcTh9/jrGtPLFwd12Q4YY4B8po/xpbvdgxMxiwmgPEiW
         Y/Sw==
X-Gm-Message-State: AOAM5308vhHeE5LxD59xIrgljKqVdiGeTPyF3djzPL6u1qlAYiNt/faC
        V+kdR3dHqJ7ZE16ZhkdG3OMr+JAkZXnFEg==
X-Google-Smtp-Source: ABdhPJw9dUAIXksRQ130Dkuy19XCegT0XGFcTjQp3jooGL0peSLdopGzkAZAIPnT6NnsAcvS2CFLUQ==
X-Received: by 2002:aa7:8c45:0:b0:43c:75ed:5b22 with SMTP id e5-20020aa78c45000000b0043c75ed5b22mr25739005pfd.79.1633367281253;
        Mon, 04 Oct 2021 10:08:01 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:6ec:eb98:83f9:f5b4])
        by smtp.gmail.com with ESMTPSA id x10sm14472027pfq.0.2021.10.04.10.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 10:08:00 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 2/2] platform/chrome: cros_ec_proto: Use ec_command for check_features
Date:   Mon,  4 Oct 2021 10:07:12 -0700
Message-Id: <20211004170716.86601-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
In-Reply-To: <20211004170716.86601-1-pmalani@chromium.org>
References: <20211004170716.86601-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the existing cros_ec_command() for cros_ec_check_features(). This
eliminates an unnecessary duplication of the memory allocation/free and
memory copy code.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_proto.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index b908cdd680e3..c4caf2e2de82 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -813,33 +813,19 @@ EXPORT_SYMBOL(cros_ec_get_host_event);
 bool cros_ec_check_features(struct cros_ec_dev *ec, int feature)
 {
 	struct ec_response_get_features *features = &ec->features;
-	struct cros_ec_command *msg;
 	int ret;
 
 	if (features->flags[0] == -1U && features->flags[1] == -1U) {
 		/* features bitmap not read yet */
-		msg = kzalloc(sizeof(*msg) + sizeof(*features), GFP_KERNEL);
-		if (!msg) {
-			dev_err(ec->dev, "failed to allocate memory to get EC features\n");
-			return false;
-		}
-
-		msg->command = EC_CMD_GET_FEATURES + ec->cmd_offset;
-		msg->insize = sizeof(*features);
-
-		ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
+		ret = cros_ec_command(ec->ec_dev, 0, EC_CMD_GET_FEATURES + ec->cmd_offset,
+				      NULL, 0, features, sizeof(*features));
 		if (ret < 0) {
-			dev_warn(ec->dev, "cannot get EC features: %d/%d\n",
-				 ret, msg->result);
+			dev_warn(ec->dev, "cannot get EC features: %d\n", ret);
 			memset(features, 0, sizeof(*features));
-		} else {
-			memcpy(features, msg->data, sizeof(*features));
 		}
 
 		dev_dbg(ec->dev, "EC features %08x %08x\n",
 			features->flags[0], features->flags[1]);
-
-		kfree(msg);
 	}
 
 	return !!(features->flags[feature / 32] & EC_FEATURE_MASK_0(feature));
-- 
2.33.0.800.g4c38ced690-goog

