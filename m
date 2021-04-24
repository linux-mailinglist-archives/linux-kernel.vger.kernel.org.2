Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6448736A08E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbhDXJlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbhDXJlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:41:08 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AB1C061574
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:40:30 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id w10so441150pgh.5
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LA57vWCVMiY4P4woVTvjEC8mwlFLbTmc6hS8nrtLwxk=;
        b=UHnm3Zn5HEbbnn5HFCMzzMQPadz+vkhBazkUKZ4mAc3p5JOou3t9BqDtm1cb6txw2G
         gAnZ38tfzxUXHSNmbcMdXUhCnLjjb2R67/imj108QATFLT+Jv3DUW5jOr96RumMzj5w/
         kbfGNlszEGrOx72VzADAdcZzlL1LbeGmedZtkikkTj1OotgEUFkI3L04xFzupfqxV/Uo
         lgb3cS+fPoVCN2K+WxdR3q2Y3LmbwUo7BmOPPXJHd+J0TuzBTzI/Lw56wGbt63dhG1d9
         TXb6xOGfjQf1k7kGWGaLhpXsbtxBu8LUc2iZ3j8jIlhiajMkGAJCazJ1v7WQpcITpwrr
         xkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LA57vWCVMiY4P4woVTvjEC8mwlFLbTmc6hS8nrtLwxk=;
        b=spdWD8vjmUAAHjuZfO+yRQ5bN3ssP3ooKWy6ypoLatmPlZ4SBr1ZWRVIic7xoB4gj1
         JuXFFqV+5g74RMwfv4tmap5icl50X+MzCNvDOwWemkSN3CesVgBzST1Taa91TCPfUONl
         RkOXSyeU0W/GCdLIb/xyBeBoQB9uKDsHtRILBi7Yn7O55MLwTRSf5JUoNL7DI3vj8XGl
         Aa/XdIEQ3ond5o6EfxWY6xmp/cqdUcS5vPAVDuNIysYaHqQ7LK4LbDAhL/ilqzvMbm8O
         eCCgqcG0aNVl3OZiqntlhGmCMConHulYWJtQdMk73dP2m03xI/7EROkIMEFMd5WGeuov
         KFqA==
X-Gm-Message-State: AOAM531APXaGpSWmArofek0/3lb4iWwOZ9tgSIfJIgY2pBDaXWs2tyNX
        +JIkFH/VB10dYwqrbxsDPEA=
X-Google-Smtp-Source: ABdhPJwg+tg8GcPgDvv2TDIocwUvqkaroiM+AEvPeULvWWiUJbExOXBCKpVrELN6EVIIo6LoFm7imw==
X-Received: by 2002:a62:9283:0:b029:25d:4039:cac1 with SMTP id o125-20020a6292830000b029025d4039cac1mr7867494pfd.77.1619257229981;
        Sat, 24 Apr 2021 02:40:29 -0700 (PDT)
Received: from localhost.localdomain ([49.37.81.172])
        by smtp.gmail.com with ESMTPSA id o9sm7228119pfh.217.2021.04.24.02.40.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Apr 2021 02:40:29 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     Felix.Kuehling@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH v2] drm/amdgpu: Added missing prototype
Date:   Sat, 24 Apr 2021 15:10:20 +0530
Message-Id: <1619257220-3905-1-git-send-email-jrdr.linux@gmail.com>
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

>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c:195:5: warning:
>> no previous prototype for 'kgd_arcturus_hqd_sdma_dump'
>> [-Wmissing-prototypes]
     195 | int kgd_arcturus_hqd_sdma_dump(struct kgd_dev *kgd,

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
v2:
	Added header which has the function declarations.

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
index 9ef9f3d..6409d6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
@@ -25,6 +25,7 @@
 #include <linux/firmware.h>
 #include "amdgpu.h"
 #include "amdgpu_amdkfd.h"
+#include "amdgpu_amdkfd_arcturus.h"
 #include "sdma0/sdma0_4_2_2_offset.h"
 #include "sdma0/sdma0_4_2_2_sh_mask.h"
 #include "sdma1/sdma1_4_2_2_offset.h"
-- 
1.9.1

