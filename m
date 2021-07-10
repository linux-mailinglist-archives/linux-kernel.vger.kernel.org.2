Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4AFD3C3360
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 09:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhGJHFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 03:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbhGJHE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 03:04:59 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CDEC0613DD
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 00:02:15 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d12so10907372pfj.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 00:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hdw+Y8ePcpmL93WaBQ0NtdSK7j8tLADFniGhpLrQBiU=;
        b=bdC7FTR5+xw2eR02RQ9QsXTfdLuJ126SHouurAJiP27yYqtJUyGmkdS3coEOXUEPtQ
         yqKhjiZql05paXY9mqrwG5MVzcUC8CDa4CK3jn/fUzv92go2aHfabbl9ANsm1/he9Pjw
         CNROE0P7Ody7lUY7hW4X3KN1KKmUn4U4NMRcErbNrUv19JabgRXbR0b1wpPkgg0M8ABj
         MSgBCeExz3pkgeRqyWaDr/b2Rd2UOn2f4PqKMKHsM/1YmMChOpoURgrSipcAcWIqeG14
         HKg/uAJhIs5GjrLld1B03n98R4FBhdQT+YwtboBflz1MAli2Cn6TYSudWPmbCpMJ09y9
         0jgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hdw+Y8ePcpmL93WaBQ0NtdSK7j8tLADFniGhpLrQBiU=;
        b=KahsH+nKsLflBkHR6Iyi3mAROQ3IpFW4OP0w6yEz/63LaIVMhbstotO84i/I3tK4aP
         aZ75XW9Pi+Mv/rmWR43xX8REUXRP5n1GERvLjbsjyDGFgjP9cCsHMhzm3qfRZaosOfsd
         7qdk/2R4tMpb5TdrZmcfg2hqQvn7cP50La52oJucgKdPoBv4tnucaD6sYa8BRqPG7zMw
         HXzaEV/+7evBPSZjUVp1aNTK4GqLKDxVyvX+TMRKV1H1UnRJ4fhjemrRc1gpQ6xISNgb
         aXPQmWNNIyteNz6tYUIW+Geu4FF7m751R1WY5sh4tLyaffbqM03ZHUJLc40EKTuYjU/D
         O1Ww==
X-Gm-Message-State: AOAM533KyGeGkyJGMbSDw2RxDoUR6qt1BcJc29E1N1t+GZssz3jTo93v
        H6XASi79Fn1N8XxBmbqDyzJu4Q==
X-Google-Smtp-Source: ABdhPJw1YrMyuMsavMpXYW2qL9XqrZ9zFOmfQUKlYRGLVdvCaxcSqODVE7xWaz100nmymTp5sKZ6Ng==
X-Received: by 2002:a05:6a00:1988:b029:324:2bf0:d769 with SMTP id d8-20020a056a001988b02903242bf0d769mr22671401pfl.68.1625900534724;
        Sat, 10 Jul 2021 00:02:14 -0700 (PDT)
Received: from localhost ([103.127.241.250])
        by smtp.gmail.com with ESMTPSA id 198sm7286710pfw.21.2021.07.10.00.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 00:02:14 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 2/2] coresight: catu: Correct memory sync ranges in catu mode
Date:   Sat, 10 Jul 2021 15:02:06 +0800
Message-Id: <20210710070206.462875-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210710070206.462875-1-leo.yan@linaro.org>
References: <20210710070206.462875-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code misses to handle the case for the trace wrapping around,
thus it fails to sync the complete memory ranges in catu mode.

This patch corrects the memory sync ranges, when detects the wrapping
around case, it splits into two chunks: one chunk is the tail of the
buffer and another chunk is from the start of the buffer after wrapping
around.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-catu.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index e0740c6dbd54..634af451f0d3 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -323,7 +323,24 @@ static void catu_sync_etr_buf(struct etr_buf *etr_buf, u64 rrp, u64 rwp)
 	}
 
 	etr_buf->offset = r_offset;
-	tmc_sg_table_sync_data_range(catu_table, r_offset, etr_buf->len);
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
+		tmc_sg_table_sync_data_range(catu_table, r_offset, len1);
+		tmc_sg_table_sync_data_range(catu_table, 0, len2);
+	} else {
+		tmc_sg_table_sync_data_range(catu_table, r_offset,
+					     etr_buf->len);
+	}
 }
 
 static int catu_alloc_etr_buf(struct tmc_drvdata *tmc_drvdata,
-- 
2.25.1

