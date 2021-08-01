Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3344F3DCC8F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 18:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbhHAQDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 12:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbhHAQDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 12:03:08 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2F5C06175F
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 09:02:59 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id u9-20020a17090a1f09b029017554809f35so27996711pja.5
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 09:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=9WHfa05emgeYdvg5zaeTSJK9ZWbxQqTP0TmxQ8412Lk=;
        b=WBCJxWSj4Mccb35DFcRn0E0dbWa792cNXI8FF77t2qSdMsMAXe5QmSrOqv2vANeWhr
         /1uMuPe6GoK+V/6HYWjagRy72GmzC1vuLBSJyeawE5F+40o7kvzI3ySRBo+3+ONYyiDy
         +ABlPm0BI6kRuYofIDDt7g6i6UU0Dm9ijxwnLNXxwOTK8mEfhBlU9rUgltfNCcBUBbMZ
         5eREZLA3YY4Us9pb9ZpLcpeTidLOnXti7qDTUsMNm5z0GLwV63oBCBGWiBJuzTBMX5gQ
         Gk/VjbRsXoLhcruOfNNIVn47oiLO7vm3oWURD/zRP5J8yuAgOSCkSlTEu5E5Av4QGTWH
         yyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=9WHfa05emgeYdvg5zaeTSJK9ZWbxQqTP0TmxQ8412Lk=;
        b=fkD8mYt4Df9Prbw9Eum0Tf1S+ENWUT7xGGD7q96DvJf5fcJaXQeAyGRZO8lf9Ph3WU
         DDFMescRMsNc2kppMwqlsqoTMhfJCTAozYHLI7g66xgIyIOhPxE6TgARX49ARLTiCkaQ
         p4scNJkk6QtxzKT6NeiIED6RXAQsc/igpJ+Wr9YjpJ3N0/ES+bD8EW3DO4733U72rd9A
         7ZXs9SsadDNz3JBGFpZa0WjXcZd8p47bmVx8azF1hEAr/b6+n2Wy5NfX2r+7T44I/+Fb
         PK6qy6BxcYseXgEinzAdy5T5UNXmn9dm72e5iWrv5n0GXDUof8Q47ooLOfFI1tUr1gBn
         q6fw==
X-Gm-Message-State: AOAM531v2cS0g7SV3g5n9YI90T8k/enoqO0XoIIdzm3IfLYY88YJi9hn
        DwudbUJwoVhQO3GqcVVU94k=
X-Google-Smtp-Source: ABdhPJwl/Y8S13DMfmsEfy4Oq0KQ4o1v/Q8AdJysvZqXDXVDTO49IrkHsCcEKz6Ds6TBOmHA+QbSDA==
X-Received: by 2002:a17:902:8493:b029:12c:552f:1fb1 with SMTP id c19-20020a1709028493b029012c552f1fb1mr10997498plo.26.1627833778689;
        Sun, 01 Aug 2021 09:02:58 -0700 (PDT)
Received: from adolin ([49.207.203.94])
        by smtp.gmail.com with ESMTPSA id k8sm8618416pfu.116.2021.08.01.09.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 09:02:58 -0700 (PDT)
Date:   Sun, 1 Aug 2021 21:31:48 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     melissa.srw@gmail.com
Cc:     rodrigosiqueiramelo@gmail.com, hamohammed.sa@gmail.com,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 0/2] drm/vkms: Add virtual hardware module
Message-ID: <cover.1627831087.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for emulating virtual hardware with VKMS.
The virtual hardware mode can be enabled by using the following command
while loading the module:
        sudo modprobe vkms enable_virtual_hw=1

The first patch is prep work for adding virtual_hw mode and refactors
the plane composition in vkms by adding a helper function vkms_composer_common()
which can be used for both vblank mode and virtual mode.

The second patch adds virtual hardware support as a module option. It
adds new atomic helper functions for the virtual mode
and modifies the existing atomic helpers for usage by the vblank mode
This gives us two sets of drm_crtc_helper_funcs struct for both modes,
making the code flow cleaner and easier to debug.

This patchset has been tested with the igt tests- kms_writeback, kms_atomic,
kms_lease, kms_flip, kms_pipe_get_crc and preserves results except for
subtests related to crc reads and skips tests that rely on vertical
blanking.

Sumera Priyadarsini (2):
  drm/vkms: Refactor vkms_composer_worker() to prep for virtual_hw mode
  drm/vkms: Add support for virtual hardware mode

 drivers/gpu/drm/vkms/vkms_composer.c | 93 ++++++++++++++++++----------
 drivers/gpu/drm/vkms/vkms_crtc.c     | 51 ++++++++++-----
 drivers/gpu/drm/vkms/vkms_drv.c      | 16 +++--
 drivers/gpu/drm/vkms/vkms_drv.h      |  4 ++
 4 files changed, 112 insertions(+), 52 deletions(-)

-- 
2.31.1

