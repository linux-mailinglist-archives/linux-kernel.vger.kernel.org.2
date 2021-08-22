Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0A13F3E70
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 09:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbhHVHwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 03:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbhHVHwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 03:52:14 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA10EC0617A8
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 00:51:33 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id j2so3954315pll.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 00:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6C21nGDw7vC+YBB6XbuzwfBKcOzsmqPCIkUK4Z1vJAk=;
        b=Ji3zF0ScHvssM3yEcYuqxBVQT7opuzxr2ml2VOmlokTrlcGiRxuQRIE5ii4b9MyZsw
         dzz+42Ry/0UFEtiSFUqmob6u3PEqDrgN7h0KHRchUbyVZTFVR1/Pke/pWz/OrnW853AD
         Q9jPbDCw/vc7NpeDWdXq8N6YVitMmJptYA4bU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6C21nGDw7vC+YBB6XbuzwfBKcOzsmqPCIkUK4Z1vJAk=;
        b=NOUxYSe7y0Qn8e1oi9tB/rVvR7mCzbefutsB40eeq0IAN2JIRqAR9kExocdN6MMdse
         SIzXgMOwJTJMwrH18frSoS4g/LfipSiDoalzBg5h9N/IpGbJKA1bZcUoZGlBn6jvtKfF
         4A7HPtpnXnonq2uwUJcbe9yvU5vLmWtvRCAy2FNNvTp9myh2scMHEl3bXIEplcEIkiG3
         Ek+dz4/q8HomW7KoL6KGO1EHypgYVOBtESveh2ty3WSv6mn+DuwrTFjWwndYakhfVCiK
         psK013usNJM+K12U69g0zvXb2/E/DPSscTQhNW2u7Mv7/6zg4lfgelJ2X22joudPNfmr
         wdgw==
X-Gm-Message-State: AOAM532nbOmLUaZAWHAhYslwNiR/rdwIZdtKHx3KIoRh7yHbUjEvEtIv
        iBMXuHX38KecUjMLVUfZUy/l3g==
X-Google-Smtp-Source: ABdhPJxKtIv7kfe7mAWtdJ1vmYPKu66XmZYKB4qFJwGNRru8Yzc+vuKS3S7aSG0NOIOGLmCJGX+CmQ==
X-Received: by 2002:a17:90a:7141:: with SMTP id g1mr13915053pjs.142.1629618693402;
        Sun, 22 Aug 2021 00:51:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 6sm12363166pfg.108.2021.08.22.00.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 00:51:29 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Bart Van Assche <bvanassche@acm.org>,
        David Gow <davidgow@google.com>, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: [PATCH for-next 05/25] cxl/core: Replace unions with struct_group()
