Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4212F3F84BC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 11:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240784AbhHZJsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 05:48:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233249AbhHZJsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 05:48:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9618610C8;
        Thu, 26 Aug 2021 09:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629971253;
        bh=lpekgNllohbTsJscCE+DMZSVVOYatSpbb1/0ifhgDZ4=;
        h=From:To:Cc:Subject:Date:From;
        b=RM3sLxr1CNNYU8rip+S4irEnE1aPku4co1yFxiIr+dQLoCTFRu0aDmSN8lvnenats
         FsTbfCL1q6NjA/ca3aTXZZXQMA/6vySUr6ELv3bxF8twR/qHZNhsdegffOW9CXkgl+
         ESfDlXzwGCL77SOo1LsFC086e+4qQ712FNOdRy7/E3qe37yaKgO2eKVM0akU/bYssU
         ryXLSMxfL46sbAMOGtAmK/874aihG/O0ydp+A4asB3vYPjIRkZWqPNCa5kNXacE9Sh
         e2viBmeViIephLX/W0zoIfOHNb/aXGyAKJ2Iwn1qxoEDglRW5MIB8lf+c8kIqyCrkX
         +xO90Lj9Fq5vg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Rajaravi Krishna Katta <rkatta@habana.ai>
Subject: [PATCH] habanalabs/gaudi: hwmon default card name
Date:   Thu, 26 Aug 2021 12:47:28 +0300
Message-Id: <20210826094728.16336-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajaravi Krishna Katta <rkatta@habana.ai>

This commit corrects CARD NAME for Gaudi as "HL205"

Signed-off-by: Rajaravi Krishna Katta <rkatta@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudiP.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index 7addb31e3eee..bbbf1c343e75 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -66,7 +66,7 @@
 
 #define DMA_MAX_TRANSFER_SIZE		U32_MAX
 
-#define GAUDI_DEFAULT_CARD_NAME		"HL2000"
+#define GAUDI_DEFAULT_CARD_NAME		"HL205"
 
 #define GAUDI_MAX_PENDING_CS		SZ_16K
 
-- 
2.17.1

