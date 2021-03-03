Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6775932BE2C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385184AbhCCRIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238550AbhCCMvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 07:51:55 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C566C06178C
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 04:49:56 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id c19so4090243pjq.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 04:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=UENSETCCSEDGxjTkQmqskiUgabV6KTJ5GVCGqRR2WeU=;
        b=FCtkSXDEcxgX1TqpqqdTnD8DMSoRVbK1hEuV3/IhT/lllSVvPuEtO4J4uGFDBefbOj
         ImvnczGzv+lY/tPJLrhxQqyNFK9mB8S3WK430mXnkWSTY+HNP7JVFga5xneXH4SoIGru
         Kmi5BFYtY69xEBr6B8BJKuGTMT6yC3GpB43G0lds2vOPR7/yhALobcKNHJmM2yFdRtfS
         5y07AutoWsGjS+sPh+dcj1S4kddIUpMNDre6Yc1WxKKbXKJbrOvitFaPQGawApqRNxY4
         bCU5QJszHbPbysh8ofYcOsDuCSMuQa4pBYJ5z+IJSpJTltnwvNfxfArSO+Qk9vmFGSzY
         gePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=UENSETCCSEDGxjTkQmqskiUgabV6KTJ5GVCGqRR2WeU=;
        b=DW3OujNubgW0h69sJXA66w0Cu9L/G9Uwp3ZyyWJAuxNCVH4Yl5csO5Cn9X5tzFwPJ7
         iF9acNqtUGV32CGHbHTY7Yhqjy8SGOrpYDFczH23CqOms39zNeCh2qLritLbHfj38gjO
         Roqs2xL+EaOXL1ENlHl8RenSu2ASxmln25WTh3pi2E3cnYngy5oDTzHurNrAhI1YC7qH
         Zp+Lbuhu2HgsgwJGM29hL226k71GvD7TcxuxsOq1Sf1UEIylR77OYqKFbmyA58cUgKa0
         klg3k4MFDIeFCPjkChALPRlmxYJRA9iWXvWViYF0niKAumAQeBUjfwHWBi2OiB83UTlt
         eOjQ==
X-Gm-Message-State: AOAM5315M1H/sq5h3XaSg3LraGfcQjHxzV3HlYUywVoxSHl6LviCxTrf
        2x4dIEqcUu9MgLRCGUM4Ltw=
X-Google-Smtp-Source: ABdhPJxKGgC9YUoFjWyKXMfkcrb48impfAYkzV47xMdbWioftwa0OsXTkQLd+BsvpwC2mHNsIm1Mzg==
X-Received: by 2002:a17:90a:5887:: with SMTP id j7mr9143604pji.178.1614775795754;
        Wed, 03 Mar 2021 04:49:55 -0800 (PST)
Received: from adolin ([49.207.223.176])
        by smtp.gmail.com with ESMTPSA id q192sm24878430pfc.85.2021.03.03.04.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 04:49:55 -0800 (PST)
Date:   Wed, 3 Mar 2021 18:19:50 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     melissa.srw@gmail.com
Cc:     rodrigosiqueiramelo@gmail.com, hamohammed.sa@gmail.com,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/2] Add virtual hardware module
Message-ID: <cover.1614775351.git.sylphrenadin@gmail.com>
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

The first patch adds virtual hardware support as a module option. The
second patch adds new atomic helper functions for the virtual mode
and modifies the existing atomic helpers for usage by the vblank mode
This gives us two sets of drm_crtc_helper_funcs struct for both modes,
making the code flow cleaner and easier to debug.

This patchset has been tested with the igt tests, kms_writeback, kms_atomic,
kms_lease, kms_flip, kms_pipe_get_crc and preserves results except for
subtests related to crc reads and skips tests that rely on vertical
blanking. This patchset must be tested after incorporating the
igt-tests patch: https://lists.freedesktop.org/archives/igt-dev/2021-February/029355.html .

Sumera Priyadarsini (2):
  drm/vkms: Add support for virtual hardware mode
  drm/vkms: Add crtc atomic helper functions for virtual mode

 drivers/gpu/drm/vkms/vkms_composer.c | 88 +++++++++++++++++-----------
 drivers/gpu/drm/vkms/vkms_crtc.c     | 45 ++++++++++----
 drivers/gpu/drm/vkms/vkms_drv.c      | 18 ++++--
 drivers/gpu/drm/vkms/vkms_drv.h      |  4 ++
 4 files changed, 106 insertions(+), 49 deletions(-)

-- 
2.25.1

