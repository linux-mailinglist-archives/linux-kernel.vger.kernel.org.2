Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7079A38AF2B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240990AbhETMwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243025AbhETMvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:51:13 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62543C05BD09
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:14:06 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id i17so17405100wrq.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bf99ykgi1lM4lcfMFEH2UH6HKylTc4ahtgweVGCdhFs=;
        b=LrzX6C2S3fY8TWaQkFFoca9p3j874ryjkg9GANTxMGAAj6QZfiP2okqc8XkVPpJ2vu
         JxT0IoRbWph8ob5x4EgSXuvHgWQQ3tYqaO1l67wNG/VGynonLcyxy+lfhkK44qmY0eYG
         k0pMX2ZEObgkA/jgbTihhBkBjh5KSNvjyC1IQwWbddfRq5dkvJEiyxTOzqldb7xLBenE
         gejawHYpze3u2IzBsSS7gMM6EnHFZizItjWFoy30IRxWN9kH9GzJiA+BTde52k/ocpz7
         CGKAHPwHYCyi5h3pXSzimfwwfoUlACfu7A1uKBhsphiandcOwOcVOCqbmDYmsp3asbB6
         Ta4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bf99ykgi1lM4lcfMFEH2UH6HKylTc4ahtgweVGCdhFs=;
        b=XXJDc7YOjh3hlt/qvMHf71TdCrZ9lZr99TlugInHpNvux7ikv7mgDX4MljqPUq9CxP
         1pvyWGyHP8be770gLFV8+CodPhHNWfIPy/3d91vQxYEOMUcUTOYpDIUuHI28ewfnqm79
         xbrDeTTBJfjBXaPRXlNaWCGc/GPL0RowKq6B01WqAEGlk0r/jAGTT8Nqy2FKIDuQfBXO
         aRX9FCBUKsK7j9frfcYX0yQHg0aSEF7ooFc5wPwH+0yqyFKiRbxoOZbSmALlReaIEIVm
         l15Jq9PDR4K8b7EyJLj7T5dsdKzbt1/4rE8LI+LhtbW/OrmhZhx5S4GJOeRv6G5BZo1l
         E4Nw==
X-Gm-Message-State: AOAM530TW+DDI1P7E97AiCFAuNR0T5MNCUIeqruV4s7oqpDwBeNVFZkO
        VoNykaYXqrB22NvrMLyWf2oTGf5R5X3E7A==
X-Google-Smtp-Source: ABdhPJzZVOS/r3wLynsr27bYK8YYjYg3w2bJVG1Sw8M1nYu/gttV+pfGzyff+Hv6GgU0uHMYRlhBXw==
X-Received: by 2002:a05:6000:2a3:: with SMTP id l3mr4207818wry.70.1621512845020;
        Thu, 20 May 2021 05:14:05 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id 61sm3393704wrm.52.2021.05.20.05.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:14:04 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>
Subject: [PATCH 09/16] char: agp: backend: Demote some non-conformant kernel-doc headers
Date:   Thu, 20 May 2021 13:13:40 +0100
Message-Id: <20210520121347.3467794-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520121347.3467794-1-lee.jones@linaro.org>
References: <20210520121347.3467794-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/char/agp/backend.c:68: warning: Function parameter or member 'pdev' not described in 'agp_backend_acquire'
 drivers/char/agp/backend.c:93: warning: Function parameter or member 'bridge' not described in 'agp_backend_release'

Cc: David Airlie <airlied@linux.ie>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/char/agp/backend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/agp/backend.c b/drivers/char/agp/backend.c
index 004a3ce8ba72d..c901c719fba89 100644
--- a/drivers/char/agp/backend.c
+++ b/drivers/char/agp/backend.c
@@ -60,7 +60,7 @@ EXPORT_SYMBOL(agp_bridge);
 EXPORT_SYMBOL(agp_bridges);
 EXPORT_SYMBOL(agp_find_bridge);
 
-/**
+/*
  *	agp_backend_acquire  -  attempt to acquire an agp backend.
  *
  */
@@ -81,7 +81,7 @@ struct agp_bridge_data *agp_backend_acquire(struct pci_dev *pdev)
 EXPORT_SYMBOL(agp_backend_acquire);
 
 
-/**
+/*
  *	agp_backend_release  -  release the lock on the agp backend.
  *
  *	The caller must insure that the graphics aperture translation table
-- 
2.31.1

