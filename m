Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953933839F9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 18:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244218AbhEQQeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 12:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244511AbhEQQdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 12:33:47 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CF3C059C94
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 08:22:40 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id et19so2726921ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 08:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P+7sG3/Jmv/wBWtoh3/MZVcO8CZp8esktTkHoMkDLYo=;
        b=F2kCUFghNi6IMOwnEJibP3dYc7YqvFgTZRqgv0xN8X19MV446rQsXUcEQTHrUX+IH9
         b3aEfLWz5VrQO2SZY2ERucBM5qXFxazXeiOSwUeAl9bu5pm5zYVFgJ3dB1GRWiR6sr1/
         JT/MatQ0LcOORLBA1T5NPbfJw88/xAUnmY8uGuisHdBLiDhsZJ2o6mR+amJDTDgRpQMa
         Fw5fW7O0cPzFlpqINJJuAgiKa2MngUnmHxHL8LDbZdgOTkN4Twui+G12qnwO3P29p186
         p+XpStg/jKOKzpzS4Fs49ZvFkC688Ad4QvNn+WtP2grmMXurFleD3rk1Qo+Mi/vXmPCn
         6IEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P+7sG3/Jmv/wBWtoh3/MZVcO8CZp8esktTkHoMkDLYo=;
        b=bQPo0GXWbkxvkEGV4rcvQ1WrHrg2fW5F8igeekM2iKEKS7VQjoz3dL0b4BXWeDV3B2
         eji0+D8bFS73m11Ohb136lG5VC1hKfmU7q2Xq2y7Edg6VzjdXB3oKo5nEA+VR+jpmI1Z
         YSFL5P06ajPDUsGW08ZS9Fn4oHWAJQfBi+uG2XvsfMknHALsaMwI+01NNhqJqdH5cWHm
         5x0caWTSmJ38veATBPuqZSkgxpNsxcteICTJQ39pGuKZwFTrWD+UlZ8q6rYqwwnFsui4
         T1r6s2q3vymIp5r+E4g2hTiEz2PVSygdiftjzEWIz77CYIj0qcYJ4XFnIo8NL7gUvFbf
         52jg==
X-Gm-Message-State: AOAM531fc6ViplKU6FoSOLDpwGlTST0koPo3dZTipu0tX+kgqduJJQC0
        TdcMyeuuwSRXMmSWSn8WWU9GdQ==
X-Google-Smtp-Source: ABdhPJxV3U48zfxePLyqfMNwTJz43JF4mRuLiwZeYnOUA0alPW+w8WU00vbcmni2jZSBFVQmZoYrCQ==
X-Received: by 2002:a17:906:fcb4:: with SMTP id qw20mr474669ejb.216.1621264958826;
        Mon, 17 May 2021 08:22:38 -0700 (PDT)
Received: from localhost.localdomain ([195.24.90.54])
        by smtp.gmail.com with ESMTPSA id jw9sm3028375ejb.77.2021.05.17.08.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 08:22:38 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH] venus: hfi_cmds: Fix conceal color property
Date:   Mon, 17 May 2021 18:22:25 +0300
Message-Id: <20210517152225.482511-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conceal color property used for Venus v4 and v6 has the same
payload structure. But currently v4 follow down to payload
structure for v1. Correct this by moving set_property to v4.

Fixes: 4ef6039fad8f ("media: venus: vdec: Add support for conceal control")
Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi_cmds.c | 22 ++++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
index 11a8347e5f5c..4b9dea7f6940 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.c
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
@@ -1226,6 +1226,17 @@ pkt_session_set_property_4xx(struct hfi_session_set_property_pkt *pkt,
 		pkt->shdr.hdr.size += sizeof(u32) + sizeof(*hdr10);
 		break;
 	}
+	case HFI_PROPERTY_PARAM_VDEC_CONCEAL_COLOR: {
+		struct hfi_conceal_color_v4 *color = prop_data;
+		u32 *in = pdata;
+
+		color->conceal_color_8bit = *in & 0xff;
+		color->conceal_color_8bit |= ((*in >> 10) & 0xff) << 8;
+		color->conceal_color_8bit |= ((*in >> 20) & 0xff) << 16;
+		color->conceal_color_10bit = *in;
+		pkt->shdr.hdr.size += sizeof(u32) + sizeof(*color);
+		break;
+	}
 
 	case HFI_PROPERTY_CONFIG_VENC_MAX_BITRATE:
 	case HFI_PROPERTY_CONFIG_VDEC_POST_LOOP_DEBLOCKER:
@@ -1279,17 +1290,6 @@ pkt_session_set_property_6xx(struct hfi_session_set_property_pkt *pkt,
 		pkt->shdr.hdr.size += sizeof(u32) + sizeof(*cq);
 		break;
 	}
-	case HFI_PROPERTY_PARAM_VDEC_CONCEAL_COLOR: {
-		struct hfi_conceal_color_v4 *color = prop_data;
-		u32 *in = pdata;
-
-		color->conceal_color_8bit = *in & 0xff;
-		color->conceal_color_8bit |= ((*in >> 10) & 0xff) << 8;
-		color->conceal_color_8bit |= ((*in >> 20) & 0xff) << 16;
-		color->conceal_color_10bit = *in;
-		pkt->shdr.hdr.size += sizeof(u32) + sizeof(*color);
-		break;
-	}
 	default:
 		return pkt_session_set_property_4xx(pkt, cookie, ptype, pdata);
 	}
-- 
2.25.1

