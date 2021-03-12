Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F5F339998
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 23:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbhCLWTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 17:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235511AbhCLWTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 17:19:13 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DA8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 14:19:11 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id w8so5820872pjf.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 14:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5lCTRTL0XOntWq+/Jewv+3VDq5DVbLtgsr4PgJEUSAQ=;
        b=qsTbGYznsg4e7gIVNRJb1Wje1KmeFBB2621CW6lcd0qquAG8lwMa8ABuWdTamWZRkD
         AMw8elFz6Wly5FxmQcHEGQ7Ht0j6Qb5ty+IXNTRqeYhKP4Qg7KZotu7Ho7Il9x+Yf7zM
         pk+DusfI2ktr8p75HiRbXy4stwJArc79STx8fEHR7wc6MvdR7c9rlLxKF/3ZmbJOrwn4
         KL+WHDbvE5uVQPKMvx34QdnLmZT/nRodV2lDRA6jdBtlHm0wvX6GJOzXjNL9oseexnRh
         MJmCMoWtX1kcXW8YXEIzlblYaizhYgzZdVwqf6KKre+TZlqXbcqEgDlP8qoEwNwrGl+7
         EkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5lCTRTL0XOntWq+/Jewv+3VDq5DVbLtgsr4PgJEUSAQ=;
        b=Cz5/N5WGV5GcmpsGcy/IqLi8l9IAKXoIixFS7DB+fc4OHIPLgE1epb5YHv78zCNpoq
         makVwcPfgyNz9aYqfpERNqp9Jsf735/oQTOSub1ITw2KfwZZ53Ih7BDNBrPlI1r6Ykrs
         78vpwR2ednIoPesSXTvo+MT36jBL6P9rZvqa8HscpRbNKYiquoJr8OPeim6KBivbve1y
         aIAu/DoFZ+rrzJelrDZFbIwQB0IVseRn1m0O+rdR5C06N8ZPBor9TLRkmQZUcaMG+bHH
         SCf2DnGv0cVPX0gbm7myFUOxwWPhZJ+gY9q4BZt1iNBo5WaJ4xQfGDViedEf7ONca93X
         iEMg==
X-Gm-Message-State: AOAM530DuCl82nGk7dy4YviD3Hk/NwnYSnRfO/6X2LJT1RDKxIiVdWpc
        p5qXIg0ELJ5z2jq5LEWVUFk=
X-Google-Smtp-Source: ABdhPJwklsbFkTp8L268idsEDENQZHXVv+PsUT6z+eiAfp5PhwrYIRisF5EVudW6Lta4saWme4DDxQ==
X-Received: by 2002:a17:902:bc87:b029:e3:aae4:3188 with SMTP id bb7-20020a170902bc87b02900e3aae43188mr650144plb.56.1615587551227;
        Fri, 12 Mar 2021 14:19:11 -0800 (PST)
Received: from localhost.localdomain ([49.37.85.112])
        by smtp.gmail.com with ESMTPSA id z68sm6487329pfz.39.2021.03.12.14.19.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Mar 2021 14:19:10 -0800 (PST)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, Hawking.Zhang@amd.com,
        Oak.Zeng@amd.com, felix.kuehling@amd.com, kevin1.wang@amd.com,
        le.ma@amd.com, lijo.lazar@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] drm/amdgpu: Mark mmhub_v1_7_setup_vm_pt_regs() as static
Date:   Sat, 13 Mar 2021 03:48:57 +0530
Message-Id: <1615587537-28989-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel test robot throws below warning ->

drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c:56:6: warning: no previous
prototype for 'mmhub_v1_7_setup_vm_pt_regs' [-Wmissing-prototypes]

Mark mmhub_v1_7_setup_vm_pt_regs() as static.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index 4df0b73..ae7d8a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -53,7 +53,7 @@ static u64 mmhub_v1_7_get_fb_location(struct amdgpu_device *adev)
 	return base;
 }
 
-void mmhub_v1_7_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
+static void mmhub_v1_7_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
 				uint64_t page_table_base)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
-- 
1.9.1

