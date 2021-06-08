Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5FB39F567
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 13:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhFHLpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 07:45:41 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:37483 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbhFHLpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:45:40 -0400
Received: by mail-ed1-f42.google.com with SMTP id b11so24152634edy.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 04:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tFrq06L55Y88t1UsTNBMVBuhf1oW5jJWDm/FwjGxUTg=;
        b=Jp3nTomJgkEhgEeyNwnrzndFq1i5o2nkzUWx/TjttTeXoFc+xDqbl/RePlnQ34/o83
         aqETP9FV1A5nviFpqiUOhI2WiaWjQQCMqjUKjA7UUHB8kzTqJIA/gnWnur/Sb5Ayux/Y
         +VNdJOZdweRnciUJCKJxa76D1XseXobydCW9A/ZXTNUK2RLxcJFjkV06DEyndn1U3aNN
         bEzQOZ1jG2C2ZqEw57GLBKOoRD5TIqcNe9HTaMWLorKiUiyHw3qxr/pvZRh3itKpaMXp
         UKXp2+v37eTFZ8u41Xlq1T7meq98CeBY5+/mBUbNCkhsPrEticL4nsfddP52mycsznqM
         GmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tFrq06L55Y88t1UsTNBMVBuhf1oW5jJWDm/FwjGxUTg=;
        b=s2+W35NjuCnjo4a+FV+V6eWC8zwsrNfZ0izhV/Rt6+3LXtbgFx3aVnidge8J28nRfp
         e0YR2vOEYoWq06MJURsflc+k5hrhnreeVXR2+XqtFGsFz7ctR7NZfa+Qscn/ddSNx20A
         6Jj6+okxsQoxTVJM+Ta+GowSgAADQPvXXj0muqAflXiqvnSKws528ISWV3AQ9fgq0iS6
         JVwRmsIK2ZNz507YWHu9xlZAM0d91ueMLUsWlX8C8R2q0xZtiWC2AinDyzSDcIIxA+iY
         zWpm5heZ9+vV7CKHEZxLC46ZPnmJ0F6O15i/+tUfy1M0cOyAQsabPJn9MIzumdhJY8rX
         UcWQ==
X-Gm-Message-State: AOAM530T96hE4bZ4xJ8NOENhEMgbiWwouQlkKlIUrOZ82WE3azLOBtDn
        3zit9xPW14NMy1wyxUYhyctHm9qkylxIb0PP
X-Google-Smtp-Source: ABdhPJw+uZQIHhLXGaXT3Ui6sOHP3nHG5aE5HnbKkLgQyrNANYbcdjG1Cf5aIH/wLOQ8wn/6cXokpg==
X-Received: by 2002:aa7:c68f:: with SMTP id n15mr9554873edq.145.1623152551207;
        Tue, 08 Jun 2021 04:42:31 -0700 (PDT)
Received: from localhost.localdomain (hst-221-104.medicom.bg. [84.238.221.104])
        by smtp.gmail.com with ESMTPSA id x4sm8754740edq.23.2021.06.08.04.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 04:42:30 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vikash Garodia <vgarodia@codeaurora.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v2 4/5] venus: helpers: Add helper to mark fatal vb2 error
Date:   Tue,  8 Jun 2021 14:41:55 +0300
Message-Id: <20210608114156.87018-5-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210608114156.87018-1-stanimir.varbanov@linaro.org>
References: <20210608114156.87018-1-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper to mark source and destination vb2 queues fatal
unrecoverable error.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/helpers.c | 12 ++++++++++++
 drivers/media/platform/qcom/venus/helpers.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 210c628ac8f4..abd41ebf3c1b 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -1505,6 +1505,18 @@ void venus_helper_vb2_stop_streaming(struct vb2_queue *q)
 }
 EXPORT_SYMBOL_GPL(venus_helper_vb2_stop_streaming);
 
+void venus_helper_vb2_queue_error(struct venus_inst *inst)
+{
+	struct v4l2_m2m_ctx *m2m_ctx = inst->m2m_ctx;
+	struct vb2_queue *q;
+
+	q = v4l2_m2m_get_src_vq(m2m_ctx);
+	vb2_queue_error(q);
+	q = v4l2_m2m_get_dst_vq(m2m_ctx);
+	vb2_queue_error(q);
+}
+EXPORT_SYMBOL_GPL(venus_helper_vb2_queue_error);
+
 int venus_helper_process_initial_cap_bufs(struct venus_inst *inst)
 {
 	struct v4l2_m2m_ctx *m2m_ctx = inst->m2m_ctx;
diff --git a/drivers/media/platform/qcom/venus/helpers.h b/drivers/media/platform/qcom/venus/helpers.h
index e6269b4be3af..6a250c3d3cfe 100644
--- a/drivers/media/platform/qcom/venus/helpers.h
+++ b/drivers/media/platform/qcom/venus/helpers.h
@@ -21,6 +21,7 @@ int venus_helper_vb2_buf_prepare(struct vb2_buffer *vb);
 void venus_helper_vb2_buf_queue(struct vb2_buffer *vb);
 void venus_helper_vb2_stop_streaming(struct vb2_queue *q);
 int venus_helper_vb2_start_streaming(struct venus_inst *inst);
+void venus_helper_vb2_queue_error(struct venus_inst *inst);
 void venus_helper_m2m_device_run(void *priv);
 void venus_helper_m2m_job_abort(void *priv);
 int venus_helper_get_bufreq(struct venus_inst *inst, u32 type,
-- 
2.25.1

