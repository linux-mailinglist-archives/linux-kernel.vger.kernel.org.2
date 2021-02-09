Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3FD3153C8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 17:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbhBIQ0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 11:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbhBIQZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 11:25:29 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C4FC061786
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 08:24:49 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id b3so22701193wrj.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 08:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RpRFBI7aKbXuZDTdplO4uMlEuZf03cJC9y/EwRGqErk=;
        b=TyUxia1hD3NL+J2VrBNXDjo25wR7eUhQYezop+YWKD1SZvz88brr4tvYsjqbAoX4h9
         BwupS6bzf5vSW3L5jqgNQOiB/wFf68ZdH6kPXttsXhbo/8fOD+McPuumr/Tm3osGAqUu
         Uw3OzWQrJFYV9qRE8EIXAv0WgFlJi/sz8ZBUVMTJQFGRi5DDVNdg7MMDlUJQU0Q7uTsH
         8wuBxE7sSwmeF5XE9RiPfYMik9lNm5mTeT+UMQcChhVXh4dZYiyYvO83ZI9D55+Y+4ap
         BAjLFHOrcMBYOLiMTtjH+CawRITezWzT0d5L4Cpcib55+VWzf5OBR1EBTP+SlLHe4ZbO
         JyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RpRFBI7aKbXuZDTdplO4uMlEuZf03cJC9y/EwRGqErk=;
        b=kDNb08rtd2FsfggSujB15APBk+iRiqT8ZkENP7aQLWYwcpYonRbQdLFtuPlUKvDQQW
         Sd5QtVBAlrd0vk1i7rbVW999/kwQ81GcdhUl95h8c8bdFp/o+rWs4tIfm4ANI7ZEpAtI
         dUXqkX8bCtdHdrDuL0it0JcGhTkXRF1BPyxr/Wtx6I+bXSve1dk00JN6oYQ7xmsynCCk
         MBiSfvvCrIT4pbKAAp2ZoOhiQTXLGAIVv4QCO61ZLehDhsyHLluyx348Ur+TIRYmkFjp
         plGLHbbhyXD/50SLVIOzvbWOkGSUSm/TGgjB5cPzwdGaQw2pyvqjyIHVMv+Fi3OBR+gv
         oxWw==
X-Gm-Message-State: AOAM533m55aq8LkhjO9Cf2/YCSX4J5td2B3Vn45wK1vkHPkRs1dX2yxS
        uCMxH6Sxq+SLKJOPRk+C71CYXQ==
X-Google-Smtp-Source: ABdhPJxHaDkT4suJomqyo4M7fMIiESKtRKbbFCU/DRB6TFFGc/RFkt7+1m2jVUORI5xNGLQxSxhyhw==
X-Received: by 2002:adf:ea12:: with SMTP id q18mr12760655wrm.79.1612887888332;
        Tue, 09 Feb 2021 08:24:48 -0800 (PST)
Received: from localhost.localdomain (hst-221-125.medicom.bg. [84.238.221.125])
        by smtp.gmail.com with ESMTPSA id w8sm45210wrm.21.2021.02.09.08.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 08:24:47 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v5 1/5] v4l: Add new Colorimetry Class
Date:   Tue,  9 Feb 2021 18:24:21 +0200
Message-Id: <20210209162425.3970393-2-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210209162425.3970393-1-stanimir.varbanov@linaro.org>
References: <20210209162425.3970393-1-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Colorimetry control class for colorimetry controls

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/v4l2-core/v4l2-ctrls.c | 7 ++++++-
 include/uapi/linux/v4l2-controls.h   | 4 ++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
index 016cf6204cbb..335cf354f51b 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -1201,6 +1201,10 @@ const char *v4l2_ctrl_get_name(u32 id)
 	case V4L2_CID_STATELESS_H264_SLICE_PARAMS:		return "H264 Slice Parameters";
 	case V4L2_CID_STATELESS_H264_DECODE_PARAMS:		return "H264 Decode Parameters";
 	case V4L2_CID_STATELESS_FWHT_PARAMS:			return "FWHT Stateless Parameters";
+
+	/* Colorimetry controls */
+	/* Keep the order of the 'case's the same as in v4l2-controls.h! */
+	case V4L2_CID_COLORIMETRY_CLASS:	return "Colorimetry Controls";
 	default:
 		return NULL;
 	}
@@ -1389,8 +1393,9 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
 	case V4L2_CID_RF_TUNER_CLASS:
 	case V4L2_CID_DETECT_CLASS:
 	case V4L2_CID_CODEC_STATELESS_CLASS:
+	case V4L2_CID_COLORIMETRY_CLASS:
 		*type = V4L2_CTRL_TYPE_CTRL_CLASS;
-		/* You can neither read not write these */
+		/* You can neither read nor write these */
 		*flags |= V4L2_CTRL_FLAG_READ_ONLY | V4L2_CTRL_FLAG_WRITE_ONLY;
 		*min = *max = *step = *def = 0;
 		break;
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index 039c0d7add1b..a41039559193 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -66,6 +66,7 @@
 #define V4L2_CTRL_CLASS_RF_TUNER	0x00a20000	/* RF tuner controls */
 #define V4L2_CTRL_CLASS_DETECT		0x00a30000	/* Detection controls */
 #define V4L2_CTRL_CLASS_CODEC_STATELESS 0x00a40000	/* Stateless codecs controls */
+#define V4L2_CTRL_CLASS_COLORIMETRY	0x00a50000	/* Colorimetry controls */
 
 /* User-class control IDs */
 
@@ -1657,6 +1658,9 @@ struct v4l2_ctrl_fwht_params {
 	__u32 quantization;
 };
 
+#define V4L2_CID_COLORIMETRY_CLASS_BASE	(V4L2_CTRL_CLASS_COLORIMETRY | 0x900)
+#define V4L2_CID_COLORIMETRY_CLASS	(V4L2_CTRL_CLASS_COLORIMETRY | 1)
+
 /* MPEG-compression definitions kept for backwards compatibility */
 #ifndef __KERNEL__
 #define V4L2_CTRL_CLASS_MPEG            V4L2_CTRL_CLASS_CODEC
-- 
2.25.1

