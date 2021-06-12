Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15973A5077
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 22:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhFLUJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 16:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhFLUJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 16:09:11 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2568C061574
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 13:07:00 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id h22-20020a05600c3516b02901a826f84095so10466253wmq.5
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 13:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9LjSjYijj0EfqsEdoSIw7/BzTxcNazaz65qdvp2jts0=;
        b=c8pQ+o+1xZdLNWcyuWJ03l1ewGoL3lMIS6/vjwJllwwrYLVb2B6wuMxXKaiycDK79m
         5OpUhsPSyrkgNlt/hGhFbBesBpDWm7mazBZE/z5+6Hwkh2nUcXRz3JXhpmAx8KoaDr5D
         9boDu/ueOKhKYB8uLY1pVDDd6BmtL+Zf+q2omq7jyTwLd83riT5v+MGODd2WXmQiPwAj
         vU2+6x19wn0ik+ny6g7/LyDwq0U3Z7jFIG4v148tSdvhgGRbj5/TZLiENynDOWnamJRX
         DTrQsBmMd8wVPHn1mx7hN+tlOzLmzFuXK7SBXZwq9bVc0yMyjChv5HhGVvUsbkyuuEqB
         kVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9LjSjYijj0EfqsEdoSIw7/BzTxcNazaz65qdvp2jts0=;
        b=ewn/iGLxyONRnT2hdbM0vu2+1ikYu4+Co8Vca4PHKDfmg4CTZu882g56OHzNOyfqMw
         oQjZn4ne3u/2GI+cg4uQZtMJcR/p3W27OcA2bh0LeQb2C/7Q0fxLpWu8LWAIs2Gt830K
         wLtETrllHljjxKVD3GajJDVkMuDKIYq2WcPA5T9ZB+l22DjhwsdFtxyJS/bC6zCWFTiy
         lXNAo1w5pCoyyMaETZIshgr95M01Twj4WS9tPDFOzoaB+jr3QryU0DxqBaM2SIfYkqji
         bbzZ7b/pXc6oaC5kzTZNB1s+i0wXu5h7tDdcuGA1J8RRerYMThDOSI4fmP+quv5DH7L7
         Onvw==
X-Gm-Message-State: AOAM532vxa8/HLVKTg+3vtsWEGfkdL0dxwiGT+09hLSk/TTtF3O2KZSg
        00C2CLcob0FO3W6NislWQTw=
X-Google-Smtp-Source: ABdhPJzmy+LX9c5Oh4Zq9XpAlIR6k7Unme1vwt4gpaoD97v8U1+HgFkeMX5uW7GkIWAhXCbRaqV/0g==
X-Received: by 2002:a1c:c256:: with SMTP id s83mr9257228wmf.86.1623528419402;
        Sat, 12 Jun 2021 13:06:59 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c22-7608-e300-f22f-74ff-fe21-0725.c22.pool.telefonica.de. [2a01:c22:7608:e300:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id v17sm13716193wrp.36.2021.06.12.13.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 13:06:59 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     alsa-devel@alsa-project.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RESEND PATCH] ASoC: rt5640: Make codec selectable
Date:   Sat, 12 Jun 2021 22:06:50 +0200
Message-Id: <20210612200650.1301661-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Realtek rt5640 codec driver can be used with the generic sound card
drivers, so it should be selectable. For example, with the addition
of #sound-dai-cells = <0> property in DT, it can be used with simple and
graph card drivers.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
Re-sent because my last mail did not make it to the list

This will be used in arch/arm/boot/dts/meson8b-ec100.dts


 sound/soc/codecs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 2a7b3e363069..96fc0144f9fc 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1180,7 +1180,7 @@ config SND_SOC_RT5631
 	depends on I2C
 
 config SND_SOC_RT5640
-	tristate
+	tristate "Realtek RT5640/RT5639 Codec"
 	depends on I2C
 
 config SND_SOC_RT5645
-- 
2.31.1

