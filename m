Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748723E3592
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 15:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbhHGNfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 09:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhHGNft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 09:35:49 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA86FC0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 06:35:30 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id a20so11140911plm.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 06:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lfpqGuV3FkgsE6sIJlZN1/FnF/i4KwLJkZg8SrqlLBg=;
        b=n2yE//5GuABT5nJx6KwgalyRToS6ZZWdRPUkGs4bCn5D8fqIc02FzVrQC0dGN4IhfH
         oHotltPkWGNezyC/HUjIJJi5E5RvQnfzrcZ1wDOZM7F97ZVyZPjJ3JV6AGlrfizyM2wm
         Lxvi5Ofp7/XjInhXGInEfBl3UwIBQTMx2L3k3bNJkdlGOS4sx2VHTDO+XywlHK0yWzT2
         ZcHVn0VeyTqyFQoGftZQO7MopnOCAbY2s6Fe/l4glECvldZ2Q9ZqaEq2zqlGW6eTmXWk
         maqxSLbcGAEnBIoTESH+O7hEK5nsuVWKby7CHjRmrhxUo/P/OTfdqHf1MB5Mn4X/gj4H
         7S1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lfpqGuV3FkgsE6sIJlZN1/FnF/i4KwLJkZg8SrqlLBg=;
        b=isFyepuTWc1IlrzvHHt1Xj3jrxg5d5CYKfdyUZpooEuX4rteDt594NMhyU5YHn8B6n
         53id4s/M3zGrk08RCktO0iWyf9Fh/8Lik/jTug0v9ZjThr1wP/+sQuuWwEeBNimePCnh
         /EqCntV4ilGD1Q7bbdgxdwMDvNMzXLzdFHDfWrQc2lMeYd7RM2L35SXduWnKHJOlhTr1
         FStS6IjSy04D+oE5NRNCoOY3IEq0niduYlltuORo7r6EiPalWFofmHmDmrxSp6awgp+v
         jMRB6Hl26ojoEREFsIWeECfB2pPD5A2NLD/hqJtsJy0m+vYMgrE/OY12L8GPvKxbknq/
         YvWw==
X-Gm-Message-State: AOAM53148PlIKmyCAakqgYqC+ufcmlaSbVXSias+1XjwT7h7H8EhJPx0
        0r9XGbgrkho5KeGGCirNyL0=
X-Google-Smtp-Source: ABdhPJzbVausotJitV6ge4yNPA7o0Hk53NaWfOlofLSePiuEcrn4dtEvTiUa50T0wpMbQr4qucxIKw==
X-Received: by 2002:a17:902:c3cb:b029:12c:a426:164a with SMTP id j11-20020a170902c3cbb029012ca426164amr12991599plj.81.1628343330316;
        Sat, 07 Aug 2021 06:35:30 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.87])
        by smtp.gmail.com with ESMTPSA id cu12sm15967183pjb.5.2021.08.07.06.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 06:35:29 -0700 (PDT)
From:   Tuo Li <islituo@gmail.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        lee.jones@linaro.org, trix@redhat.com, Chris.Park@amd.com,
        Ashley.Thomas2@amd.com, Charlene.Liu@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
        Tuo Li <islituo@gmail.com>, TOTE Robot <oslab@tsinghua.edu.cn>
Subject: [PATCH] drm/amd/display/dc/dce112/dce112_resource: Drop redundant null-pointer check in bw_calcs_data_update_from_pplib()
Date:   Sat,  7 Aug 2021 06:35:06 -0700
Message-Id: <20210807133506.243629-1-islituo@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable dc->bw_vbios is guaranteed to be not NULL by its callers.
Thus the null-pointer check can be dropped.

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Tuo Li <islituo@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
index ee55cda854bf..3fc8e6b664f9 100644
--- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
@@ -1064,7 +1064,7 @@ static void bw_calcs_data_update_from_pplib(struct dc *dc)
 	struct dm_pp_clock_levels clks = {0};
 	int memory_type_multiplier = MEMORY_TYPE_MULTIPLIER_CZ;
 
-	if (dc->bw_vbios && dc->bw_vbios->memory_type == bw_def_hbm)
+	if (dc->bw_vbios->memory_type == bw_def_hbm)
 		memory_type_multiplier = MEMORY_TYPE_HBM;
 
 	/*do system clock  TODO PPLIB: after PPLIB implement,
-- 
2.25.1

