Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA8A35B347
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 13:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbhDKLFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 07:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235386AbhDKLF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 07:05:29 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71EBC061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 04:05:10 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a7so15560393eju.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 04:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gSsTwCvLzeHONfXXfMoWnkseUsAdTn25RtS0S0FESUU=;
        b=JoTiuI7J03ZK/zUMWHy2lvYEQhqY54DyViQODpjueEd+YKS3Ap4bb0mssmR23Ad3aY
         LnhQH9VWzAqMLNgWf29dZzVA2TG+LDkOBYQUZ+rbLsV9B1WERIGhngQAvKo6qq1Klz8x
         arjoHTAk3dd5umVGPDM99Lfat3TFUEbjbCddTw4rzuR9jWOnB5zpae+Im9rMIRVDJcCI
         FPKMgqLcULeikw/A/9dlnnRMEcRs99Y5IjMM1WcDnno876IzEfeD8mnj58/fttOVERw8
         UAcgj0cBo4m+nk/0tFGPqkHSipQkUK+x9DmmoU41fKoNCaimWbZKVRai6DYbu6jIPFpW
         V02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gSsTwCvLzeHONfXXfMoWnkseUsAdTn25RtS0S0FESUU=;
        b=anHVQv3HLCCxOUF+vZrindZ4f5Vsvn5SOLcWAAm2+DeQ3Qxy4Hss7VkFwixCp0aTN0
         YztkLdM3DdR8yW1PHaEVcc8Z38Mm6ectJ91RVAb2GlmLLWOY6Yadd8ydoxQKLRo5ai2t
         xN/JfiyTxPfCDwxLh+xqk4qGwa4hgX+0rw+rJTvXm7sFCyEsJU/t4IDc+vbjw+gTTsP8
         B9ozFkWAGj4/OntTY2DdyuDT+G7+cbhpX3+g4Jw/GhdjaJeFeihD1WqcNqaLhrdzUZ/R
         qEJ+0TmF5c1LK0Z/75H933FZSDll6MGYi6kWth1dxIZo9GJpt+4yK2+9R8xSI8w6YT+b
         QocA==
X-Gm-Message-State: AOAM533RRivfsFlrLxNr2Grdn1sNL6v3L0jv2WD8qohb9T/sI7zzj+uZ
        BBOjKDL/VF6Cir4Ttglp1tBqQbJFq49k+6zr
X-Google-Smtp-Source: ABdhPJwaYEB+uPzxOixlcQbuoELwVX8bkoD8SdDeSHbFDaYUxJfLKLZ0g4Zuq5CaIFJhEKeRrJ6Wvw==
X-Received: by 2002:a17:906:3643:: with SMTP id r3mr22725051ejb.527.1618139109483;
        Sun, 11 Apr 2021 04:05:09 -0700 (PDT)
Received: from localhost.localdomain (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id i2sm4577202edy.72.2021.04.11.04.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 04:05:09 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH v5 3/4] staging: rtl8723bs: include: Change the type of a variable
Date:   Sun, 11 Apr 2021 13:04:57 +0200
Message-Id: <20210411110458.15955-4-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210411110458.15955-1-fmdefrancesco@gmail.com>
References: <20210411110458.15955-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the type of fw_current_in_ps_mode from u8 to bool, because
it is used everywhere as a bool and, accordingly, it should be
declared as a bool.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

Changes from v4: Write patch version number in 2/4.
Changes from v3: Move changes of controlling expressions in patch 4/4.
Changes from v2: Rewrite subject in patch 0/4; remove a patch from the
series because it had alreay been applied (rtl8723bs: core: Remove an unused variable).
Changes from v1: Fix a typo in subject of patch 1/5, add patch 5/5.

 drivers/staging/rtl8723bs/include/rtw_pwrctrl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
index 0a48f1653be5..0767dbb84199 100644
--- a/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
+++ b/drivers/staging/rtl8723bs/include/rtw_pwrctrl.h
@@ -203,7 +203,7 @@ struct pwrctrl_priv {
 	u8 LpsIdleCount;
 	u8 power_mgnt;
 	u8 org_power_mgnt;
-	u8 fw_current_in_ps_mode;
+	bool fw_current_in_ps_mode;
 	unsigned long	DelayLPSLastTimeStamp;
 	s32		pnp_current_pwr_state;
 	u8 pnp_bstop_trx;
-- 
2.31.1

