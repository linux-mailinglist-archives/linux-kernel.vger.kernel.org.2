Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12564358AFC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbhDHRKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbhDHRKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:10:14 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863C9C0613D8
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 10:10:02 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id y32so1838161pga.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 10:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bhHnDgdkc380lRG0DprB8hF3ZuDbY3ZupEqjD9vGLeM=;
        b=socZ2ANWNkQiWG9q39C9s4AWh1H2JHFoZMthhryqaUslo4Q83rjXGj+wSYhMPurkFd
         HaOeCwqt8HyjKaQF4ibVeChKvJpiuu8kKy2R0BUWp361zwBPUHSGQcTr2g8IZ34onwiQ
         iPA9Te1nGeIWA0p3ZzDMDHASUwbejWWQmITdQT54oinNrBfKELT+CHd+e3XycpN9SibE
         0gpPXddYoA5DSBG5EKEINHM8l3WTS+dEIL29I4Folz5ASlVi6QHdNYqiHv4jZRUvhUsJ
         yHK0LML7z7VsyxH9z7eigIhp3OWaffZ7qogZ1TwtEFC87yB4B9nJyJqEzXmwYA6W4I5o
         Q1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bhHnDgdkc380lRG0DprB8hF3ZuDbY3ZupEqjD9vGLeM=;
        b=fsBDQkKgN+iJJvYTziYnqQFuuF/6Bkh3wvZM4wMjQF+SHD0sshw7EHVJPCRB7WZ1aP
         mKxbf5hx2TX4a46DOaGNv6TLY+ryQq8vgiGBQkiJoCd7WkbYFaQ8ExFNwDu12+pJJnbc
         uLsOouF+Q70qH0aKDQSl6WN9lPy4uffcjZw/oiYUz79neXQtBY8P7F0kftaiUzco2tj5
         N81DTPW8yk2rPBupu2skAX4eDgLJYkEJxDNUwL9mxRL+blvsqU/0U6MO8+xXHmwKd/ko
         GhhvrHisM+sHhlo5M1fbnM7Yt2CiYpzOYnq4y4WSGSIWh4WECrTHbo4zJqYOWBesA8x9
         +8ag==
X-Gm-Message-State: AOAM533WSCU7cwu0wFR5PoxEMDXe/3PDUAl60Vuuw0VvbaNYvBqkkDfF
        4cp4ODFNa05mPj3xgcJlKZJu
X-Google-Smtp-Source: ABdhPJwrX4rA2tI7/W9GqerWclsigh6LwPX6gPGwAjGW0O4y5xDmFkK1SsjS7RlKne6RsWL7YUuq3Q==
X-Received: by 2002:a63:a19:: with SMTP id 25mr8930942pgk.177.1617901802085;
        Thu, 08 Apr 2021 10:10:02 -0700 (PDT)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id a191sm57921pfa.115.2021.04.08.10.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 10:10:01 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 7/7] ARM: configs: qcom_defconfig: Reduce CMA size to 64MB
Date:   Thu,  8 Apr 2021 22:39:30 +0530
Message-Id: <20210408170930.91834-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408170930.91834-1-manivannan.sadhasivam@linaro.org>
References: <20210408170930.91834-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all platforms are able to allocate CMA size of 256MB. One such
platform is SDX55. Hence, use the standard 64MB size for CMA.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/configs/qcom_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 4e4c49c29aa5..26353cbfa968 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -296,7 +296,7 @@ CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
 CONFIG_DMA_CMA=y
-CONFIG_CMA_SIZE_MBYTES=256
+CONFIG_CMA_SIZE_MBYTES=64
 CONFIG_PRINTK_TIME=y
 CONFIG_DYNAMIC_DEBUG=y
 CONFIG_DEBUG_INFO=y
-- 
2.25.1

