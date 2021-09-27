Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4CC418D59
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 02:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbhI0Aww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 20:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbhI0Aws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 20:52:48 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECE9C061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 17:51:11 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id d4-20020a17090ad98400b0019ece228690so2414597pjv.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 17:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wRlSrRWN8ZeQosEp+WXYy+zsVZFnR5I4rS0SZN/3GUk=;
        b=SRoWUSJ1fjtUuizmYMmEwXSiT3KtKaU+3ub480ffovEAog18NdgJLFYjPWywXncKwT
         3aDhNli7LfWuJB9JvntfTb2dDRJlrq+wFbsD7liqiSYAwLt4GzyD0dT9oK1zdv0G82fA
         IoUD7d5Ua5jm+ECKkMlPQI1lRbWEzbeBaAfa0IKQDG75BvSsLIlBbYG0BJAJhiYcJ6t7
         DwLAeosqhgHNcCxHkJl+Jzc0Prxp0lXrF4Ng7h9wZ7wm3IRxCiv3e+J+EPAxZnHXNwGl
         e5JLBdP1hPD+MQ5ZZpCQKojybJY+2FXGHu9GeLhAWLw4RGScyi7l9ps/csobjfQEcL1C
         4omA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wRlSrRWN8ZeQosEp+WXYy+zsVZFnR5I4rS0SZN/3GUk=;
        b=mnRJ5mzQPFEpi671nNglx8JMh9kMe87GCUByLh6blRZ5lcvMWqYfdXfXclLF/iSkMM
         7Ykb9GaRtz75sqsdHWnxFZd4hO2y3vJRcfM+9JEn7E9rItjgn4l+BJK0tKC5r8STElPt
         eWh7SfBQVZt9T5c1QrNR3DZhdJM5lcQvl0DwFW9hBVtmNpuH+ScQKRrneW0Vvfhse6MP
         lAd0EH4Fi8NuArOfeaY+CBm6O2uCbcDom3aifbnRw3c+040xretXRt1scZGTTvDi5FuS
         xOQElNvIabF4/B8/6R3xSK/ZdZd/8E6BnF5RAwwxBXsmcQk6+gT0w3243M6ebCEG+o6j
         5ubw==
X-Gm-Message-State: AOAM531nGATm2DUfcA1XDf8spS4GCb96e4ocScCW847TfZGK49Nu+Qpw
        9Qrl197wiT0ZALVoA3RpON7MkmCbCoLTNg==
X-Google-Smtp-Source: ABdhPJzITfB8sv5VtDt3+G79zOX6nfr7DAL6rLUu/elC9n6vpsv9QRoDUR3roDWcTce8lZkdFIx2jg==
X-Received: by 2002:a17:90a:514e:: with SMTP id k14mr16790467pjm.154.1632703871119;
        Sun, 26 Sep 2021 17:51:11 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h16sm13980124pjt.30.2021.09.26.17.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 17:51:10 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     kexec@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, Coiby Xu <coxu@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] arm64: kexec_file: use more system keyrings to verify kernel image signature
Date:   Mon, 27 Sep 2021 08:50:04 +0800
Message-Id: <20210927005004.36367-3-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210927005004.36367-1-coiby.xu@gmail.com>
References: <20210927005004.36367-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Coiby Xu <coxu@redhat.com>

This allows to verify arm64 kernel image signature using not only
.builtin_trusted_keys but also .secondary_trusted_keys and .platform keyring.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 arch/arm64/kernel/kexec_image.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index 9ec34690e255..2357ee2f229a 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -14,7 +14,6 @@
 #include <linux/kexec.h>
 #include <linux/pe.h>
 #include <linux/string.h>
-#include <linux/verification.h>
 #include <asm/byteorder.h>
 #include <asm/cpufeature.h>
 #include <asm/image.h>
@@ -133,8 +132,7 @@ static void *image_load(struct kimage *image,
 #ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
 static int image_verify_sig(const char *kernel, unsigned long kernel_len)
 {
-	return verify_pefile_signature(kernel, kernel_len, NULL,
-				       VERIFYING_KEXEC_PE_SIGNATURE);
+	return arch_kexec_kernel_verify_pe_sig(kernel, kernel_len);
 }
 #endif
 
-- 
2.33.0

