Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9063EB707
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 16:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240900AbhHMOxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 10:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240021AbhHMOxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 10:53:36 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3687C0617AD;
        Fri, 13 Aug 2021 07:53:09 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id fa24-20020a17090af0d8b0290178bfa69d97so16425464pjb.0;
        Fri, 13 Aug 2021 07:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W750PVMZgiWGTiNJlB3UJ+AorGIAQwDaKf6ieffQwJg=;
        b=MUt/4SwxB3Y3F64qVzsUw2vp25wFxb9ArneoB+cnEB2Z40tXVJKSIkmqrauq7S7GlH
         QJ8QalTtGctl+re5BA/01stwUYjUYvs2rpmFKFUD8kqykahXXT9BNET3nObTLqtdoA+q
         f93qYsGrDs1R0NdLLFN3bNYtJjc2KdxdodV3n0rTnLIQj+J9WC4b9v81YmXg/YdiAPHd
         Ch39mPmNOzMTzvx4kvdaKZqqQcUtvl192WxjT8t8s7utHG6eyRi/WvL0B1MwoJW180Cx
         cS2KK4TpsOsm8rPoq7658vLlLys+wE/DIQYWuDSBaLLMuFV0Dfr21ubjpCR54zLE+Fze
         PvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W750PVMZgiWGTiNJlB3UJ+AorGIAQwDaKf6ieffQwJg=;
        b=syiO0SrtC8n6OfS/4tROFW+QvdIntc49BIv1mq/7exegC/qherMIwsZ82fNX7gBggt
         TIUbBujwU0QR4BlBgFnzsMaty/T1m69uf+wkrGi/9n8N0bnFPWDpzpTjaJIkJxo8bqoQ
         ONjXcirTFGjbtcmiBiA4x1mpp3R1VOu/v4v/UUIkWFhYoQsjGa2SdUouuAGcyV2I1735
         hAw0sbifWRDZBpzoE6XSCqzkeTlPivJD5jg6N9wlaDXjQpPLcJVmAgto5IP6PnRn67+X
         ITjhyarm8hH6R4V2EvJPEsw9om9uk5QWml0N1kF8CmjfQfYJWOc2y0ZB/BspXF3hMJyR
         Jblw==
X-Gm-Message-State: AOAM531goO1JEb/3jy8VJo9XHP+x1Nn+Xneyb7W29G+XNtKP/oNctZ3f
        r5dGLM0Aq/EOkuZUUoBWFnY=
X-Google-Smtp-Source: ABdhPJzfhdG1AfZsh6YAv1gIu7OgVFF0mG2fGSODYY0+jgUPzF2N6AJAYj0r+P8mUiX5i/pTd+bE0g==
X-Received: by 2002:a17:903:3109:b029:12d:3160:a815 with SMTP id w9-20020a1709033109b029012d3160a815mr2304245plc.45.1628866389300;
        Fri, 13 Aug 2021 07:53:09 -0700 (PDT)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e12sm2524787pfc.214.2021.08.13.07.53.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Aug 2021 07:53:08 -0700 (PDT)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, kevin3.tang@gmail.com,
        pony1.wu@gmail.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v6 0/6] Add Unisoc's drm kms module
Date:   Fri, 13 Aug 2021 22:52:56 +0800
Message-Id: <20210813145302.3933-1-kevin3.tang@gmail.com>
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

v6:
1. Disable and clear interrupts before register dpu IRQ
2. Init dpi config used by crtc_state->adjusted_mode on mode_set_nofb
3. Remove enable_irq and disable_irq function call.
4. Remove drm_format_info function call.
5. Redesign the way to access the dsi register.
6. Reduce the dsi_context member variables.

Kevin Tang (6):
  dt-bindings: display: add Unisoc's drm master bindings
  drm/sprd: add Unisoc's drm kms master
  dt-bindings: display: add Unisoc's dpu bindings
  drm/sprd: add Unisoc's drm display controller driver
  dt-bindings: display: add Unisoc's mipi dsi controller bindings
  drm/sprd: add Unisoc's drm mipi dsi&dphy driver

 .../display/sprd/sprd,display-subsystem.yaml  |   64 +
 .../display/sprd/sprd,sharkl3-dpu.yaml        |   77 +
 .../display/sprd/sprd,sharkl3-dsi-host.yaml   |   88 ++
 drivers/gpu/drm/Kconfig                       |    2 +
 drivers/gpu/drm/Makefile                      |    1 +
 drivers/gpu/drm/sprd/Kconfig                  |   13 +
 drivers/gpu/drm/sprd/Makefile                 |    6 +
 drivers/gpu/drm/sprd/megacores_pll.c          |  317 +++++
 drivers/gpu/drm/sprd/megacores_pll.h          |  146 ++
 drivers/gpu/drm/sprd/sprd_dpu.c               |  954 +++++++++++++
 drivers/gpu/drm/sprd/sprd_dpu.h               |  109 ++
 drivers/gpu/drm/sprd/sprd_drm.c               |  207 +++
 drivers/gpu/drm/sprd/sprd_drm.h               |   19 +
 drivers/gpu/drm/sprd/sprd_dsi.c               | 1260 +++++++++++++++++
 drivers/gpu/drm/sprd/sprd_dsi.h               |   94 ++
 15 files changed, 3357 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sprd/sprd,display-subsystem.yaml
 create mode 100644 Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml
 create mode 100644 Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
 create mode 100644 drivers/gpu/drm/sprd/Kconfig
 create mode 100644 drivers/gpu/drm/sprd/Makefile
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

