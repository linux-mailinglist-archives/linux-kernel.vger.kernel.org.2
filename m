Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42AE140CDE1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 22:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbhIOUUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 16:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbhIOUU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 16:20:28 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BFFC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 13:19:08 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id 22so4950132qkg.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 13:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eNeXjhvCGZPX2nOcWVH9hj3paV16QHjNZaxjtD37JKc=;
        b=g3OY89RCjR/ZGNoaOqhwVZXTsShvf+4AgqRiex9BxVvvDDGOxenuubTn8Mm0zFpxlP
         vhjhH6r6IMvoDpkKeOD7854wV7ZjqnRes5liPmP0Z7eREmGwaB6v3dauUdBmRCy74rVg
         uqjYewRfe/6Gg1DF4qqpH3cjb3p3QMpMgZEtMkEGQxvxHgDM8NzcLelILaSg+NAxJitD
         JsfxtuD/hreiPf0fn96PTFzV0kpbqEk9e/xz/evXzHjJiq4S87rqBTUMArzSh1EmTW8G
         1/29JD7LhFCTx6EdMfxsaBd1OSCpY1QNMm5VhxyQetbHlPlR0gm2SaF34N+/ORufHfm5
         Px9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eNeXjhvCGZPX2nOcWVH9hj3paV16QHjNZaxjtD37JKc=;
        b=ZY/9CW+bK/H85pgH5bebfLdCF25DxTTjnlBqPfJ+Q8hIpI1ye2wt7Q+4IBttpTF42y
         l9j/w1U5vNdf3gJcsouU+PjR8llZOrwF5zPle9NCCbsdXW7DaNMAs9tmZfF4vEZ0sc92
         n/PjzMtM1+7ieya/tqbLekc/9OCwGHb+mMKbpo6y4BFgZn11jKBEZPAYpdJDXmM+xxpg
         4/2+qwVaPO6BuypHPVKwm4wbV2gzivZuaM1SMvYvLvGK7LKJCNMwaW548Wm3hJ08GBhe
         RexvcE/onL7Rfxt/ecxjhFc4JzFNnsUlwxjC72azjjp31CriBTm32swMeNko8llth6ld
         PMgw==
X-Gm-Message-State: AOAM532qH3Wc15ORMrtpFdzfnkNZT0XgxY/YZM1T6cvdPdfiuZ08pLxK
        xNpLHJ3s2WVTpH3+0dAcLm0=
X-Google-Smtp-Source: ABdhPJyanF71gCbC8J2WEmeT+/Yhmt/G/LTPzMgphfSx8n8Wl1RiJa07g2Q3QxjqOURzIhVZPbh41Q==
X-Received: by 2002:a05:620a:129c:: with SMTP id w28mr1754188qki.359.1631737148148;
        Wed, 15 Sep 2021 13:19:08 -0700 (PDT)
Received: from debianG.lan ([181.166.206.110])
        by smtp.gmail.com with ESMTPSA id g8sm752834qkm.25.2021.09.15.13.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 13:19:07 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH 5/7] staging: vchiq_arm: fix quoted strings split across lines
Date:   Wed, 15 Sep 2021 17:18:22 -0300
Message-Id: <20210915201824.413202-5-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915201824.413202-1-gascoar@gmail.com>
References: <20210915201824.413202-1-gascoar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoted strings should not be split across lines. As put it in
Documentation/process/coding-style.rst: "never break user-visible
strings such as printk messages because that breaks the ability to grep
for them."

Reported by checkpatch.pl

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c    | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 778540faaa1c..3225f0738ef9 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -1613,9 +1613,8 @@ vchiq_dump_service_use_state(struct vchiq_state *state)
 	read_unlock_bh(&arm_state->susp_res_lock);
 
 	if (only_nonzero)
-		vchiq_log_warning(vchiq_susp_log_level, "Too many active "
-			"services (%d).  Only dumping up to first %d services "
-			"with non-zero use-count", active_services, found);
+		vchiq_log_warning(vchiq_susp_log_level, "Too many active services (%d). Only dumping up to first %d services with non-zero use-count",
+				  active_services, found);
 
 	for (i = 0; i < found; i++) {
 		vchiq_log_warning(vchiq_susp_log_level, "----- %c%c%c%c:%d service count %d %s",
-- 
2.33.0

