Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262B53912C9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbhEZItX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbhEZItL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:49:11 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107BAC061761
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:40 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso2907819wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YRtghyBemkM1f6IZ3GpJkWOqFfzHliaTl7AQXunGZzc=;
        b=Y24P+kDZguBC+oVfwlOZFjooki7OrpJfb708/HImocxi6jC/uZws/ZGaZeCPgRGhsP
         6rH5ZxL4BMZNfhpJiJ4g9XZYsk6YsowF9AlC7gvmBOEjVd1FoWoo67zki9tmuOORdyc4
         SGdDw0BRw6nQ1CtrpdaCr0X3IS2WzJZs0HZ6AwQi1zhcuxR+rwOzbH2sbIuq5ZORCIeP
         yq97uTNUjojtB0lP0QMQsNZRkVT9jOrCJu+Doa5X69vt5c6nB+i0o/f+KRMc+AV5jE1Q
         rkYALgXhiGAs5SFxc/CIMVtGA+ypcoa6H5FoJ/9EGVWi9SpMhDkZxDwhgUoc2YLpQnab
         LzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YRtghyBemkM1f6IZ3GpJkWOqFfzHliaTl7AQXunGZzc=;
        b=c5n9PTN2JbunaNySshpgo1/+PRiVXsbvm1Orp8h6kGgkxAVEoyusTDpg9csxm+IlzU
         xx21f1fibGPC7DMEhAm5WiJ4MzMn2abajRxCd8gib6CkHGELT/lnuYSdrA6ggMyZ/qKu
         90tWxNtcS6JglT6HEgrjuMyD0gXWoRbPx5b8SWbRFVqhKgg5qxzm3S+RQfxtHXocGxGa
         ekKltmNHcJpiGc1YBaDV2jk+AeFhrOx2Xlqi+7t/oLSdYkyTRRc9fhQZihupWoNpMwNF
         OgNmOISJ33bxG1k3R0d0V6lhCupMuPG8dOX+lPpPoPNbnqfSB6Y9hygvPGOUKckFhump
         EexQ==
X-Gm-Message-State: AOAM5303JW1VIuq+QzzOzEp4F7Cxha5LUdtOJ6i8Hav6Ie4+lypqXFiy
        +joZlTorOh7C/vn3dbyr1VcXu1SBcEqzRQ==
X-Google-Smtp-Source: ABdhPJx9vfcxXeT3oxlu5PcMyEPJqgiMaOfRGR7HD4cfqeoJ6OCvXxTjHoGViev/C4hAPtm4WP+X6g==
X-Received: by 2002:a1c:2cc3:: with SMTP id s186mr2365738wms.150.1622018858606;
        Wed, 26 May 2021 01:47:38 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:47:38 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 08/34] drm/amd/display/dc/bios/command_table_helper: Fix function name for 'dal_cmd_table_helper_transmitter_bp_to_atom()'
Date:   Wed, 26 May 2021 09:47:00 +0100
Message-Id: <20210526084726.552052-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526084726.552052-1-lee.jones@linaro.org>
References: <20210526084726.552052-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table_helper.c:127: warning: expecting prototype for translate_transmitter_bp_to_atom(). Prototype was for dal_cmd_table_helper_transmitter_bp_to_atom() instead

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/bios/command_table_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.c b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.c
index 5b77251e05909..e317a36151477 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.c
@@ -114,7 +114,7 @@ bool dal_cmd_table_helper_controller_id_to_atom(
 }
 
 /**
- * translate_transmitter_bp_to_atom - Translate the Transmitter to the
+ * dal_cmd_table_helper_transmitter_bp_to_atom - Translate the Transmitter to the
  *                                    corresponding ATOM BIOS value
  * @t: transmitter
  * returns: output digitalTransmitter
-- 
2.31.1

