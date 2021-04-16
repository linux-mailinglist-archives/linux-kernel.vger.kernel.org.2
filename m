Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4723622DB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244883AbhDPOjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243762AbhDPOiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:38:11 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E2CC06138A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:45 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id s15so32573658edd.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aDdT4/+XKsblVJiSEV/Ng5U9nFlFYwJI7t0KAgT17Jc=;
        b=GVXZ4RlJwFsNGButwNcLJWso5eM3oO2t1LugQa1WxR7somr6EYngKqt9MGvUfV0Z8W
         spo/YFrOR3/L+OL4pExz+ObuFTvVaxlIwmaIYA6w3hQK7rnf1tuA96FZQMF6en7epBdG
         HpQumRcb3VUt6TsG4HUTHHw6OwUnu9wtDWEl1lVrgbbd9I1wJZ7j2BCeaLZvHtCd21MF
         QcxYTguRaX2CL4McdxAzZ7TpfuM1e86es6aqUz0ESVv2F9jwl8aBqiuJlQKp9418pQBZ
         xWyM1V3MfTcLYKsGQMcnArnMB8vwHKUbkBPB5DwJKigdjWREp1b/yeg+2tt1gZBQWZSs
         cuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aDdT4/+XKsblVJiSEV/Ng5U9nFlFYwJI7t0KAgT17Jc=;
        b=ejqmcI63BtI4X2+tCt7TNw+plJSEf2QZ+RJ/FHrBUKJFsVFHXs45veybK40htp0XLd
         ChuquJ1rwBsXjQrjH4BtYdryHMhyssAe0l861HeLDfCXzliOjrxA9xujvz1AuYr42gGT
         WTFsw9FV1k1hUQAxup72nndiLW71TK1ZZZUT8s6/VScsuZusZdiUlT2SnIjw9CMqgNa1
         TcBOHfxPLnlIjYXJRWGCcqV+lFoQQHlDGVp7ms2bYgPCevdvpbHxrIYLv3/Ovflh+spC
         Dba5BG15O/8fCxZ3OTwCZ51IDnuulcHJOROtcMwO4v46TMqcfxPWltDconrX0g2lXQCw
         Q7eA==
X-Gm-Message-State: AOAM531hSs0/YDrImZfbM5KhJDca715S/utHkveGFk3qzt/wfS8PbBa3
        GzjgTq4DEJ4iZyh9qeRToY2TmBpEEDoElw==
X-Google-Smtp-Source: ABdhPJzotflJvZTB2ll/FcWUU6QTmhzLk1MA/Yw8TC9PpImJipTW60OTtbwHhoYkTSqbc7cvA17dTw==
X-Received: by 2002:a05:6402:27d3:: with SMTP id c19mr10448067ede.129.1618583864278;
        Fri, 16 Apr 2021 07:37:44 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm1326523ejk.93.2021.04.16.07.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:37:43 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 13/40] drm/nouveau/dispnv50/disp: Include header containing our prototypes
Date:   Fri, 16 Apr 2021 15:36:58 +0100
Message-Id: <20210416143725.2769053-14-lee.jones@linaro.org>
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

 drivers/gpu/drm/nouveau/dispnv50/disp.c:2599:1: warning: no previous prototype for ‘nv50_display_create’ [-Wmissing-prototypes]

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 351f954989530..4905ed584ff48 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -68,6 +68,8 @@
 
 #include <subdev/bios/dp.h>
 
+#include "nv50_display.h"
+
 /******************************************************************************
  * EVO channel
  *****************************************************************************/
-- 
2.27.0

