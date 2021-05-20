Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A7438AEDB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242643AbhETMqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242781AbhETMoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:44:17 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BB6C0564A9
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:03:23 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id y14so15303396wrm.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oOCS+hcR746GCJgf+MTN84dmS4mfJygmI/El7Wrt4P4=;
        b=ZUD65uqjYlggL85gY9v2dGP0qaEAtUv9/6yMYvyc6T+yU5TXOVtoJYkrk15QeUqmTC
         cE3LQxHt/DtOkRgOgMIfh0MRQGRTTmnYhR4AgZwQQLc3SCNbDeioVcipg6covQsn4ynm
         +GCS3mvEDYAgBL4Hn/l6Ci0RwqwCRXM8oWyhnBZ5L+dwOj4c0mg9nNp9ETdiFOkR46P0
         IsDLYhphvMJegX3q3vjLGm6YIWJ0u3V0ktJfDTBfWhBv/yDqJIq2Yhd0k+sBC64x5JMb
         Ni05pKPh4xHIe1OK0JoD10mCgbve8icQ/yi0vvUP5sCREjDv861COjn5th/TxAaeEvYr
         /2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oOCS+hcR746GCJgf+MTN84dmS4mfJygmI/El7Wrt4P4=;
        b=KBymLw4BgaA/UTsNIJnnv4CzY9wHZJnj3syj4oh3wkrFM6roFjhxxNaV5/t7/X17pH
         qMRso4m0A+dT2ovYOvHSGA+X6X7nPlw4GLFFVLwbt8VJNd/j6FBsCTqpvcSQE8VOaKYd
         ogzmrdBPA4uF3uR7n0LAwjrEOeQSBItlrHTXliVjKYfT8BpLn9G3lDtjiTNkDVbkdMnJ
         iG/3MXOfQ92U0PaKl6EFUkBVCpuAclvIDFoMgf5L4uyVwZC/HyFsuT+h0v2tR1R4ctJi
         lY8pB/ThFl8ylgiXcT0WSVuftUs9dpisNocqcumgmtoUI1yxhGz3AsRrBEv2BoXqOOkK
         y1Fw==
X-Gm-Message-State: AOAM532qeB5KeKayko3hDP2hw5uJbNuxahJHsgARdDhGnaeq+SJ9vBF7
        5AOhHVplHaPD2wbuPghA9K6WXw==
X-Google-Smtp-Source: ABdhPJyAItR0gb4XPRxdBIWogM59UBoe9P9QuJ8hc0mi4kUzQUx9yTK3mbjp5Cx9hjsoU+iBasFpHQ==
X-Received: by 2002:a05:6000:10d1:: with SMTP id b17mr3885211wrx.281.1621512201663;
        Thu, 20 May 2021 05:03:21 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:03:21 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH 29/38] drm/radeon/r100: Realign doc header with function 'r100_cs_packet_parse_vline()'
Date:   Thu, 20 May 2021 13:02:39 +0100
Message-Id: <20210520120248.3464013-30-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120248.3464013-1-lee.jones@linaro.org>
References: <20210520120248.3464013-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/r100.c:1423: warning: expecting prototype for r100_cs_packet_next_vline(). Prototype was for r100_cs_packet_parse_vline() instead

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/r100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/r100.c b/drivers/gpu/drm/radeon/r100.c
index fcfcaec25a9ef..3c4e7c15fd159 100644
--- a/drivers/gpu/drm/radeon/r100.c
+++ b/drivers/gpu/drm/radeon/r100.c
@@ -1406,7 +1406,7 @@ int r100_cs_parse_packet0(struct radeon_cs_parser *p,
 }
 
 /**
- * r100_cs_packet_next_vline() - parse userspace VLINE packet
+ * r100_cs_packet_parse_vline() - parse userspace VLINE packet
  * @p:		parser structure holding parsing context.
  *
  * Userspace sends a special sequence for VLINE waits.
-- 
2.31.1

