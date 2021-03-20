Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8393B342E10
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 16:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhCTP5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 11:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhCTP5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 11:57:13 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC94C061763
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 08:57:12 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id z9so10844695ilb.4
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 08:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JhdFcchuQBPn7JgNfClVq2sxbKjMlI0nSg0rBIySRpM=;
        b=RxDCVYWR0JpZLmlxHNEHDiAVyEPbw4lRR74XpQVXdlGNM3D1BAgHcsXYQh88Jg5aMm
         gAimnTtcYbB5vWOCJ54B42zxcBGKte/eVBFHsylydigT5eBjX/zwb3fpmoda/qrSB8bL
         Lf4NvUbf9xADjXGQ8qyCfbL7m3yM2bTwtaeb5+d6PwJYxUgeFMocMPkvHQ1yOhTW7pyb
         /lFPtMgmt/cBjGgq484GqaRuKCOrhUu5cBVFoLkyu4LBjzVrm8Rjb5i2EehLDhqxl46I
         pGxWJ4kWIKouEdoIIdLt1/TbEGuCVfc11qRL1xbaX4gfwWNWoYadNb8UlNdW9zaSzYWc
         fWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JhdFcchuQBPn7JgNfClVq2sxbKjMlI0nSg0rBIySRpM=;
        b=S5XCo792gxl0Ri+5G70mAaK9tyzvXZn8JfEZN6buBEUGr/vp/E5poX1aClHHHRH5Gl
         W/1B0BpIDVduvhzphn+MaCxrKIGvGPSvVpiGkTDCykYvQLaN43iH2J15YvmT9bOWFEJj
         3EbsLQ2yYS+6bclGzWeuqYkYUhPd0UuRIMlj0lD1pvMUOKgAbl1FoNTfrpBr4WKPgget
         t5K9djLkhLDTLXobOVEi89ZYSENAVm/ErbLKn4GIraxhRxNMDWqk9xtT0m7cQkv1G8JQ
         hDPLBlV395hW2PjdkesFFRBstzUpg4AYsvTbvuIcUH0GAhy/0iLi9Hc+YXQXCwOJVY5R
         Sv6Q==
X-Gm-Message-State: AOAM532M/SXbdXl3dPgDCxh8OmNLUlZl7YFlFbShwZKGRDO2dhR5FTcK
        OTJEXjhn5mKFfSFZd7fi8XNimg==
X-Google-Smtp-Source: ABdhPJz2NLSwP7TGVTcSh9r0WtpNkf+iNttrIMlGc91793ARdrbSNGB4UkY8Q+H7DsbrdRgoYTneSg==
X-Received: by 2002:a92:c6d0:: with SMTP id v16mr6034829ilm.289.1616255832385;
        Sat, 20 Mar 2021 08:57:12 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id n16sm4501698ilq.71.2021.03.20.08.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 08:57:12 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/5] net: ipa: implement MAX_READS_BEATS QSB data
Date:   Sat, 20 Mar 2021 10:57:04 -0500
Message-Id: <20210320155707.2009962-3-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210320155707.2009962-1-elder@linaro.org>
References: <20210320155707.2009962-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting with IPA v4.0, a limit is placed on the number of bytes
outstanding in a transaction, to reduce latency.  The limit is
imposed only if this value is non-zero.

We don't use a non-zero value for SC7180, but newer versions of IPA
do.  Prepare for that by allowing a programmed value to be specified
in the platform configuration data.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_data-sc7180.c |  1 +
 drivers/net/ipa/ipa_data.h        |  2 ++
 drivers/net/ipa/ipa_main.c        | 10 ++++++++--
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ipa/ipa_data-sc7180.c b/drivers/net/ipa/ipa_data-sc7180.c
index 216f790b22b66..8fa10d0d9a4e7 100644
--- a/drivers/net/ipa/ipa_data-sc7180.c
+++ b/drivers/net/ipa/ipa_data-sc7180.c
@@ -14,6 +14,7 @@ static const struct ipa_qsb_data ipa_qsb_data[] = {
 	[IPA_QSB_MASTER_DDR] = {
 		.max_writes	= 8,
 		.max_reads	= 12,
+		/* no outstanding read byte (beat) limit */
 	},
 };
 
diff --git a/drivers/net/ipa/ipa_data.h b/drivers/net/ipa/ipa_data.h
index d50cd5ae7714f..4162c4722c00c 100644
--- a/drivers/net/ipa/ipa_data.h
+++ b/drivers/net/ipa/ipa_data.h
@@ -59,10 +59,12 @@ enum ipa_qsb_master_id {
  * struct ipa_qsb_data - Qualcomm System Bus configuration data
  * @max_writes:	Maximum outstanding write requests for this master
  * @max_reads:	Maximum outstanding read requests for this master
+ * @max_reads_beats: Max outstanding read bytes in 8-byte "beats" (if non-zero)
  */
 struct ipa_qsb_data {
 	u8 max_writes;
 	u8 max_reads;
+	u8 max_reads_beats;		/* Not present for IPA v3.5.1 */
 };
 
 /**
diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index 1ce593b46b04c..64b92dfdd3f5c 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -274,10 +274,16 @@ ipa_hardware_config_qsb(struct ipa *ipa, const struct ipa_data *data)
 
 	/* Max outstanding read accesses for QSB masters */
 	val = u32_encode_bits(data0->max_reads, GEN_QMB_0_MAX_READS_FMASK);
-	/* GEN_QMB_0_MAX_READS_BEATS is 0 (IPA v4.0 and above) */
-	if (data->qsb_count > 1)
+	if (ipa->version >= IPA_VERSION_4_0)
+		val |= u32_encode_bits(data0->max_reads_beats,
+				       GEN_QMB_0_MAX_READS_BEATS_FMASK);
+	if (data->qsb_count > 1) {
 		val |= u32_encode_bits(data1->max_reads,
 				       GEN_QMB_1_MAX_READS_FMASK);
+		if (ipa->version >= IPA_VERSION_4_0)
+			val |= u32_encode_bits(data1->max_reads_beats,
+					       GEN_QMB_1_MAX_READS_BEATS_FMASK);
+	}
 	iowrite32(val, ipa->reg_virt + IPA_REG_QSB_MAX_READS_OFFSET);
 }
 
-- 
2.27.0

