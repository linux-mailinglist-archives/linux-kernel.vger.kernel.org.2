Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D6F30AED8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhBASOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbhBASOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:14:35 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888A3C0613ED
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:13:55 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id p21so735711pld.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dGzmgBv4K1U0QOhwlZji5Uk4apM7BYnCXSr1rOYmcOs=;
        b=dQDFI+Mu9BvvAMZgG2UflQSsnnjrfgFTRhaVlUtADA/wI4ubZRWs3bIiZburIrVOYk
         NMFUJz7GX8uK0OoOBGSFfEvOR/ZdNW8g/ZNFfk7oFyfObgr4aO/mv3Ohh3YWxmTOgUsS
         s5UMJq2Yqv9hFR02dlmtKmN1w6ysMoHtk2q9SEj6N95ibITwGpJerJBwr4E4wahV4USp
         N1AksKm/2NqkBdnS+jrpzsvYuHJ7KFZqoMhL03UlEAs2KmZUDaErQl43Glnwa6ZC/IH5
         xQ2KxR7SeboK2WRldPNu8fJeaczzm9KWIfFdGVJIAtHwJjdeGi15O+R+sELID1v8Hu3D
         k/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dGzmgBv4K1U0QOhwlZji5Uk4apM7BYnCXSr1rOYmcOs=;
        b=VrHTOyeRYO9VeNca3/9GGh64UnsV0lXfyYd7L1nLj1dxPaCp5UsQ3kSoGI/MUW/K/O
         SIi8cnhgDJKm8EVdvzCrEUCHO4Esb1zwt6RRVNvqoLRN0k8QonTRe+Qv7vS0AG3T4aK5
         PlKNBAVYVeZAJ4p+zIbjpivAJHTI1wV4QkIoChyo5kW3cuYrxPsZteULK5V135BhXNYB
         Xex00c4qesNBYEgw80kbVrr2/1/FmTVZp7aGPMO+6WpnFcfKIme3/nt7qadl+ud+h1rL
         uiuhGcbMs+qUtcnTQLPZzAcy55r4Q63sGpbmc7QNqwPFNx5kYUW9qxUDdBQY4p7PM5c3
         C3ag==
X-Gm-Message-State: AOAM5336J6t/BWYlkUYLMpfpjdKez+AvnyTiO4r8F9Ydcn0f//6SjfzK
        h/Abkm1a8aRwE5tXgyDtAm83kQ==
X-Google-Smtp-Source: ABdhPJyjnaarUPrvsvjrLcHjhyWaIR5c5QLFS6RSAs6vBEP5vLqKtMhzO1O2Ssa8vdwMxp53u++PNg==
X-Received: by 2002:a17:902:b986:b029:df:e5d6:cd71 with SMTP id i6-20020a170902b986b02900dfe5d6cd71mr18646285pls.42.1612203235161;
        Mon, 01 Feb 2021 10:13:55 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e12sm75784pjj.23.2021.02.01.10.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 10:13:54 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/31] coresight: etm4x: add AMBA id for Cortex-A55 and Cortex-A75
Date:   Mon,  1 Feb 2021 11:13:22 -0700
Message-Id: <20210201181351.1475223-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
References: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Add AMBA UCI id to support Cortex-A55(Ananke) and Cortex-A75(Promethus).

Signed-off-by: Bin Ji <bin.ji@unisoc.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Reviewed by: Mike Leach <mike.leach@linaro.org>
Link: https://lore.kernel.org/r/20210118065549.197489-1-zhang.lyra@gmail.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index b20b6ff17cf6..8c4b0c46c8f3 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1713,6 +1713,8 @@ static const struct amba_id etm4_ids[] = {
 	CS_AMBA_ID(0x000bb95a),			/* Cortex-A72 */
 	CS_AMBA_ID(0x000bb959),			/* Cortex-A73 */
 	CS_AMBA_UCI_ID(0x000bb9da, uci_id_etm4),/* Cortex-A35 */
+	CS_AMBA_UCI_ID(0x000bbd05, uci_id_etm4),/* Cortex-A55 */
+	CS_AMBA_UCI_ID(0x000bbd0a, uci_id_etm4),/* Cortex-A75 */
 	CS_AMBA_UCI_ID(0x000bbd0c, uci_id_etm4),/* Neoverse N1 */
 	CS_AMBA_UCI_ID(0x000f0205, uci_id_etm4),/* Qualcomm Kryo */
 	CS_AMBA_UCI_ID(0x000f0211, uci_id_etm4),/* Qualcomm Kryo */
-- 
2.25.1

