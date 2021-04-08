Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0FE358AF8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbhDHRKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbhDHRKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:10:05 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B21C061762
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 10:09:54 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id t7so1377938plg.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 10:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hsVpapqIjp7CiSFT8fhwxm6WDX91yn65qSgcrfEuhWM=;
        b=dYU9jCs3NDGiCyR4OPYV+1Zl9XGFcZYdDDg4gt/3M7Sf8kXTkhOeFKrCD13PrK72TJ
         9/Z/fmFsKT25ZFc8V2guW/2hDoSZkLTwn7ayMSvtC2pZZNcyQ6d2huyxspl9l9jwdP/+
         5vEMcHbOF/x0e/wYFXjLSYyu+D3rbitInWDuKJ2UEwIg8wIqHTXrSG45xx0G17nn7Wjq
         W1Opz5qx7sA/aw1D7Z5lxpOXNyFl+s9qOQu8iykr+klaRQbBBOyKaqJhITEMvb29eMN3
         tEQebE5Fn0iWsfr+AnunDdXVYzyVxO1ib7rvJZJpRr3x2KX6YqbmBmALzz7sr1x8otmz
         knWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hsVpapqIjp7CiSFT8fhwxm6WDX91yn65qSgcrfEuhWM=;
        b=bK+Xjefc4BGPuwkgV7BIZDobyu6cqq44vpYv6PTDCYrpWgPZuEzS9WiWaGfJ3G0o7f
         v9cJo0D4DkzwiDg2OYGBv2Iy8BngcKIKu3gtua542szBHGv+KKWwuVhsD1UBLb/y6+Cw
         Q8F0KrvGjz+ITpIG/lyWKPN5jODW2yYXJ271GLCLKubLUSkBkmw43zpUnt16OQlOkoBf
         vflilm0SkkCPzBQk/02/1OKbKyQ31J7KN5iCKjk9wv+g+ZTJ3Wk8InJ6SXYvas5x2H1f
         JSDi83Y2XkGucNqE+N29Z9xctMnzu3OuiXjxnzzeL9Xf8kKJvsDDUYmixRTZh40jrB6n
         2NOQ==
X-Gm-Message-State: AOAM530LIBMx2bmZlNySm6aNG3kf9Gtt6N78MmeEUnwm6iBXG3nIFkV7
        IpXeqk73pBj6MuVJilghSQtx
X-Google-Smtp-Source: ABdhPJzSfA2XPcEZLjDyuH/0sDU6wuj8yT3wExa0BHvI+q0gNChg+qh3XLkeOUVhqek1J9MTAfMhkQ==
X-Received: by 2002:a17:90a:bf06:: with SMTP id c6mr6478111pjs.186.1617901794132;
        Thu, 08 Apr 2021 10:09:54 -0700 (PDT)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id a191sm57921pfa.115.2021.04.08.10.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 10:09:53 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 4/7] ARM: configs: qcom_defconfig: Enable Q6V5_PAS remoteproc driver
Date:   Thu,  8 Apr 2021 22:39:27 +0530
Message-Id: <20210408170930.91834-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408170930.91834-1-manivannan.sadhasivam@linaro.org>
References: <20210408170930.91834-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the Qualcomm Q6V5_PAS (Peripheral Authentication Service)
remoteproc driver to manage the modem co-processor in SDX55 platform.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 47343d0ea586..695612829503 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -237,6 +237,7 @@ CONFIG_MAILBOX=y
 CONFIG_QCOM_APCS_IPC=y
 CONFIG_REMOTEPROC=y
 CONFIG_QCOM_ADSP_PIL=y
+CONFIG_QCOM_Q6V5_PAS=y
 CONFIG_QCOM_Q6V5_PIL=y
 CONFIG_QCOM_WCNSS_PIL=y
 CONFIG_RPMSG_CHAR=y
-- 
2.25.1

