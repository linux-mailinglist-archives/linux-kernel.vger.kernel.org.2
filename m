Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37C43C335F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 09:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbhGJHE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 03:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbhGJHE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 03:04:57 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E07C0613DD
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 00:02:12 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so7328072pjo.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 00:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ETf7pOEa7vSxLlHOHWrCI0L1NDAZ4Qs1/MDoyQ30i9c=;
        b=lB9cYyqpUjUkPkf04lKmAg6MHYoaHoM1BMqSMScPrqEHGVr1VWJYWSZLyvAOCYlA8F
         q5nYqinJ8ROUd9upqlTRFHuZb2LIo3aQUGZ9TfypTDAMdAuyrv4HYxoELmmY2dqoG9l0
         SjBygYJbqizSXGOcUYC/+M5/njz6vAZWNdoBL71hDHw1GdEWwvcl4C9+m7ISFfCtq16x
         qktvBFGTF9P7bWASi6dCTnc25I3zd3H+iRA7pr0SvyJuHPAcg0wpfG7URCFjhFaBrr52
         q4TY+wLRP0QIc9u4zN08Eaau5QbnOsEN5cwVVSeqewBck2wnjAdfpC5JFRqZIQOUQchu
         7JlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ETf7pOEa7vSxLlHOHWrCI0L1NDAZ4Qs1/MDoyQ30i9c=;
        b=JEu38OZLfkBZUC5ViaLS54hV8DTCvE4GhFzRkhxmp/viJq9g/40unDkcudIR2bOCEr
         aGiKTd0hTUCKhwBxuntCRzHjss2+4Sk381/ZwCEb9uuIWA85zPgEt0gst9xqaut5lqZC
         aflkG02emP4rbRoYDddmo0EBWdIwSWE4XR7va0Zbhd7i3gj2Xz1V4CYH1mZq3yDeJ5WK
         Hv729vQU3rY5HmHlUpca3vYmebly3wTMOPTupclm+NKgohhP1XkCL2EP3DXPO2vNor/U
         A2rcco8eFkA7FnYkH+CqczbWsWV0H/2TgbGsaQMZAT2nfB0ZVsOM80JjR0vvsbgSsUIJ
         WwHw==
X-Gm-Message-State: AOAM532OQeUc4gFs95H+rVbPWXSflo0DEQF5p8eGrJ3ktf2J+DVY02L7
        9rK3lxVCeVVhp2nstLbXsN657g==
X-Google-Smtp-Source: ABdhPJyn1QuKxnthyYisrDWv3egVrcLnyGkTYowcKSgAEMw5SQA/TId6HXA4lPRJhNkc2zKYkwmX2A==
X-Received: by 2002:a17:902:ed84:b029:129:73d9:b83d with SMTP id e4-20020a170902ed84b029012973d9b83dmr31014378plj.43.1625900531889;
        Sat, 10 Jul 2021 00:02:11 -0700 (PDT)
Received: from localhost ([103.127.241.250])
        by smtp.gmail.com with ESMTPSA id r14sm4068429pfg.161.2021.07.10.00.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 00:02:11 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 1/2] coresight: tmc-etr: Correct memory sync ranges in SG mode
Date:   Sat, 10 Jul 2021 15:02:05 +0800
Message-Id: <20210710070206.462875-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code syncs the buffer range is [offset, offset+len), it doesn't
consider the case when the trace data is wrapped around, in this case
'offset+len' is bigger than 'etr_buf->size'.  Thus it syncs buffer out
of the memory buffer, and it also misses to sync buffer from the start
of the memory.

This patch corrects the memory sync ranges, when detects the wrapping
around case, it splits into two chunks: one chunk is the tail of the
buffer and another chunk is from the start of the buffer after wrapping
around.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../hwtracing/coresight/coresight-tmc-etr.c    | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 888b0f929d33..a1afefcbf175 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -780,7 +780,23 @@ static void tmc_etr_sync_sg_buf(struct etr_buf *etr_buf, u64 rrp, u64 rwp)
 	else
 		etr_buf->len = ((w_offset < r_offset) ? etr_buf->size : 0) +
 				w_offset - r_offset;
-	tmc_sg_table_sync_data_range(table, r_offset, etr_buf->len);
+
+	if (r_offset + etr_buf->len > etr_buf->size) {
+		int len1, len2;
+
+		/*
+		 * If trace data is wrapped around, sync AUX bounce buffer
+		 * for two chunks: "len1" is for the trace date length at
+		 * the tail of bounce buffer, and "len2" is the length from
+		 * the start of the buffer after wrapping around.
+		 */
+		len1 = etr_buf->size - r_offset;
+		len2 = etr_buf->len - len1;
+		tmc_sg_table_sync_data_range(table, r_offset, len1);
+		tmc_sg_table_sync_data_range(table, 0, len2);
+	} else {
+		tmc_sg_table_sync_data_range(table, r_offset, etr_buf->len);
+	}
 }
 
 static const struct etr_buf_operations etr_sg_buf_ops = {
-- 
2.25.1

