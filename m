Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD1B3622D5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244654AbhDPOix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236291AbhDPOiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:38:08 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE90C061761
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:43 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x4so32589771edd.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9yFPCpC+KcvysSHE/TzUxgB6C7mqpr36eNkZECpHJ1c=;
        b=q24GGnGRAdzpbYYl+M7v9f6M5HcbMMdNCA8arW0qs7LIDVQVe0UheCz0W99E9kxnj8
         N9FH43w69SituNqVOudZiavc32EsX36KzfUsKqwa1nLTqpCTmE83YCzAJcJZblI57yeZ
         +2yJUhe+ShtafcRhG+RrBXeAsrhgdbxSN2AwmxE46GXV+mlylZpzRs65X5SFvZGldR3r
         WAe1mbQraJTDhXL8wK09ukr8acgzxwhxqfItaqvC5EVi9cCEun6BK7WXQp5C6SONaOV1
         Feqo9YoxTXppD1tCy/5zJNjgEbL4YKuHwL4rK3TSkhLjruiaMb3YL112oC3OWWYdQ9vZ
         F5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9yFPCpC+KcvysSHE/TzUxgB6C7mqpr36eNkZECpHJ1c=;
        b=LY4yqqah3Lbd6gRLC8ElZ/YxFOb+XxkG3J2rcW8fAp9DwQJAj/eI5ZNlZ+DyqlZqB3
         jtrmwM6NejxJwevzfODDz6i/UApO0dsntpPvywiUGp6lWdkqBjOoh6pberuaSizhtFNr
         Ntel2wS4+USDwLCOs9cdHUUtJ0yKuf5hmuygAkwiUQeaYknYwoOpLlFkcIIJ0bG7P02s
         UIewCqow8awIwyeRuy12PxctQqnByDbQ7/bgIr8v/SXldq4V27DZWQNL+GnKQu9f63Xi
         G52LE5sc3HA25g0tpa1hEZWqPxNpUCPw2iayt3wEfXoBmXLuD1VVTePBcWNOL/Kv9oD3
         nOpQ==
X-Gm-Message-State: AOAM533DS0WQyWb7csEzEfH7atiQEjjYGjiJm9fUd+FFl1hmFK43ApWF
        1YaLRiWRJzSkyLi5sYvxUU9sSQ==
X-Google-Smtp-Source: ABdhPJypegeIw/OfmdjDiD5Yv8LbnLlddqWoHhsQUliKWi5Cl4dqXq69rC2fzWbChz449ozg46lBfA==
X-Received: by 2002:a05:6402:3550:: with SMTP id f16mr10260110edd.134.1618583862459;
        Fri, 16 Apr 2021 07:37:42 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm1326523ejk.93.2021.04.16.07.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:37:41 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 11/40] drm/nouveau/dispnv50/headc57d: Make local function 'headc57d_olut' static
Date:   Fri, 16 Apr 2021 15:36:56 +0100
Message-Id: <20210416143725.2769053-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210416143725.2769053-1-lee.jones@linaro.org>
References: <20210416143725.2769053-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/nouveau/dispnv50/headc57d.c:173:1: warning: no previous prototype for ‘headc57d_olut’ [-Wmissing-prototypes]

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/nouveau/dispnv50/headc57d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/headc57d.c b/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
index fd51527b56b83..bdcfd240d61c8 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
@@ -169,7 +169,7 @@ headc57d_olut_load(struct drm_color_lut *in, int size, void __iomem *mem)
 	writew(readw(mem - 4), mem + 4);
 }
 
-bool
+static bool
 headc57d_olut(struct nv50_head *head, struct nv50_head_atom *asyh, int size)
 {
 	if (size != 0 && size != 256 && size != 1024)
-- 
2.27.0

