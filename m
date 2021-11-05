Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73304468F5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 20:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbhKET3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 15:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhKET3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 15:29:31 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FA9C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 12:26:52 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id q203so11771320iod.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 12:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qRP0k6J60c+VRwgJP2pgOOfkoTqAwQ9aAbOh9TWNhbk=;
        b=KR6zp2+8oFmAu3cr0wq4MJ/cHADZX4KGo1aKqYbpjcyliQWXOf7HRHwwq+7lFNnzh1
         jh1P1KFFeoQ7NgAb8nhsV/q1cTjiLjkq6g4fP4HaXi8ZR9FelHeYOzXQGPLPpcsEI49X
         8GqFqdahIX7tn4KItYhNUdx58omiOi5iH4X35gOLIoGiM1tlj/ffYaaYHYkuVem9In36
         IcUPcVj4mllHsZQbj8IE0UFEfsEhNngRqg1Y7s/1rRYNFwp4CJAbpTOQpsxcP2Xkx2yf
         fU+xPjP408mBfFKRaKR9HEyhukNjG+vlCnY/NHJfLrNUKgP3IRKeVrHJNBXeWU6xRwoH
         cccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qRP0k6J60c+VRwgJP2pgOOfkoTqAwQ9aAbOh9TWNhbk=;
        b=MUFDpra7JNEvo9m0cmXln9pxM1pUGDczzhpWu8o8V0kQXiZWVLBDecHqqoeIrqHvWg
         xgW3l9cytJURPemug7Yiywwr0U17iab2ojT/LQ7ol3cUR7ec7hfVnH6kfhRJhzPdmz+Q
         Oaqq2N9juWsyv8ZBjQ9uXo8jqRckXxCMcN6l/LEmUAWFprz8CwpJtVyGePS8RcGq1CCe
         Q/pQizkF4oMBsMd4lvIhilXctk4MfIPpQ1ZWmXTzKdFNX0w1JnM0lWZEpyQCMuwbmKFF
         QPfj/dZTjwdlkNPYMRuS4UItZqf46ork2a3/+h0aqrYURQNlOupIbfXFbagruvhaLd6X
         wquQ==
X-Gm-Message-State: AOAM5312qKOfclQzvYj4N5O5L4yJ4z+O8tn4M2rFly6ubID8cZMF1Wto
        QW8UQLHQUq+2TVbmROa5Lj8=
X-Google-Smtp-Source: ABdhPJzGjY79lwbH9Wx5dRR19O6yLjk08RQIKZHczVQG6f+Nm3kjDuEs34bbOyHLH/VhcPf2yLM56w==
X-Received: by 2002:a05:6638:2045:: with SMTP id t5mr10875675jaj.127.1636140411193;
        Fri, 05 Nov 2021 12:26:51 -0700 (PDT)
Received: from samwise.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id l18sm4338617iob.17.2021.11.05.12.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 12:26:50 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com, sean@poorly.run,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, lyude@redhat.com,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v10 00/10] use DYNAMIC_DEBUG to implement DRM.debug & DRM.trace
Date:   Fri,  5 Nov 2021 13:26:27 -0600
Message-Id: <20211105192637.2370737-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason, Greg, DRM-everyone,

This patchset has 3 separate but related parts:

1. DEFINE_DYNAMIC_DEBUG_BITGRPS [patch 1/10]

   Declares DRM.debug style bitmap, bits control pr_debugs by matching formats
   Adds callback to translate bits to $cmd > dynamic_debug/control
   This could obsolete EXPORT(dynamic_debug_exec_queries) not included.

   /* anticipated_usage */
   static struct dyndbg_desc drm_categories_map[] = {
   	  [0] = { DRM_DBG_CAT_CORE },
	  [1] = { DRM_DBG_CAT_DRIVER },
	  [2] = { DRM_DBG_CAT_KMS },
	  [3] = { DRM_DBG_CAT_PRIME }, ... };

   DEFINE_DYNAMIC_DEBUG_BITGRPS(debug, __drm_debug,
				" bits control drm.debug categories ",
				drm_categories_map);

   Please consider this patch for -next:
   - new interface, new code, no users to break
   - allows DRM folks to consider in earnest.
   - api bikeshedding to do ?
     struct dyndbg_desc isnt that great a name, others too probably.

