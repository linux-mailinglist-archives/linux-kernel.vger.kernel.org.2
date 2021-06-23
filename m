Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E095F3B1957
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 13:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhFWLy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 07:54:27 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:23125 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230130AbhFWLy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 07:54:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624449128; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=AHMt0GzCvHn4hyYD7cdhM7SJoQ7X95tIMSwPoZD5d7s=; b=DhmI5j1IIl0oYqt7/AUXn8q6dvBLQPCjQEDxCx0kNgBKoLU8Ee1uO9wxymLEJ3J8TrE/U6xy
 GNysEC2+Q/rfqaOHGyWPucW122bVCXCafWqep/ddhQVK9dVCWfKLdhFjGUSjALHZRXiXtmau
 PdRM2vvWRpRttFhAZIAWmY4LU0I=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 60d32066638039e9972c830c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 23 Jun 2021 11:52:06
 GMT
Sender: tdas=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AA944C43144; Wed, 23 Jun 2021 11:52:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tdas-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 30CB6C433F1;
        Wed, 23 Jun 2021 11:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 30CB6C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v2] clk: qcom: gcc: Add support for a new frequency for SC7280
Date:   Wed, 23 Jun 2021 17:21:56 +0530
Message-Id: <1624449116-9497-1-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a requirement to support 52MHz for qup clocks for bluetooth
usecase, thus update the frequency table to support the frequency.

Fixes: a3cc092196ef ("clk: qcom: Add Global Clock controller (GCC) driver for SC7280")
Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
[v2]
 * Update commit message and subject "Add"/"bluetooth".

 drivers/clk/qcom/gcc-sc7280.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/gcc-sc7280.c b/drivers/clk/qcom/gcc-sc7280.c
index ef734db..6cefcdc 100644
--- a/drivers/clk/qcom/gcc-sc7280.c
+++ b/drivers/clk/qcom/gcc-sc7280.c
@@ -716,6 +716,7 @@ static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s2_clk_src[] = {
 	F(29491200, P_GCC_GPLL0_OUT_EVEN, 1, 1536, 15625),
 	F(32000000, P_GCC_GPLL0_OUT_EVEN, 1, 8, 75),
 	F(48000000, P_GCC_GPLL0_OUT_EVEN, 1, 4, 25),
+	F(52174000, P_GCC_GPLL0_OUT_MAIN, 1, 2, 23),
 	F(64000000, P_GCC_GPLL0_OUT_EVEN, 1, 16, 75),
 	F(75000000, P_GCC_GPLL0_OUT_EVEN, 4, 0, 0),
 	F(80000000, P_GCC_GPLL0_OUT_EVEN, 1, 4, 15),
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

