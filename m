Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0978F43C189
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 06:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbhJ0Ejm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 00:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbhJ0Ejl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 00:39:41 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F157FC061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 21:37:16 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id g8so790502iob.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 21:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mf6lETji8wRbFfL3yOTy5bMwinsDXPmqL9mcZuNkVB0=;
        b=BAw66o90BBGtTaY9aOpx0FDTJCot/dtAjS8AB4Vc1ATEb4iIO9NEdygjth5D1xUI92
         6CiqOEQVLpuMEkJWkyJCkhoyZQuWTx8rqMe1eBdgoqPvlE7dSPDBMZYkWfD1sA545jZ5
         KxGT9g2gRPD9Z+SL4NfQBptYf9nE5lB5maa8/KvRWqF7kCuFHsWpk/OChccaxlbnIceO
         8vcSleh0ymPOARma7mfqhFE1zJuxWyxWkOWuIBOpMYrF4jJAygtPspTmb85LEznVlQzj
         pVAi12MLEdiq5jH+Y3OV+Xn9+Nh5busSXLIqu6FWA+p7Fo2XZW0ZJ7ogLINS2mZy6l8r
         tMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mf6lETji8wRbFfL3yOTy5bMwinsDXPmqL9mcZuNkVB0=;
        b=d51MniUCLqPSs6O/2fgrlx9/n4Yh9XiyYLn5zURdoNyqkqP6VfJX8oddYoobMmX9tL
         XheEiF5sa2GJlnsay3pcLhTXmY5M3hnUDfbdRVEyzBjhvgzIeMnRNVlW7+nzeAcZdshq
         XNd2VfqZbojxg1uakXeuvHFwt67kOwQLIC8zJatF1lI/HLs7+G/sufT2hEqOZUVgRGwF
         EOb1JQzEqo2PPptqdPN1rvYLaA9vwo2AAG7MOxrGv8m5JnI/klMz+tuIHaJ99Kd+DU5r
         hWX1RsW8I4R6WSchbL3Tm5UwSmwdKbXuv4Ls7VPRRAIzUFNYHlyq9kDfdypOzXNefMiR
         qh+w==
X-Gm-Message-State: AOAM5309B3kRdG8AMXY70206MtTBxwpsCAPpJBHvrN8y0LszPRXP4zAq
        0QDEVh+9dsTUsM2+MxfOags=
X-Google-Smtp-Source: ABdhPJwpsfgxu5gQsE7OVueH37qwBxt0RRxcxdgdCZco5RbEcYJ4iPjbrkvKCX5QN5o5gWvh0uGI/A==
X-Received: by 2002:a05:6638:25ce:: with SMTP id u14mr509799jat.28.1635309436239;
        Tue, 26 Oct 2021 21:37:16 -0700 (PDT)
Received: from samwise.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id a15sm2030404ilj.81.2021.10.26.21.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 21:37:15 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v9 00/10] use DYNAMIC_DEBUG to implement DRM.debug & DRM.trace
Date:   Tue, 26 Oct 2021 22:36:35 -0600
Message-Id: <20211027043645.153133-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset has 3 separate but related parts:

1. DEFINE_DYNAMIC_DEBUG_CATEGORIES [patch 1/10]

   Declares DRM.debug style bitmap, bits control pr_debugs by matching formats
   Adds callback to translate bits to $cmd > dynamic_debug/control
   This could obsolete EXPORT(dynamic_debug_exec_queries) not included.

   anticipated_usage:
   DEFINE_DYNAMIC_DEBUG_CATEGORIES(debug, __drm_debug,
				" bits control drm.debug categories ",
				[0] = { DRM_DBG_CAT_CORE },
				[1] = { DRM_DBG_CAT_DRIVER },
				[2] = { DRM_DBG_CAT_KMS },
				[3] = { DRM_DBG_CAT_PRIME }, ...);

2. use (1) to reimplement drm.debug [patches 3-7]::

   1st in amdgpu & i915 to control existing pr_debugs by their formats
   then in drm-print, for all drm.debug API users
   avoids drm_debug_enabled(), gives NOOP savings & new flexibility.
   changes drm.debug categories from enum to format-prefix-string
   alters log format to include the format-prefix-string
   Daniel Vetter liked this at -v3
   https://lore.kernel.org/lkml/YPbPvm%2FxcBlTK1wq@phenom.ffwll.local/
   Im sure Ive missed stuff.
   
3. separately, Sean Paul proposed drm.trace to mirror drm.debug to tracefs
   https://patchwork.freedesktop.org/series/78133/ ::

   He argues::
     tracefs is fast/lightweight compared to syslog
     independent selection means tailored traffic for both

ISTM he's correct. So it follows that its also good for dyndbg, where
its then available for all pr_debug users (if CONFIG_TRACING).

So basically, I borg'd his::
   [patch 14/14] drm/print: Add tracefs support to the drm logging helpers
   
Then I added a T flag, so anyone can enable it::

   # turn on all drm's pr_debug --> tracefs
   echo module drm +T > /proc/dynamic_debug/control

It appears to just work: (RFC)

The instance name is purposely crappy, to force a revisit later, maybe
"pr_debugs" (plural).  Per-module subdirs kinda fits the tracefs
pattern, but ./dyndbg-tracefs/$module/$file/$function/$line seems a
little like overkill.  RFC.

