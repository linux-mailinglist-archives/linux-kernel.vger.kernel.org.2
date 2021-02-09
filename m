Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB728315C78
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbhBJBnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbhBIXtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 18:49:08 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DEAC06178A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 15:48:27 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id h26so193974lfm.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 15:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yNEcY+k1I/sPxeT89v0RbvERaYcFC6w0nk6p7Ga+k7o=;
        b=H55GtJ+kFJow/fff1SlxkWECW/MsUAGzpc1ycWI29ms7aU5BsoRoN6PI5KmdemYb3e
         lsdW1od8WBmJt4SLC9o5lqjwSPxX5fs7DCAZpvaLduFlvDn0up50izcE3A9sh684r1Og
         AhVM1o29PNIjDIv62v++595uWT8LWfgYSbHvAmGTVt0NNlWp/zT9kPJy/3lc7X7qUdyh
         6NMylHkFQ3VWjNHgUOKUdvqqwyiD3KqKSvPNVer+dV9SfmSbV2ZsJ4mldWqSnD3KeayA
         +L+czvtUTNzU2kIljMobA1Gwxet4fjA7apw9SRYaj+eX9RlWpXij60MQw53QCFt3jD9o
         3KpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yNEcY+k1I/sPxeT89v0RbvERaYcFC6w0nk6p7Ga+k7o=;
        b=p7MxcR2/pmTCvq2rngwQYUBIQYlAMhFNgQzAvQhL3QIs7iTjUN37MI7tlvpPRD0Hop
         ikFg5KIRVhdenfTeEdtaIxT1QdrHxPtnKDcE1oX0icgv3yk50YEpwKNEf/pxHGFn8rEE
         AHCRal5SVgPxEMe+TKiBV5XWYoCP2YZ3R1Rp2csJuBqmaGg9McfgFmHJfbnW+RAn4aOv
         fLab9+7DteFbH1s+vJ3VgyG9DjjyTAF9fr2OdLnQLzLLyyaVgwj7h3tBmonkPVsJluNZ
         hyMKckY4B/mrA2DdOR+TKs+BTOfmggjjQNpNkAqUABq10Ai+F6tGh4hWwdAfDo6CC161
         tQ0w==
X-Gm-Message-State: AOAM531uod+zarJD0B9cLSgYKGXAjcsK6tkDuxwARAt3+Ys/YT0H8vjS
        x1z9nTlGmKyyLGJsEQQ7jKo=
X-Google-Smtp-Source: ABdhPJwEgfMGoJUtU5l1trR++7LWKZ1G/cGIubNiHZdjGVjhcKjS3G5FyPiBakSx7jaYCAYohVN/Yw==
X-Received: by 2002:a05:6512:39ce:: with SMTP id k14mr195590lfu.169.1612914506449;
        Tue, 09 Feb 2021 15:48:26 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-164.NA.cust.bahnhof.se. [158.174.22.164])
        by smtp.gmail.com with ESMTPSA id c25sm23779lja.131.2021.02.09.15.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 15:48:25 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Likun Gao <Likun.Gao@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 3/3] drm/nouveau/ttm: constify static vm_operations_struct
Date:   Wed, 10 Feb 2021 00:48:17 +0100
Message-Id: <20210209234817.55112-4-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209234817.55112-1-rikard.falkeborn@gmail.com>
References: <20210209234817.55112-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of nouveau_ttm_vm_ops is to assign its address to the
vm_ops field in the vm_area_struct struct. Make it const to allow the
compiler to put it in read-only memory

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_ttm.c b/drivers/gpu/drm/nouveau/nouveau_ttm.c
index 495288182c2d..b81ae90b8449 100644
--- a/drivers/gpu/drm/nouveau/nouveau_ttm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_ttm.c
@@ -154,7 +154,7 @@ static vm_fault_t nouveau_ttm_fault(struct vm_fault *vmf)
 	return ret;
 }
 
-static struct vm_operations_struct nouveau_ttm_vm_ops = {
+static const struct vm_operations_struct nouveau_ttm_vm_ops = {
 	.fault = nouveau_ttm_fault,
 	.open = ttm_bo_vm_open,
 	.close = ttm_bo_vm_close,
-- 
2.30.0

