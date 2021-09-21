Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85212413639
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbhIUPaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbhIUP37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:29:59 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8D2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 08:28:31 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id w14so9300603pfu.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 08:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jL5fGwtC4j55LTOWAT+GILFN7trYNKsOooZiEJOBglo=;
        b=CVgXjLfxVPPZCl8S6+xYmywgFO/821gBvJld/ra3BvZhp8sYuR5zHlVMUI8pzflrjC
         2uIrPhuW+z1pYiH0hh0iWQczEOZMH5VEHkrSReF12xjlyEcB8fl3+kCJ9iJmjTUt/jZ9
         hQczEHEeDIiA28sy0XKbdvK9ZDdGJj1+jp6uE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jL5fGwtC4j55LTOWAT+GILFN7trYNKsOooZiEJOBglo=;
        b=OryvUKzegS8CFvXP6dhXTK0vov0DM/gp6QXiLns4FbTVsA8PEjgwcYifQvnmsPmnfF
         J1FQnztBpJMP44pwntSG9zQhimWkmpCYKLVcAMpK9zGjdMN795eig/nwpm/fLiE0gH3K
         Fm9rQZEYBRnzZ6wbRoez+fPn8VhCFQ4fgYoCVz5MzRzwW4tg24k1jD6JYRq4ZtEd4MIQ
         t7ZjWJgcu2lu1DdufeuAGfjcLn3093IbTo9WuZ6lbGHIbQRA+/332K0Pdwd6PU04+qcH
         46lloxAnYG7skEhmAAvYCIfass4NZ0FgQzuHv7XzYROOmHcMISiXLH8bc7wlx34hWDK3
         HTCA==
X-Gm-Message-State: AOAM530kHDC3x9U2xPUwLWEBy8V4Cs7ghmpjYEaC1CeOrZhA2pXQ6B/A
        xdj3vb/7WW2Us/GleUL81vxoNg==
X-Google-Smtp-Source: ABdhPJyYjqMBuf7nb+ttOG1fuvgpEfDFQ/tDtegPet467YO1ldp7Iha/kbLA7d0LHdI95ltEdWcmyA==
X-Received: by 2002:aa7:825a:0:b0:43e:124e:5c1e with SMTP id e26-20020aa7825a000000b0043e124e5c1emr30655949pfn.76.1632238110490;
        Tue, 21 Sep 2021 08:28:30 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:5d7:1a63:a991:2247])
        by smtp.gmail.com with ESMTPSA id k3sm2968083pjg.43.2021.09.21.08.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 08:28:30 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     sam@ravnborg.org, daniel.vetter@ffwll.ch, lyude@redhat.com,
        jani.nikula@intel.com, swboyd@chromium.org, airlied@redhat.com,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] drm/print: Add deprecation notes to DRM_...() functions
Date:   Tue, 21 Sep 2021 08:28:01 -0700
Message-Id: <20210921082757.RFC.1.Ibd82d98145615fa55f604947dc6a696cc82e8e43@changeid>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's hard for someone (like me) who's not following closely to know
what the suggested best practices are for error printing in DRM
drivers. Add some hints to the header file.

In general, my understanding is that:
* When possible we should be using a `struct drm_device` for logging
  and recent patches have tried to make it more possible to access a
  relevant `struct drm_device` in more places.
* For most cases when we don't have a `struct drm_device`, we no
  longer bother with DRM-specific wrappers on the dev_...() functions
  or pr_...() functions and just encourage drivers to use the normal
  functions.
* For debug-level functions where we might want filtering based on a
  category we'll still have DRM-specific wrappers, but we'll only
  support passing a `struct drm_device`, not a `struct
  device`. Presumably most of the cases where we want the filtering
  are messages that happen while the system is in a normal running
  state (AKA not during probe time) and we should have a `struct
  drm_device` then. If we absolutely can't get a `struct drm_device`
  then these functions begrudgingly accept NULL for the `struct
  drm_device` and hopefully the awkwardness of having to manually pass
  NULL will keep people from doing this unless absolutely necessary.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 include/drm/drm_print.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 15a089a87c22..22fabdeed297 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -340,6 +340,8 @@ void drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 /**
  * DRM_DEV_ERROR() - Error output.
  *
+ * NOTE: this is deprecated in favor of drm_err() or dev_err().
+ *
  * @dev: device pointer
  * @fmt: printf() like format string.
  */
