Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5878D3A4EF3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 14:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbhFLM5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 08:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhFLM5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 08:57:12 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BED3C061574
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 05:55:13 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id g6so6750151pfq.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 05:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eb2MpznI1FrI/fGbqqgN7+yj2amKt0XEdrNNlykJC5k=;
        b=TfXfu0bfH9YUnOeSFGMVLTZYIRcJVfZT2oHpbhX/QW7VDi36f6jsqCzp/e4Z3muh7W
         JloSXUKgWczFceQ6BZzmStBQJzGtBc5nUAVo+vFaFyqKvuUFdDpvxjH90QUM8henXy/m
         8dNjf3MTi1LeU/87XF9fi3Tu6mk2hG9Hn97Ux13KlPrWMaVrgSfruzoJkETXmtn6cIxE
         cNaUwOozGVWmycnhAjns1O6SMkmf4KNgzhHhNr57cwlo7ELMQDHAo8bxVw+oYWLSdKVL
         vofDJveXshvsMMhj53rsHxtQ74Tdl4sYY7G6w5qv8HdB+ZYm4molOxO52nTN5B4ytcBg
         mLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eb2MpznI1FrI/fGbqqgN7+yj2amKt0XEdrNNlykJC5k=;
        b=PraM+3gRxYKgJiO4vy4GbZBhLkqAmzVQ//bzRPdWRzA07YeTlHjtGEtJGr+1fxQClK
         /R2DjlMOF4zaTDwlPLnx1TQoFoeL9/AiYzUE0fb7d0KNxqxLsifKFrBV+xu4NOoIAdiv
         gv0x5lrLAkTcFaDpVYvbq/y6RAaheevmXAbTFSluqAOBnY6zSjwAkl9Xoy/swj8T2clL
         oZMt3HGTGZurydzCrnMiyJxkCgEDBbQWjEiKEh0EcsSvkOsnY+yEMwav5f7J21D/kgFb
         gutYdrrIyzbDBURwOSjsBg4uswX3GueauiUQsduA7H9ry4BJ4IPmH4txPwj5+VzS3XA0
         Jbng==
X-Gm-Message-State: AOAM533navM7BPkFUc+ngFSEgl9S0ZhSQaN4bQsmuCUTXKuSNJaXTaeK
        wNTQfWZzJ2o6C/LNzi/Yipk=
X-Google-Smtp-Source: ABdhPJyQcLlhoZsHoGgitL1Yik3SCMrENZucQuSz7Oa97wztfdRZjB+cRh2q9PHjcpLYOQ30hzuZ1g==
X-Received: by 2002:aa7:8a58:0:b029:2ee:2da3:746d with SMTP id n24-20020aa78a580000b02902ee2da3746dmr13250190pfa.75.1623502513030;
        Sat, 12 Jun 2021 05:55:13 -0700 (PDT)
Received: from localhost.localdomain ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id c7sm8015498pgh.72.2021.06.12.05.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 05:55:12 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 0/2] drm: Address potential UAF bugs with drm_master ptrs
Date:   Sat, 12 Jun 2021 20:54:24 +0800
Message-Id: <20210612125426.6451-1-desmondcheongzx@gmail.com>
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

Desmond Cheong Zhi Xi (2):
  drm: Add a locked version of drm_is_current_master
  drm: Protect drm_master pointers in drm_lease.c

 drivers/gpu/drm/drm_auth.c  | 23 ++++++++++++---
 drivers/gpu/drm/drm_lease.c | 58 +++++++++++++++++++++++++++----------
 2 files changed, 62 insertions(+), 19 deletions(-)

-- 
2.25.1

