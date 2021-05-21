Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10A638C886
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 15:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236470AbhEUNmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 09:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236087AbhEUNm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 09:42:27 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3612C06138D
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:41:03 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j14so19382987wrq.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gdVy1JGSBoZuqI274R7n9JIUIxcN1AY4e4E1RFGG9Dg=;
        b=XT+WuJkP7kfD3oFoklO/xy+Oqoj/F309Q26ExLm+Q7Zls8oFptQ8oRbWO1h+PlpRol
         6JoO9iVJhh4ij5bY/Nm7cJAXXGdcG9swCZmPEQRF0Z4JgkzDkAXGldbNq7p4QrIsPfLr
         NI2+dU5dIe/FD9YUM4BpO6noa1uS3P4onCp80vuEHKC/f0rf9NYG6weEf8ieh09zG5kT
         1LtO4Ikk1vw4IzLb5MKIZIfTRyVJV9322p9kbGDuFpwWlkygyDDVPZI1XYH3BCX0bxwR
         5nV2lMeKlOSi7jy69cDlsuC0jAeOwanGAPTtzghoFCGTuzJBG+UkE8U5BpFjaAAE84PJ
         Vd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gdVy1JGSBoZuqI274R7n9JIUIxcN1AY4e4E1RFGG9Dg=;
        b=Rop2Tbcm9hD/BgeDlYudcYwcmy7Au1VFZ3mVXxz/xc6y6TSDjYJMW60QYv8Vz4weoN
         v0K+lIU9oXWrhDaizVFqTPWgtdEuW7ns+ybg0bYuBKxc2j5aiCq/KPJOamdpUtZRvRgY
         t+qw3jnjf+tRg20cftV+f05Eaj/ZMbq7ooqjrDgeA8Pj3PV/HBwnCzs4G/SutM5qp7fA
         dtraaMSdE+9Tjh+Jv34QuT2SvUVj49Twgkm6cQ6JlxiZk9l+Nf3CcUEcgWe73paM9f8l
         2rn6EAy2d9FTVUXxqA/8y1SW8LPYfrgPl2s8eYRy+WUVpsMDsRvfGUeQ5obDh+dQnkdJ
         Dxyw==
X-Gm-Message-State: AOAM530mvaAgd2uZiZy+LxdoqBUAR2GjmY50HI5T5cz2fv8DpxGN6BCg
        aQ7MOZuLxYV7Jn1Xr6aQxDosur3zMMI0b0Cw
X-Google-Smtp-Source: ABdhPJw1iRaF7MviWJC5X3zG1neDuyXbBVqQEfM2Fan3gf0S2Tjw7tf9BdEw77gR9IMIPh8EXEjzmw==
X-Received: by 2002:adf:ff88:: with SMTP id j8mr9367632wrr.427.1621604462401;
        Fri, 21 May 2021 06:41:02 -0700 (PDT)
Received: from lmecxl0524.home (2a01cb058b850800205e07f10870202e.ipv6.abo.wanadoo.fr. [2a01:cb05:8b85:800:205e:7f1:870:202e])
        by smtp.gmail.com with ESMTPSA id v3sm2161372wrr.19.2021.05.21.06.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 06:41:02 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 3/4] dt-bindings: arm: OP-TEE as transport channel for SCMI messages
Date:   Fri, 21 May 2021 15:40:53 +0200
Message-Id: <20210521134055.24271-3-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210521134055.24271-1-etienne.carriere@linaro.org>
References: <20210521134055.24271-1-etienne.carriere@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce compatible "linaro,scmi-optee" for SCMI transport channel
based on an OP-TEE service invocation.

Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
Changes since v1:
 - Removed modification regarding mboxes property description.
---
 Documentation/devicetree/bindings/arm/arm,scmi.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documentation/devicetree/bindings/arm/arm,scmi.txt
index 856d041b397e..ccab2ef6f6ec 100644
--- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
+++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
@@ -14,7 +14,8 @@ Required properties:
 
 The scmi node with the following properties shall be under the /firmware/ node.
 
-- compatible : shall be "arm,scmi" or "arm,scmi-smc" for smc/hvc transports
+- compatible : shall be "arm,scmi" or "arm,scmi-smc" for smc/hvc transports,
+	  or "linaro,scmi-optee" for OP-TEE transport.
 - mboxes: List of phandle and mailbox channel specifiers. When used, it should
 	  contain exactly one or two mailboxes, one for transmitting messages
 	  ("tx") and another optional for receiving the notifications("rx") if
-- 
2.17.1

