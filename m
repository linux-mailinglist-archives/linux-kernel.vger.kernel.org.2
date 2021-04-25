Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8305936A739
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 14:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhDYMgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 08:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhDYMgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 08:36:55 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86962C061574;
        Sun, 25 Apr 2021 05:36:15 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 10so1734122pfl.1;
        Sun, 25 Apr 2021 05:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ofDoDGVcFXfNp3joLh7XMNbC13RApFLIA9JxH55i0Y0=;
        b=ho978dngaeW2FEIQa3scJ/CICMwzUU7IeHuEVG2orXxctosukMtyljcMld+Z3DZcFE
         tV0qCq33sTHRULszHBw+NRHP0z7qpMjxo05YFjBUyIbwncHOevvqMkxcNpSt6uFj414W
         cnqDJBBcHsVzZwyZQneG5gE4EvF2KYlI8VBRh3jXF5YeKUrZfGS0h3tAwRnodapd58Qm
         jneZryU38220SExWjZJ3CUmzCXDSkgy4lrGga4hyBSBoZryUHBRRcT9ez5gyLaFp9+2+
         P9L09nUlajOBqTrCEYKcXfzyzOVa7Q3sWxU3NEX+HcP+H+FBcWW9gLG3q6GBVv/vdFAO
         kaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ofDoDGVcFXfNp3joLh7XMNbC13RApFLIA9JxH55i0Y0=;
        b=WBqS1MfaUIfeKGKxIiE6H/p8+MeVvhMQPpaqVARplUDszV6VsZpwvUKWvPZJfQxVSY
         lYBRBMIo3oLBGNGSBvcV7bqzXVDiXUT/S+G2aUDMc7Oz12lr/bJ47+ptkLexkhBwviAa
         KbEQlmGboQ5IQfEjFw6nBf40e6L+J95LWp2Lw55ME/ZeONiFCBlaTAA0xZCdoXbg2FyJ
         xyeXeUQTU592+mD3nj9/vfsSO2BFtYfAP/kDtlj245jGZlDWPEx3IGiNkamy+HIVUHw1
         9U7FELfhiFNzdj4iF6yplgXF4g+DdBNEFXIi47sHGDedkB43wHKrga6x8ftXgMfYs+Rf
         jwgw==
X-Gm-Message-State: AOAM531/Ij2gSQetwfCF9XeJTr/AzSrCMYJSVPxcX75pidNPN2gvzgEQ
        3DIYdAZWjfr+5gbvYXH9cIM=
X-Google-Smtp-Source: ABdhPJzvTzGt/6iZKu7kQTjLwEIo0mfPJxHDGXbyKX019+An346qKSwFlkMUhfSQ4/w35JtQPY9FQQ==
X-Received: by 2002:aa7:85d7:0:b029:25d:2b00:2c6c with SMTP id z23-20020aa785d70000b029025d2b002c6cmr12837783pfn.3.1619354174935;
        Sun, 25 Apr 2021 05:36:14 -0700 (PDT)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id f135sm8767808pfa.102.2021.04.25.05.36.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Apr 2021 05:36:14 -0700 (PDT)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 0/6] Add Unisoc's drm kms module
Date:   Sun, 25 Apr 2021 20:36:01 +0800
Message-Id: <20210425123607.26537-1-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeList:
RFC v1:
1. only upstream modeset and atomic at first commit.
2. remove some unused code;
3. use alpha and blend_mode properties;
3. add yaml support;
4. remove auto-adaptive panel driver;
5. bugfix

RFC v2:
1. add sprd crtc and plane module for KMS, preparing for multi crtc&encoder
2. remove gem drivers, use generic CMA handlers
3. remove redundant "module_init", all the sub modules loading by KMS

RFC v3:
1. multi crtc&encoder design have problem, so rollback to v1

RFC v4:
1. update to gcc-linaro-7.5.0
2. update to Linux 5.6-rc3
3. remove pm_runtime support
4. add COMPILE_TEST, remove unused kconfig
5. "drm_dev_put" on drm_unbind
6. fix some naming convention issue
7. remove semaphore lock for crtc flip
8. remove static variables

RFC v5:
1. optimize encoder and connector code implementation
2. use "platform_get_irq" and "platform_get_resource"
3. drop useless function return type, drop unless debug log
4. custom properties should be separate, so drop it
5. use DRM_XXX replase pr_xxx
6. drop dsi&dphy hal callback ops
7. drop unless callback ops checking
8. add comments for sprd dpu structure

RFC v6:
1. Access registers via readl/writel
2. Checking for unsupported KMS properties (format, rotation, blend_mode, etc) on plane_check ops
3. Remove always true checks for dpu core ops

RFC v7:
1. Fix DTC unit name warnings
2. Fix the problem of maintainers
3. Call drmm_mode_config_init to mode config init
4. Embed drm_device in sprd_drm and use devm_drm_dev_alloc
5. Replace DRM_XXX with drm_xxx on KMS module, but not suitable for other subsystems
6. Remove plane_update stuff, dpu handles all the HW update in crtc->atomic_flush
7. Dsi&Dphy Code structure adjustment, all move to "sprd/"