@@ -349,6 +351,9 @@ void drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 /**
  * DRM_DEV_ERROR_RATELIMITED() - Rate limited error output.
  *
+ * NOTE: this is deprecated in favor of drm_err_ratelimited() or
+ * dev_err_ratelimited().
+ *
  * @dev: device pointer
  * @fmt: printf() like format string.
  *
@@ -364,9 +369,11 @@ void drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 		DRM_DEV_ERROR(dev, fmt, ##__VA_ARGS__);			\
 })
 
+/* NOTE: this is deprecated in favor of drm_info() or dev_info(). */
 #define DRM_DEV_INFO(dev, fmt, ...)				\
 	drm_dev_printk(dev, KERN_INFO, fmt, ##__VA_ARGS__)
 
+/* NOTE: this is deprecated in favor of drm_info_once() or dev_info_once(). */
 #define DRM_DEV_INFO_ONCE(dev, fmt, ...)				\
 ({									\
 	static bool __print_once __read_mostly;				\
@@ -379,6 +386,8 @@ void drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 /**
  * DRM_DEV_DEBUG() - Debug output for generic drm code
  *
+ * NOTE: this is deprecated in favor of drm_dbg_core().
+ *
  * @dev: device pointer
  * @fmt: printf() like format string.
  */
@@ -387,6 +396,8 @@ void drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 /**
  * DRM_DEV_DEBUG_DRIVER() - Debug output for vendor specific part of the driver
  *
+ * NOTE: this is deprecated in favor of drm_dbg() or dev_dbg().
+ *
  * @dev: device pointer
  * @fmt: printf() like format string.
  */
@@ -395,6 +406,8 @@ void drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 /**
  * DRM_DEV_DEBUG_KMS() - Debug output for modesetting code
  *
+ * NOTE: this is deprecated in favor of drm_dbg_kms().
+ *
  * @dev: device pointer
  * @fmt: printf() like format string.
  */
@@ -480,47 +493,63 @@ void __drm_err(const char *format, ...);
 #define _DRM_PRINTK(once, level, fmt, ...)				\
 	printk##once(KERN_##level "[" DRM_NAME "] " fmt, ##__VA_ARGS__)
 
+/* NOTE: this is deprecated in favor of pr_info(). */
 #define DRM_INFO(fmt, ...)						\
 	_DRM_PRINTK(, INFO, fmt, ##__VA_ARGS__)
+/* NOTE: this is deprecated in favor of pr_notice(). */
 #define DRM_NOTE(fmt, ...)						\
 	_DRM_PRINTK(, NOTICE, fmt, ##__VA_ARGS__)
+/* NOTE: this is deprecated in favor of pr_warn(). */
 #define DRM_WARN(fmt, ...)						\
 	_DRM_PRINTK(, WARNING, fmt, ##__VA_ARGS__)
 
+/* NOTE: this is deprecated in favor of pr_info_once(). */
 #define DRM_INFO_ONCE(fmt, ...)						\
 	_DRM_PRINTK(_once, INFO, fmt, ##__VA_ARGS__)
+/* NOTE: this is deprecated in favor of pr_notice_once(). */
 #define DRM_NOTE_ONCE(fmt, ...)						\
 	_DRM_PRINTK(_once, NOTICE, fmt, ##__VA_ARGS__)
+/* NOTE: this is deprecated in favor of pr_warn_once(). */
 #define DRM_WARN_ONCE(fmt, ...)						\
 	_DRM_PRINTK(_once, WARNING, fmt, ##__VA_ARGS__)
 
+/* NOTE: this is deprecated in favor of pr_err(). */
 #define DRM_ERROR(fmt, ...)						\
 	__drm_err(fmt, ##__VA_ARGS__)
 
+/* NOTE: this is deprecated in favor of pr_err_ratelimited(). */
 #define DRM_ERROR_RATELIMITED(fmt, ...)					\
 	DRM_DEV_ERROR_RATELIMITED(NULL, fmt, ##__VA_ARGS__)
 
+/* NOTE: this is deprecated in favor of drm_dbg_core(NULL, ...). */
 #define DRM_DEBUG(fmt, ...)						\
 	__drm_dbg(DRM_UT_CORE, fmt, ##__VA_ARGS__)
 
+/* NOTE: this is deprecated in favor of drm_dbg(NULL, ...). */
 #define DRM_DEBUG_DRIVER(fmt, ...)					\
 	__drm_dbg(DRM_UT_DRIVER, fmt, ##__VA_ARGS__)
 
+/* NOTE: this is deprecated in favor of drm_dbg_kms(NULL, ...). */
 #define DRM_DEBUG_KMS(fmt, ...)						\
 	__drm_dbg(DRM_UT_KMS, fmt, ##__VA_ARGS__)
 
+/* NOTE: this is deprecated in favor of drm_dbg_prime(NULL, ...). */
 #define DRM_DEBUG_PRIME(fmt, ...)					\
 	__drm_dbg(DRM_UT_PRIME, fmt, ##__VA_ARGS__)
 
+/* NOTE: this is deprecated in favor of drm_dbg_atomic(NULL, ...). */
 #define DRM_DEBUG_ATOMIC(fmt, ...)					\
 	__drm_dbg(DRM_UT_ATOMIC, fmt, ##__VA_ARGS__)
 
+/* NOTE: this is deprecated in favor of drm_dbg_vbl(NULL, ...). */
 #define DRM_DEBUG_VBL(fmt, ...)						\
 	__drm_dbg(DRM_UT_VBL, fmt, ##__VA_ARGS__)
 
+/* NOTE: this is deprecated in favor of drm_dbg_lease(NULL, ...). */
 #define DRM_DEBUG_LEASE(fmt, ...)					\
 	__drm_dbg(DRM_UT_LEASE, fmt, ##__VA_ARGS__)
 
+/* NOTE: this is deprecated in favor of drm_dbg_dp(NULL, ...). */
 #define DRM_DEBUG_DP(fmt, ...)						\
 	__drm_dbg(DRM_UT_DP, fmt, ## __VA_ARGS__)
 
@@ -536,6 +565,7 @@ void __drm_err(const char *format, ...);
 #define drm_dbg_kms_ratelimited(drm, fmt, ...) \
 	__DRM_DEFINE_DBG_RATELIMITED(KMS, drm, fmt, ## __VA_ARGS__)
 
+/* NOTE: this is deprecated in favor of drm_dbg_kms_ratelimited(NULL, ...). */
 #define DRM_DEBUG_KMS_RATELIMITED(fmt, ...) drm_dbg_kms_ratelimited(NULL, fmt, ## __VA_ARGS__)
 
 /*
-- 
2.33.0.464.g1972c5931b-goog

