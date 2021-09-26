Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC904186D9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 09:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhIZHJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 03:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbhIZHJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 03:09:37 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD51C061604
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 00:08:01 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id c4so9508767pls.6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 00:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SrwP2ShS2h50zXhgDpTauRMRNVTw9mBZJ1dbGK6KY/0=;
        b=WZjMDAuO/Xi35ye6CfouBkO1F2KmVL7s+JZ1xCZnhT6WPgRloF5Tvqx/pte/v9aLI1
         YBorUmXaHuFxP62zeAZxQneNu97K44PZzUlRPikwp6BrZShUl1j6kp2lzyOx8Alhun40
         5uSGGAGu0irnCU2DN+ycDzCEIcvogGMRJAVLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SrwP2ShS2h50zXhgDpTauRMRNVTw9mBZJ1dbGK6KY/0=;
        b=a/QJOHYwggLoM5br6VUnksbpqey6Bo0KSBMeozDaR9L16HTObVbj9bmqmrR85J+1Dv
         AvRPgrEEiL1dlIhUEnpRHDB79OofywIQNULp6hYPQz/vyi/vSdxwqMud2T1Rj8Eq8oEO
         bEHzRjrEyZ+z7gIr4pZBqOJG+lWTsTXOwX9D3EaQ5yCi4tmc5+o5d8axcAde2gH+TD7p
         rkFBPKe0lt4KEmsivCRbwi4kzH/0czU56CIhASTGyYWy11fSWAL3/+2/L//qmZvaj+LK
         JIRO+jyyXtWjc28jJRbKRvOefGATqFE48bd1UnLh9j7RuRKW7IL3p6AGsnT90heNxw47
         80eA==
X-Gm-Message-State: AOAM530DbfitHnD0G07owoB4wfL7lPQYIu2zbg22/4GL5dKmPYBDn53S
        MX413+30rLIRQyL+K5raOHz3r398uB6mKg==
X-Google-Smtp-Source: ABdhPJwGXxrcV/M268IELeB71DmoGPZly4RZOOOicWodSKhPCoK2HFuqtnX/c+NMSkIRNclP/BZN5w==
X-Received: by 2002:a17:90b:3145:: with SMTP id ip5mr12362908pjb.161.1632640081588;
        Sun, 26 Sep 2021 00:08:01 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:8152:3867:7050:3260])
        by smtp.gmail.com with ESMTPSA id o17sm13796174pfp.126.2021.09.26.00.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 00:08:01 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] Bluetooth: btrtl: enable Realtek 8822C/8852A to support AOSP extension
Date:   Sun, 26 Sep 2021 15:07:48 +0800
Message-Id: <20210926150657.v4.3.Iba6327b2544d1904bbcb17f369dcd3761b566153@changeid>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <20210926150657.v4.1.Iaa4a0269e51d8e8d8784a6ac8e05899b49a1377d@changeid>
References: <20210926150657.v4.1.Iaa4a0269e51d8e8d8784a6ac8e05899b49a1377d@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables Realtek 8822C and 8852A to support the AOSP
extension.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Joseph Hwang <josephsih@chromium.org>

---

Changes in v4:
- Call hci_set_aosp_capable in the driver.

Changes in v3:
- Fix the auto build test ERROR
  "undefined symbol: btandroid_set_quality_report" that occurred
  with some kernel configs.

Changes in v2:
- Fix the title

 drivers/bluetooth/btrtl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 1f8afa0244d8..5a1090b7c69a 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -746,6 +746,7 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
 	case CHIP_ID_8852A:
 		set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
 		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
+		hci_set_aosp_capable(hdev);
 		break;
 	default:
 		rtl_dev_dbg(hdev, "Central-peripheral role not enabled.");
-- 
2.33.0.685.g46640cef36-goog

