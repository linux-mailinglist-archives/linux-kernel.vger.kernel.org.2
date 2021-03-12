Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD188338264
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 01:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhCLAck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 19:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbhCLAcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 19:32:18 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A83DC061761
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 16:32:18 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id n23so2761450otq.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 16:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6yerQKfDnfz7buskmtSzYD6MzcxxmHz36LYzDDWncI4=;
        b=j4+FEri2ovICTXT2ZO3+c/mLbrKpu5cWHdhqiPqMR0arRsjb8+lFV/4MQOFSL5/bOx
         CrFy6v67inEGWaL51OH4w4L/9APFRcf/DaO9y7VMbTW5BjWfq3xr27OFA+Y/RuhBj+Vj
         /QNKDkwP08lPGDIhDndxgwWEtpFdfFFOK7pDL5vILBuVqqdz+2n3hRNHUV6v9Fm2r71B
         rcAbzQG6UJNvX/NhS+bzREx5gMy2lBu7xjWX6dv2bGVDb6B6ZvevK3wDTW50EjHmWefq
         gw7+1ua4dhyLZzjjGu9DZkK0QxfWgUcUq8jaucpIvMpJrFt849ju/FB1D8KWwzYLT69+
         FeZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6yerQKfDnfz7buskmtSzYD6MzcxxmHz36LYzDDWncI4=;
        b=qH0Qn5sAVsK1JlX8HQ0PwB541N+Q0nqDmrHdKnuRboFLWpSwF4Jd75x/EEdcSV+rfy
         wJuY6akVf8L3LpqITzZpbjNLYvLwZiP1ut6hyCh2YieEiEj65c7/Gu9dsMZkJmXw+H0p
         L3++2/UdD//eonL22g/iVV0v3aIJ9A8N4Da9VxXZf7lq452D9om2T3XD3vAtbZsJcVoX
         a1A2rFOCI7LTlo1hUFWVJMEVPhkeSd0pUMsjOgiVl94h7568upio2YvKP2KPS0u00Iiz
         xWlQ3VFKcDVuaxSIEgITeyTw/r6TvsN2CXVt7teOxHhEpgSmkEVJ2J2x4E6Qjj0VjXUi
         WFjA==
X-Gm-Message-State: AOAM531OgjK+3ptmY5dIdbcxCnLrWnCK2MV3UZXRdK32+kSaFHrYaJSJ
        jfSccTKsCmDJNYXWyyhPPDOjkA==
X-Google-Smtp-Source: ABdhPJw71XAFXEC95aShYwX8z3HWOLkEXvyvBx7QSIHTC8+qxdNVlPBNNz+050QfFrq7anbHAYmiaw==
X-Received: by 2002:a05:6830:1d69:: with SMTP id l9mr1227667oti.369.1615509137518;
        Thu, 11 Mar 2021 16:32:17 -0800 (PST)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id l190sm670835oig.39.2021.03.11.16.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 16:32:17 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 3/5] soc: qcom: wcnss_ctrl: Introduce local variable "dev"
Date:   Thu, 11 Mar 2021 16:33:16 -0800
Message-Id: <20210312003318.3273536-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210312003318.3273536-1-bjorn.andersson@linaro.org>
References: <20210312003318.3273536-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a local variable to carry the struct device *, to reduce the
line lengths in the next patch.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/soc/qcom/wcnss_ctrl.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/qcom/wcnss_ctrl.c b/drivers/soc/qcom/wcnss_ctrl.c
index 32bed249f90e..358526b9de06 100644
--- a/drivers/soc/qcom/wcnss_ctrl.c
+++ b/drivers/soc/qcom/wcnss_ctrl.c
@@ -199,6 +199,7 @@ static int wcnss_download_nv(struct wcnss_ctrl *wcnss, bool *expect_cbc)
 {
 	struct wcnss_download_nv_req *req;
 	const struct firmware *fw;
+	struct device *dev = wcnss->dev;
 	const void *data;
 	ssize_t left;
 	int ret;
@@ -207,9 +208,9 @@ static int wcnss_download_nv(struct wcnss_ctrl *wcnss, bool *expect_cbc)
 	if (!req)
 		return -ENOMEM;
 
-	ret = request_firmware(&fw, NVBIN_FILE, wcnss->dev);
+	ret = request_firmware(&fw, NVBIN_FILE, dev);
 	if (ret < 0) {
-		dev_err(wcnss->dev, "Failed to load nv file %s: %d\n",
+		dev_err(dev, "Failed to load nv file %s: %d\n",
 			NVBIN_FILE, ret);
 		goto free_req;
 	}
@@ -235,7 +236,7 @@ static int wcnss_download_nv(struct wcnss_ctrl *wcnss, bool *expect_cbc)
 
 		ret = rpmsg_send(wcnss->channel, req, req->hdr.len);
 		if (ret < 0) {
-			dev_err(wcnss->dev, "failed to send smd packet\n");
+			dev_err(dev, "failed to send smd packet\n");
 			goto release_fw;
 		}
 
@@ -248,7 +249,7 @@ static int wcnss_download_nv(struct wcnss_ctrl *wcnss, bool *expect_cbc)
 
 	ret = wait_for_completion_timeout(&wcnss->ack, WCNSS_REQUEST_TIMEOUT);
 	if (!ret) {
-		dev_err(wcnss->dev, "timeout waiting for nv upload ack\n");
+		dev_err(dev, "timeout waiting for nv upload ack\n");
 		ret = -ETIMEDOUT;
 	} else {
 		*expect_cbc = wcnss->ack_status == WCNSS_ACK_COLD_BOOTING;
-- 
2.29.2

