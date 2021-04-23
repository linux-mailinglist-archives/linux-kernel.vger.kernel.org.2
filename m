Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7FC369C1F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 23:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244077AbhDWVkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 17:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhDWVks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 17:40:48 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6646BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 14:40:11 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id w6so20363023pfc.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 14:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZdewDA3O/vpf75aCvIGPbrONaUjKUEiVp0e2T7LbJsM=;
        b=QABHy58z2VRDtQCbsBKAchLL2ZsK3fKYgls12hiZv6d+eauTc/yqd3y2PMMFPaWiN7
         p7ZXmog20r3A+hZh1xLtCVI2OULoqYBI/vUfwoOMP1InMZXRQIDDOmHdJcOGhqrmk1OL
         9NdRWWZypzOgTDicWTnJNUAs+oTJLAr/Y8eKCV5djQLEkvUqAC0w/v7J8XW/Rl6x43Yq
         xHx1dU8KCp3pRZyRYBLGu7GKjsXiM9jHHMe0zgtSz5b7jKMr1oj3yMZIMPl+nEl5Lv8s
         Za+2dMNTywfi4yUl8pg+IxDJ851/U5v8zShS5iPWSjqFpFpOB4+OqRr3JfJ4iQRGXOpH
         IiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZdewDA3O/vpf75aCvIGPbrONaUjKUEiVp0e2T7LbJsM=;
        b=eE7sOxQa+gsB/vsj5AdS9B1pusEaClIsn5cPWYMmfwWfMFOe+FKeQ7AEh4nxN2gGBM
         UPZGyr1Wul6daydQAds7GB0RSdPuNoUuOCbB8BT7JI96yrjTt4cFAjTWyZ2wH2dvM20Y
         rzwmN5Q5zE4rQC1bEg7Qf2gpmUxKe5Q3E3CDKsqTlWZ14Llqgt6yqC9tiYTwGBxhT11k
         pRhS6lgDQe4x4C+RRLD5EUnELlSqlTIq2hDBY0+mwYUMltvcJNtINagBZ+00+LQsLM2A
         58L07Y/op/2frwj/UvAkZL49FLpYeYbZSHvB/6Y4+2H9jnSbD71xmqBiQofXW46/7Ypy
         5X2w==
X-Gm-Message-State: AOAM532Pv1siQLRPSI35IqiRyD4Mj0p5dxUAXBee+jqmoMQ2sA1aYSzB
        Q+3TgUSQOrdPE05aKMDl+lc=
X-Google-Smtp-Source: ABdhPJwtj1HeimjSsv/t/Vm+7rVULlKphY6FH/hjJl5J1zEO1n34ZGFhg4PNHiicYoDfTmOnf/J1ag==
X-Received: by 2002:a62:1ec1:0:b029:24d:b3de:25be with SMTP id e184-20020a621ec10000b029024db3de25bemr5671238pfe.17.1619214010912;
        Fri, 23 Apr 2021 14:40:10 -0700 (PDT)
Received: from localhost.localdomain ([49.37.83.54])
        by smtp.gmail.com with ESMTPSA id e7sm5553001pjd.6.2021.04.23.14.40.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Apr 2021 14:40:10 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, Hawking.Zhang@amd.com,
        evan.quan@amd.com, Dennis.Li@amd.com, luben.tuikov@amd.com,
        jonathan.kim@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] drm/amdgpu: Added missing prototype
Date:   Sat, 24 Apr 2021 03:09:57 +0530
Message-Id: <1619213997-5475-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel test robot throws below warning ->

>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c:125:5: warning:
>> no previous prototype for 'kgd_arcturus_hqd_sdma_load'
>> [-Wmissing-prototypes]
     125 | int kgd_arcturus_hqd_sdma_load(struct kgd_dev *kgd, void
*mqd,

>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c:227:6: warning:
>> no previous prototype for 'kgd_arcturus_hqd_sdma_is_occupied'
>> [-Wmissing-prototypes]
     227 | bool kgd_arcturus_hqd_sdma_is_occupied(struct kgd_dev *kgd,
void *mqd)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c:246:5: warning:
>> no previous prototype for 'kgd_arcturus_hqd_sdma_destroy'
>> [-Wmissing-prototypes]
     246 | int kgd_arcturus_hqd_sdma_destroy(struct kgd_dev *kgd, void
*mqd,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Added prototype for these functions.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index dc3a692..8fff0e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -316,6 +316,11 @@ int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
 				   enum amd_ip_block_type block_type);
 bool amdgpu_device_ip_is_idle(struct amdgpu_device *adev,
 			      enum amd_ip_block_type block_type);
+int kgd_arcturus_hqd_sdma_load(struct kgd_dev *kgd, void *mqd,
+				uint32_t __user *wptr, struct mm_struct *mm);
+bool kgd_arcturus_hqd_sdma_is_occupied(struct kgd_dev *kgd, void *mqd);
+int kgd_arcturus_hqd_sdma_destroy(struct kgd_dev *kgd, void *mqd,
+					unsigned int utimeout);
 
 #define AMDGPU_MAX_IP_NUM 16
 
-- 
1.9.1

