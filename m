Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F8E416652
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 22:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243069AbhIWUFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 16:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243063AbhIWUFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 16:05:01 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61476C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 13:03:29 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id mv7-20020a17090b198700b0019c843e7233so5657805pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 13:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yfD/Eu1fl3QMahPGOmDm4yn6sa1SCJ9iJzXvakwFqm4=;
        b=WFvChYGm6vDhAbDZ95xiqbHbY4JZN19vdiqQy2OKeQi4J87WvOA+0/+6cqMqqyTgst
         FZXzB1Aaoy9yvENsgjg9vX9jTa6iOPGot9WqHjsIOeTCNcQHIAnPkHsEEk6oKTlan3mL
         AZXcmWre31qX/pLZH9SEc7CnLSwmV29nwRcBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yfD/Eu1fl3QMahPGOmDm4yn6sa1SCJ9iJzXvakwFqm4=;
        b=lIT7v9ckDaWdJJKfDPkptODFYyEmhfbnsd9P5+rplFtT8Mwp8LlR9TRGTSI4sSK6V1
         zMYNNvar/5hp3NFjfaJV+oal2TAHyKwlnQm7f+jaoycemf4+9+Q0jD3FmeiWm/dXfwwO
         pDqWVxZKjnnshze7pl3fjo1Z1pdPdXYHwoxyAdh4WtPo+Fivh8teSWPHL47LnuRoqTlu
         3UOhUIvORleMM46n56odcgdS2PkmfZlLCa7S6zS7pfBSSoGJ7gcWkuC4lnWW8pbN9HQg
         xe95W4f+6cVhDQrDTnDhf2NLe5SJPn2Z05Ponmrjz7BZ+zyMOdLGAOPc4tpFAc8/cWQR
         CApQ==
X-Gm-Message-State: AOAM531mBnBJWfKiQxL7zbY0PmeebIUmxApZIDlJvG1sLaAp/26lHs66
        ENM99NydwvPEd9JDPfcUxnoWxMOMphrkvw==
X-Google-Smtp-Source: ABdhPJxoWbxtd23KPnbEbjMy/t4WKwCJqAx6QQoJyFmh9kwxP4IQjraq/isoVnTl7bpfTvCPVgCxww==
X-Received: by 2002:a17:90a:928e:: with SMTP id n14mr4524488pjo.129.1632427408269;
        Thu, 23 Sep 2021 13:03:28 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:3a08:fd9c:cd23:fc38])
        by smtp.gmail.com with ESMTPSA id c22sm6258753pja.10.2021.09.23.13.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 13:03:27 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH] platform/chrome: cros-ec-typec: Cleanup use of check_features
Date:   Thu, 23 Sep 2021 13:03:21 -0700
Message-Id: <20210923200321.3623222-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cros_ec_check_features() now returns a boolean. Remove the double NOT
operator since it's not required anymore.

No functional changes are expected with this patch.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 262a891eded3..7b3afb6cda5d 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -1116,9 +1116,8 @@ static int cros_typec_probe(struct platform_device *pdev)
 	}
 
 	ec_dev = dev_get_drvdata(&typec->ec->ec->dev);
-	typec->typec_cmd_supported = !!cros_ec_check_features(ec_dev, EC_FEATURE_TYPEC_CMD);
-	typec->needs_mux_ack = !!cros_ec_check_features(ec_dev,
-							EC_FEATURE_TYPEC_MUX_REQUIRE_AP_ACK);
+	typec->typec_cmd_supported = cros_ec_check_features(ec_dev, EC_FEATURE_TYPEC_CMD);
+	typec->needs_mux_ack = cros_ec_check_features(ec_dev, EC_FEATURE_TYPEC_MUX_REQUIRE_AP_ACK);
 
 	ret = cros_typec_ec_command(typec, 0, EC_CMD_USB_PD_PORTS, NULL, 0,
 				    &resp, sizeof(resp));
-- 
2.33.0.685.g46640cef36-goog

