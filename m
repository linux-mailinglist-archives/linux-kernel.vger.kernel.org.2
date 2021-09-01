Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1413FE03B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 18:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344079AbhIAQnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 12:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245469AbhIAQnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 12:43:11 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A1FC061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 09:42:14 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id r2so3320393pgl.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 09:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=1rGeijHq8WZgg+lrwUTnmHa7aiFWRXgtn3qY3995sgA=;
        b=ceTE2ch8NNIa92TZhOHa1RRLewscF9g9GuxKxhL/HkPP7v7lfazyZalGElcYWHyX9L
         zAMevYtcQFRsaaiTb8orLn2cb5q5FY233/uKgTK9xzzgCZHY+IT42xhC6VfDiXCGq45M
         TwZ039c9Xox2GO6CQxzGJbJP+xwC9ODaIxW+Pp1KfaQO2A/IYM1P2SpMtaCrCLzddmKD
         5gW+s3ZFtM+k5MED5VHduMvDDol05Hp/rp/IbjbCaATy5I4tXMjiXLAn8TUWSTX4D2VI
         md3b4zLELgvS5pMOG9aTMG8gkQ9VRiDelRnhHlDBS1J6o9UPE17rz27mVB/qsW4dOCRi
         eq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=1rGeijHq8WZgg+lrwUTnmHa7aiFWRXgtn3qY3995sgA=;
        b=YTin3JQX6OBPrBAL5HDKYtAo6WbzYsrLlC/bk0L6JbeX8WUDX0f/b1cYjUL438hyhV
         bYL6ymdsFcHg5uTSuM3eKBwgf7SYKfiJzW768kETixPuauWkhGhErLr/I1rJrTFKOCCY
         UL4HBflknnjrYJB3sO1TPun28KanNur8QY7hrFtM7knoSEZtcD9M0Zlt728typgegvWc
         3bZ/Nl5WuJQdKQ7kLxKPxJHlfR5Qc/FnRRQWpayNM1AJHJnVG7ecPL9TkDWpNLNVOREB
         gRsuDhaNnZUQMIV467zQqyLp8HU+M7277jkohK9oy7HDyGY6LTqWQkv32XcNPG2B/O0F
         JxCg==
X-Gm-Message-State: AOAM531npWXdX7cVe6KYffwoGbpfJrudv2Z2YB1U9KXdGeLANGXt2BI+
        u81hWw9B3TecBHWVRGkaLtoo/Q2eX48=
X-Google-Smtp-Source: ABdhPJxywaujLQLOBCM9G/jjnxtpahJPwLQrm88Lz/Rb+Tb6db2w7Gq7LNrwMSgxW5S+aVGIhtBNbw==
X-Received: by 2002:aa7:800b:0:b029:330:455f:57a8 with SMTP id j11-20020aa7800b0000b0290330455f57a8mr363476pfi.7.1630514534105;
        Wed, 01 Sep 2021 09:42:14 -0700 (PDT)
Received: from adolin ([49.207.225.208])
        by smtp.gmail.com with ESMTPSA id cm17sm79295pjb.35.2021.09.01.09.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 09:42:13 -0700 (PDT)
Date:   Wed, 1 Sep 2021 22:10:49 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     melissa.srw@gmail.com
Cc:     rodrigosiqueiramelo@gmail.com, hamohammed.sa@gmail.com,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V6 0/2] drm/vkms: Add virtual hardware module
Message-ID: <cover.1630512292.git.sylphrenadin@gmail.com>
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
the plane composition in vkms by adding a helper function
vkms_composer_common() which can be used for both vblank mode
and virtual mode.

The second patch adds virtual hardware support as a module option.
It adds new atomic helper functions for the virtual mode
and uses the existing atomic helpers for vblank mode
This gives us two sets of drm_crtc_funcs and drm_crtc_helper_funcs
structs for both modes, making the code flow cleaner and
easier to debug.

This patchset has been tested with the igt tests- kms_writeback, kms_atomic,
kms_lease, kms_flip, kms_pipe_get_crc and preserves results except for
subtests related to crc reads and vertical blanking, in which case,
tests are skipped.

Sumera Priyadarsini (2):
  drm/vkms: Refactor vkms_composer_worker() to prep for virtual_hw mode
  drm/vkms: Add support for virtual hardware mode

 drivers/gpu/drm/vkms/vkms_composer.c  | 92 +++++++++++++++++----------
 drivers/gpu/drm/vkms/vkms_crtc.c      | 43 ++++++++++++-
 drivers/gpu/drm/vkms/vkms_drv.c       | 16 +++--
 drivers/gpu/drm/vkms/vkms_drv.h       |  4 ++
 drivers/gpu/drm/vkms/vkms_writeback.c |  3 +-
 5 files changed, 117 insertions(+), 41 deletions(-)

-- 
2.31.1

