Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C9E3C1E7E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 06:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhGIEkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 00:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhGIEkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 00:40:19 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C68C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 21:37:36 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id k20so1738236pgg.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 21:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eBdDu50tMNuB7A6waM/ZyWIMl2LOJYIC1/NpalUridM=;
        b=C655qxBGfJlYMHH9QBFLbhyK4uAmvdwzkJEVRuHMZB1mKz3O4MEfvXbS4szocXmsQx
         XIZA71qy/kDzskTcV6GbpzRzk8XHO4KV9K7Cf1kSB9kEBsdsJHCYou1sWIlHT4aU7d8n
         oO+1zOGotRjyCjPehfvMbg1+d41s4nllzJJ4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eBdDu50tMNuB7A6waM/ZyWIMl2LOJYIC1/NpalUridM=;
        b=sYsTl02Dko6Vx1aaAjIvz1kNegxtmWwWtOYhxTKtZQCEJ0tNHi0tI2Z+Cu366YZ51M
         QMIXho/hfxySPfzbJIt57pQmTqX2ZMHsavYJGrh3bZh7qwwWcpkQtw7EObp/5MPiF17T
         sexX/a1AYZj3j9WHaWtI8EI+wbclqYqUw4wVYYGrxSoRFbQ+lIuaNn1H9zMEbkDa7grd
         Dzu3Fmc5plBjhghZgVzmYCOw3BGVCaKDe1rV5B0Bt10TDkZ3iPzdXpfkXDxEuiQ0lfd+
         W4gvBz1aq1o2oqnx4FbWHG0dYS67O9xfGYEZTM7X7Kmhs35pwBbyq8O2cwM6BzxecVsy
         k4Gg==
X-Gm-Message-State: AOAM530a6uH9UNg6u/OxH2b5vMVXqzvSxy1oTTucXrTgJPxZh9tiOQQt
        /TbDXJrqdlf4PXe5VGJlWaUnBg==
X-Google-Smtp-Source: ABdhPJyU5pINJoX/AogKYgRXTY5MbyhKXColfNbeIbVpm0ISXAwe7bj9tLDDjqgSf+cAP3MHB+R6Wg==
X-Received: by 2002:a63:4e4d:: with SMTP id o13mr35755196pgl.361.1625805455971;
        Thu, 08 Jul 2021 21:37:35 -0700 (PDT)
Received: from senozhatsky.flets-east.jp ([2409:10:2e40:5100:a30d:fc4:7834:ee08])
        by smtp.gmail.com with ESMTPSA id y4sm4420760pfa.14.2021.07.08.21.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 21:37:35 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Cc:     Suleiman Souhlal <suleiman@google.com>,
        Joel Fernandes <joelaf@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 1/4] arm64: smccc: Add SMCCC pv-vcpu-state function call IDs
Date:   Fri,  9 Jul 2021 13:37:10 +0900
Message-Id: <20210709043713.887098-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210709043713.887098-1-senozhatsky@chromium.org>
References: <20210709043713.887098-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the definitions of the SMCCC functions that will be
used to paravirt VCPU state configuration.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 include/linux/arm-smccc.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index 7d1cabe15262..dbf0d658e54a 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -177,6 +177,24 @@
 			   ARM_SMCCC_OWNER_STANDARD,		\
 			   0x53)
 
+#define ARM_SMCCC_HV_PV_VCPU_STATE_FEATURES			\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
+			   ARM_SMCCC_SMC_64,			\
+			   ARM_SMCCC_OWNER_STANDARD_HYP,	\
+			   0x60)
+
+#define ARM_SMCCC_HV_PV_VCPU_STATE_INIT			\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
+			   ARM_SMCCC_SMC_64,			\
+			   ARM_SMCCC_OWNER_STANDARD_HYP,	\
+			   0x61)
+
+#define ARM_SMCCC_HV_PV_VCPU_STATE_RELEASE			\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
+			   ARM_SMCCC_SMC_64,			\
+			   ARM_SMCCC_OWNER_STANDARD_HYP,	\
+			   0x62)
+
 /*
  * Return codes defined in ARM DEN 0070A
  * ARM DEN 0070A is now merged/consolidated into ARM DEN 0028 C
-- 
2.32.0.93.g670b81a890-goog

