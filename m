Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D306357144
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 18:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354002AbhDGQAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 12:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353984AbhDGQAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 12:00:19 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA0AC061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 09:00:10 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id p12so9389300pgj.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 09:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FpGDn90rLRqvjylyUXsuVuzgr2YncycP+0/YC/QC/Z0=;
        b=XkjF2CMPupoN0eFZkNHoqIno2zmWby0YtLxSp3/EaAqm30A1VKL/u8q2ZivpUtsWTB
         LfMORj9l140LBZLPDCE9/bxQqklhnqsfA+1z6eqMUXHhxFQvp+fU8dZuRbloM7V9NUuk
         3bNWuFOOqa1zhGtAYLYZmG/rS30A773oGTy37wDSFl4wJvzePO99H+oamujUca/FmEVB
         EXnwGnkXzuVJjMzHKqU3l4Ydf1De9g7IypxXlD74l5Q7vxYwyfCA/Kncs7wMfz2x4rJ1
         fvPczvyFASFMDV8Ig3xUuguDVch0eff14/lXnlh2YG+qp5tk8fdhjeKoKveSB7lsL0Nz
         FOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FpGDn90rLRqvjylyUXsuVuzgr2YncycP+0/YC/QC/Z0=;
        b=V8kLSjVXfdQ2TvxDo/a+KNNPsHNzLxl4po8aeGu2QejK5MaN0fIxOsp5191eqpB4yG
         f0xY248VBN4miKcJbPxaFs5ETF9GPw/WvFC8y2LW+7SuQ1ecGceA/os4kDbybXDO+edB
         5IdnQrlOrDgGQeojJiLMlltTGrbQL2a/Ru9WD3jtQ/BSEiM2l6Kr9lgLkdWtq2QIeSul
         EyzS4ysI08yKebiqxr4BFH8vh+UTXQVjImMaGwk32f+ZDtzdWPH6yGdVlWBmxjIDPpIk
         Ptl/PVcTcgRiTtbVpeCZIClNr1w59xFZVHXGDyGMLzHQAz0jwwh1YEB1SHqwZwcgKZtE
         0ZQw==
X-Gm-Message-State: AOAM530rjVw43Uo9+1ecR2F0GVlIaRbI1RCKPrZ7dAU1c9Lyuiq/M8fA
        SUI+POrM5l/Kz2ksPKwwj6aV1A==
X-Google-Smtp-Source: ABdhPJySzp86JNtE8rAOrTeTgC09Rq4fRGkwBDrDs+mpT3sJeV71xRugl6KcmvnoeTkGpoisRmqkSQ==
X-Received: by 2002:aa7:858e:0:b029:1f1:5df2:1f70 with SMTP id w14-20020aa7858e0000b02901f15df21f70mr3479831pfn.46.1617811209756;
        Wed, 07 Apr 2021 09:00:09 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id s22sm21464713pfe.150.2021.04.07.09.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 09:00:09 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] coresight: etm4x: Add ETM PID for Cortex-A78
Date:   Wed,  7 Apr 2021 10:00:04 -0600
Message-Id: <20210407160007.418053-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210407160007.418053-1-mathieu.poirier@linaro.org>
References: <20210407160007.418053-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

Add ETM PID for Cortex-A78 to the list of supported ETMs.

Link: https://lore.kernel.org/r/20210213112829.26834-1-saiprakash.ranjan@codeaurora.org
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 15016f757828..a5b13a7779c3 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1951,6 +1951,7 @@ static const struct amba_id etm4_ids[] = {
 	CS_AMBA_UCI_ID(0x000bbd05, uci_id_etm4),/* Cortex-A55 */
 	CS_AMBA_UCI_ID(0x000bbd0a, uci_id_etm4),/* Cortex-A75 */
 	CS_AMBA_UCI_ID(0x000bbd0c, uci_id_etm4),/* Neoverse N1 */
+	CS_AMBA_UCI_ID(0x000bbd41, uci_id_etm4),/* Cortex-A78 */
 	CS_AMBA_UCI_ID(0x000f0205, uci_id_etm4),/* Qualcomm Kryo */
 	CS_AMBA_UCI_ID(0x000f0211, uci_id_etm4),/* Qualcomm Kryo */
 	CS_AMBA_UCI_ID(0x000bb802, uci_id_etm4),/* Qualcomm Kryo 385 Cortex-A55 */
-- 
2.25.1

