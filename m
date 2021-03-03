Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801E132BE72
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574193AbhCCRWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444522AbhCCNqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:46:37 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907F7C061A29
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:43:55 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v15so23747232wrx.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BenSWVQP2zN1koiPW0t4kws5hTFRiEoau/BE1y9GfNM=;
        b=Ng8hdaWRiiyvyJ7rnmG9yRryrouH4pj2frjYm54JU0V/Kij/mLkEoTUEP+yMJyN858
         43bEo3V8esgmfbqdFHDVhOX+SYmO5tr9O/V0Mceqz5W1Xcgm7WGS+5ivEqcwlqOs8Ds7
         gUsslo0geHrYU/ZKFsr3zq/YneNyJndoy2Em75uprLvmdbJe7KRxkSvIsl559Ym/lM8a
         V4HEidvwkXJY7TwiMQqabQmXvPddzJPgihMF4HHRUsKPHxZdQKO0HpYJ2lh1WlJB06N5
         cC4fLLZcxrlhDnzlMsFU70uqIMOuAxIpB4tT9G1IKwKiYZzRepB8asZvagjaujELaLUf
         SRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BenSWVQP2zN1koiPW0t4kws5hTFRiEoau/BE1y9GfNM=;
        b=GMed1ll/tKCIKUxj6yCm6qf+7HopxP2AGCAdvb4JPjDaIzR7iFe50Yg0PesRacImld
         S4NC/SYnZH1SeJnwaRE26L7S5I8xvvydp7iYOg34h+lUj5nFVIym/DbphvGTPymWo87X
         F2paob6Bwz+h95w7Ibdj4qqOrtJrbK6CA2hQfh0r4zqzD3Heu+YhpwqP9cPxcd9BLTH5
         gp85NlyG89MMWglKDiJ5ccZtqATRLzVlyEXoTLTJcnKPPjaoXuMtBqRVgViWpMkqfYeA
         UG4Ehlpv96kNNw39wyE3o/+XwFJiWYn38XynFWbbBmNumojLc9wBJotrNYpLZDvfUmQr
         K1MQ==
X-Gm-Message-State: AOAM532F1ASEPkMkP6levMtwo8NoTOQ7oTNRzyT6/5iM9hZ0NOUyBuKH
        C7o1Pw6iULzX208U/i0PzOIrGUq2+uoRQA==
X-Google-Smtp-Source: ABdhPJycA6TC1eg5KWRI2oQfh3Gk2eiMaVqoQpFQ2CQX+w8wHkausDg6d3nojKl6dS4quQKwNJFznw==
X-Received: by 2002:a5d:6042:: with SMTP id j2mr28094272wrt.336.1614779034339;
        Wed, 03 Mar 2021 05:43:54 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id w18sm6109524wrr.7.2021.03.03.05.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:43:53 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 22/53] drm/nouveau/nouveau_ioc32: Demote kernel-doc abuse to standard comment block
Date:   Wed,  3 Mar 2021 13:42:48 +0000
Message-Id: <20210303134319.3160762-23-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303134319.3160762-1-lee.jones@linaro.org>
References: <20210303134319.3160762-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/nouveau/nouveau_ioc32.c:52: warning: Function parameter or member 'filp' not described in 'nouveau_compat_ioctl'
 drivers/gpu/drm/nouveau/nouveau_ioc32.c:52: warning: Function parameter or member 'cmd' not described in 'nouveau_compat_ioctl'
 drivers/gpu/drm/nouveau/nouveau_ioc32.c:52: warning: Function parameter or member 'arg' not described in 'nouveau_compat_ioctl'

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/nouveau/nouveau_ioc32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_ioc32.c b/drivers/gpu/drm/nouveau/nouveau_ioc32.c
index 8ddf9b2325a42..2af3615c5205c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_ioc32.c
+++ b/drivers/gpu/drm/nouveau/nouveau_ioc32.c
@@ -38,7 +38,7 @@
 
 #include "nouveau_ioctl.h"
 
-/**
+/*
  * Called whenever a 32-bit process running under a 64-bit kernel
  * performs an ioctl on /dev/dri/card<n>.
  *
-- 
2.27.0

