Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7A63912CE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbhEZItb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbhEZItO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:49:14 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325BCC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:42 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j14so207305wrq.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S7Vhy55irc0KIRnoY1AtIhd7OdR89vjnmNeVszJAECQ=;
        b=eOgEFPmvC30HjVNA4Cq3235ugvwODQjfTMEVmYHNrTdvhnuoAsJejtxVRd3f8oj5Wi
         oRQQEFGbC4NXCz0QMPmwIR9qxYU8DlpvdkfUMHtBfcdLhB4yMFUMnzwNIY9CtmqCJTHl
         O+HbpzWWWcraBqJj1gRG9fQMp6wrPlO13d0Bi4B96ycuqw9dL+o0N7dsrc6tiDzncxrL
         HsIEr8NJ/tttK8hTKWsYTDcPjNF/E2lrmYRacRhA6AgqtomdIxPuOSSeTso+7plsZXSX
         OwoSpcUV7EtXkzV5ljXXYXBGzsjWUHAErFwWrwqJ44PkNDBRO9w9EIZjfw5teG+aul48
         hnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S7Vhy55irc0KIRnoY1AtIhd7OdR89vjnmNeVszJAECQ=;
        b=pN311T0u+sDjO5HeIKe3aRBdL1bY+sF5NE0loNwo752RNUKxeVbMsiUNLLESgjLTUl
         WbyWjS5d8HzB8sI8fLEEyVybKWlph7zuFVnHyH6yX8+4oOf2f7+8vcF20UtHG5cC//SF
         EOGo7/fCHqxmCeXKrqdajHpRFZYXAquKYQceE7IpIvW+IawESwADkuz90SsWbZaSJW7j
         KGFwoOksVFEst879eG1Nx9juxyaiF3yjaSDbOYZ8zZLyF9XEgXtHaqhjjQp4KTrODyGr
         BE7HgWzEZ70xkjUVQVBgCzMrFGUqKhPlSyASYlCLtt1jV7RAdR5C/n9fq+ehj40TJv9g
         2f1w==
X-Gm-Message-State: AOAM530SvSwJSV+eeS68NisSK0l2krXOcSWjpSW7o/hRndHpDpqUes4D
        6socD4CC0pbe1GoXfWCu5eDkHA==
X-Google-Smtp-Source: ABdhPJxE0BtwOIYQjuYn6Y7+Q6ACbzICk5aAr0XXdSoA3yVkfOmmF2TnwfLbYcp+4PimxnS4+0XwlA==
X-Received: by 2002:adf:a2de:: with SMTP id t30mr16243809wra.104.1622018860628;
        Wed, 26 May 2021 01:47:40 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:47:40 -0700 (PDT)
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
Subject: [PATCH 10/34] drm/amd/display/dc/bios/bios_parser: Fix formatting and misnaming issues
Date:   Wed, 26 May 2021 09:47:02 +0100
Message-Id: <20210526084726.552052-11-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:997: warning: expecting prototype for get_ss_info_from_table(). Prototype was for get_ss_info_from_tbl() instead
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1562: warning: expecting prototype for BiosParserObject(). Prototype was for bios_parser_get_ss_entry_number() instead
 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser.c:1739: warning: expecting prototype for get_ss_entry_number_from_internal_ss_info_table_V3_1(). Prototype was for get_ss_entry_number_from_internal_ss_info_tbl_V3_1() instead

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
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index c67d21a5ee52f..9b8ea6e9a2b96 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -979,7 +979,7 @@ static enum bp_result get_ss_info_from_internal_ss_info_tbl_V2_1(
 	struct spread_spectrum_info *info);
 
 /**
- * get_ss_info_from_table
+ * get_ss_info_from_tbl
  * Get spread sprectrum information from the ASIC_InternalSS_Info Ver 2.1 or
  * SS_Info table from the VBIOS
  * There can not be more than 1 entry for  ASIC_InternalSS_Info Ver 2.1 or
@@ -1548,7 +1548,7 @@ static uint32_t get_ss_entry_number_from_ss_info_tbl(
 	uint32_t id);
 
 /**
- * BiosParserObject::GetNumberofSpreadSpectrumEntry
+ * bios_parser_get_ss_entry_number
  * Get Number of SpreadSpectrum Entry from the ASIC_InternalSS_Info table from
  * the VBIOS that match the SSid (to be converted from signal)
  *
@@ -1725,7 +1725,7 @@ static uint32_t get_ss_entry_number_from_internal_ss_info_tbl_v2_1(
 	return 0;
 }
 /**
- * get_ss_entry_number_from_internal_ss_info_table_V3_1
+ * get_ss_entry_number_from_internal_ss_info_tbl_V3_1
  * Get Number of SpreadSpectrum Entry from the ASIC_InternalSS_Info table of
  * the VBIOS that matches id
  *
-- 
2.31.1