[root@gandalf dyndbg-tracefs]# pwd
/sys/kernel/tracing/instances/dyndbg-tracefs
[root@gandalf dyndbg-tracefs]# echo 1 > /sys/module/drm/parameters/trace
[root@gandalf dyndbg-tracefs]# head -n16 trace | sed -e 's/^#//'
 tracer: nop

 entries-in-buffer/entries-written: 405/405   #P:24

                                _-----=> irqs-off
                               / _----=> need-resched
                              | / _---=> hardirq/softirq
                              || / _--=> preempt-depth
                              ||| / _-=> migrate-disable
                              |||| /     delay
           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
              | |         |   |||||     |         |
           <...>-2254    [000] .....  7040.894352: __dynamic_pr_debug: drm:core: comm="gnome-shel:cs0" pid=2254, dev=0xe200, auth=1, AMDGPU_CS
           <...>-2207    [015] .....  7040.894654: __dynamic_pr_debug: drm:core: comm="gnome-shell" pid=2207, dev=0xe200, auth=1, DRM_IOCTL_MODE_ADDFB2
           <...>-2207    [015] .....  7040.995403: __dynamic_pr_debug: drm:core: comm="gnome-shell" pid=2207, dev=0xe200, auth=1, DRM_IOCTL_MODE_RMFB
           <...>-2207    [015] .....  7040.995413: __dynamic_pr_debug: drm:core: OBJ ID: 121 (2)

This is the pr-debug doing most of that logging: (from dynamic_debug/control)

  drivers/gpu/drm/drm_ioctl.c:866 [drm]drm_ioctl =T "drm:core: comm=\042%s\042 pid=%d, dev=0x%lx, auth=%d, %s\012"

Turning on decoration flags changes the trace:

  echo module drm format drm:core: +mflt > /proc/dynamic_debug/control 

           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
              | |         |   |||||     |         |
           <...>-2254    [003] ..... 15980.936660: __dynamic_pr_debug: [2254] drm:drm_ioctl:866: drm:core: comm="gnome-shel:cs0" pid=2254, dev=0xe200, auth=1, AMDGPU_CS
           <...>-2207    [015] ..... 15980.936966: __dynamic_pr_debug: [2207] drm:drm_ioctl:866: drm:core: comm="gnome-shell" pid=2207, dev=0xe200, auth=1, DRM_IOCTL_MODE_ADDFB2
           <...>-2207    [015] ..... 15981.037727: __dynamic_pr_debug: [2207] drm:drm_ioctl:866: drm:core: comm="gnome-shell" pid=2207, dev=0xe200, auth=1, DRM_IOCTL_MODE_RMFB
           <...>-2207    [015] ..... 15981.037739: __dynamic_pr_debug: [2207] drm:drm_mode_object_put:195: drm:core: OBJ ID: 124 (2)
           <...>-2207    [015] ..... 15981.037742: __dynamic_pr_debug: [2207] drm:drm_mode_object_put:195: drm:core: OBJ ID: 124 (1)

The FUNCTION could stand tweaking (to match the callsite in the
control file, cited above), or perhaps replaced by the 'mfl'
decorations; the 't' flag is redundant for trace. Meh.

SELFTEST

A previous version of this patchset added test_dynamic_debug.ko, but
it relied upon code I ripped out when I made tracefs available by
default (without modules registering 1st).  So it fails 10/29 tests,
which counted +T sites executed, via side effect.

TODO: userspace selftest

  # to set expected tracing activity
  echo module test_dynamic_debug function do_debugging +T > control

  # run do_debugging function (todo: add sysfs knob) 
  echo 2 > /sys/module/test-dynamic-debug/parameters/do_debugging

If thats wrapped in the right trace_on, trace_pipe, etc incantations,
the +T enabled pr_debugs in do_debugging() can be counted, compared
against expectations, and passed or failed.

v8 is here:
https://patchwork.freedesktop.org/series/93914/
https://lore.kernel.org/lkml/20210915163957.2949166-1-jim.cromie@gmail.com/

The major change since v8 is that +T now works for all users, if
CONFIG_TRACING=y, otherwise it complains/errors.


Jim Cromie (10):
  dyndbg: add DEFINE_DYNAMIC_DEBUG_CATEGORIES macro and callbacks
  drm: fix doc grammar
  amdgpu: use dyndbg.CATEGORIES to control existing pr_dbgs
  i915/gvt: trim spaces from pr_debug "gvt: core:" prefixes
  i915/gvt: use dyndbg.CATEGORIES for existing pr_debugs
  drm_print: add choice to use dynamic debug in drm-debug
  drm_print: instrument drm_debug_enabled
  dyndbg: add print-to-tracefs, selftest with it - RFC
  dyndbg: create DEFINE_DYNAMIC_DEBUG_TRACE_CATEGORIES
  drm: use DEFINE_DYNAMIC_DEBUG_TRACE_CATEGORIES bitmap to tracefs

 .../admin-guide/dynamic-debug-howto.rst       |   7 +-
 MAINTAINERS                                   |   1 +
 drivers/gpu/drm/Kconfig                       |  26 ++
 drivers/gpu/drm/Makefile                      |   3 +
 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +
 .../gpu/drm/amd/display/dc/core/dc_debug.c    |  44 +++-
 drivers/gpu/drm/drm_print.c                   |  72 ++++--
 drivers/gpu/drm/i915/Makefile                 |   2 +
 drivers/gpu/drm/i915/gvt/debug.h              |  18 +-
 drivers/gpu/drm/i915/intel_gvt.c              |  34 +++
 include/drm/drm_drv.h                         |   2 +-
 include/drm/drm_print.h                       | 184 ++++++++++++---
 include/linux/dynamic_debug.h                 |  72 +++++-
 lib/Kconfig.debug                             |  11 +
 lib/Makefile                                  |   1 +
 lib/dynamic_debug.c                           | 203 ++++++++++++++--
 lib/test_dynamic_debug.c                      | 222 ++++++++++++++++++
 17 files changed, 815 insertions(+), 89 deletions(-)
 create mode 100644 lib/test_dynamic_debug.c

-- 
2.31.1

