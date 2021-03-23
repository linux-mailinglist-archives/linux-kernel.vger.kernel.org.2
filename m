Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D80B3461F8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 15:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbhCWOxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 10:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbhCWOvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:51:43 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886DBC0613D8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 07:51:42 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id c17so18379706ilj.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 07:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=urnf0slLMOPXg7nga5dabZHaUvtoQMaa3zOQvFLPfpg=;
        b=pfdUAefHTU48e5RsyI0UEot4pGuYp3/Kjriu7AGl/84y+Q8gwbMTFs7Ii+0fzyu1na
         x2fk6H0UJj/eSixj+rpfeRRRjXKbXFE/MsGI2cXNIqNpGktqAozO6FfsqHjwVwJUILyZ
         GSYWTz/X2jz//fdZFgsxPWmrdcU3FmF3VUn3aWI9XuuteiOPmtsQwpA/5rQBuNkvZ7+T
         CV0RZb9/0zl3UrjC94v3at64nYulTNFCKdzPtpNzJ9RXl8yzDqTiPBw6+XHInH1waEqm
         ZgMoJHTJb/NeRvMV6lrgy1gQnYLAlslMO6cwgOLmP1Tjarlh1NtFXTamUBzUtSPNVsDE
         p54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=urnf0slLMOPXg7nga5dabZHaUvtoQMaa3zOQvFLPfpg=;
        b=YztcwgklBNTjmHibpkvd0roejKw8zurNV/z88VpF8kCoySxA9eBy0KRGjOqWR4wm/6
         DBdJoLBVIf9OqFDPIovBV6L0+Xinuwf2N+B4TU/z38KDoG13NxPg4Roh2RszYbeTySFN
         /ag19G7/o+JwanEdWvb3B++3j/E9hodVr9V9+PZYnRKptvtpY+MjWKI22SCjPv9PPupU
         R6DUaZa/wLe7dUyVjSiCQhwitdckRBuxjgPEYrwPJDPl1kuW6Il6Ae4X3IeGZQkm9l4B
         WF7Dn0QdOQwFFOfeQ2T1DmIgpDMEqK2y/61XiY3ugOCF3axiEB/cM5X5+dHacf0La9Zl
         ywMw==
X-Gm-Message-State: AOAM531mhYK9rOmZ49ie0Fiet0+dnjZxXI4rx9xxO+AZ+tl/aXhNg/H9
        K+ilvCBivcAEIA9f6hhjIcy3Lg==
X-Google-Smtp-Source: ABdhPJx5IpgaoIDQgTKR/80zskZFPXeu0K27Ryw76Opbl+jAdilTF/0v3HMlUptpmwwhgeDkZVj3Eg==
X-Received: by 2002:a92:611:: with SMTP id x17mr5313351ilg.261.1616511101981;
        Tue, 23 Mar 2021 07:51:41 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id o13sm8961147iob.17.2021.03.23.07.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 07:51:41 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/6] net: ipa: limit local processing context address
Date:   Tue, 23 Mar 2021 09:51:30 -0500
Message-Id: <20210323145132.2291316-5-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210323145132.2291316-1-elder@linaro.org>
References: <20210323145132.2291316-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all of the bits of the LOCAL_PKT_PROC_CNTXT register are valid.
Until IPA v4.5, there are 17 valid bits (though the bottom three
must be zero).  Starting with IPA v4.5, 18 bits are valid.

Introduce proc_cntxt_base_addr_encoded() to encode the base address
for use in the register using only the valid bits.

Shorten the name of the register (omit "_BASE") to avoid the need to
wrap the line in the one place it's used.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_mem.c |  6 ++++--
 drivers/net/ipa/ipa_reg.h | 14 ++++++++++++--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ipa/ipa_mem.c b/drivers/net/ipa/ipa_mem.c
index f25029b9ec857..32907dde5dc6a 100644
--- a/drivers/net/ipa/ipa_mem.c
+++ b/drivers/net/ipa/ipa_mem.c
@@ -61,6 +61,7 @@ int ipa_mem_setup(struct ipa *ipa)
 	struct gsi_trans *trans;
 	u32 offset;
 	u16 size;
+	u32 val;
 
 	/* Get a transaction to define the header memory region and to zero
 	 * the processing context and modem memory regions.
@@ -89,8 +90,9 @@ int ipa_mem_setup(struct ipa *ipa)
 	gsi_trans_commit_wait(trans);
 
 	/* Tell the hardware where the processing context area is located */
-	iowrite32(ipa->mem_offset + ipa->mem[IPA_MEM_MODEM_PROC_CTX].offset,
-		  ipa->reg_virt + IPA_REG_LOCAL_PKT_PROC_CNTXT_BASE_OFFSET);
+	offset = ipa->mem_offset + ipa->mem[IPA_MEM_MODEM_PROC_CTX].offset;
+	val = proc_cntxt_base_addr_encoded(ipa->version, offset);
+	iowrite32(val, ipa->reg_virt + IPA_REG_LOCAL_PKT_PROC_CNTXT_OFFSET);
 
 	return 0;
 }
diff --git a/drivers/net/ipa/ipa_reg.h b/drivers/net/ipa/ipa_reg.h
index bba088e80cd1e..cbfef27bbcf2c 100644
--- a/drivers/net/ipa/ipa_reg.h
+++ b/drivers/net/ipa/ipa_reg.h
@@ -217,8 +217,18 @@ static inline u32 ipa_reg_bcr_val(enum ipa_version version)
 	return 0x00000000;
 }
 
-/* The value of the next register must be a multiple of 8 */
-#define IPA_REG_LOCAL_PKT_PROC_CNTXT_BASE_OFFSET	0x000001e8
+/* The value of the next register must be a multiple of 8 (bottom 3 bits 0) */
+#define IPA_REG_LOCAL_PKT_PROC_CNTXT_OFFSET		0x000001e8
+
+/* Encoded value for LOCAL_PKT_PROC_CNTXT register BASE_ADDR field */
+static inline u32 proc_cntxt_base_addr_encoded(enum ipa_version version,
+					       u32 addr)
+{
+	if (version < IPA_VERSION_4_5)
+		return u32_encode_bits(addr, GENMASK(16, 0));
+
+	return u32_encode_bits(addr, GENMASK(17, 0));
+}
 
 /* ipa->available defines the valid bits in the AGGR_FORCE_CLOSE register */
 #define IPA_REG_AGGR_FORCE_CLOSE_OFFSET			0x000001ec
-- 
2.27.0

