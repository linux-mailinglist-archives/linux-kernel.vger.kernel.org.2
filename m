Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555E93117AE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 01:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbhBFANY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 19:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbhBENGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 08:06:06 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D817C06178B
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 05:05:16 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id a12so6696125qkh.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 05:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MHJsMavE3nujSnxW3LwxOmZw7EFguJmQU/pNqi0G+xI=;
        b=aMDfbAIFLwP4uP1FRsZWcGK7FHIzEj8ip4FiQPK6ctpA3bml5yjPvhqvazWVsOzEBk
         wajhqlQvaHgCFdT1nl/xpxc1mzULoGWx06Ns4RRAQBERMwtazx1KZvhWmwMk3fxPVJFP
         kV1JMyvIV29OgJLsJ7dAiupMuu6aTScFJOondIYf/3H5mKmlAoLY++mJrVpBKJiS5s7W
         ijKR8tTRYbft0V9oGR8zHk3ZqT3Oj4awoQIXOFd3rfp1D+5P5522+bECxacfhbhDGTM7
         EWgpQmovHeJBnC0QPEfbg/bxOQEqXTLr5q+InvsU5BfejkczuSNrtWDraf6iM5R/+P81
         RIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MHJsMavE3nujSnxW3LwxOmZw7EFguJmQU/pNqi0G+xI=;
        b=PXYjU+EMlx7tTegy/6jrNJLutmpNn4VE8pXxQ6jNh1kOcloZudTWLc2p3cUAfl6qm6
         o3Q+jSDjroYCwkeaBFak2dGeI1gpBZG6WKyts9E+CnZ9Q4fwzvF7OJAFe1ph3LsR8wR6
         lqx21A/QHJh8C7/AxzAUZnav0LlduFfkQpnLKcA7gFi+Yxg90DPOtHMEMH/VbR3/RMMB
         I6aYFA1+GmjHah68SmhXbuCrnXgOjT2XKcTVPf3MDmKIsVGt/eB6VW8lFG+2niMQ6hp/
         IQvwMlZWmKlxlW1L96IGjLFA6AaINjYcGLU5WN1sIEJBwipUPb6Y6iJ6fGaWtErwvs36
         JO9g==
X-Gm-Message-State: AOAM533mHyrgYnxlNpa+JbYZ+pl8aJ30skvxHXM938dJzOqhVV3oz9x7
        8n1LZ23msOfatFOpSv4yjSk=
X-Google-Smtp-Source: ABdhPJzESrKrwXVHsctE3NGaG/IC2lbP3Th5GQobMhswX/sILMe3FBMtg0ocebizL/CRAVGrkZXKVg==
X-Received: by 2002:a37:9d53:: with SMTP id g80mr4055340qke.307.1612530315873;
        Fri, 05 Feb 2021 05:05:15 -0800 (PST)
Received: from localhost.localdomain ([138.199.10.106])
        by smtp.gmail.com with ESMTPSA id k8sm9092945qkk.79.2021.02.05.05.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 05:05:14 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     bskeggs@redhat.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] drivers: drm: nouveau: nvkm: Replace a word with a better phonetic word in the file macros.fuc
Date:   Fri,  5 Feb 2021 18:35:02 +0530
Message-Id: <20210205130502.1440514-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



s/fuck/heck/


Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/fuc/macros.fuc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/fuc/macros.fuc b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/fuc/macros.fuc
index 3737bd27f74e..1407a1b16d95 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/fuc/macros.fuc
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/fuc/macros.fuc
@@ -46,7 +46,7 @@
 #define NV_PPWR_INTR_EN_SET_SUBINTR                                  0x00000800
 #define NV_PPWR_INTR_EN_SET_WATCHDOG                                 0x00000002
 #define NV_PPWR_INTR_EN_CLR                                              0x0014
-#define NV_PPWR_INTR_EN_CLR_MASK                    /* fuck i hate envyas */ -1
+#define NV_PPWR_INTR_EN_CLR_MASK                    /* heck, i hate envyas */ -1
 #define NV_PPWR_INTR_ROUTE                                               0x001c
 #define NV_PPWR_TIMER_LOW                                                0x002c
 #define NV_PPWR_WATCHDOG_TIME                                            0x0034
--
2.30.0

