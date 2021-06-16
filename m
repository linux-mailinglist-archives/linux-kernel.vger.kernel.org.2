Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178143A8F8F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 05:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhFPDrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 23:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhFPDrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 23:47:16 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C273C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 20:45:10 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id h12so422866plf.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 20:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xMDlEjTyDZrlVyDA/lRWAdE9yXmdWHujrHlqXVP/rdY=;
        b=NHsaphg3BChOLEFUqwY9+YQvUH63qokrJ096TJK+wTHvDb1RNfZxz8XPCkb70j83E2
         FIAxoPinZsqaYSNDK6B0uR61qLe+2Fsz+3QljoHnNgcaPqq00D4ukuu+Inp1Ocdzv55I
         WYUFlQ6reZrq8hHxYH2110jAqTTdYfMOeZbsPLhPs9VrqYGAvqq6U1cZfPNwAM4A+/oA
         1NIUuJ64M/FhG0X1tMdxvuD0+c1HeOWoEvT8cfR92rgyofKQWVWHGqPmkNHt6WmK873N
         WsLFC9frxJYBTTz579Q8vVE8jM6HI17vVlmkvij/G6lBsNSdCVMPXd5YYAyxfb//Ta3n
         /X6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xMDlEjTyDZrlVyDA/lRWAdE9yXmdWHujrHlqXVP/rdY=;
        b=p0Gh4NzCOwoY9+XbWXWWpAyWt40PfazxqK6b9k+Cq2+OHiUilVSz9FsPrU6QnC7bHR
         QLDIbPcmxHJ95urGBJhLbvIg/1b8dWvLpCjXIMjxQBoVXGf4RR5oaeedt9TqrYIzznyR
         tTf1B6SAitpJ/xpJE+oD9lIgIHwiuzL8J1kWpcZjh5L1yFfiS8Hg9h9tdHF5NRslzWYY
         /hCBMgev+R43zMd0pkxteovyez6cZFvCC/iY3+588Vy6iVP5S1geg5Q5G0nwIsGwC17b
         khXjXQ+TZw9ZtxN0Sz20Y31AGYKb15NHQFj2nWbWHDToY5rqDsO/juJULpffvLOl280D
         W/xw==
X-Gm-Message-State: AOAM530EVt5LnUkUEO8W6tZ7t5jJ+JO8LDEW6pFt+ClE8qNu11VOHmIJ
        UiiMi87OR5op1oFRxVIUi/NbMA==
X-Google-Smtp-Source: ABdhPJwgwRNBWQ9XoVNFrjixuAX74f84/DppstUBXLF1gakcvSCXXSkiZ4ZX5fgFg9sMJiyXPchm2g==
X-Received: by 2002:a17:90b:1295:: with SMTP id fw21mr2703582pjb.147.1623815109994;
        Tue, 15 Jun 2021 20:45:09 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id s4sm528925pjn.31.2021.06.15.20.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 20:45:09 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Lars Ivar Miljeteig <lars.ivar.miljeteig@remarkable.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/3] regulator: sy7636a: Make regulator_desc static const
Date:   Wed, 16 Jun 2021 11:44:57 +0800
Message-Id: <20210616034458.3499522-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210616034458.3499522-1-axel.lin@ingics.com>
References: <20210616034458.3499522-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's only used in this file and never changed, make it static const.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/sy7636a-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/sy7636a-regulator.c b/drivers/regulator/sy7636a-regulator.c
index 54ab1be1001e..c71c0a007d95 100644
--- a/drivers/regulator/sy7636a-regulator.c
+++ b/drivers/regulator/sy7636a-regulator.c
@@ -53,7 +53,7 @@ static const struct regulator_ops sy7636a_vcom_volt_ops = {
 	.get_status = sy7636a_get_status,
 };
 
-struct regulator_desc desc = {
+static const struct regulator_desc desc = {
 	.name = "vcom",
 	.id = 0,
 	.ops = &sy7636a_vcom_volt_ops,
@@ -61,7 +61,7 @@ struct regulator_desc desc = {
 	.owner = THIS_MODULE,
 	.enable_reg = SY7636A_REG_OPERATION_MODE_CRL,
 	.enable_mask = SY7636A_OPERATION_MODE_CRL_ONOFF,
-	.poll_enabled_time	= SY7636A_POLL_ENABLED_TIME,
+	.poll_enabled_time = SY7636A_POLL_ENABLED_TIME,
 	.regulators_node = of_match_ptr("regulators"),
 	.of_match = of_match_ptr("vcom"),
 };
-- 
2.25.1

