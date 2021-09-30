Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF4E41D10B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 03:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347628AbhI3BqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 21:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhI3BqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 21:46:21 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DC7C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 18:44:39 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id s20so5582057ioa.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 18:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ag+4yNg3t4lDobvnoXDI3lx/G6JRcztPX349EfTrvys=;
        b=XA15C3MS+Ru70z9K5PsYOaBwzptA+i62Y+vQntpRsUlukIjSnmeJDdPy2atqjE4DQR
         upfKCZTzoypEmAcTBoDbVGcEycJBD/EsN9lwpZmGmbVzEshIauR/Th4Sg6ZyVkxKuGZx
         oOq8Vk6++/nCq19t1N0DSSwrCudU9Ekp9hio0+CM4o9vwyxXn2HufWdP0VBIhzTJJja/
         HjfYjviablg2wJeVWudVV0StGkDHDeAq7qRuWywrOcOcgaAEViNTpRhJTx7bj85adxQo
         Flq1RK8Idpuec8A5BjLGPihMJ1cq2L31ryzrAtm+4gvFYUJsmSSshaOW4A778StHdkWL
         1toQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ag+4yNg3t4lDobvnoXDI3lx/G6JRcztPX349EfTrvys=;
        b=vAS102Ops7QbNNr83Wqgqvezw5ytW3s1tU84OJ2qAA1UZuXV10wSGfPyjX9g2b7Idp
         PYZfq5msZr2Jmd7E1ky/JlBcstNcUVKCO/vMECXL5MWIH4cqeCx3+s7ysTmOp/7eabfK
         Y5OvalFIZZHwjdsnOV10JwuxVlhu4q1ex+P6vA8sBh19i9XeSRNBuL7RKflmQPEATzVt
         ZN4SJIz3YWVFMxIKho8EKmf27qHB/g+yxWnp6tIvn9mxrtAGU/sJAGGT15FhJ69MWnOh
         KFDWTw1O53dGogjpAlRLSU86SmIxX2y1JJ0jtr1Dpz+HKLrqtxKUdZ1mW/GfwrtDTDty
         DlcQ==
X-Gm-Message-State: AOAM531r64wly6o0iJh2tHz+VrPlvpMN8frFVi+p+boDIZoyPO7LSotB
        YnJ0NPN1//2m/svQlO8/flU=
X-Google-Smtp-Source: ABdhPJw9+lHlgC4C0Iib/UIs9kg4hYI1KRlIi8BBpwfD2Erth25p4XAh09jmFmHvTdGWPRLhCLs9Aw==
X-Received: by 2002:a5d:9145:: with SMTP id y5mr2010979ioq.200.1632966279194;
        Wed, 29 Sep 2021 18:44:39 -0700 (PDT)
Received: from samwise.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id h23sm1155414ila.32.2021.09.29.18.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 18:44:38 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 0/4] drm: maintenance patches for 5.15-rcX
Date:   Wed, 29 Sep 2021 19:44:23 -0600
Message-Id: <20210930014427.14239-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi drm folks,

Heres a small set of assorted patches which are IMO suitable for rcX;
one doc fix, 2 patches folding multiple DBGs together, and a format
string modification.

Jim Cromie (4):
  drm: fix doc grammar error
  amdgpu_ucode: reduce number of pr_debug calls
  nouveau: fold multiple DRM_DEBUG_DRIVERs together
  i915/gvt: remove spaces in pr_debug "gvt: core:" etc prefixes

 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 293 ++++++++++++----------
 drivers/gpu/drm/i915/gvt/debug.h          |  18 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c     |  36 ++-
 include/drm/drm_drv.h                     |   2 +-
 4 files changed, 191 insertions(+), 158 deletions(-)

-- 
2.31.1

