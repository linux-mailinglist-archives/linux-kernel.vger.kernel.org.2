Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9925740855C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 09:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237667AbhIMHaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 03:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237645AbhIMHaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 03:30:02 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FB6C061766
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 00:28:46 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id w7so8606615pgk.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 00:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wzr/tDY+SZhvYSJPQ+K7kJlNJzjJfxAyxq+7vt2n+E8=;
        b=PapxB+4evxTDIxxsBZs5sP8wB4RESQHtmXbaiuABpZbRCivOVxFr/xnYn3ArvE2x45
         OkkT3PnMsDFTkOaZVqSgJa5Y27vFcvLL83iIUQfY6XO4XW2zayPuyH5wKFrHvZUva2DT
         5r154psCD4xPSSTD9vZmEwoY3Qikmhp9FVIQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wzr/tDY+SZhvYSJPQ+K7kJlNJzjJfxAyxq+7vt2n+E8=;
        b=bUktRS6V2STQW4Oegs0FMVVhX4Wly4gh1NpiuXLc4fVl/I0680RPRQIEg3kEKSzgeN
         vkWy4JuKxpekdTSec5ykalLQ19Pfssm2h62kiMX2+rJG0pi+5chr6RLaq7aBYQnDhaD3
         IZeRKhitQiYnjVED3wt6Cm3a7F7PAk+w055D3R/hYIt2fDwMSHarguUnbf/Z4I4McD1w
         h9u4bwoMj/Pbzo1ZhXAnd5lS992p/hcgZFXEjC1ulmp4l6k1md2uSL4YwMNR6jfr88jv
         +O8hcfvIdptrlo46GjHTKpDllbygsCXLTdsNpmbIPBBtzKsItgG+AcO4iTfApDIenPYl
         zDHg==
X-Gm-Message-State: AOAM53322D9Jutc8WZ0iSeDuPswhwSXUWvddcSOI2U7nGHyCMYdYAaFh
        rwYYVLIBn9uCEVS66ugw3GPdJg==
X-Google-Smtp-Source: ABdhPJzkKp9xe290AFmj3veLxm1mWg9pNLjagG+3eu2OWr86D1yuTxbIo9Td28dQqtVn/Ng8v60jVw==
X-Received: by 2002:a62:16c8:0:b0:43d:d6b8:f38 with SMTP id 191-20020a6216c8000000b0043dd6b80f38mr2948110pfw.9.1631518126387;
        Mon, 13 Sep 2021 00:28:46 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:b418:a601:c444:4951])
        by smtp.gmail.com with ESMTPSA id g8sm5688019pfv.51.2021.09.13.00.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 00:28:46 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] Bluetooth: hci_qca: Set up Qualcomm WCN399x for Android BQR commands
Date:   Mon, 13 Sep 2021 15:28:37 +0800
Message-Id: <20210913152801.v3.2.Ie2014b5e6ed62dee26015805cf9c9b00d8dc64e5@changeid>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
In-Reply-To: <20210913152801.v3.1.I17f57656757b83a1c0fb4b78525d8aca581725db@changeid>
References: <20210913152801.v3.1.I17f57656757b83a1c0fb4b78525d8aca581725db@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch sets up Qualcomm WCN399x to support the Android BQR commands.

Reported-by: kernel test robot <lkp@intel.com>

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

Changes in v3:
- Fix the auto build test ERROR
  "undefined symbol: btandroid_set_quality_report" that occurred
  with some kernel configs.

Changes in v2:
- Fix the title

 drivers/bluetooth/hci_qca.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 53deea2eb7b4..bf576046681d 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -38,6 +38,7 @@
 
 #include "hci_uart.h"
 #include "btqca.h"
+#include "btandroid.h"
 
 /* HCI_IBS protocol messages */
 #define HCI_IBS_SLEEP_IND	0xFE
@@ -1730,6 +1731,7 @@ static int qca_setup(struct hci_uart *hu)
 	if (qca_is_wcn399x(soc_type) ||
 	    qca_is_wcn6750(soc_type)) {
 		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
+		hdev->set_quality_report = btandroid_set_quality_report;
 
 		ret = qca_read_soc_version(hdev, &ver, soc_type);
 		if (ret)
-- 
2.33.0.309.g3052b89438-goog

