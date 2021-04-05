Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33DE1353C0B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 08:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhDEGMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 02:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhDEGME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 02:12:04 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C97C061756
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 23:11:57 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id w10so2011844pgh.5
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 23:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=NlN6KbhYqIPvr2/7x4/KY0Pw6vbwxZNfvJPFeHzAzZk=;
        b=LRMiUHwAA79sCFDI4KhMhVXxTJ+JsUd4r1tdGwcTZmrYoa/ZZjhdTZMKKszcwU5pYi
         jG/DDKzc2+ZWeT5odmKIlrJPGTsVvkTyczbjqFPz5tFYqRsUhxySiBvaCRwm2LuL6Gg1
         p+i4xZsMFjxOP5UmN0GoPdwocaQbMQDUJsHhpmcspEPmZaHdGB5C7y3ce8dExJYLyuMl
         4C9rYnQmuMaFW+eMXukIBsqusUVk0XddKm15aBcbTkHNmuWNozjioeqTyH3v1VaseE9i
         JeVSn1NK9KjeRL2AJfaq69rhvW6qoqCH8E6jE7aND7B4HAOaknKdfKKewtMIqgmrh7ai
         P5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=NlN6KbhYqIPvr2/7x4/KY0Pw6vbwxZNfvJPFeHzAzZk=;
        b=Q7mNJcvDT76ovK0TCWw9am0wzNTMMcvhSfSqRGOUOjn4qwtwIhT1S165QjeWQj1GuM
         l9wfZVjgdtaHh0zvlvI/Yt8v6O5xAEiji38xzyjHTtqXhY3dEXBaVFbrjb8oKX270Fxy
         eE6RcbXMDqlQ7S5QgIddAN5a4Xvs7t3kbZD9T5RM/81Z5jtDrZT4wRnofWoXWUjNUFJx
         deibm8KeWpOkiquWY5KyGUTDjsIVyytFlmsYWHeF/IBwQBgwcoU9I/LVHNFnSjmxfMEX
         eBU5sGrUvxGh1+dtyWNWQJbDsuls6AHN96p3akBHd+s6EnSXVsPGFG+inh6W1hnIAApd
         iFaA==
X-Gm-Message-State: AOAM530YJIeAnXGP6y4YCO70d1S3A2InI2buHtxPD2YKovIcC4wnmkg0
        kya3Rpl50czM6MXpo6IpEoQ=
X-Google-Smtp-Source: ABdhPJw+sJpRcyjs0gH3rVbmZq3N5Ue26fGHgAK+0KQBiO3N4I+Fmq0u4ocTY7jt7xelebmWlOElYA==
X-Received: by 2002:a65:4083:: with SMTP id t3mr21660869pgp.150.1617603117041;
        Sun, 04 Apr 2021 23:11:57 -0700 (PDT)
Received: from adolin ([49.207.194.193])
        by smtp.gmail.com with ESMTPSA id c128sm14425727pfc.76.2021.04.04.23.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 23:11:56 -0700 (PDT)
Date:   Mon, 5 Apr 2021 11:41:50 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     melissa.srw@gmail.com
Cc:     rodrigosiqueiramelo@gmail.com, hamohammed.sa@gmail.com,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 0/2] Add virtual hardware module
Message-ID: <cover.1617602076.git.sylphrenadin@gmail.com>
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
blanking. This patchset must be tested after incorporating the
igt-tests patch: https://lists.freedesktop.org/archives/igt-dev/2021-February/029355.html

Sumera Priyadarsini (2):
  drm/vkms: Refactor vkms_composer_worker() to prep for virtual_hw mode
  drm/vkms: Add support for virtual hardware mode

 drivers/gpu/drm/vkms/vkms_composer.c | 88 +++++++++++++++++-----------
 drivers/gpu/drm/vkms/vkms_crtc.c     | 51 +++++++++++-----
 drivers/gpu/drm/vkms/vkms_drv.c      | 18 ++++--
 drivers/gpu/drm/vkms/vkms_drv.h      |  4 ++
 4 files changed, 109 insertions(+), 52 deletions(-)

-- 
2.25.1