2. use (1) to reimplement drm.debug [patches 3-7]:

   1st in amdgpu & i915 to control existing pr_debugs by their formats
   then in drm-print, for all drm.debug API users
   POC for (1)
   avoids drm_debug_enabled(), gives NOOP savings & new flexibility.
   changes drm.debug categories from enum to format-prefix-string
   alters in-log format to include the format-prefix-string
   Daniel Vetter liked this at -v3
   https://lore.kernel.org/lkml/YPbPvm%2FxcBlTK1wq@phenom.ffwll.local/
   Im sure Ive missed stuff.
   
3. separately, Sean Paul proposed drm.trace to mirror drm.debug to tracefs
   https://patchwork.freedesktop.org/series/78133/

He argues:
   tracefs is fast/lightweight compared to syslog
   independent selection (of drm categories) to tracefs
       gives tailored traffic w.o flooding syslog

ISTM he's correct.  So it follows that write-to-tracefs is also a good
feature for dyndbg, where its then available for all pr_debug users,
on a per-site basis, via echo +T >control.  (iff CONFIG_TRACING).

So basically, I borg'd his:
   [patch 14/14] drm/print: Add tracefs support to the drm logging helpers
   
Then I added a T flag, so it can be toggled from shell:

   # turn on all drm's pr_debug --> tracefs
   echo module drm +T > /proc/dynamic_debug/control

It appears to just work: (RFC)

The instance name is a placeholder, per-module subdirs kinda fits the
tracefs pattern, full mod/file-basename/function/line feels like
overkill, mod/basename-func.line would flatten it nicely. RFC.

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
  echo 2 > /sys/module/test-dynamic-debug/parameters/run_me

If thats wrapped in the right trace_on, trace_pipe, etc incantations,
the +T enabled pr_debugs in do_debugging() can be counted, compared
against expectations, and passed or failed.

change since v9:
. patch confict against drm-misc resolved
. s/CATEGORIES/BITGRPS/ in 1/10 - keep name generic: bitmap + groups
. CATEGORIES is drm term, use it there only
. fix api friction wrt drm.trace knob
  2 separate macros: DEFINE_DYNAMIC_DEBUG_{LOG,TRACE}_GROUPS - JBaron

v9: https://patchwork.freedesktop.org/series/96327/
v8: https://patchwork.freedesktop.org/series/93914/
    https://lore.kernel.org/lkml/20210915163957.2949166-1-jim.cromie@gmail.com/

The major change since v8 is that +T now works for all users, if
CONFIG_TRACING=y, otherwise it complains/errors.


Jim Cromie (10):
  dyndbg: add DEFINE_DYNAMIC_DEBUG_BITGRPS macro and callbacks
  drm: fix doc grammar
  amdgpu: use dyndbg.BITGRPS to control existing pr_debugs
  i915/gvt: trim spaces from pr_debug "gvt: core:" prefixes
  i915/gvt: use dyndbg.BITGRPS for existing pr_debugs
  drm_print: add choice to use dynamic debug in drm-debug
  drm_print: instrument drm_debug_enabled
  dyndbg: add print-to-tracefs, selftest with it - RFC
  dyndbg: create DEFINE_DYNAMIC_DEBUG_LOG|TRACE_GROUPS
  drm: use DEFINE_DYNAMIC_DEBUG_TRACE_GROUPS in 3 places

 .../admin-guide/dynamic-debug-howto.rst       |   7 +-
 MAINTAINERS                                   |   1 +
 drivers/gpu/drm/Kconfig                       |  26 ++
 drivers/gpu/drm/Makefile                      |   2 +
 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +
 .../gpu/drm/amd/display/dc/core/dc_debug.c    |  55 ++++-
 drivers/gpu/drm/drm_print.c                   |  62 +++--
 drivers/gpu/drm/i915/Makefile                 |   2 +
 drivers/gpu/drm/i915/gvt/debug.h              |  18 +-
 drivers/gpu/drm/i915/intel_gvt.c              |  47 ++++
 include/drm/drm_drv.h                         |   2 +-
 include/drm/drm_print.h                       | 182 +++++++++++---
 include/linux/dynamic_debug.h                 |  88 ++++++-
 lib/Kconfig.debug                             |  11 +
 lib/Makefile                                  |   1 +
 lib/dynamic_debug.c                           | 203 ++++++++++++++--
 lib/test_dynamic_debug.c                      | 222 ++++++++++++++++++
 17 files changed, 843 insertions(+), 88 deletions(-)
 create mode 100644 lib/test_dynamic_debug.c

-- 
2.31.1

