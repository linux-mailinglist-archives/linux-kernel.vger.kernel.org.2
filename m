Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9234038A5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 13:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349213AbhIHLVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 07:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbhIHLVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 07:21:09 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95747C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 04:20:01 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id s29so1764375pfw.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 04:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Coy2eW1XyQHI0Kys17CdQehAZIVSSakTIxwVO2f+uuk=;
        b=ix7iuG6AMjXW4gtpi0mlq7XdWkNLJKw+27HLSTWoqCkn38ZqFuZWvO2p4u87CdJ06/
         IvQGdOkCOdrhd4R3yZ+gfSMX3eoNlJFTcHBH8KxuwbVDqqK+42HnUOkpuUUTrxKxbwQ1
         TXNQSxUUFS2ZT17aRGVRtsEcrtiV66t2TTnTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Coy2eW1XyQHI0Kys17CdQehAZIVSSakTIxwVO2f+uuk=;
        b=QHp3csP4oBpDOUc0jlbx8lX0VMv+1h9nX5691vJT0ISniRBGE3eBJUfmovNQId8jWA
         1v++U4F+V7TgiL0Kv0c38JouUNPJdHX+s18iP4c/fAtmmdc7Falmu0H4jvPTFY0L+XCY
         hxjWWuLAL8u79prDTYWYOX+TsXpwuLNtcYfj3ysAFk9g1P71KnldSYhbkBxPd9d3JSL5
         xtcEjRtdD2yaxGn5VdWH1wibrREND7Ur9XSGn7WR3yBChl003LsPWStM08zUiH9R3Xg6
         NsPhZqZkjGbAmJ9zDYouFuRoygstckb9OdQXpfO1zJk+NjvHan9hc3iXg73s4jzu/j1h
         XKrw==
X-Gm-Message-State: AOAM533X7EHEX4a5GgYJJ4blhiJxaM9qcYeVrNnzqj877B8Cm164Cxim
        bsSRhC4+4z7Jnbi6oDBWw6ugDw==
X-Google-Smtp-Source: ABdhPJw79A14sqmPxPpGF554ONNVKxU4Ccz7p0hqCDsDNCsj7Ug6QTvaEp1kipObIucWxMYDNen1Gg==
X-Received: by 2002:a05:6a00:14c4:b0:412:444e:f600 with SMTP id w4-20020a056a0014c400b00412444ef600mr3039154pfu.83.1631100001200;
        Wed, 08 Sep 2021 04:20:01 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:6939:f2f4:4be:bf22])
        by smtp.gmail.com with ESMTPSA id v6sm2160881pjr.41.2021.09.08.04.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 04:20:00 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] Bluetooth: hci_qca: Set up Qualcomm WCN399x for Android BQR commands
Date:   Wed,  8 Sep 2021 19:19:50 +0800
Message-Id: <20210908191915.v2.2.Ie2014b5e6ed62dee26015805cf9c9b00d8dc64e5@changeid>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
In-Reply-To: <20210908191915.v2.1.I17f57656757b83a1c0fb4b78525d8aca581725db@changeid>
References: <20210908191915.v2.1.I17f57656757b83a1c0fb4b78525d8aca581725db@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch sets up Qualcomm WCN399x to support the Android BQR commands.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

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
2.33.0.153.gba50c8fa24-goog

