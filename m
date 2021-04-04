Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0E335382D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 15:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhDDNKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 09:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbhDDNKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 09:10:17 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247FDC061756
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 06:10:13 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso4603724pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 06:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=/of33qOjnEhY45uD1x/HAVtGTCodSVzYWgcg1uH37ss=;
        b=GGjHQuQk821BGc1xUvWgR8KKM5g2fcrC/69hMeb1RKziiCL4ZqJRmR4Ejp9HkTNgZQ
         gOylSgwjogyoTqDp/AikdqkE2Mdy9PENS9XNYzjMBZZ9MqISpkyH65IJGhK5UFn7Sdwz
         iRzC3syWjwCPACuni5MBx4XkozafIm1rHqyUGr2dQ0aHu7I8EMAkxI+P6dpuP86I1Djw
         6rX6JXOhGP4xrpoHLbfjMSfHa9sawrvXIMOsm2zmCUxv/wohrhYTvJQGGdfW39mf8B0V
         JumKVd5NGIJQ0In0TgE53C/z/s/ccYRRzSXHH7JoHtfQfGaxyn8k2gLNgOFjQ6CVpm/g
         PeTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=/of33qOjnEhY45uD1x/HAVtGTCodSVzYWgcg1uH37ss=;
        b=nNN6R9CjjslQZOqv5MnJjZ7ew++CWbbB2T6jlg3hCLymQj66Xerm81W6GDzCWlJKAP
         8zslz988xKVo73BqrEW4qzxNPoW+HwlRhmUddNNB4kgvX12SsFxML0a3d56ZON5jTGuQ
         yri5jZJhNivFQfByGtLcItd1lN7NwjMWQ2flGsvWK7fGgJo6jFGz8Ayk2rDCVGInBwu2
         Y/K9nqMnWgJ3XodjtYVnyYkRX3/5dUqUYwYT5bOJgmzDMmtp5zTv4CtPR1YjauZmKPXf
         2InLCE6VxhGyU91OJDF3wUeIOisbkKEujHAWWlv8rOMsChvqAnhF+O3yBI0pK2UX3kSL
         QUoQ==
X-Gm-Message-State: AOAM531Su0y5U/tO1RSc70gX6ysJwelXN4xLt+OWe4mqKgx1x+4jH6YR
        jd1XKI3pFSYl5pGVFGZC/IQ=
X-Google-Smtp-Source: ABdhPJxdUlBgl/WGy0d+ibbRpFm4MOUmQ8jTnB5/7hGYLMKMlRY+EI4M9/dsO2Jrkg2gM5pg25I9FA==
X-Received: by 2002:a17:902:7585:b029:e6:cc10:61fe with SMTP id j5-20020a1709027585b02900e6cc1061femr20072418pll.23.1617541812110;
        Sun, 04 Apr 2021 06:10:12 -0700 (PDT)
Received: from adolin ([49.207.202.237])
        by smtp.gmail.com with ESMTPSA id i7sm12581945pgq.16.2021.04.04.06.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 06:10:11 -0700 (PDT)
Date:   Sun, 4 Apr 2021 18:40:06 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     melissa.srw@gmail.com
Cc:     rodrigosiqueiramelo@gmail.com, hamohammed.sa@gmail.com,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 0/2] Add virtual hardware module
Message-ID: <cover.1617539357.git.sylphrenadin@gmail.com>
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

The second patch adds virtual hardware support as a module option. The
second patch adds new atomic helper functions for the virtual mode
and modifies the existing atomic helpers for usage by the vblank mode
This gives us two sets of drm_crtc_helper_funcs struct for both modes,
making the code flow cleaner and easier to debug.

This patchset has been tested with the igt tests, kms_writeback, kms_atomic,
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

