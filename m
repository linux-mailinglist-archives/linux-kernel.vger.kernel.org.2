Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22A740CDD4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 22:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbhIOUUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 16:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbhIOUUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 16:20:25 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321FAC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 13:19:06 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 22so4949963qkg.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 13:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b700IZOvcmDVrq+0HZ+RP1WwJQWxcExsUcbv+nvnXKY=;
        b=qvHmIw3rsiOmJNvQnovoM0eSxf60ZOF3NN7bXJBhMKTXA5AZMTxHsB2LVjXld7utC9
         AhyY9FxPd9Ug9poqLYuFD9UxFZjFqBjtuUMxAF5Vixoq9VZKDOolaWEKJDTjvDw0wEG9
         zGLALbltQ63z8cHWnCD86kXsj++MFG7cuHNBOm+KC17g2fvCp3fdaL0bnWJPqpTkJeyc
         dz9BNi1qdEblD43b4H5QgQ3ugJD7U9aBdczHMi79wgNg+5W5ugDf8isf8QjsLz/cUV9k
         ODxCDfYCxEBQqQWumFCo5xWpd0ghL4ANHajmOQIu8/GkCROwbw7auSVvqsWwDJ8b+S0A
         Wisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b700IZOvcmDVrq+0HZ+RP1WwJQWxcExsUcbv+nvnXKY=;
        b=yYNFSogwGEVRQWEtEAPbql+j+12OlthXtTVuHylsOVN3o6h8Y1cUU7ldjvlRznKe67
         bpTEmeEIjwM3cbtwmC6227VMpLFWbvl8scCYRHEYmhDSav49vBoAV/BIME7iuRhGH7ZV
         DcpNlwqlaNOt+pLTnA3+tq+JCd/JuF7MKvZwKiy/I45aXD0repxmE64QI6eNrVnyZwVZ
         xOt7oqn5Vhf3uN3BXzk5A0pZ8oqLoU9ZeC9XWmNPcz4qDx5auBPEw44xNDpWpsm5lRu0
         EDbl0aLNDAdbCEHIv3nzvz3SCeX6xkbl0BNc7QF6Qyl5XAvy3UFoOv9zCzc/J9p35X34
         N0iQ==
X-Gm-Message-State: AOAM5312vMRDovdMQTLaEhEvPyZEn7mhwl6ejSlAzRpYt0NOIpKGiWid
        fxzekJpTnZTrbYzO/1NTEEs=
X-Google-Smtp-Source: ABdhPJzmRHxWO920nngdRsWvz7XJcu2fOsLeeXM1AJ5dnkZrzjyb14Hm86NHvlwr1RDYeC+Xu1I+uw==
X-Received: by 2002:a05:620a:bc5:: with SMTP id s5mr1771242qki.47.1631737145479;
        Wed, 15 Sep 2021 13:19:05 -0700 (PDT)
Received: from debianG.lan ([181.166.206.110])
        by smtp.gmail.com with ESMTPSA id g8sm752834qkm.25.2021.09.15.13.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 13:19:05 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH 4/7] staging: vchiq_arm: cleanup blank lines
Date:   Wed, 15 Sep 2021 17:18:21 -0300
Message-Id: <20210915201824.413202-4-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915201824.413202-1-gascoar@gmail.com>
References: <20210915201824.413202-1-gascoar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary blank lines after open braces and before close
braces.

Reported by checkpatch.pl

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 9464a4777ff6..778540faaa1c 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -1218,7 +1218,6 @@ int vchiq_dump_platform_service_state(void *dump_context,
 struct vchiq_state *
 vchiq_get_state(void)
 {
-
 	if (!g_state.remote)
 		pr_err("%s: g_state.remote == NULL\n", __func__);
 	else if (g_state.remote->initialised != 1)
@@ -1339,7 +1338,6 @@ vchiq_arm_init_state(struct vchiq_state *state,
 
 		arm_state->state = state;
 		arm_state->first_connect = 0;
-
 	}
 }
 
-- 
2.33.0

