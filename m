Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660403942CB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 14:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbhE1Mnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 08:43:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42495 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbhE1Mns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 08:43:48 -0400
Received: from mail-ua1-f70.google.com ([209.85.222.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lmboa-0007xh-IZ
        for linux-kernel@vger.kernel.org; Fri, 28 May 2021 12:42:12 +0000
Received: by mail-ua1-f70.google.com with SMTP id v20-20020ab076940000b029020b0b4ada34so1857642uaq.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 05:42:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5rn4epAcNH1Mik4gARYYfuC/XhUWwqVwYBKCtmf4Gqs=;
        b=Pm2o4BOcuPMgFTpMDmciFDlhX2BQApx8jxguenJX5+yCt6KW++1+AyihSuDx+w8ma1
         eIfb1QEnZS6ueQ2Xqx63ZzWyUjFvXE+1s9D9IFc4Bdd3fa61zXpBhKpsN83GrGxuqAEq
         Kli4W+2YIDwfAJXqsF4FwfDhhsSFzrZURLSgEg5tkg3Y874UIwQLBPUzBb1YBg3Iiw1v
         57AXf4eAz1bqLwvixC9+5AGrT7nDhIQE7S9cl2gqKNG35NqmoMLyvZF2rh1/+r4hO9nx
         S1j/mDZ6qxjGYw+xbb4M+GoSfFqUR6YDvmleurDYxJBkLDZ0sX3Ob9PJwOMDHEakgc2K
         sF7A==
X-Gm-Message-State: AOAM530iDN5cd+g58an7nkfXw0Mfu3grX/LWr6p+hSJyaOCyAk4NNUyY
        In4vR+T3Gkba18bOVHd+4Crij/CPKLDW5ZkvHrUb1BPmYuLShUE3dqRlmMJ3AQv3O4R+m4cI8LZ
        MOSgfQ68dyW0cZsvKYd4hjP6KDM26BExx/rDRPSclDw==
X-Received: by 2002:a67:f489:: with SMTP id o9mr6659009vsn.47.1622205731738;
        Fri, 28 May 2021 05:42:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7U4c+zsR2eMX8uGtXZTl5loFQdOdjHKdIFeosX2oE3JmTuGdnSEfaAP46EceGx8B3kXxW1A==
X-Received: by 2002:a67:f489:: with SMTP id o9mr6658995vsn.47.1622205731595;
        Fri, 28 May 2021 05:42:11 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.6])
        by smtp.gmail.com with ESMTPSA id b35sm782328uae.20.2021.05.28.05.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:42:11 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/12] nfc: port100: correct kerneldoc for structure
Date:   Fri, 28 May 2021 08:41:51 -0400
Message-Id: <20210528124200.79655-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210528124200.79655-1-krzysztof.kozlowski@canonical.com>
References: <20210528124200.79655-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The port100_in_rf_setting structure does not contain valid kerneldoc
docummentation, unlike the port100_tg_rf_setting structure.  Correct the
kerneldoc to fix W=1 warnings:

    warning: This comment starts with '/**', but isn't a kernel-doc comment.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/port100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nfc/port100.c b/drivers/nfc/port100.c
index 8e4d355dc3ae..4df926cc37d0 100644
--- a/drivers/nfc/port100.c
+++ b/drivers/nfc/port100.c
@@ -94,7 +94,7 @@ struct port100;
 typedef void (*port100_send_async_complete_t)(struct port100 *dev, void *arg,
 					      struct sk_buff *resp);
 
-/**
+/*
  * Setting sets structure for in_set_rf command
  *
  * @in_*_set_number: Represent the entry indexes in the port-100 RF Base Table.
@@ -145,7 +145,7 @@ static const struct port100_in_rf_setting in_rf_settings[] = {
 };
 
 /**
- * Setting sets structure for tg_set_rf command
+ * struct port100_tg_rf_setting - Setting sets structure for tg_set_rf command
  *
  * @tg_set_number: Represents the entry index in the port-100 RF Base Table.
  *                 This table contains multiple RF setting sets required for RF
-- 
2.27.0

