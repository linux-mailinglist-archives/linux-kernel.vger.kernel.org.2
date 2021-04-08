Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6BD358AFB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbhDHRK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbhDHRKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:10:11 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282C3C061764
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 10:10:00 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so1764382pjv.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 10:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9VeaJUos33kOdc+CESD0K8vbBALqy9Gn3vs+W7blbgA=;
        b=PmnWIBEB2OfY2OXy7Agk/+IIIGB6fU0BAxq+xWODalW9g8IiET3b3IfPUJsCj40UUB
         ezJpFFjm0ZllMVrxrZo+WnZSwe2l2xbvqV/0lko8iV5LSuuYgqnopODPrG3ToP1i7fzi
         vAHcm9UPkzUeAfl5wh1HI4GuIAmN9I1Ci1vsEKGM1yQ9nQkl/e0DG1JSfCN5SL6lCCnq
         kAW67JzOFHSur1mqVMvnGIK3cxXYccpZvEh0QUcuRbYci+vYShT7kC+M01Id+L+3tW3z
         nQrkNjpaFJbWjRWlhnMRW0mG5C+923X5O68axewNfZu/cIlHmytNoRKDCdcb8x8NEfhM
         r92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9VeaJUos33kOdc+CESD0K8vbBALqy9Gn3vs+W7blbgA=;
        b=Lkhnn31y+owWgFWuM/uk40oQ/LfpKGZhYl9IRu7INWsM8+DveJC9V+OCbKuOk/GgnV
         T/Pww0vxz7iplKgGxGy4F5VbOJOnk0iTzA8xExvU7NDosZ1liAThMT4ri7cgg5sCtV43
         GfA4t9S4YtGnuBGqZf55bY7Cd2YlwNW2pvok6FoTtVbTgec7k221N5XMD9tnKiyVDnXw
         VYsKTdPJXEHMjzjxAD/r8gAN/JG0yQQiGuOFlbTFPk+ZS3y07yAMXShFVUU1FDPL1GrV
         sHRcWeoxr01tzdRzL35zdUf4lVF2Q7OZVIqD/KjJb/395kFHHpZ7OpF+hU//Ivk2w0tZ
         ce5A==
X-Gm-Message-State: AOAM5322dV6ogLeNQGOMDNMXAjFbOqdGmAmlY+u9Sx2CtfntH8qwb32f
        b/Zk+xqq3r6U9v+MuISTKL9/
X-Google-Smtp-Source: ABdhPJxV9YYbRgqyJYz/WqBm5i3phYkp2/AxxOr7lCaKkJfaNHneCXbTLRNK7nJhwKqwdViOIP7giQ==
X-Received: by 2002:a17:902:6f10:b029:e9:7fdf:4902 with SMTP id w16-20020a1709026f10b02900e97fdf4902mr5739405plk.41.1617901799659;
        Thu, 08 Apr 2021 10:09:59 -0700 (PDT)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id a191sm57921pfa.115.2021.04.08.10.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 10:09:59 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 6/7] ARM: configs: qcom_defconfig: Enable GLINK SMEM driver
Date:   Thu,  8 Apr 2021 22:39:29 +0530
Message-Id: <20210408170930.91834-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408170930.91834-1-manivannan.sadhasivam@linaro.org>
References: <20210408170930.91834-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the Qualcomm GLINK SMEM driver to support GLINK protocol over
shared memory.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 5955aeb0646e..4e4c49c29aa5 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -241,6 +241,7 @@ CONFIG_QCOM_Q6V5_PAS=y
 CONFIG_QCOM_Q6V5_PIL=y
 CONFIG_QCOM_WCNSS_PIL=y
 CONFIG_RPMSG_CHAR=y
+CONFIG_RPMSG_QCOM_GLINK_SMEM=y
 CONFIG_RPMSG_QCOM_SMD=y
 CONFIG_QCOM_COMMAND_DB=y
 CONFIG_QCOM_GSBI=y
-- 
2.25.1

