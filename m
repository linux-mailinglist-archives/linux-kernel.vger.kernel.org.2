Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599EA38B2E3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 17:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243761AbhETPUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 11:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbhETPUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 11:20:42 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDA3C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 08:19:20 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id k132so3363342iof.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 08:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gp4zK5F2YjtgwGkVne9PjTqCbpKTKbtlpIMPojGX78E=;
        b=jxiIg/X8eeGT0fxle+nAvWqUrzDTkM4OMKMHiBuXd3gTNNdIRFHo0W1oWw9eFYzDdo
         CawCNgJtcrAaq33LtKjLLlavJRSAMmo0q4HfPO+PizyisIBxov3xNupNT2DV1+z38lEb
         q4dG6qNgQeUhj1XdCcmEhpn5Mq8lfBKpvmIQV86lIGyOFu+GBfwnhd6H49XDP0ZirMzI
         8CiSeV2hj3UM30FDLUbHnSrLdL8uogFDoohqmlGoMndE9ENHuPttzaMKql4c9R3+AbBo
         1LwK6uaMjlRXg9XsvrTk9YtqcY1Ijxrhw/aaC+6EgrSD2KNmqRP3llqM8Zna9Bnlsvf3
         viYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gp4zK5F2YjtgwGkVne9PjTqCbpKTKbtlpIMPojGX78E=;
        b=C1+hVLaf2R1gpu8VOKfdglRWa58+ldT+x5hkY7kDfCCwqp+YWQG1sw540pnQsEMRnN
         STAB66WG2sDR812jMVDNLmjpZJvhY9seETfSKizrpCCtn+fV+YZIM2zlAzLxr/XSAHLw
         kkxcdCobEhJRjhtb8vbAV0ZQdYVplyB2GCcMbYKdaSu7YJ61dB5Wb6GPfSfSuhHzroab
         tz8am0BtfCOtcTQpDt/mugcO/jXCwW3ZUMMF2OnYYclX5YsAlsDF/FXrlBeAQhUMJ15S
         Ma8y/DXNx2nmqzSToIALqK+cL3HEl+vOaw7Y9HsuoeY4IfAV8Aw7GotX1cqOWNAy9Fts
         U2/Q==
X-Gm-Message-State: AOAM5316KwaXT02EhgH/GY3GE4h1C6ZrVoH7lNVmyrpj0OVCd4/aBJyP
        iCei85qGn4vsMyiXgPNfN4M=
X-Google-Smtp-Source: ABdhPJzd/GIEWPYhCBDP28KgS4r3aRlx2GrfhtLxDPMW0Xz/EVLshHxnZV2UnA4rIQXxC2p18t96XQ==
X-Received: by 2002:a5d:81c9:: with SMTP id t9mr6347913iol.45.1621523959364;
        Thu, 20 May 2021 08:19:19 -0700 (PDT)
Received: from edi.home.geth (69-174-157-26.symrinaa.metronetinc.net. [69.174.157.26])
        by smtp.gmail.com with ESMTPSA id t14sm3410014iob.36.2021.05.20.08.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 08:19:19 -0700 (PDT)
From:   Derrick McKee <derrick.mckee@gmail.com>
To:     derrick.mckee@gmail.com
Cc:     Nathan.Burow@ll.mit.edu, Yianni Giannaris <yiannig@mit.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Ensure kernel AI key is not changed on fork
Date:   Thu, 20 May 2021 11:18:54 -0400
Message-Id: <20210520151854.3632129-1-derrick.mckee@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210430150438.GA57205@C02TD0UTHF1T.local>
References: <20210430150438.GA57205@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel uses the IA key for PAC signing, 
and this key should remain unchanged from the kernel point of view.
This patch ensures that the IA key remains constant on fork, 
if it has been previously set.
The software is provided on an as-is basis.

Signed-off-by: Derrick McKee <derrick.mckee@gmail.com>
Signed-off-by: Yianni Giannaris <yiannig@mit.edu>
---
 arch/arm64/include/asm/pointer_auth.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/pointer_auth.h b/arch/arm64/include/asm/pointer_auth.h
index d50416be99be..9748413e72fd 100644
--- a/arch/arm64/include/asm/pointer_auth.h
+++ b/arch/arm64/include/asm/pointer_auth.h
@@ -69,10 +69,13 @@ static inline void ptrauth_keys_init_user(struct ptrauth_keys_user *keys)
 	ptrauth_keys_install_user(keys);
 }
 
-static __always_inline void ptrauth_keys_init_kernel(struct ptrauth_keys_kernel *keys)
+static __always_inline void
+ptrauth_keys_init_kernel(struct ptrauth_keys_kernel *keys)
 {
-	if (system_supports_address_auth())
-		get_random_bytes(&keys->apia, sizeof(keys->apia));
+	if (keys->apia.lo == 0 && keys->apia.hi == 0) {
+		if (system_supports_address_auth())
+			get_random_bytes(&keys->apia, sizeof(keys->apia));
+	}
 }
 
 static __always_inline void ptrauth_keys_switch_kernel(struct ptrauth_keys_kernel *keys)
-- 
2.31.1

