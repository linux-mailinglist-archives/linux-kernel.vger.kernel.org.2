Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6234230AF4E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbhBASae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbhBASPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:15:30 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58FDC061220
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:14:18 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id j11so7861100plt.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PjnieVeYjaiReOFmA2WdsBKbhVRjBxoMWJClMRBvNZk=;
        b=tzoyyo4fGQkr6c887iXZVOMnx+ryZvntzpwBoxoqDh8tatuq8RXyaV7wzrd4d2WY5R
         bY5mKC7WQvtS1LoCBUACkgDweBuGdyMvF3s4J1+OwPIuIvqIHKGd4/hJ2x8V/7eyltC6
         qv2U+9cvs9L6r15jZjf5SmHK2o4yopin6LG+UdzX7Fk1vd7SqU+IUxsuxhBNJOer6Avh
         7svfdF9bYqzlXOqAnbZdrePB9CX83/YTejPKi8a76CGixhVJRmugx5VaZ9efHCMa60qi
         PwgkQIVBtAiowjBOV9WFUxQoPwCe6CKXmEmHhmKexPMqxBpBP1gMlbwtwKA9uL6k3nd8
         6I4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PjnieVeYjaiReOFmA2WdsBKbhVRjBxoMWJClMRBvNZk=;
        b=qWwY7tM0/O+cX8QB/06e9PRBgo2YVTwE8z4jSbPX6XU/zv74gf+w2bORY0w2kT5tA+
         eRRwL84QvfyBBrbmtuC908XJ7DC/yettYpaRHG0M2xugdYBmdEK2VbGL3KB1u4DHj29p
         wtRSrobogC2oMepUX0QbmQHKfFkoofJHsWASRe+sMnSiMI5te4ciyeu7jc9K+Gt/QFHz
         8AVI+2R5eoWhETEVVnIEjp12ME/Mqel7eKOiamrwnUjSbvEJUNT34zOsbUrqqMLU9GPB
         svX+LVXCpNykCPi4Fl0e6J4cy0akJ7CvYer/H9oIcSfplc97GGI+mrjt6kATZCJ4QN9Y
         FHEA==
X-Gm-Message-State: AOAM531UMRR8mlVfThmsF9w2B2bbFpxA4mo4xZGHXs7lIxunJO4+Yvti
        ilMBBvqtkTs5g2LLJvEL6Z4G8Q==
X-Google-Smtp-Source: ABdhPJx2K97OVJujZKHd1ou0m9ucAagyon1tPZtXb0yQuTNbNg1B2WTMRCdpSHs6WdMhECVA/ARwXQ==
X-Received: by 2002:a17:90a:ba08:: with SMTP id s8mr143205pjr.112.1612203258318;
        Mon, 01 Feb 2021 10:14:18 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e12sm75784pjj.23.2021.02.01.10.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 10:14:17 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 23/31] coresight: etm4x: Add necessary synchronization for sysreg access
Date:   Mon,  1 Feb 2021 11:13:43 -0700
Message-Id: <20210201181351.1475223-24-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
References: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

As per the specification any update to the TRCPRGCTLR must be synchronized
by a context synchronization event (in our case an explicist ISB) before
the TRCSTATR is checked.

Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20210110224850.1880240-22-suzuki.poulose@arm.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index a09a653fc5b0..8d644e93de51 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -284,6 +284,15 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 	/* Disable the trace unit before programming trace registers */
 	etm4x_relaxed_write32(csa, 0, TRCPRGCTLR);
 
+	/*
+	 * If we use system instructions, we need to synchronize the
+	 * write to the TRCPRGCTLR, before accessing the TRCSTATR.
+	 * See ARM IHI0064F, section
+	 * "4.3.7 Synchronization of register updates"
+	 */
+	if (!csa->io_mem)
+		isb();
+
 	/* wait for TRCSTATR.IDLE to go up */
 	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_IDLE_BIT, 1))
 		dev_err(etm_dev,
@@ -362,6 +371,10 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 	/* Enable the trace unit */
 	etm4x_relaxed_write32(csa, 1, TRCPRGCTLR);
 
+	/* Synchronize the register updates for sysreg access */
+	if (!csa->io_mem)
+		isb();
+
 	/* wait for TRCSTATR.IDLE to go back down to '0' */
 	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_IDLE_BIT, 0))
 		dev_err(etm_dev,
-- 
2.25.1

