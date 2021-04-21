Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318133673B0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 21:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242477AbhDUTri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 15:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235966AbhDUTrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 15:47:36 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C4AC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 12:47:03 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id g9so26495941wrx.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 12:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/kZqRjhE3R5JUG9kHiYQ4hDaNWVduuH/NPkt3x6nfsA=;
        b=oGke5souEYgJohQtV2QSaNwO2ESSjvHKqjUSi5z7tDqnUcyIVMeEXAyluKQnGGoHoh
         Ca8dZUujb+1HYqJYAEAA2/WIcJ0zQxw/Sk8kkNGGAhHD/M+l38Hr8LIglCmr6ExfJWD/
         jCewvRKpgbWQbezDa0OAp1lcbrQf6TfP/cbVo9iQgT8Jh0G65ssudMCse57lXby2AEei
         5T7NxSjk+qeqobGeIgx7EsUmqKG4QKRq2WXzkAxgFAFDGFfY5qQx9M2Bv0ahVGPsXfo2
         SGjvYw1rincMHC+rdqcSiTLQE4ni3ig64WoKJm8G0x0ok8pB6C6zmRJcI47lusqEFSY9
         2xpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/kZqRjhE3R5JUG9kHiYQ4hDaNWVduuH/NPkt3x6nfsA=;
        b=kaG4jgU8oyIFH4Md1+Pd63AJhaHYTP86FgHHH/Wp8a7eQxvqKRUtpBQr25Ag/qMy1v
         gge/srBQWZ2DPTGFh7jmv8U3PhIId115JVjnDa1kjkZ/fKDRYmmHSU2baycOy7hLZVBI
         VcoxTo+OfccZkwwtyAEG0cVWyrrZBH5VKK3G6ehJj+NClTpCsph+g25AqQlJKeHhiSwf
         lKri1szMul2u+LlSNs5iRm2QiFieV4bb8Du8rovoufUjumOZvNdLf3TcapN7KEwGErIU
         lETGi5kzU7w/Ku3Z3DpFOq48rShhMMwjvk221VFCvvDQ1kblBn7Q3gbgTip7HeO8RgKQ
         Pbxw==
X-Gm-Message-State: AOAM530SXF681HWdsPO4rHO6+gXMbgKPH6MoNhIaCHWFRYhXUhEAIGzZ
        D0qageDo4vc4+HN+XkirysA=
X-Google-Smtp-Source: ABdhPJz07TgN43jTbi7d0YRbfGaBSemHp+g7RW97Qynj85k3ab6X3ASUh/RWCXezI5ypRAhuSylrIw==
X-Received: by 2002:a5d:47c1:: with SMTP id o1mr27365168wrc.216.1619034421930;
        Wed, 21 Apr 2021 12:47:01 -0700 (PDT)
Received: from bcarvalho-Ubuntu.lan ([2001:818:de85:7e00:6d3d:2d8b:5417:831c])
        by smtp.gmail.com with ESMTPSA id c6sm13004217wmr.0.2021.04.21.12.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 12:47:00 -0700 (PDT)
From:   Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     melissa.srw@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH 0/5] drm: Adjust end of block comment
Date:   Wed, 21 Apr 2021 20:46:53 +0100
Message-Id: <cover.1618756333.git.martinsdecarvalhobeatriz@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new line with */ on the last line of a block comment to follow 
the Linux kernel coding conventions. 
Problem found by checkpatch.
in tree dpu/drm

Beatriz Martins de Carvalho (5):
  drm: drm_atomic.c: Adjust end of block comment
  drm: drm_auth.c: Adjust end of block comment
  drm: drm_bufs.c: Adjust end of block comment
  drm: drm_connector.c: Adjust end of block comment
  drm: drm_context.c: Adjust end of block comment

 drivers/gpu/drm/drm_atomic.c    | 3 ++-
 drivers/gpu/drm/drm_auth.c      | 3 ++-
 drivers/gpu/drm/drm_bufs.c      | 3 ++-
 drivers/gpu/drm/drm_connector.c | 9 ++++++---
 drivers/gpu/drm/drm_context.c   | 3 ++-
 5 files changed, 14 insertions(+), 7 deletions(-)

-- 
2.25.1

