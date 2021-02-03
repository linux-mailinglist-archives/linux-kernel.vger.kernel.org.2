Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16ADB30DFD4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbhBCQgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbhBCQfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:35:17 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F279DC06178A
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 08:34:36 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id a20so370pjs.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 08:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=squareup.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tDdfcsBZJuJtkpBOSJDEI0wgJxTXViUcOD8MHou6QmE=;
        b=VXtxZbi8AtZyMZJpc50pEvpcML6zaCXy49jNoMowkU5wXzOsZgefVdUPQHgGHCEr3B
         VX/+A3V9YXOgufIR6vLDsozEfwkoAZ/C1d88U1v/Wkhpp93O57e5bVOJgh4lDGnRF7W+
         6IRdn4Htmw5yyWbTH2IP++5A1kQzyq0CkCkuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tDdfcsBZJuJtkpBOSJDEI0wgJxTXViUcOD8MHou6QmE=;
        b=e1vpeKKMCgqAp0LliMLLGEndQ+oOS/n7DKC1j6p8m87kHNTzfoz3tMcvETF/mKtwpc
         0EUlo+6mAr8+1L/B8gLzuEgpPaDRubja31ZT/rrHk0AavLqCpVlCHAKxC4EZRLctybcM
         fR69EZLDyW6Z1kX45JoGC2bTzihHBX95ZcUtRzELmKlGMdIVE07ittZlcMwHCZYGfD1Y
         6LNb1wXb1XuJjgCnoY33TGIxKugI4DIX4HZjQ2YZUdp41mXrT5WE4JgNaJ9QhFwLse4Y
         aTy2b7hhBze2AUUW5NzoDHQJuQYyxYmzLL0eJ++Yj27aMISCEUBvqzTZ6zhGzhghnqDO
         9WAQ==
X-Gm-Message-State: AOAM530XunxOGDDQEuclj9xITWTaA/7ufZyc/VeQLEmdzHHd85Uohgn+
        pmP8COWt5v/GncuU/K5H2glStg==
X-Google-Smtp-Source: ABdhPJwHW/bPgjpIW8uXFOPagPYKISILCxeoo1NzldsvLxwfQdCWM66jZLnLeBPCfTIPz2JEdYXQHQ==
X-Received: by 2002:a17:90b:4acd:: with SMTP id mh13mr3913378pjb.229.1612370076555;
        Wed, 03 Feb 2021 08:34:36 -0800 (PST)
Received: from localhost (162-207-206-139.lightspeed.sntcca.sbcglobal.net. [162.207.206.139])
        by smtp.gmail.com with ESMTPSA id y6sm2754285pfn.123.2021.02.03.08.34.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2021 08:34:35 -0800 (PST)
From:   Benjamin Li <benl@squareup.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     square@linaro.org, kernel@squareup.com,
        Benjamin Li <benl@squareup.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] interconnect: qcom: icc-rpm: record slave RPM id in error log
Date:   Wed,  3 Feb 2021 08:34:06 -0800
Message-Id: <20210203163407.9222-2-benl@squareup.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210203163407.9222-1-benl@squareup.com>
References: <20210203163407.9222-1-benl@squareup.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add slave RPM ID to assist with identifying incorrect RPM config.

Signed-off-by: Benjamin Li <benl@squareup.com>
---
 drivers/interconnect/qcom/icc-rpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index cc6095492cbe..54de49ca7808 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -59,8 +59,8 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 					    qn->slv_rpm_id,
 					    sum_bw);
 		if (ret) {
-			pr_err("qcom_icc_rpm_smd_send slv error %d\n",
-			       ret);
+			pr_err("qcom_icc_rpm_smd_send slv %d error %d\n",
+			       qn->slv_rpm_id, ret);
 			return ret;
 		}
 	}
-- 
2.17.1

