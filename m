Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D070E3DC850
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 23:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbhGaVm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 17:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhGaVm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 17:42:26 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7408EC06175F
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 14:42:19 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id i13so1112055ilm.11
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 14:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aVmLFF8kIa6pqHI/2spVEX6Ez1Zxaw1z0VKkysUh6OA=;
        b=bcyRDE9jmBi53NVEL7/BoTyb684M2vZ6IcBWkShz6AkdBGn5fKXWkKNDM3yIlZ/8a6
         PKl7ZOhM8wANJtKXf3SCzfwam1qd7XhONbnoLuHgUM7tUNorOIA+1S+8ONCpbZPKYTVD
         wW6BNfpkrKZnwVucQlxbs9pHCieQ/7JYjgaefuzu924hZdpyHSw/C4IuRVeGlmFA9EDJ
         mKMS3WVEZvYz0tR6/jjF9cqY7ipD5jzgX09qV/j3UqKxrBvH4niw3fxOSj+inZgfYZEf
         VxwUis6kkhEwObgi2CteUlELN1GLfISqeCnxlQYTcR+8gugfGoRADLNPNSnwepRCDgAJ
         9fag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aVmLFF8kIa6pqHI/2spVEX6Ez1Zxaw1z0VKkysUh6OA=;
        b=s6VSKX+1lkkSwaSyF0R4UymCJzancroDnF7CjD5/alGCy7pveW1VG95E9MMBV3oFMO
         NOvOXeomgPgr4oUhvRILIzwF4aGKypHAJMcPJe3uMeCLE6NhTql2ZcOHJAV7H/6WLb0o
         oMF1utTT8J6m7CTnDpkzT1W9XUsnteFQDm4a8S4WoeK+/5WSfV6aTOug4aVm5vnOTfwS
         qexgPeXfal7rfOkJXDrk+wKV3faEuYwCshWzRUXGS37L+QOVlpQaCzfrnfNtvLFjwLI7
         HzgGi6w0POTKCi37d9I9r6ISA9ammtP7wp9H+tAOsfUaeZTQ/FVs+Cx1v+XFiDY817eU
         EV+w==
X-Gm-Message-State: AOAM533+QyLn+CEDkg5g3f7tRaDeVEehFF7jP4uYYjR8v5QOM2kODZeJ
        GUZq30OomSsofAj+SgfbEEw=
X-Google-Smtp-Source: ABdhPJy4yG0XZkDRl88spj8jPzgZkJAjSj7zUAGj1fizHZfah2LLETjfqevLrHE/TItkYYWsEGN2sQ==
X-Received: by 2002:a92:c605:: with SMTP id p5mr6570294ilm.209.1627767738825;
        Sat, 31 Jul 2021 14:42:18 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id q10sm3721040ion.3.2021.07.31.14.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 14:42:18 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jason Baron <jbaron@akamai.com>,
        Ashley Thomas <Ashley.Thomas2@amd.com>,
        Wyatt Wood <Wyatt.Wood@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Johan Hovold <johan@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Joe Perches <joe@perches.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Subject: [PATCH v4 0/7] drm: use dyndbg in drm_print
Date:   Sat, 31 Jul 2021 15:41:57 -0600
Message-Id: <20210731214211.657280-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

Apologies for broad --to, but it touches a wide range, if casually.

In order to avoid runtime costs of drm_debug_enabled(), this patchset
re-implements drm.debug to use dyndbg, after extending dyndbg with
kernel_param_ops to implement the bitmap->dydnbg-query and expose it
for use.

To define your pr_debugs categorization (that you want to control):

DEFINE_DYNDBG_BITMAP(debug_gvt, __gvt_debug,
	"i915/gvt dyndbg bitmap desc",
	/* bits 0-N are initialized with these exprs */
	{ "gvt:cmd: ",	"command processing" },
	{ "gvt:core: ",	"core help" },
	{ "gvt:dpy: ",	"display help" },
	{ "gvt:el: ",	"help" },
	{ "gvt:irq: ",	"help" },
	{ "gvt:mm: ",	"help" },
	{ "gvt:mmio: ", "help" },
	{ "gvt:render: ", "help" },
	{ "gvt:sched: ", "help" });

Then, you can change whole categories of pr_debugs:

  echo 0x5A > /sys/modules/i915/parameters/debug_gvt

BIT($i++) is implied by order, can it be autogend with macros and
stuffed into MODULE_PARAM_DESC automagically ?

v4:
 - extend kernel_param with void* .data (2/7)
 - move v3 kernel_param_ops code into dyndbg (3/7)
 - add DEFINE_DYNDBG_BITMAP (3/7)
 - use DEFINE_DYNDBG_BITMAP in drm-core, i915 (5/7), amdgpu (7/7)
 - lots of changes per @DanVet feedback, thanks!
   no doc yet, content more in commit-log refinements

