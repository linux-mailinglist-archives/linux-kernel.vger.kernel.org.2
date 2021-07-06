Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606493BD6FF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 14:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbhGFMtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 08:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240758AbhGFMsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 08:48:41 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB13C08E81A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 05:41:09 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id l5so9161964wrv.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 05:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=co2CdYXFE7Ol3YA8dMqb29CNEHa7yCiGPitI5faXCjs=;
        b=VSX7etRg+C/iteL/+Pb2AdgcflfCAwFn3ui7ugZTOUwrS12OZTDV9tPDDN2wwwCh6w
         bgyrJ6QxxX4XD2miuFTTcHYoqtHcqhQNqN2PUWR+ztdNuTjSBc/I0W/Ftbi03lSNGG5s
         hD9/kqv5ph+ayeA83Je8wsNvLkFRLOpF57+yE82a6/2XRW6TVghkWgyj25p07Rc6ZuVO
         0yK6WbZclRm0qm/xszR+c8Nrk6EAi1J7itus+tEqU5vVBUj7yYft3VlFzPtFJkm5VVxc
         GQFFyA0DLA7It2XZU/oaPq+2A4Gp86jQFWZeYfepa9sY0TSbwEvSqrZSSJqQ9t5wI+41
         JDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=co2CdYXFE7Ol3YA8dMqb29CNEHa7yCiGPitI5faXCjs=;
        b=N+B5pjw/BBL5t80YAKWKYZLVlhSJJAQ3G/BrxD3IwpMKdd/WUHs6ow8U7zRixMspjT
         VerSYJPPKeYhZhWSRwDpt8ljEDiq4XOSiay1n5eA7IowntmBYnaY7TQGgKuvo6U8vEAH
         vWg9aHJDo919C5cuBxQKsUkWhne5a8G4TF84qk+8c3ITB5NacA8zUhW8XlP8KBm4ED9A
         nwNbpJA2FP7ESAVKpW1r1Nc2xq1V8CY2zY5bLYahxPAjvfuuuffR3WjE3lvsJXNUwu6M
         gjLVojsOKtuRX5sMpOdGghYiDPQxFKlnF136NhiBevFcYY1JE8excoyc3/YFJALdtlwL
         w8Sg==
X-Gm-Message-State: AOAM533P2CCl/rAgtMnvjdfeooWbWNBfhJp7h9Pnh1tVovf7RwsgahVk
        T6KqEWmQVnVr+kSBBhrlQqD9cA==
X-Google-Smtp-Source: ABdhPJxS4TH7SeppkR7aTUrIgzMdkRTUiLyRaR7vSDAXwseluDbqNAVMEsaLquWusMulqVeQ7udjYA==
X-Received: by 2002:adf:f642:: with SMTP id x2mr17929574wrp.37.1625575268165;
        Tue, 06 Jul 2021 05:41:08 -0700 (PDT)
Received: from localhost.localdomain (hst-221-27.medicom.bg. [84.238.221.27])
        by smtp.gmail.com with ESMTPSA id n18sm2585979wms.3.2021.07.06.05.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 05:41:07 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v2 2/5] venus: helpers: Add helper to check supported pixel formats
Date:   Tue,  6 Jul 2021 15:40:31 +0300
Message-Id: <20210706124034.773503-3-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210706124034.773503-1-stanimir.varbanov@linaro.org>
References: <20210706124034.773503-1-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper to check supported pixel format per codec and session
type.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/helpers.c | 23 +++++++++++++++++++++
 drivers/media/platform/qcom/venus/helpers.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 1fe6d463dc99..48da88d21ccd 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -1725,6 +1725,29 @@ int venus_helper_get_out_fmts(struct venus_inst *inst, u32 v4l2_fmt,
 }
 EXPORT_SYMBOL_GPL(venus_helper_get_out_fmts);
 
+bool venus_helper_check_format(struct venus_inst *inst, u32 v4l2_pixfmt)
+{
+	struct venus_core *core = inst->core;
+	u32 fmt = to_hfi_raw_fmt(v4l2_pixfmt);
+	struct hfi_plat_caps *caps;
+	u32 buftype;
+
+	if (!fmt)
+		return false;
+
+	caps = venus_caps_by_codec(core, inst->hfi_codec, inst->session_type);
+	if (!caps)
+		return false;
+
+	if (inst->session_type == VIDC_SESSION_TYPE_DEC)
+		buftype = HFI_BUFFER_OUTPUT2;
+	else
+		buftype = HFI_BUFFER_OUTPUT;
+
+	return find_fmt_from_caps(caps, buftype, fmt);
+}
+EXPORT_SYMBOL_GPL(venus_helper_check_format);
+
 int venus_helper_set_stride(struct venus_inst *inst,
 			    unsigned int width, unsigned int height)
 {
diff --git a/drivers/media/platform/qcom/venus/helpers.h b/drivers/media/platform/qcom/venus/helpers.h
index e6269b4be3af..00ecb39d7f6b 100644
--- a/drivers/media/platform/qcom/venus/helpers.h
+++ b/drivers/media/platform/qcom/venus/helpers.h
@@ -51,6 +51,7 @@ void venus_helper_init_instance(struct venus_inst *inst);
 int venus_helper_session_init(struct venus_inst *inst);
 int venus_helper_get_out_fmts(struct venus_inst *inst, u32 fmt, u32 *out_fmt,
 			      u32 *out2_fmt, bool ubwc);
+bool venus_helper_check_format(struct venus_inst *inst, u32 v4l2_pixfmt);
 int venus_helper_alloc_dpb_bufs(struct venus_inst *inst);
 int venus_helper_free_dpb_bufs(struct venus_inst *inst);
 int venus_helper_intbufs_alloc(struct venus_inst *inst);
-- 
2.25.1

