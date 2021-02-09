Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED54315C76
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbhBJBmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234496AbhBIXtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 18:49:07 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0928BC061786
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 15:48:26 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id f19so479819ljn.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 15:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4swNihDJsoYDJ0JsyJpoLdvvdULpyc/j+WuCFDkGmdk=;
        b=DvGasgA0cBZxp10arB0pzHAA1elBFCn6tbSXE+bUO9kNl0dcAlRLjHFfTwTid6UkaK
         ClaJs+JwM2OWf+ysSQ20FVEj7J9jqethm5mXLVh0iSq+LzI7Pzcdt3rHTpW63cetSWZ3
         KJr+a0sLR97wkDBDC+XBvIGpXAjuG+PvVkRJYHQbiOY53uzGHMsJu7V7DOhQpXkLGD/s
         vrm34aGpfgT7XqPa4R+lUh9iVnPdg76XWg8R2juQt8BJ2nmOUyvV6qcTisw1T16Ai3Dk
         06i80KyIlv934deDzVPavbqkNr+08UtlVJkz4Jm75gmnHuvGPP2bMCYoWEGVT57datxG
         4MCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4swNihDJsoYDJ0JsyJpoLdvvdULpyc/j+WuCFDkGmdk=;
        b=kFNrpXmUbk0lkJW3scpVbulBlKXJjhXWAulW+oxr4nD3tBSvG+PTiK12+hpYOKWagY
         8aGQOeE4/J8geNB1F9vlLZSvIRuvPsN1H609vTr0hMNkGlORjXkBuGHUdykuN3rPh0+8
         JEBUvg8DMOnbsFy3FbxrVZ5MMXZX6/u1qtrCXH3v5gDnTzLpc7s1Nn9QipWcPZ1xEoJS
         87xC7AgjI47o3zEHoeqKGlurCIQ1z8Bn4BDIc+9+YCZMLRDutobWWYRL/N97gIPpCtf0
         Gh8dw5qTe7v7g6j17YuMjV7EE3b8dNL8WM95e1Yh6yzPxj7XUN9kK9Hro/5jZ23MYnq1
         pZ4A==
X-Gm-Message-State: AOAM532HKYHjmKDa8PA/TGWy3lIi1SDfqk/xXI0euqp4SBl0bn0P0McX
        GgdNFbDZZ+9LJuRyUGS5Q3E=
X-Google-Smtp-Source: ABdhPJwgJMwrUJpmjPdiN4LhVY8dzLtZOmK+2j8dd/eOrcdGwk+wfMPJmghCa/fXf9neZoI5z8dCSQ==
X-Received: by 2002:a2e:804d:: with SMTP id p13mr164131ljg.177.1612914504481;
        Tue, 09 Feb 2021 15:48:24 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-164.NA.cust.bahnhof.se. [158.174.22.164])
        by smtp.gmail.com with ESMTPSA id c25sm23779lja.131.2021.02.09.15.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 15:48:23 -0800 (PST)
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
Subject: [PATCH 1/3] drm/amdgpu/ttm: constify static vm_operations_struct
Date:   Wed, 10 Feb 2021 00:48:15 +0100
Message-Id: <20210209234817.55112-2-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209234817.55112-1-rikard.falkeborn@gmail.com>
References: <20210209234817.55112-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of amdgpu_ttm_vm_ops is to assign its address to the
vm_ops field in the vm_area_struct struct. Make it const to allow the
compiler to put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 29cfb0809634..a785acc09f20 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2002,7 +2002,7 @@ static vm_fault_t amdgpu_ttm_fault(struct vm_fault *vmf)
 	return ret;
 }
 
-static struct vm_operations_struct amdgpu_ttm_vm_ops = {
+static const struct vm_operations_struct amdgpu_ttm_vm_ops = {
 	.fault = amdgpu_ttm_fault,
 	.open = ttm_bo_vm_open,
 	.close = ttm_bo_vm_close,
-- 
2.30.0

