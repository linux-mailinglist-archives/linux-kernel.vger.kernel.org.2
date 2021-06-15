Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4578D3A7461
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 04:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhFOCuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 22:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhFOCtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 22:49:40 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC846C0613A2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 19:47:34 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id 5so41791652ioe.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 19:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XZngOmx3QZGSGE9q4/ABb06fw8+v1CSMYNte3U/V958=;
        b=j8BK1QDugcRXfg29Tqm6PhfSwlMgaC9EAqEaNluYMNCwd1ZYqElpq+kpbUktZ/urN4
         MVFmsPENeAISNrJygUJCEH0UF3af93a34tumnmJViTDG/YGE/wodIWkh6IlvmCndB6+C
         dhDr528Ave7TwpBKkGjCQI5PK87kyPYmJvipI4DE38MSn+6feAKYNBkQV19h8yNjhNDr
         UYugo4buc+C0+WvrHfvDhza6lHEJ+JjmM2oqHjcwqmDbG1d19wnfbfgHbu/EGX3jc2Tu
         jTh8f5lXw1t0Dqjad76TQQ7B/0slKvtYlcdMqP/585LM2WdakYuYfAYdSziFLM0+kJIK
         /K5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XZngOmx3QZGSGE9q4/ABb06fw8+v1CSMYNte3U/V958=;
        b=o9YwIkbHJiOccdunhetULPPy68cl+982mgwJh/+CNAErQr49gogDsGGNmoGPXo+lU8
         LWNzo+8GELTy1eN7YPGMX3BLKV1vzQZf4WK6qe2aiL9lQo+0KlW5LwqDzS373yuLiPp3
         qN1OVLJtXlI5rTcVdcxQzy3ruv1MQAy0JZIJutM2rVMoMUXXBtKsRP2nFxhVdjNVk6/d
         5MMWmOwkRfVnDKTDIJkSHS+uOtli5zCTamKq/VKhgQ9FpYO0OUeELcN5p/nJLIECtrqU
         sjLcX82y71PVWgKyVd4UhQh1ZKispDBcha94fzLpzg8Bfnb6D74iHr81flxJ7FcaF4h0
         DEEw==
X-Gm-Message-State: AOAM532QB/zCk9jH+iSQx6iU1Zz+j+1Zo9MH5BOh3ONDC5DMRl2h+qYt
        fN+2wqkr7KimscWvGL2AWJdwx6ERhyTK4YM6WEg=
X-Google-Smtp-Source: ABdhPJwkiRcyYOeOqxFuMqJ+7O0OK1G86N3d9NPQLqADbQgmmfevSGkqOf0Dpo41Ig68e77DvD7ZZA==
X-Received: by 2002:a63:ce07:: with SMTP id y7mr3664904pgf.249.1623724650822;
        Mon, 14 Jun 2021 19:37:30 -0700 (PDT)
Received: from localhost.localdomain ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id b133sm14102623pfb.36.2021.06.14.19.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 19:37:30 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        emil.l.velikov@gmail.com
Subject: [PATCH v2 0/2] drm: Address potential UAF bugs with drm_master ptrs
Date:   Tue, 15 Jun 2021 10:36:43 +0800
Message-Id: <20210615023645.6535-1-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series addresses potential use-after-free errors when dereferencing pointers to struct drm_master. These were identified after one such bug was caught by Syzbot in drm_getunique():
https://syzkaller.appspot.com/bug?id=148d2f1dfac64af52ffd27b661981a540724f803

The series is broken up into two patches:

1. Implement a locked version of drm_is_current_master() function that's used within drm_auth.c

2. Identify areas in drm_lease.c where pointers to struct drm_master are dereferenced, and ensure that the master pointers are protected by a mutex


Change in v2:
- Patch 2: Move the lock and assignment before the DRM_DEBUG_LEASE in drm_mode_get_lease_ioctl, as suggested by Emil Velikov

Desmond Cheong Zhi Xi (2):
  drm: Add a locked version of drm_is_current_master
  drm: Protect drm_master pointers in drm_lease.c

 drivers/gpu/drm/drm_auth.c  | 23 ++++++++++++---
 drivers/gpu/drm/drm_lease.c | 58 +++++++++++++++++++++++++++----------
 2 files changed, 62 insertions(+), 19 deletions(-)

-- 
2.25.1

