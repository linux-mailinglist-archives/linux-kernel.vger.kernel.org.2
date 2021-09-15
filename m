Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A2240CDD5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 22:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbhIOUUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 16:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbhIOUUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 16:20:33 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE01C0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 13:19:11 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id f22so4933447qkm.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 13:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IjkKpbsOxtTLRzIMIRjss6tASIT031WBS0F4FaC661o=;
        b=NsR01QR1nDuiFpi9f+jX2Vt5AXHErqLS4DoCkeN1aYkVfSCLubVO5nk3E1duUnwA7y
         XRoKx30/JUaooaSWxQKFyLuDy/xwfyoQ0PUuFFDGxsBU63xh69T0Lgh3PYiH2bAgH0hD
         wLieKG/lrcfStyVIr5Xx8s1wDnyS2Osb0+hEza/a+bgLsBjBqau10PV7sRaI1Rrq+tmA
         WWX/nWntsqnffvdq100PkRCWsXoL15NxaREdfimqT8XOSw439TGvlECD1nQHGzRrIbW0
         8XX+/frzSur16a9Qck9QgOJ9Q2actIuTomn5LvCHAw8wIah2vpWGaoE/RwpBvbK8gIgt
         2usg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IjkKpbsOxtTLRzIMIRjss6tASIT031WBS0F4FaC661o=;
        b=Y+ySqbIj4m4bjjSQ5XAd1LDlTmCAjWYs+jU2YY0706kFYAGXL2KFNkijjsz8hlrZSW
         BQS7Xu4PQ0CzmRnjnNp5GYlCNtscpRmQHO/K2qN+rWkgPyIx1Zei2BrOkqKtMtb0voGx
         YNUMnIfw7VEqXZXkyypjSq3EYenQ+gY6qb8pbDwIua5iftMWATXt0i0/nwFlrpQwyx3M
         OfhWQ5/q22YAWEiFsPMbfxvzzpg48E6q0CNTajoX/OVWNQ4dAEygHt7a3Bbqz79MbOG1
         tR/vKv4mEn+gxoGLtdT0AtP7OU82H6d2zoMd7lY0mAvB8QUuUP2j0NmpPfOLRNNYwC3H
         bhkg==
X-Gm-Message-State: AOAM532j5oL56kxlp708Cu1AEa9ulD2NyeYTVpaSwtJ6Nk6MUWYL1To2
        xc/Zvul0EBQ7W/SUV67I7rq8ErWiMDeocw==
X-Google-Smtp-Source: ABdhPJzGaVaPmN/ZRRmux31NxHdMbfPHZSvr8nFu9oEOEurSgh/CvDC6wjBAoBgHgNZaDd0P6VjFNw==
X-Received: by 2002:ae9:c007:: with SMTP id u7mr1838430qkk.271.1631737150846;
        Wed, 15 Sep 2021 13:19:10 -0700 (PDT)
Received: from debianG.lan ([181.166.206.110])
        by smtp.gmail.com with ESMTPSA id g8sm752834qkm.25.2021.09.15.13.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 13:19:10 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH 6/7] staging: vchiq_arm: remove extra blank line
Date:   Wed, 15 Sep 2021 17:18:23 -0300
Message-Id: <20210915201824.413202-6-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915201824.413202-1-gascoar@gmail.com>
References: <20210915201824.413202-1-gascoar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary blank line.

Reported by checkpatch.pl

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
index e8e39a154c74..8f5182df17b6 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
@@ -151,7 +151,6 @@ vchiq_dump_service_use_state(struct vchiq_state *state);
 extern struct vchiq_arm_state*
 vchiq_platform_get_arm_state(struct vchiq_state *state);
 
-
 extern enum vchiq_status
 vchiq_use_internal(struct vchiq_state *state, struct vchiq_service *service,
 		   enum USE_TYPE_E use_type);
-- 
2.33.0