v3: https://lore.kernel.org/lkml/20210714175138.319514-1-jim.cromie@gmail.com/
    main element is now patch 6/7, 
v2: https://lore.kernel.org/lkml/20210711055003.528167-1-jim.cromie@gmail.com/
v1: https://lore.kernel.org/lkml/20201204035318.332419-1-jim.cromie@gmail.com/

NOTES:

https://github.com/jimc/linux/tree/dd-drm-v4 should be seen and tested
by robots soon.

Using dyndbg to implement categories/classes of pr_debugs requires
that the class-prefix is compiled into the format string, and not
written at runtime with pr_debug("%s %pV", class_str, vaf).

That caveat is reflected in (6/7) where category is catenated with the
format, and ceases to exist as a separate arg for DRM_USE_DD=y builds.
ISTM this also means drm_debug_enabled() isnt going away just yet.

The categories arent atomic in any sense; callsites controlled via
drm.debug can still be tweaked arbitrarily with echo $query > control.

dyndbg's search is global by default; format ^$prefix cuts across
code modules, and anyone can add a pr_debug("drm:foobar: yada")
classification.  Rules against this are policy, and belong in the
realm of author taste and code review, not in the tool.

Maybe modname's already available via kp, if we need it.  Other query
terms are possible, if struct dyndbg_bitdesc is elaborated.

The dyndbg-queries built by the callback don't include modname.  This
allows drm.dbg to control pr-debugs inside i915, despite being done
from a different module.  This is ok because i915 used the drm_debug
api for those messages.

i915/gvt uses a different way to prepend its classes, but it shares
the classification space.  Like a good namespace citizen, it has
"gvt:" as its top-level name, with ~9 2nd level names.

sean@chromium.org posited "drm:atomic:fail: " as a new category, to
leverage the additional selectivity of dyndbg.

Allowing for N-level namespaces, ' ' terminates the prefix, not ':'.
So "drm:atomic:" & "drm:atomic: " are different searches, 1st
including pr_debug("drm:atomic:fail: ")

DEFINE_DYNDBG_BITMAP() bits and masks are dependent on order of
bit-declarations.  Since bits are applied 0-N, later bits could
override (ie sub-categorize) earlier ones.  IOW, "drm:atomic:fail: "
just needs to be after "drm:atomic: ".



dyndbg is extremely agnostic about how you use format ^$prefix, your
classification scheme just needs to work within the limitation that
its a simple anchored literal substring match, no regex stuff.

In particular, commit 578b1e0701af ("dynamic_debug: add wildcard
support to filter files/functions/modules") left format out, because
it was already special (floating substr match, no need for '*').

Patch 6/7 has many more "advices" on classification / categorization.

and im restating things.

Much more to say/do instead of what follows, which is v3 prose.
I wanted to send, see how its received by robots and people.


drm_debug_enabled() is called a lot to do unlikely bit-tests to
selectively enable debug printing; this is a good job for
dynamic-debug, IFF it is built with JUMP_LABEL.
 
This patchset enables the use of dynamic-debug to avoid all those
drm_debug_enabled() overheads, if CONFIG_DRM_USE_DYNAMIC_DEBUG=y.


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

This is on top of master @ v5.14-rc3.

Jim Cromie (7):
  drm/print: fixup spelling in a comment (already in drm-mumble)
  moduleparam: add data member to struct kernel_param
  dyndbg: add dyndbg-bitmap definer and callbacks
  i915/gvt: remove spaces in pr_debug "gvt: core:" etc prefixes
  i915/gvt: control pr_debug("gvt:")s with bits in parameters/debug_gvt
  drm/print: add choice to use dynamic debug in drm-debug
  amdgpu: define a dydbg-bitmap to control categorized pr_debugs

 drivers/gpu/drm/Kconfig                       | 13 +++
 .../gpu/drm/amd/display/dc/core/dc_debug.c    | 42 +++++++-
 drivers/gpu/drm/drm_print.c                   | 15 ++-
 drivers/gpu/drm/i915/gvt/Makefile             |  4 +
 drivers/gpu/drm/i915/gvt/debug.h              | 18 ++--
 drivers/gpu/drm/i915/i915_params.c            | 34 +++++++
 include/drm/drm_print.h                       | 99 ++++++++++++++-----
 include/linux/dynamic_debug.h                 | 36 +++++++
 include/linux/moduleparam.h                   | 11 ++-
 lib/dynamic_debug.c                           | 55 +++++++++++
 10 files changed, 284 insertions(+), 43 deletions(-)

-- 
2.31.1

