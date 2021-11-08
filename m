Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E29448072
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 14:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240051AbhKHNro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 08:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240062AbhKHNrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 08:47:42 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528A7C061764
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 05:44:58 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id w9-20020a17090a1b8900b001a6b3b7ec17so8733354pjc.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 05:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H7m5p97BKE1ln9x8mMCJwq7P//I9O+wuU0Z+Nt2052Y=;
        b=P+Utp/dlqKEWj6LUw9H9YhiIfaKS72hoEaHw6MpLEqMUryo4lbSa/EH6J0o0iegScV
         cdYm2qLfUKciJFZnblzm5/ZpoXAZeaoML+UBYTfSa33+YzfsDrLGOBa0iMW6mWoKTaQh
         C3TfeMkME+OA749VGpq+6dtLlhEO088MoXK8+v37H3tAV3WsNdnxltM7ZFeO2rPCzvrF
         Rsci752T7LTOztbaJ9a+PzAriqlW0MMWKvm3cH5Xx44p2uOaD/twNlM9UWDj+FdbSXqU
         YZPk7kN8HW+ds0EMjvaTdPDfwobr4MjYYditYbTdRdAsRTTnnADdSnmN2MR8duf50utd
         Ck7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H7m5p97BKE1ln9x8mMCJwq7P//I9O+wuU0Z+Nt2052Y=;
        b=w+aaTjuPrhaQ4oykBL9yLnABXjJfIVgUPyMjPfgHULDWxzqKbCMeuwNEsM5gfGtNVm
         p7ae3oUYVAOJMjXyjSPJynn2riqcqJwFnBZqoT53Qg3B+HAJetWx5P1EXFaEc5FgU71L
         2mS2p0IRuseCPWTXCe4lkmQmJyB1nb4TIFZeoC8dcVZm8PqIOYlOnwvd2g54tpvLHjHi
         F+/0O1QRlgABwuUf8bSBmBXdnCzSJM+YdpDSJLEgGnJmaKIdt6nhlFfFStleRSqDUcoK
         2kUfDnekTTxLPbkka7kw0A6bvsTlLiNO4GGrTw8s33QIMLwCSt/9Wh3fYBp4N21JHjh6
         gvxw==
X-Gm-Message-State: AOAM530bIRHzx+ynIdm2H1R5A62/MV+Dioe7z6uRCDx7FnjFmPH0ilSM
        FfBk7k8ndZWbhO9hcZ6rY/wEqA==
X-Google-Smtp-Source: ABdhPJxP7jW2gLwiv9Q8PBw5mnZz3NE2z/LeHukHwHW64eCdd5J2Zd7+qzRP1C1lvWKdCUfie1FVag==
X-Received: by 2002:a17:90a:ab17:: with SMTP id m23mr5745396pjq.194.1636379097787;
        Mon, 08 Nov 2021 05:44:57 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id m184sm3693974pga.61.2021.11.08.05.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:44:57 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 1/3] soc: qcom: rpmpd: Drop unused res_name from struct rpmpd
Date:   Mon,  8 Nov 2021 21:44:40 +0800
Message-Id: <20211108134442.30051-2-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211108134442.30051-1-shawn.guo@linaro.org>
References: <20211108134442.30051-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The res_name field in struct rpmpd is unused.  Drop it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/soc/qcom/rpmpd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index 4f69fb9b2e0e..3e7905854eb9 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -102,7 +102,6 @@ struct rpmpd {
 	const bool active_only;
 	unsigned int corner;
 	bool enabled;
-	const char *res_name;
 	const int res_type;
 	const int res_id;
 	struct qcom_smd_rpm *rpm;
-- 
2.17.1

