Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB2D40365F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 10:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348135AbhIHIwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 04:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348229AbhIHIwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 04:52:45 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10956C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 01:51:38 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so911674pjc.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 01:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R6vtjJKuC99IOQ3Le32jvxrKofdBfc7OwHyDPgzoYVk=;
        b=kZ+qdiAebk9G+RCLyExQQ6bRewCvw3egeTnLGG1PNJxaoIuA7oRuuP7rKZFsndMM9y
         rLxTdSXe3+zaCvqsMSh73Lr00hX/HCoYsyk3BIItZ7XSGG/nwh7yJPS5hN1MFlBV0+bR
         Bw5Y2ZLpLixU3vrjBt6+vGG/46gYAqtvrm+wU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R6vtjJKuC99IOQ3Le32jvxrKofdBfc7OwHyDPgzoYVk=;
        b=EOU+ZstnjNB2ZUUs9e/BdV7D7uv+/4/ks1VixoPySHY/E/maJVG/KyjcVsCJn0+UXv
         70Hp0x8LySFHAb144rYFEFsgaJ9Qtt5v3KiizaPrmOo81PvI2Rjh5B5C2gBdwm+DnDKi
         fMnGmvouhrT2CaGHZkgf/4tOzGG/SD/eBJtacjYkCkgqPqng57WCQyLJ/7uY46NyMGzR
         VtXTTpYWgs4HzZQaiXKUUmlD2k5Gl4b7SobiE4Ybg1/D3tw0jqosJA7t3zzy3Aj8v4X+
         4nQKw8B2Dx/paHBkW73u6qEOUeNcwqwjfIJC7T6lwXsKDYSzPMEnBDh0nDbsfV76xVfF
         xPsA==
X-Gm-Message-State: AOAM533zWVaSNt7YvRa9xnZCdk6j4/uQ+iYAEbjDixzJC90ZZQCe8otQ
        1yBrZo1DkMb+zEspUvMvxom8AQ==
X-Google-Smtp-Source: ABdhPJwrJTHmw7Jv/0SzR9fx4ZLySSxS0o/x1DDtehidKznPjYfIoxBJ7NQXoUt18U7WkZg3hlXjjQ==
X-Received: by 2002:a17:902:9b90:b029:12d:5ce1:4d99 with SMTP id y16-20020a1709029b90b029012d5ce14d99mr2283918plp.37.1631091097606;
        Wed, 08 Sep 2021 01:51:37 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:6939:f2f4:4be:bf22])
        by smtp.gmail.com with ESMTPSA id i7sm2116694pgd.56.2021.09.08.01.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 01:51:37 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] CHROMIUM: drivers: bluetooth: set up Qualcomm WCN399x for Android BQR commands
Date:   Wed,  8 Sep 2021 16:51:18 +0800
Message-Id: <20210908165017.v1.2.Ie2014b5e6ed62dee26015805cf9c9b00d8dc64e5@changeid>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
In-Reply-To: <20210908165017.v1.1.I17f57656757b83a1c0fb4b78525d8aca581725db@changeid>
References: <20210908165017.v1.1.I17f57656757b83a1c0fb4b78525d8aca581725db@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch sets up Qualcomm WCN399x to support the Android BQR commands.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

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

