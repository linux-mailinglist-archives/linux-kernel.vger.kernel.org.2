Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE24341767
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 09:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbhCSIZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 04:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234319AbhCSIYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 04:24:35 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C20DC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:24:35 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id w18so9795038edc.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RtDwwCGh7BV2jdAMFgyU0jxW3SadS1NJKEYSwbpKHII=;
        b=WhTHIjR2p9qQ5IzTyze6AacLklI9Uo/G/4AeQAM0EOoFlz5LkznOnDUWF75RUVTZny
         qer7yMUfkB6TKXfPaawXmK5zh8Pi9N5h6zEpScZ1Fu89JdEFkocmRuPbRm5ABbwoiFK+
         gtLZ1h26d4UDgeTtC6QnsZLj98dW37j8gh6W34B4B8Xefus9CJpzpRk4OJPyCMr5bK4+
         VABaE1bCTgYauqI+vzAtGP0+pGooM9EuRNTgoD7Q7DL7ybOqAnDBvAWHhGqs4yoAXfC8
         Q5xYO8pwXh1ZTAuujTxEs+wME7A4VXeS0kaKvcjENfMCF8aSGC5EI3TaxGRPp/HRhFVF
         yQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RtDwwCGh7BV2jdAMFgyU0jxW3SadS1NJKEYSwbpKHII=;
        b=n9UwfKSivTkEobtv6THHKP736TsGx/HmuKvd0x0me29iUCeY02nuR8sttpB7HjDNwz
         b/35boEYsGWauu+tYgs3tXtStohuCmdJl2cQySlVRl9l1SCuy59gKLfVfASrL5B1xTpN
         0c8hW+8WItmfCSbV73Z047ujrhbSH2pTh/wBnAIXUQU8YRr8eTHLH7SwLtLCAYotESbu
         5REVdxBRmj4HSBaGnmAl/yHWg47S735Wr4t2SBAFYUOuXG8aZAogDGm4EmnvFy8hiB8s
         XRe7r91Zg5G589i6CFVxmxZAA5ln72xkLHQhzqw9iGdpmGKVBU1t9aIlQBoUZ8l/6VCf
         tw8A==
X-Gm-Message-State: AOAM532CRcWKKnyxjTs/BcM/YlTaCvyLJniQR1Ii0/Tto+q6sHDdGars
        BhMo1GiJMUdAdSDSO9iHvX1j+A==
X-Google-Smtp-Source: ABdhPJw66ngNg/IJvxqFYVq3B2gZC9vNyjb/90i+qd665pUnOKsuirpenLdXDSTsIgUANeauTQ0TvQ==
X-Received: by 2002:a50:8524:: with SMTP id 33mr8258811edr.110.1616142274097;
        Fri, 19 Mar 2021 01:24:34 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id b18sm3273727ejb.77.2021.03.19.01.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 01:24:33 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 02/19] drm/nouveau/dispnv50/disp: Remove unused variable 'ret'
Date:   Fri, 19 Mar 2021 08:24:11 +0000
Message-Id: <20210319082428.3294591-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210319082428.3294591-1-lee.jones@linaro.org>
References: <20210319082428.3294591-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/nouveau/dispnv50/disp.c:1381:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 196612addfd61..c51efca82ac78 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1410,10 +1410,9 @@ nv50_mstm_prepare(struct nv50_mstm *mstm)
 {
 	struct nouveau_drm *drm = nouveau_drm(mstm->outp->base.base.dev);
 	struct drm_encoder *encoder;
-	int ret;
 
 	NV_ATOMIC(drm, "%s: mstm prepare\n", mstm->outp->base.base.name);
-	ret = drm_dp_update_payload_part1(&mstm->mgr);
+	drm_dp_update_payload_part1(&mstm->mgr);
 
 	drm_for_each_encoder(encoder, mstm->outp->base.base.dev) {
 		if (encoder->encoder_type == DRM_MODE_ENCODER_DPMST) {
-- 
2.27.0

