Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470F03AD83A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 08:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbhFSGqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 02:46:20 -0400
Received: from mail-m17639.qiye.163.com ([59.111.176.39]:14236 "EHLO
        mail-m17639.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbhFSGqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 02:46:19 -0400
DKIM-Signature: a=rsa-sha256;
        b=V7U9SUoPmwi6dCxg84nX2VemV9THIQztla0KW9b/w8RzxJGQ6E9L3N3Jlg+J/5dbZnZOx/ZIvmeF1q3nLDZ4SfqDDENrTehFTVivHVt/HVk7M01oVkIUDH7LYcFLM8VyLW7h/7fnAYJ2LGnOoWe2A2Z4I3naFac75W5dg/NhJAY=;
        s=default; c=relaxed/relaxed; d=vivo.com; v=1;
        bh=s42oowK7cO0V1ZW3C3sS49FrZZtUENhP2zLbYkd5Fe8=;
        h=date:mime-version:subject:message-id:from;
Received: from ubuntu.localdomain (unknown [36.152.145.181])
        by mail-m17639.qiye.163.com (Hmail) with ESMTPA id F243C380113;
        Sat, 19 Jun 2021 14:44:04 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Bernard Zhao <bernard@vivo.com>
Subject: [PATCH 0/4] delete useless function return values & remove meaningless if(r) check code
Date:   Fri, 18 Jun 2021 23:43:44 -0700
Message-Id: <20210619064349.26676-1-bernard@vivo.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGhlCH1ZCTx5IQx4eGRpNGkNVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hOSFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NzI6Ljo*PT8cTkIJKxcXTSkD
        NVYaCRNVSlVKTUlPS0NOS09OT0tOVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlITVVK
        TklVSk9OVUpDSllXWQgBWUFJTk1NNwY+
X-HM-Tid: 0a7a23031f84d994kuwsf243c380113
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function radeon_fence_driver_init always returns success,
the function type maybe coule be changed to void.
This patch series will first delete the check of the return
value of the function call radeon_fence_driver_init, then,
optimise the function declaration and function to void type.

Signed-off-by: Bernard Zhao <bernard@vivo.com>

Bernard Zhao (4):
  drm/radeon: remove meaningless if(r) check code
  drm/radeon: remove meaningless if(r) check code
  drm/radeon: remove meaningless if(r) check code
  drm/radeon: delete useless return values

 drivers/gpu/drm/radeon/cik.c          | 4 +---
 drivers/gpu/drm/radeon/evergreen.c    | 4 +---
 drivers/gpu/drm/radeon/ni.c           | 4 +---
 drivers/gpu/drm/radeon/r100.c         | 4 +---
 drivers/gpu/drm/radeon/r300.c         | 4 +---
 drivers/gpu/drm/radeon/r420.c         | 5 +----
 drivers/gpu/drm/radeon/r520.c         | 4 +---
 drivers/gpu/drm/radeon/r600.c         | 4 +---
 drivers/gpu/drm/radeon/radeon.h       | 2 +-
 drivers/gpu/drm/radeon/radeon_fence.c | 5 +----
 drivers/gpu/drm/radeon/rs400.c        | 4 +---
 drivers/gpu/drm/radeon/rs600.c        | 4 +---
 drivers/gpu/drm/radeon/rs690.c        | 4 +---
 drivers/gpu/drm/radeon/rv515.c        | 4 +---
 drivers/gpu/drm/radeon/rv770.c        | 4 +---
 drivers/gpu/drm/radeon/si.c           | 4 +---
 16 files changed, 16 insertions(+), 48 deletions(-)

-- 
2.31.0

