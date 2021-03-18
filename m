Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0384C3404B4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 12:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhCRLfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 07:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbhCRLfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 07:35:23 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9B3C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 04:35:23 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id cx5so2960372qvb.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 04:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KmBXAGCvFvpYqqcBHXg4z1zeVnk1DOtEJHhSo0JH5cU=;
        b=LNtv+kAqajFLJPtzOg2+/5ZoQ0rrbBDaq+s7yaPrzGyWjgOq2BYKIfxPUM8uNa/aGh
         oTFqfzaJrjSt6KoGATr76WYdgTpf4KXIle3EDGB+cVgN15YdjBVx4RrPeivFGQwjwyuz
         vcqInqMRoD/bFZVBjdaXSozC9cvb/OQO1MGGsytyYluzbUIeT6zar7mS35x+6JpktkhW
         N2N2cBuINhG/Hb7QHBTEcFOYa1W8JQS1/OJahHI4GRW31NtPt3BLnnqEi5wJTlYtWIBY
         enoDlzAl2KkSe39Ebggifsn6VL+Q88yFmEk0dj2r0JBwaPH5g0okkqVLZzuY2T88saFf
         iv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KmBXAGCvFvpYqqcBHXg4z1zeVnk1DOtEJHhSo0JH5cU=;
        b=l4tmPkaCSTHm+Gff2iBJahxGXJ5N0/+oqiIVhX9jaJPJI5jiZf0ZZwi1sn5tdg9xiz
         ohispoUjqtulyFfpNlvI4UD90ixOU1JtMQ8iIytUpVfB62o2eOvpr3ruVv8VwYYZUVhr
         YnFc29rNN7+tBbt/limjn8XyKA+WN8XZ1QY7LVQK9FxJ3c+k42uuU3aRGbbXEuziW0MF
         9tmYbt221TEVtAPpoS9KxUGW7WIXGzYJQWcX9i1bxv0HuHUjHo/Gw6LGP8aUMYeRntq2
         uEhkH/2eLN0XUSBlBUpPDMpRsfa5cVSVWSIZHtvTJFiczKUFpJ2u1RK6jr9EB7bk529V
         GMHA==
X-Gm-Message-State: AOAM532k7NjNxBIvULVvPyM8Bu6h+jfbxgUagH1Ok6Ed2WNDpqEgz4qI
        igfQLE30546zhbFZ6w851Rk=
X-Google-Smtp-Source: ABdhPJxs+awZjzg+I4yr1kGFNs6UNhuk8pcWqa820xZ2PBlfYTwlckQi5EFB9aagxi5sKj1rE0xDZQ==
X-Received: by 2002:a0c:a954:: with SMTP id z20mr3813029qva.29.1616067323010;
        Thu, 18 Mar 2021 04:35:23 -0700 (PDT)
Received: from localhost.localdomain ([156.146.54.246])
        by smtp.gmail.com with ESMTPSA id k24sm1222233qtu.35.2021.03.18.04.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 04:35:22 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, Hawking.Zhang@amd.com,
        John.Clements@amd.com, guchun.chen@amd.com, tao.zhou1@amd.com,
        Likun.Gao@amd.com, Bhawanpreet.Lakha@amd.com,
        Jiansong.Chen@amd.com, ray.huang@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] drm/amdgpu: Fix a typo
Date:   Thu, 18 Mar 2021 17:03:08 +0530
Message-Id: <20210318113308.1345-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/traing/training/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index c325d6f53a71..db18e4f6cf5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -661,7 +661,7 @@ static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)

 	if (ops & PSP_MEM_TRAIN_SEND_LONG_MSG) {
 		/*
-		 * Long traing will encroach certain mount of bottom VRAM,
+		 * Long training will encroach certain mount of bottom VRAM,
 		 * saving the content of this bottom VRAM to system memory
 		 * before training, and restoring it after training to avoid
 		 * VRAM corruption.
--
2.26.2