Date:   Sun, 22 Aug 2021 00:51:02 -0700
Message-Id: <20210822075122.864511-6-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210822075122.864511-1-keescook@chromium.org>
References: <20210822075122.864511-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3038; h=from:subject; bh=aPnZgEf5gVMxv6joe4aeeaiC41mLeeNUPXEOUkw15pA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhIgH1V4pv+RrBgTmMfewsiWCP2lqqF6kbWCQzkQgf mFzlBb2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYSIB9QAKCRCJcvTf3G3AJo0+D/ 9Jz/jR+mz50zVHd7Qz1HuijCsP3CE2am0+KSpb3turLr/DMNZftg1bJZUaHMny9kE5HxKOU7Hw365I +KzZ46ZTSCsYKwyppITdzOEZ8X/Lr6/IGEDb6NdSf86zNTdy+PvM2giYo3xWD9h2wGq/Yfxus5TsqA dsA8ZUz7aPT+In5PBqttwprSQV8R0TibJ17vAUSz8nRloqstcZAkMFi3mmFjwBduSfjcKoXGpBR4iJ eJQrVtIY2J1mFanh4xHcuC07Fad5zIrlnhh3k/JeZvE/5mAEMZ0ovV/VBEvUI7TC74akrzULbSGL7p Ae0AvSGT+zys7+FHAL4TCnQDh1FieT9rO+HrqhI7EJa10sBfW6TucEe3Xyor1dZY+gZ4+4gUHQKUMK cjhgpnGRrvsLBvBgJWJrGKYgW8pKRGwwmmZv87ww1DsqmyN/KCj09A3psEvUzEFhi9Nnz9azNymdHM eIHNPagW3o/kGhkq3WwN0nGkQEnDDtVZa4Z0WslkQt9kIi+2KhhYT/LHNQJaaD6Vimd++nKexjFR4i 8Ed9z2zrtMLgohvCkvIllZwpsILkqj9IX+DelmMyDTbNrVtDH9uUjra2j/J+6V1QWqrvu5vHhEbtbA 1eJNDdy+jCHsMUjTsSnycxghYAyQi0tZfPmJCHv6D6BqvNCkWMvew3qC0tuw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the newly introduced struct_group_typed() macro to clean up the
declaration of struct cxl_regs.

Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Ben Widawsky <ben.widawsky@intel.com>
Cc: linux-cxl@vger.kernel.org
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Link: https://lore.kernel.org/lkml/1d9a2e6df2a9a35b2cdd50a9a68cac5991e7e5f0.camel@intel.com
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/cxl/cxl.h | 61 ++++++++++++++---------------------------------
 1 file changed, 18 insertions(+), 43 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b6bda39a59e3..97a83ba4e783 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -75,52 +75,27 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
 #define CXLDEV_MBOX_BG_CMD_STATUS_OFFSET 0x18
 #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
 
-#define CXL_COMPONENT_REGS() \
-	void __iomem *hdm_decoder
-
-#define CXL_DEVICE_REGS() \
-	void __iomem *status; \
-	void __iomem *mbox; \
-	void __iomem *memdev
-
-/* See note for 'struct cxl_regs' for the rationale of this organization */
-/*
- * CXL_COMPONENT_REGS - Common set of CXL Component register block base pointers
- * @hdm_decoder: CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure
- */
-struct cxl_component_regs {
-	CXL_COMPONENT_REGS();
-};
-
-/* See note for 'struct cxl_regs' for the rationale of this organization */
-/*
- * CXL_DEVICE_REGS - Common set of CXL Device register block base pointers
- * @status: CXL 2.0 8.2.8.3 Device Status Registers
- * @mbox: CXL 2.0 8.2.8.4 Mailbox Registers
- * @memdev: CXL 2.0 8.2.8.5 Memory Device Registers
- */
-struct cxl_device_regs {
-	CXL_DEVICE_REGS();
-};
-
 /*
- * Note, the anonymous union organization allows for per
- * register-block-type helper routines, without requiring block-type
- * agnostic code to include the prefix.
+ * Using struct_group() allows for per register-block-type helper routines,
+ * without requiring block-type agnostic code to include the prefix.
  */
 struct cxl_regs {
-	union {
-		struct {
-			CXL_COMPONENT_REGS();
-		};
-		struct cxl_component_regs component;
-	};
-	union {
-		struct {
-			CXL_DEVICE_REGS();
-		};
-		struct cxl_device_regs device_regs;
-	};
+	/*
+	 * Common set of CXL Component register block base pointers
+	 * @hdm_decoder: CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure
+	 */
+	struct_group_tagged(cxl_component_regs, component,
+		void __iomem *hdm_decoder;
+	);
+	/*
+	 * Common set of CXL Device register block base pointers
+	 * @status: CXL 2.0 8.2.8.3 Device Status Registers
+	 * @mbox: CXL 2.0 8.2.8.4 Mailbox Registers
+	 * @memdev: CXL 2.0 8.2.8.5 Memory Device Registers
+	 */
+	struct_group_tagged(cxl_device_regs, device_regs,
+		void __iomem *status, *mbox, *memdev;
+	);
 };
 
 struct cxl_reg_map {
-- 
2.30.2

