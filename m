Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE78C320108
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 22:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhBSV7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 16:59:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39825 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229999AbhBSV4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 16:56:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613771705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DW+iB7cPyvTS+W1v3rgVH6HcGBRdmo2WikAbUw64DdY=;
        b=e1EvxNzT4JEvunlqRZBYZdcrCb3HeMoH1j/a49lI4zbCku/qJ7tMSNw87aiDXQfoDASLns
        Eh/yPx7W1EFUw+m9vF15q3flQdEzgp5tcPkhqyVJmWJZ/JdZkc/RxC80F0JnYBEAE5ZbuB
        9hZ564PfrLwXazL4XAhJjDsnN44DKQs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-UAMbAVtgONG0oVJoALt_oQ-1; Fri, 19 Feb 2021 16:55:01 -0500
X-MC-Unique: UAMbAVtgONG0oVJoALt_oQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30AFE18A08C0;
        Fri, 19 Feb 2021 21:54:59 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-118-5.rdu2.redhat.com [10.10.118.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6BE46A03C;
        Fri, 19 Feb 2021 21:54:57 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 18/30] drm/print: Fixup DRM_DEBUG_KMS_RATELIMITED()
Date:   Fri, 19 Feb 2021 16:53:14 -0500
Message-Id: <20210219215326.2227596-19-lyude@redhat.com>
In-Reply-To: <20210219215326.2227596-1-lyude@redhat.com>
References: <20210219215326.2227596-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we're about to move drm_dp_helper.c over to drm_dbg_*(), we'll want
to make sure that we can also add ratelimited versions of these macros in
order to retain some of the previous debugging output behavior we had.

However, as I was preparing to do this I noticed that the current
rate limited macros we have are kind of bogus. It looks like when I wrote
these, I didn't notice that we'd always be calling __ratelimit() even if
the debugging message we'd be printing would normally be filtered out due
to the relevant DRM debugging category being disabled.

So, let's fix this by making sure to check drm_debug_enabled() in our
ratelimited macros before calling __ratelimit(), and start using
drm_dev_printk() in order to print debugging messages since that will save
us from doing a redundant drm_debug_enabled() check. And while we're at it,
let's move the code for this into another macro that we can reuse for
defining new ratelimited DRM debug macros more easily.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 include/drm/drm_print.h | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index f32d179e139d..3a0c3fe4d292 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -524,16 +524,20 @@ void __drm_err(const char *format, ...);
 #define DRM_DEBUG_DP(fmt, ...)						\
 	__drm_dbg(DRM_UT_DP, fmt, ## __VA_ARGS__)
 
-
-#define DRM_DEBUG_KMS_RATELIMITED(fmt, ...)				\
-({									\
-	static DEFINE_RATELIMIT_STATE(_rs,				\
-				      DEFAULT_RATELIMIT_INTERVAL,       \
-				      DEFAULT_RATELIMIT_BURST);         \
-	if (__ratelimit(&_rs))						\
-		drm_dev_dbg(NULL, DRM_UT_KMS, fmt, ##__VA_ARGS__);	\
+#define __DRM_DEFINE_DBG_RATELIMITED(category, drm, fmt, ...)                                    \
+({                                                                                               \
+	static DEFINE_RATELIMIT_STATE(rs_, DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST); \
+	const struct drm_device *drm_ = (drm);                                                   \
+                                                                                                 \
+	if (drm_debug_enabled(DRM_UT_ ## category) && __ratelimit(&rs_))                         \
+		drm_dev_printk(drm_ ? drm_->dev : NULL, KERN_DEBUG, fmt, ## __VA_ARGS__);        \
 })
 
+#define drm_dbg_kms_ratelimited(drm, fmt, ...) \
+	__DRM_DEFINE_DBG_RATELIMITED(KMS, drm, fmt, ## __VA_ARGS__)
+
+#define DRM_DEBUG_KMS_RATELIMITED(fmt, ...) drm_dbg_kms_ratelimited(NULL, fmt, ## __VA_ARGS__)
+
 /*
  * struct drm_device based WARNs
  *
-- 
2.29.2

