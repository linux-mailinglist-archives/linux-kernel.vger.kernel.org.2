Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA453FCE50
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 22:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241016AbhHaUWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 16:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240921AbhHaUWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 16:22:35 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D86C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 13:21:39 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id e186so515153iof.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 13:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yv9YRDAo21vPUpqq6KEd4YHQvcm8cpWSUp6HK2qPHDk=;
        b=nKEO2sA9RNXa/COb4Oof/EkP0lulNWqSv4xbF8nbsyHxRK6Q3kHq7P7GkBRtE3Kdt2
         bql4F0KUn7YGKXEDG7kdu+mYfTfaPoTxF92YNhNgpDNSXQk6eMnvrMYDtitXmnn2Qde9
         82NF1LfYU50VNXVUfS+x1Qmx6jpVNnxyyQXNOf8ax7UVDGPB9RrfHHl/rsqpFU4ZmjKb
         GchBWTcsoctOzjHoUA2EsDHNgfMCWLP4DjIN3W0tD5JMjLcXJ6w9Zh2O3HHaNzIUxyFH
         87qm6+KUk7of/7P7EfrRq3ZB5NSqy3bBd7B0ImsDIC9by7lfJw273DGdaJ9N2HxxUY8O
         MRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yv9YRDAo21vPUpqq6KEd4YHQvcm8cpWSUp6HK2qPHDk=;
        b=tgsmjtMcPvTjIkwI9xzbhoRDIYljr70npEOM1KYnq4qrP8s/zghKuK6KSZsNPZwHND
         XbiB10fWLQ0/5piAseSGDZvRqsTB7KOj9lrf0oM7vqI4Gayukv08PT0g0lJowEKtACt7
         1BErd87ZeckXyaIYt3iWFgGRo3swau6fQ1TKuDx4WXYo4dJdH7VreaTDktbLl6Neqy3J
         7YlQc6k2Ig4cokVevsXzfjQq2pFxm39+SnJv5kJm7na4o/axT3BwX9k8E7INgpqfLGMQ
         x+55ps8zbuEzxuIqxNBXBVkKy6VT3C04D3PbgPmpZa7qHxhGEXYikS63iXdBrpqJLWuv
         SbVQ==
X-Gm-Message-State: AOAM531AUZBWS0rbW8j1HdlLxlhyF0/WD//yLCYYZZYLP0z0e+t4U85t
        sa1o00K0WzEcD9BhATaRKOo=
X-Google-Smtp-Source: ABdhPJz8fln4kSXOzMYZNrXWgoMrkH1zDRuSuWNF9ErsAK2lP1IaxWTOZDe/ytRdBgYLObj5IF2rAg==
X-Received: by 2002:a05:6638:191c:: with SMTP id p28mr4445838jal.41.1630441299131;
        Tue, 31 Aug 2021 13:21:39 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id u15sm10597384ilk.53.2021.08.31.13.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 13:21:38 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v7 0/8] use DYNAMIC_DEBUG to implement DRM.debug
Date:   Tue, 31 Aug 2021 14:21:25 -0600
Message-Id: <20210831202133.2165222-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason, DRM folks,

In DRM-debug currently, drm_debug_enabled() is called a lot to decide
whether or not to write debug messages.  Each test is cheap, but costs
continue with uptime.  DYNAMIC_DEBUG "dyndbg", when built with
JUMP_LABEL, replaces each of those tests with a patchable NOOP, for
"zero cost when off" debugs.

this is v7:
- drops RFC distractions -JBaron
- drops patch-1: kp->data addition in moduleparams.h not needed -JBaron
- rework dyndbg callbacks to use kp->arg instead -JBaron
- fixes for problem configs reported -lkp 
- others noted per patch below ---

Broadly, this patchset does 3 things:

Adds DEFINE_DYNAMIC_DEBUG_CATEGORIES, which defines a mapping from
bits to "categorized" pr_debugs, a sysfs interface, and callbacks to
implement the bits as dynamic_debug >controls.  This is modelled after
DRM's debug interface.

Uses the new macro in amdgpu & i915 to control existing pr_debugs
according to their ad-hoc categorizations.

Adapts the drm-debug API (~20 macros) to configurably "replace"
drm_dbg & drm_dev_dbg with pr_debug & dev_dbg, which avoids
drm_debug_enabled() overheads.  DEFINE_DYNAMIC_DEBUG_CATEGORIES is
used to create the controlling bitmap, which is wired to __drm_debug
var so remaining drm_debug_enabled() users stay in sync.

on a virtual box:
bash-5.1# for m in i915 amdgpu nouveau; do modprobe $m; done
[43833.332326] dyndbg: 384 debug prints in module drm
[43833.609577] dyndbg: 211 debug prints in module drm_kms_helper
[43833.707124] dyndbg:   2 debug prints in module ttm
[43837.471166] dyndbg: 1727 debug prints in module i915
[43838.030774] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[43838.031905] AMD-Vi: AMD IOMMUv2 functionality not available on this system
[43846.209583] dyndbg: 3852 debug prints in module amdgpu
[43846.261391] [drm] amdgpu kernel modesetting enabled.
[43846.262512] amdgpu: CRAT table not found
[43846.263264] amdgpu: Virtual CRAT table created for CPU
[43846.264293] amdgpu: Topology: Add CPU node
[43846.743781] dyndbg:   3 debug prints in module wmi
[43852.517497] dyndbg:  92 debug prints in module nouveau

There are a few multi-second delays there, just before dyndbg
initializes the large blocks of debug prints.


Jim Cromie (8):
  dyndbg: add DEFINE_DYNAMIC_DEBUG_CATEGORIES and callbacks
  dyndbg: remove spaces in pr_debug "gvt: core:" etc prefixes
  i915/gvt: use DEFINE_DYNAMIC_DEBUG_CATEGORIES to create "gvt:core:"
    etc categories
  amdgpu: use DEFINE_DYNAMIC_DEBUG_CATEGORIES
  drm_print: add choice to use dynamic debug in drm-debug
  drm_print: instrument drm_debug_enabled
  amdgpu_ucode: reduce number of pr_debug calls
  nouveau: fold multiple DRM_DEBUG_DRIVERs together

 drivers/gpu/drm/Kconfig                       |  13 +
 drivers/gpu/drm/Makefile                      |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     | 293 ++++++++++--------
 .../gpu/drm/amd/display/dc/core/dc_debug.c    |  44 ++-
 drivers/gpu/drm/drm_print.c                   |  53 +++-
 drivers/gpu/drm/i915/Makefile                 |   4 +
 drivers/gpu/drm/i915/gvt/debug.h              |  18 +-
 drivers/gpu/drm/i915/i915_params.c            |  35 +++
 drivers/gpu/drm/nouveau/nouveau_drm.c         |  36 ++-
 include/drm/drm_print.h                       | 150 +++++++--
 include/linux/dynamic_debug.h                 |  60 ++++
 lib/dynamic_debug.c                           |  79 ++++-
 12 files changed, 582 insertions(+), 206 deletions(-)

-- 
2.31.1

