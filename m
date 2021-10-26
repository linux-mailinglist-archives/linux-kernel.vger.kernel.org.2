Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7096F43BC1B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 23:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237166AbhJZVME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 17:12:04 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:55304 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235666AbhJZVMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 17:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635282579; x=1666818579;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3ypMBrk+3j6FxYmtaFh1XZoPQs9JHaCVhfPDEWck3j4=;
  b=UYOWfUxaokMs5THo/5N2U9L5UDhQ9/kDp6frgCwDUkQBnFVZyPke1UN/
   uHtrIgX469S7bIlgwTcfGeVCGNbpaYv2D7DC510umiMws7lwVgvIfVIHQ
   1Dn2mIKksW/XLORlJ83ggULHlGUJlTfEcVA1vJoEeQP9TXSpNlC16tt0J
   4=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 26 Oct 2021 14:09:38 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 14:09:37 -0700
Received: from qian-HP-Z2-SFF-G5-Workstation.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Tue, 26 Oct 2021 14:09:36 -0700
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     James Morse <james.morse@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        Qian Cai <quic_qiancai@quicinc.com>
Subject: [PATCH] KVM: arm64: Remove unused TRNG_NO_ENTROPY
Date:   Tue, 26 Oct 2021 17:09:13 -0400
Message-ID: <20211026210913.57006-1-quic_qiancai@quicinc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TRNG_NO_ENTROPY was unused when introduced and now. This is also caught by
GCC (W=2):

arch/arm64/kvm/trng.c:17: warning: macro "TRNG_NO_ENTROPY" is not used [-Wunused-macros]
   17 | #define TRNG_NO_ENTROPY   ((unsigned long)-3)

Signed-off-by: Qian Cai <quic_qiancai@quicinc.com>
---
 arch/arm64/kvm/trng.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kvm/trng.c b/arch/arm64/kvm/trng.c
index 99bdd7103c9c..6a46b3ac3970 100644
--- a/arch/arm64/kvm/trng.c
+++ b/arch/arm64/kvm/trng.c
@@ -14,7 +14,6 @@
 #define TRNG_SUCCESS			0UL
 #define TRNG_NOT_SUPPORTED		((unsigned long)-1)
 #define TRNG_INVALID_PARAMETER		((unsigned long)-2)
-#define TRNG_NO_ENTROPY			((unsigned long)-3)
 
 #define TRNG_MAX_BITS64			192
 
-- 
2.30.2

