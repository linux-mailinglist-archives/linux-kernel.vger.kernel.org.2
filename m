Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D393DC4F6
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 10:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbhGaIZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 04:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhGaIZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 04:25:32 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D61C06175F
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 01:25:26 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id m11so1651920plx.4
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 01:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mHdpvkbP+f+dtX797YzbOAyZjqosEwv+iX1MkyFepyo=;
        b=FgD1XECONq1EEacsOnbHTBSX9RTttVxZCK7tvs4bHdTD0PFR+DLQFGoGIB7yau7x3A
         aIjFV07RmNaD6CUmzpWt6gL0WCwibOpNLZs5IIRJEyAMGI/xeNOX6IXVyMQyWmgikBmr
         dtaxcd+sRmDLQk3l8YeRD9Zo7IoykCTeTLsfgeiAHBIcTbrSZf5a4B1Db/H06hWFzcQF
         B7Yexkb75+Yh8vk+ZKLhh2afiLafMC26x57vMDPdJOpdNxnSVayOemPL6NfTWIkfS5zv
         4JyUiwUYvvl3UE6C+W+Vm5m4Nfntb6R7jj2add3fXmLSrdvnLXCPvF4nyaIJiBndtd42
         /TJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mHdpvkbP+f+dtX797YzbOAyZjqosEwv+iX1MkyFepyo=;
        b=OwBc+Xhmkmth98rjDEweY9pElgjnUdplmSI4UlOPy5yG60M8o5peUDzwgvKuImZ7Jq
         6sHdskv35JENUZZM85vsF/NQE/RvKgqDa+q1tjLdXWfNr0BWFZP72LClkjLfRa08PLxI
         rXGeV/2Czoi3diYawG6JR/OekVj3htducyZQsiT+hzZszergPo5VwQCsxQBWM14bBpsG
         eCjrVe2f6Nc+lXMIyY5pXTD14bOt8f44ZBS+096f950EH4xmyMriH5bsFSj3gDilHHoe
         ZAJOTRk6KOn8VvSKVrYG10iQyOpjh/fRKt1htyKjLCcZaEbHEwiN4KJ3kgO9+qVDCuHe
         qTGQ==
X-Gm-Message-State: AOAM533fhFjVpDM4G/BGDRvGssX8TjYjUjLQ3nUw301i309d6KdwXHmn
        EOn7n7PXmMeiWnWRQn7c+wA=
X-Google-Smtp-Source: ABdhPJzV88a/NgZkzpC2Uk3z53JeCgHQMRG5Zr9JcgffkGLRyOiiycYGDbfxycax3nceUGRo8HTqOQ==
X-Received: by 2002:a17:90b:f92:: with SMTP id ft18mr7360311pjb.31.1627719926122;
        Sat, 31 Jul 2021 01:25:26 -0700 (PDT)
Received: from localhost.localdomain ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id mq7sm3182124pjb.50.2021.07.31.01.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 01:25:25 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2 0/2] locking/lockdep, drm: apply new lockdep assert in drm_auth.c
Date:   Sat, 31 Jul 2021 16:24:56 +0800
Message-Id: <20210731082458.1962043-1-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Following a discussion on the patch ("drm: use the lookup lock in
drm_is_current_master") [1], Peter Zijlstra proposed new lockdep_assert
helpers to make it convenient to compose lockdep checks together.

This series includes the patch that introduces the new lockdep helpers,
then utilizes these helpers in drm_is_current_master_locked in the
following patch.

v1 -> v2:
Patch 2:
- Updated the kerneldoc on the lock design of drm_file.master to explain
the use of lockdep_assert(). As suggested by Boqun Feng.

Link: https://lore.kernel.org/lkml/20210722092929.244629-2-desmondcheongzx@gmail.com/ [1]

Best wishes,
Desmond

Desmond Cheong Zhi Xi (1):
  drm: add lockdep assert to drm_is_current_master_locked

Peter Zijlstra (1):
  locking/lockdep: Provide lockdep_assert{,_once}() helpers

 drivers/gpu/drm/drm_auth.c |  6 +++---
 include/drm/drm_file.h     |  4 ++++
 include/linux/lockdep.h    | 41 +++++++++++++++++++-------------------
 3 files changed, 28 insertions(+), 23 deletions(-)

-- 
2.25.1

