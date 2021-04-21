Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6EE367392
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 21:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245366AbhDUTn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 15:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241211AbhDUTn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 15:43:27 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E80C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 12:42:53 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j5so41532711wrn.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 12:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JU6/Qfl9n+QXWwBGt0462NZzcBDiybmlQ03LCPVjDcM=;
        b=EF4lWCEaoKX8fLy8cm5aOM/qjMBsBPcQxY6gh7z1b6zRT0KzOLOCYtnYT2OLC64JbL
         rzQ4CI8LNWIewiRGfBk3db2sk9X0ITizHMfXEx/Y2SMgBvuJ459nGLhFpSsjSbrG0kZe
         HfMkpztZZ/ki5VMyPg1iW5fC26ijNiTbKL47LjdIPjS5/Nvmefod6zmqaC2qJg/UILlX
         01eY3CBfTf0+doHRt6V/+PIs0FRC9J17kKkXKz+XC9FMuGsQ6ECfcI5rPqRwc1BePWvp
         tk5nyun6WSPL/nx080ahNpi59LafdJssw6pQ2dpr9Y+rPhgK3SC+9y211CksOFi3xh9P
         yrug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JU6/Qfl9n+QXWwBGt0462NZzcBDiybmlQ03LCPVjDcM=;
        b=P4SHN4IMiGhgv2ER1bEKMHYxBCmzBjcYQ9S3nzZIrStySfNGNNbpbzm5+MVBXsUpTP
         KzlQ6IGlWbntcrCU7iL6YznFGCnWb1f5uSOOk2izZTQkn8MCQcJE/C+ojLTTEdj9QkS5
         +VWcl2pGc9+03A3LqwfhrNw0be3TeQzbRYLZRULp/F3oj+2RBoMwYHsTcuViyAepadk4
         EnozNrzBeRWuxYRWLT13rMkKTazOCKr6ymvu5IqQDRpyeC7WcRLJmCaTNUREeHjmPNs1
         XEvM+Jui7nmshcVua1K/dq/hQuE0aLMd6UgTl1TNyB+9980wp8fAxzWpzKmhzT2gfqoh
         ROgQ==
X-Gm-Message-State: AOAM533gK/r6k9kf1VK2OKLfke2GjNmM+ze05oZJZTvfChV93fsPBCDB
        bU/EntzWn9+uSXqx98SAr2w=
X-Google-Smtp-Source: ABdhPJxwLLpPCAGgCKzl/unvPvqM8+kZJPO3R33aSTcElWruEpi/1NIOV+MzVBGeU40BkA90bykGHQ==
X-Received: by 2002:adf:cf09:: with SMTP id o9mr29478140wrj.366.1619034172365;
        Wed, 21 Apr 2021 12:42:52 -0700 (PDT)
Received: from bcarvalho-Ubuntu.lan ([2001:818:de85:7e00:6d3d:2d8b:5417:831c])
        by smtp.gmail.com with ESMTPSA id o4sm484163wrn.81.2021.04.21.12.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 12:42:51 -0700 (PDT)
From:   Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     melissa.srw@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH 0/3] drm: Use tabs for code indents 
Date:   Wed, 21 Apr 2021 20:42:46 +0100
Message-Id: <cover.1618828127.git.martinsdecarvalhobeatriz@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove space and use tabs for indent the code to follow the
Linux kernel coding conventions.
Problem found by checkpatch

Beatriz Martins de Carvalho (3):
  drm: drm_atomic_uapi.c: Use tabs for code indents
  drm: drm_blend.c: Use tabs for code indents
  drm: drm_connector.c: Use tabs for code indents

 drivers/gpu/drm/drm_atomic_uapi.c |  6 ++---
 drivers/gpu/drm/drm_blend.c       |  4 ++--
 drivers/gpu/drm/drm_connector.c   | 38 +++++++++++++++----------------
 3 files changed, 24 insertions(+), 24 deletions(-)

-- 
2.25.1

