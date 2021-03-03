Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBD332BE7E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357156AbhCCRbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445887AbhCCNsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:48:01 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA33C0610CE
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:44:05 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id f12so19932024wrx.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BjfwsSGdxPmrvaJOjBX9ijfyCI7yYPSZw53zZSFU+oQ=;
        b=sGQaCdMVqDriVS+b6KY0lBnm3pYMMCpz4EqqljOvMl7zgk5jRtBQ2i2oPWzoFCYHiP
         sz+9QyRiQeLU9+2j2CdDvc1h+dR8wwSwQ4ITxc+oKDq1N0/R8XSEkNboWDtqtZRMnXCa
         YoMKsx5UXZ2aTahxpyoVfcxkalHnJTobJl2WL5kI/S1/jtfJWJAav5w2Elr9j1T8x+Dh
         jpIeXoXtZ2FbJm1MLHx/hwVEq1Jn/d9lhTNu4mndi9xm78/Qc0H5eJXr6CNQ9RIcsbEf
         88pL/SiRunxWo13GmHuvzJddVrxHN4wVC1cRR5BhEEa84NvYQTR1psg5kWSKOi2m0li5
         tZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BjfwsSGdxPmrvaJOjBX9ijfyCI7yYPSZw53zZSFU+oQ=;
        b=EUmGviNsnaqxTs93wC63c0ZQw5y0ZAYl8Aws4I5yzBrnGttq21Mv3ZRRbzJ0yzgTH+
         grxbmNAPdO3A6A32MWmlRGL0pXoPI90IPigt9Mtv2sGRiyLcy6qZRjaFl0ej7xDF3g1V
         El26j0zlbwjZ6muO/uj8oK0EqZ6QMijyhb3eJBK02oS8kGgKCgPB5kFoIuAv6aX2sQgL
         k4imM2+AdCI4n7Ln2PFJQveMTnjodExyMADqUEquOTGgbFMV9zjPLzNJfFG9kLoozInR
         PnbKfkHQr4hhL6X31lZUQbDGOnw556ootR3ExQqmngLa0yp5hRfqnodKpM7sGNLvfK03
         0Uzw==
X-Gm-Message-State: AOAM530sXpZ5SF9alByR1ygwejxp0CR9HwsyC3KxNd3FQC0ZmY/8dBOe
        CmyS7ShTs6wDhlKfzq1ViTw/aQ==
X-Google-Smtp-Source: ABdhPJzH4w3Zis0RicRCbLsKI5Q9wSbWJ1nQ6IQidubaAIk3XcmrOVqPNyRlg8jIRjJsYzSZNZTzpw==
X-Received: by 2002:a5d:4564:: with SMTP id a4mr292223wrc.3.1614779044383;
        Wed, 03 Mar 2021 05:44:04 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:44:03 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Zack Rusin <zackr@vmware.com>
Subject: [PATCH 30/53] drm/vmwgfx/vmwgfx_fifo: Demote non-conformant kernel-doc header
Date:   Wed,  3 Mar 2021 13:42:56 +0000
Message-Id: <20210303134319.3160762-31-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_fifo.c:299: warning: Function parameter or member 'dev_priv' not described in 'vmw_local_fifo_reserve'
 drivers/gpu/drm/vmwgfx/vmwgfx_fifo.c:299: warning: Function parameter or member 'bytes' not described in 'vmw_local_fifo_reserve'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Zack Rusin <zackr@vmware.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20210115181313.3431493-13-lee.jones@linaro.org
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cmd.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cmd.c
index 7400d617ae3cc..20246a7c97c9d 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cmd.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cmd.c
@@ -276,7 +276,7 @@ static int vmw_fifo_wait(struct vmw_private *dev_priv,
 	return ret;
 }
 
-/**
+/*
  * Reserve @bytes number of bytes in the fifo.
  *
  * This function will return NULL (error) on two conditions:
-- 
2.27.0

