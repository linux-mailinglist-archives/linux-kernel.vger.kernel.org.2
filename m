Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 278EA358544
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbhDHNuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbhDHNuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:50:12 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25BDC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 06:49:58 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id g15so1880155pfq.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 06:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bmTMHJ1r8/ckYjh7BFgP9VA/95pe0hk78RiK7TQpNP0=;
        b=e1UEtX7cmLTEf17Joi7HzKgcXa/vqhrTIuVMcpOdbhUiIWIb60AcjhDERXbnkYHGwg
         /r3XBYOLMJ/sY9aes+xHaT7UooqVnWXqFwsX581MmZQOlWWiHNcjqPUvz17zw+Qi1v/B
         0jRaQ/P4mQ+iHV4VCAcFLFEfjH5tFniiI67YoEgTh48xU5WKKV0zHP8CAqbDMBgUero/
         itm2LMT4H9ur0lL2j0Pgn9iARNg4OVp6Zp64dLTTf3o3PwQon12qqW2K7UkeHyeDl4R+
         i1doUY+vsWVv5YX/rTeoKKlWX0MxZteEFsbB5rGncLWT9JKAdc9zXe0JAKyXpzvgBb7v
         UDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bmTMHJ1r8/ckYjh7BFgP9VA/95pe0hk78RiK7TQpNP0=;
        b=m4pE7eKoawsi06G1E9vlz1GA77bRJSfAE9paD/JVmoLX4CcBsiIKyzr6HWltLwy6hT
         SnOyu0KLg1DLClZv0y1XT9rKIL+PTtzH/8zDGi9F/v0l8tNOZ7ahNcv2ymv7yxwuKR7b
         nrA3FZc4VfEhgnrJMBhfbdPPA7VtRTgxXvQOnTx0osMjaR7FgjzX/3x+hSWFn/IULH1v
         2JlIHGAj94IUBCx+t7k2X3Y3k4XqdRFNqecdZpWH/mr0ISyLLoSAszBRa9ilKyQbyJEB
         lHrzQf8XlvlOtB+xAH2BSILkPBhUozftoimW1zoV6aSEtrx3rycuXU+RQ0+sM6t5bMfr
         NM7Q==
X-Gm-Message-State: AOAM530dlKB3gB7bjdFsmWkroirLwhelXZyqV/42OugbKYEb2Immk4sv
        CxIfe+JRBEpzJW2bajmfJbvB
X-Google-Smtp-Source: ABdhPJyZZhww91/LYnmjWeYazdIfGJsg3dGVcZCslGfgKY58mgvN4uoIjfK8POGCX67kmC9/5De5bQ==
X-Received: by 2002:a63:4d0:: with SMTP id 199mr8376413pge.304.1617889798288;
        Thu, 08 Apr 2021 06:49:58 -0700 (PDT)
Received: from localhost.localdomain ([103.77.37.173])
        by smtp.gmail.com with ESMTPSA id il6sm8369232pjb.56.2021.04.08.06.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 06:49:57 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     loic.poulain@linaro.org, hemantk@codeaurora.org,
        linux-kernel@vger.kernel.org, bbhatt@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] bus: mhi: pci_generic: Constify mhi_controller_config struct definitions
Date:   Thu,  8 Apr 2021 19:19:46 +0530
Message-Id: <20210408134946.16942-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"mhi_controller_config" struct is not modified inside "mhi_pci_dev_info"
struct. So constify the instances.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/pci_generic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/mhi/pci_generic.c b/drivers/bus/mhi/pci_generic.c
index 8f715519ba08..7c810f02a2ef 100644
--- a/drivers/bus/mhi/pci_generic.c
+++ b/drivers/bus/mhi/pci_generic.c
@@ -227,7 +227,7 @@ static struct mhi_event_config modem_qcom_v1_mhi_events[] = {
 	MHI_EVENT_CONFIG_HW_DATA(3, 2048, 101)
 };
 
-static struct mhi_controller_config modem_qcom_v1_mhiv_config = {
+static const struct mhi_controller_config modem_qcom_v1_mhiv_config = {
 	.max_channels = 128,
 	.timeout_ms = 8000,
 	.num_channels = ARRAY_SIZE(modem_qcom_v1_mhi_channels),
@@ -287,7 +287,7 @@ static struct mhi_event_config mhi_quectel_em1xx_events[] = {
 	MHI_EVENT_CONFIG_HW_DATA(3, 1024, 101)
 };
 
-static struct mhi_controller_config modem_quectel_em1xx_config = {
+static const struct mhi_controller_config modem_quectel_em1xx_config = {
 	.max_channels = 128,
 	.timeout_ms = 20000,
 	.num_channels = ARRAY_SIZE(mhi_quectel_em1xx_channels),
@@ -324,7 +324,7 @@ static struct mhi_event_config mhi_foxconn_sdx55_events[] = {
 	MHI_EVENT_CONFIG_HW_DATA(3, 1024, 101)
 };
 
-static struct mhi_controller_config modem_foxconn_sdx55_config = {
+static const struct mhi_controller_config modem_foxconn_sdx55_config = {
 	.max_channels = 128,
 	.timeout_ms = 20000,
 	.num_channels = ARRAY_SIZE(mhi_foxconn_sdx55_channels),
-- 
2.25.1