v0:
1. Remove dpu_core_ops stuff layer for sprd drtc driver, but dpu_layer need to keeping.
   Because all the HW update in crtc->atomic_flush, we need temporary storage all layers for
   the dpu pageflip of atomic_flush.
2. Add ports subnode with port@X.

v1:
1. Remove dphy and dsi graph binding, merge the dphy driver into the dsi.
2. Add commit messages for Unisoc's virtual nodes.

v2:
1. Use drm_xxx to replace all DRM_XXX.
2. Use kzalloc to replace devm_kzalloc for sprd_dsi/sprd_dpu structure init.
3. Remove dpu_core_ops midlayer.

v3:
1. Remove dpu_layer midlayer and commit layers by aotmic_update

v4:
1. Move the devm_drm_dev_alloc to master_ops->bind function.
2. The managed drmm_mode_config_init() it is no longer necessary for drivers to explicitly call drm_mode_config_cleanup, so delete it.
3. Use drmm_helpers to allocate crtc ,planes and encoder.
4. Move allocate crtc ,planes, encoder to bind funtion.
5. Move rotation enum definitions to crtc layer reg bitfields.

v5:
1. Remove subdir-ccflgas-y for Makefile.
2. Keep the selects sorted by alphabet for Kconfig.
3. Fix the checkpatch warnings.
4. Use mode_set_nofb instead of mode_valid callback.
5. Follow the OF-Graph bindings, use of_graph_get_port_by_id instead of of_parse_phandle.
6. Use zpos to represent the layer position.
7. Rebase to last drm misc branch.
8. Remove panel_in port for dsi node.
9. Drop the dsi ip file prefix.
10. Add Signed-off-by for dsi&dphy patch.
11. Use the mode_flags of mipi_dsi_device to setup crtc DPI and EDPI mode.

Kevin Tang (6):
  dt-bindings: display: add Unisoc's drm master bindings
  drm/sprd: add Unisoc's drm kms master
  dt-bindings: display: add Unisoc's dpu bindings
  drm/sprd: add Unisoc's drm display controller driver
  dt-bindings: display: add Unisoc's mipi dsi controller bindings
  drm/sprd: add Unisoc's drm mipi dsi&dphy driver

 .../display/sprd/sprd,display-subsystem.yaml  |   64 +
 .../display/sprd/sprd,sharkl3-dpu.yaml        |   77 +
 .../display/sprd/sprd,sharkl3-dsi-host.yaml   |   88 +
 drivers/gpu/drm/Kconfig                       |    2 +
 drivers/gpu/drm/Makefile                      |    1 +
 drivers/gpu/drm/sprd/Kconfig                  |   13 +
 drivers/gpu/drm/sprd/Makefile                 |    8 +
 drivers/gpu/drm/sprd/dsi_ctrl.c               |  794 +++++++++
 drivers/gpu/drm/sprd/dsi_ctrl.h               | 1475 +++++++++++++++++
 drivers/gpu/drm/sprd/dsi_ctrl_ppi.c           |  157 ++
 drivers/gpu/drm/sprd/dsi_ctrl_ppi.h           |   26 +
 drivers/gpu/drm/sprd/megacores_pll.c          |  317 ++++
 drivers/gpu/drm/sprd/megacores_pll.h          |  146 ++
 drivers/gpu/drm/sprd/sprd_dpu.c               |  956 +++++++++++
 drivers/gpu/drm/sprd/sprd_dpu.h               |  109 ++
 drivers/gpu/drm/sprd/sprd_drm.c               |  207 +++
 drivers/gpu/drm/sprd/sprd_drm.h               |   19 +
 drivers/gpu/drm/sprd/sprd_dsi.c               | 1124 +++++++++++++
 drivers/gpu/drm/sprd/sprd_dsi.h               |  107 ++
 19 files changed, 5690 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sprd/sprd,display-subsystem.yaml
 create mode 100644 Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml
 create mode 100644 Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
 create mode 100644 drivers/gpu/drm/sprd/Kconfig
 create mode 100644 drivers/gpu/drm/sprd/Makefile
 create mode 100644 drivers/gpu/drm/sprd/dsi_ctrl.c
 create mode 100644 drivers/gpu/drm/sprd/dsi_ctrl.h
 create mode 100644 drivers/gpu/drm/sprd/dsi_ctrl_ppi.c
 create mode 100644 drivers/gpu/drm/sprd/dsi_ctrl_ppi.h
 create mode 100644 drivers/gpu/drm/sprd/megacores_pll.c
 create mode 100644 drivers/gpu/drm/sprd/megacores_pll.h
 create mode 100644 drivers/gpu/drm/sprd/sprd_dpu.c
 create mode 100644 drivers/gpu/drm/sprd/sprd_dpu.h
 create mode 100644 drivers/gpu/drm/sprd/sprd_drm.c
 create mode 100644 drivers/gpu/drm/sprd/sprd_drm.h
 create mode 100644 drivers/gpu/drm/sprd/sprd_dsi.c
 create mode 100644 drivers/gpu/drm/sprd/sprd_dsi.h

-- 
2.29.0

