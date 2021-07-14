Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C693C8A23
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 19:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238906AbhGNRym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 13:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhGNRyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 13:54:39 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBC7C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 10:51:47 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id j5so2453825ilk.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 10:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6easdx0Ab/n6kI4HD5metQAor9SuXg8otRFVzJJxle0=;
        b=BzNMSon0mZrh8FKzu/6WP+Uh4v5AZXNVz1pRhPxi5w0rxnuLhX0hBULPjGr3zIak6l
         ATN3STubFI7O2zaPqJyww99Fxu+UNlMRer1XqB6Yz03cQIupVB3zL67os77YIp/SkxhA
         Ce3ztRb5cSG8VUtEguS4gq0hSjxlDqcoCiZm9Nua5EVuoN+KOJHdIIZC4upy5zMnQSM1
         5ofEhogN/WuBBagvKpT0M2iweWKeayjSzF/KaDKi6wC3j/TBAEfB99wL5iesoV3NiCqz
         sb4Awee5TH7sPPbZKX0/Uch9pu2qgoQ3DkYFXHktcqgQfmd7oHRUcJDYqJBSJCdI5PBg
         jrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6easdx0Ab/n6kI4HD5metQAor9SuXg8otRFVzJJxle0=;
        b=nypeARKB2MAGzPMB+rysMsSorFkhn+WlkZGGjyYhu8itM2OSy7dtEc0AQfcNGvilvm
         /atC9P8IJa8m69CTCHU/zHue1XPGRFl3bN0OHn0bCNPd+UY4NVTOVQwraBh5FI16REg6
         fByqBbsVsO9Xpl5CYllecE+gNhlh5Oa5mlOSm3bbWSxnmY1rFYPAU0+YfeHgbUDGMAGT
         2ijgLkiHkKb6T8/OTp4Q2LZcweh7YKBh28/qIHRk5BEMpVr+9pWa1TOwwsi5OL3vmmu8
         7EVVBT6vwAB5YqiC0//euASc6UmPDePT3eQls8FVmV1I3byLrciOGpdo6NVnb2A1gIYb
         ppWw==
X-Gm-Message-State: AOAM532qQes92ht/nJ4vz8JOQhYHBS2xXm2lpOoTqD7s3RW2Bia9iOPM
        1Yhg5uTAZgsPSMKPbGB731U=
X-Google-Smtp-Source: ABdhPJw/9JKeTpShohE+rQpOQYVy3HmTkj9zYna2y2zmzHKctVytOjzd8p4LIP+TePxldUKJQUXOrQ==
X-Received: by 2002:a92:1944:: with SMTP id e4mr7341674ilm.186.1626285107111;
        Wed, 14 Jul 2021 10:51:47 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id b16sm706518ioh.5.2021.07.14.10.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 10:51:46 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jbaron@akamai.com, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 0/5] drm: use dyndbg in drm_print
Date:   Wed, 14 Jul 2021 11:51:33 -0600
Message-Id: <20210714175138.319514-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi dri-devel,

Im pretty new in this particular playground.
Im using this to send, is it too spammy ? too --to ?
   git send-email --dry-run \
   --to-cmd='scripts/get_maintainer.pl --no-rolestats v3-000*.patch' \
   --to=jbaron@akamai.com v3-000*.patch

drm_debug_enabled() is called a lot (by drm_dev_dbg) to do unlikely
bit-tests to selectively enable debug printing; this is a good job for
dynamic-debug, IFF it is built with JUMP_LABEL.
 
This patchset enables the use of dynamic-debug to avoid those
drm_debug_enabled() overheads, if CONFIG_DRM_USE_DYNAMIC_DEBUG=y.

v3: fixes missed SOB, && on BOL, commit-log tweaks
    reordered patches, 1 is comment, 2 is whitespace.
    dropped RFC, to see what happens.
v2: https://lore.kernel.org/lkml/20210711055003.528167-1-jim.cromie@gmail.com/
v1: https://lore.kernel.org/lkml/20201204035318.332419-1-jim.cromie@gmail.com/

Doing so creates many new pr_debug callsites,
otherwise i915 has ~120 prdbgs, and drm has just 1;

  bash-5.1# modprobe i915
  dyndbg:   8 debug prints in module video
  dyndbg: 305 debug prints in module drm
  dyndbg: 207 debug prints in module drm_kms_helper
  dyndbg:   2 debug prints in module ttm
  dyndbg: 1720 debug prints in module i915

On amdgpu, enabling it adds ~3200 prdbgs, currently at 56 bytes each.
So CONFIG_DRM_USE_DYNAMIC_DEBUG=y affects resource requirements.

Im running this patchset bare-metal on an i915 laptop & an amdgpu
desktop (both as loadable modules).  I booted the amdgpu box with:

BOOT_IMAGE=(hd2,gpt2)/vmlinuz-5.13.0-dd7-13692-g8def25788f56 \
     root=UUID=mumble ro \
     rootflags=subvol=root00 rhgb \
     dynamic_debug.verbose=3 main.dyndbg=+p \
     amdgpu.debug=1 amdgpu.test=1 \
     "amdgpu.dyndbg=format ^[ +p"

That last line enables ~1700 prdbg callsites with a format like '[DML'
etc at boot, and amdgpu.test=1 triggers 3 minutes of tests, causing
~76k prdbgs in 409 seconds, before I turned them off with:

  echo module amdgpu -p > /proc/dynamic_debug/control

This is on top of master @ v5.14-rc1
Should I rebase onto something else ?

Jim Cromie (5):
  drm/print: fixup spelling in a comment
  drm_print.h: rewrap __DRM_DEFINE_DBG_RATELIMITED macro
  drm/print: RFC add choice to use dynamic debug in drm-debug
  drm/print: move conditional deref into macro defn
  i915: map gvt pr_debug categories to bits in parameters/debug_gvt

Note: 3/5, 5/5 have bits that are here for POC, but belong in
dynamic_debug.c.


 drivers/gpu/drm/Kconfig            |  13 ++++
 drivers/gpu/drm/drm_print.c        |  75 +++++++++++++++++-
 drivers/gpu/drm/i915/gvt/Makefile  |   4 +
 drivers/gpu/drm/i915/i915_params.c |  76 +++++++++++++++++++
 include/drm/drm_print.h            | 117 ++++++++++++++++++++---------
 5 files changed, 247 insertions(+), 38 deletions(-)

-- 
2.31.1

