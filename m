Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664C2369AC5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 21:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbhDWTNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 15:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243810AbhDWTM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 15:12:57 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C08C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 12:12:20 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 66so11111303qkf.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 12:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H896F4PjwDY8jmfWwaLDr4shp26B+KmxkyhAPtoMs4M=;
        b=pRma3lac0c5ClpyVGp+FlxDrBykek+53y2UaGikk8p9eHwfH7nW4VE/v7DHQV32oeZ
         5G9WhJZyojjSE6DFn0ndsv4QXv9e1QHpZg07YBRQ/JPMA+MNwFKGdwDu6VXN6kdmcxZo
         1nByFst29E593MUK+C0aJPfnNnZ6ITjj7qF32THxkIdgfRugqs2kBTpMTXIv2+p/1eSH
         LnjKtF3RenT8LbipYN3UZqka5GF9siPGVro+5MTLey4gXPqR3y4gMSfV5V1ftQUwMkhK
         AfJUaiGZIjlyNn3ErcmbmmVME5EYXwOyjigc6yKMlspVMy4AfHPS0ZJY1J+tDLhUa0Sk
         NiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H896F4PjwDY8jmfWwaLDr4shp26B+KmxkyhAPtoMs4M=;
        b=pwTey5iN6dd69FrQeCpzwg4BAasuxPngFDi3gZ8iJG29xZpsr5h0j3r9b/W9mYIdtC
         IFXNo4eSem5QB0BHs5Tb556sd6I/gGDUnRtn8jwxu2ym1U++0tdopHLoeN9UWMue8zch
         /X1XU+9qbIf9YUNpXB47xgA3uZS+PKNB7o6ExPuRop8qizEDrLTaemiEKogpUSSspyZY
         KXcuKoQ4dyR/RRNanjzQS0hv8Jc0vCnsvUq4QRKXI39G7LYtkyGCUwpd4ZTQKVcvvilW
         7GmYqQMEwzc7kzm/4TvuQlKox2lJ9EAvKRPyBoyKwWdaXfEaDtir0H/22VhJRX61TXx+
         wwHQ==
X-Gm-Message-State: AOAM532f8Nqb2E9bAU0jg4mjjD/XSYxEJMezh5q/RJUCL6J41fE1eCh5
        g9pMnDPgzToSbF2pqiP8Gvh89tId/pmcsyfkQoiFqQ==
X-Google-Smtp-Source: ABdhPJxtl7HyuuifiNlkFxXYO7ncQRrKu5Xh1IELP5GvMv+x2eQ8MKIDTBx5pc6kfeilwBtBpV4L+Q==
X-Received: by 2002:a37:a90a:: with SMTP id s10mr5507081qke.63.1619205139696;
        Fri, 23 Apr 2021 12:12:19 -0700 (PDT)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id a22sm4834630qtp.80.2021.04.23.12.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 12:12:19 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 5/5] drm/msm: deprecate MSM_BO_UNCACHED (map as writecombine instead)
Date:   Fri, 23 Apr 2021 15:08:21 -0400
Message-Id: <20210423190833.25319-6-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210423190833.25319-1-jonathan@marek.ca>
References: <20210423190833.25319-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There shouldn't be any reason to ever use uncached over writecombine,
so just use writecombine for MSM_BO_UNCACHED.

Note: userspace never used MSM_BO_UNCACHED anyway

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/msm_gem.c | 4 +---
 include/uapi/drm/msm_drm.h    | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 2e92e80009c8..56bca9178253 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -201,10 +201,8 @@ void msm_gem_put_pages(struct drm_gem_object *obj)
 
 static pgprot_t msm_gem_pgprot(struct msm_gem_object *msm_obj, pgprot_t prot)
 {
-	if (msm_obj->flags & MSM_BO_WC)
+	if (msm_obj->flags & (MSM_BO_WC|MSM_BO_UNCACHED))
 		return pgprot_writecombine(prot);
-	if (msm_obj->flags & MSM_BO_UNCACHED)
-		return pgprot_noncached(prot);
 	return prot;
 }
 
diff --git a/include/uapi/drm/msm_drm.h b/include/uapi/drm/msm_drm.h
index a92d90a6d96f..f075851021c3 100644
--- a/include/uapi/drm/msm_drm.h
+++ b/include/uapi/drm/msm_drm.h
@@ -94,7 +94,7 @@ struct drm_msm_param {
 /* cache modes */
 #define MSM_BO_CACHED        0x00010000
 #define MSM_BO_WC            0x00020000
-#define MSM_BO_UNCACHED      0x00040000
+#define MSM_BO_UNCACHED      0x00040000 /* deprecated, use MSM_BO_WC */
 #define MSM_BO_CACHED_COHERENT 0x080000
 
 #define MSM_BO_FLAGS         (MSM_BO_SCANOUT | \
-- 
2.26.1

