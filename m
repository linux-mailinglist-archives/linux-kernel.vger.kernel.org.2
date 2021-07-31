Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F31D3DC85C
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 23:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhGaVmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 17:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbhGaVmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 17:42:39 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4367C06175F
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 14:42:32 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id c3so13024278ilh.3
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 14:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FVzAd0b7G06F+b9x5+FC/aHuzWCnZbaicUuNK8fUHeA=;
        b=im7afXLgSWUILaAASEAeZU/LwwVX1SZ6P517INeRbwmW2P/hFuwWJObGJH8hqMSqqj
         bcO77GbwKF8aa9UNSH2YQo6Jc0lfiHjybWGqyfM1sWZVmbaKm7G/AEhi94bV8Zauy049
         Mc95i1CHbX/T/92IWCD6PLmCQBaYSKTtRsvubIh5EWWT643Uxi5REtHwbJE/86rgawga
         4ZhtIzDi0lp1xjpELCec1MWDNg9ujPcI7cUvV/MLyoEdv3egmEC7JVqd4/xyxS51uVCK
         NQeVFQBKnUxB2Pcpha9cPwMO41WTZ3+RSw+NZb9ZalXrRlTLV7nOTEq/dVxUdzkSsvbl
         KJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FVzAd0b7G06F+b9x5+FC/aHuzWCnZbaicUuNK8fUHeA=;
        b=WiiCFdWGnb6kC2WWMbzfUmdYqWKbp4CPkGuD5hyCf/ia5gqFI08n+v3gU8KzmCPOzZ
         e5d0pWdweS2FXr9otVW1nSoR5BtjTQka+8DGuOAF3WYJ8cjn3ESEOhndPtt5UprtVEMv
         9ajVIq8V6S72xkPArAgUUyszYsEPrrcIYy/ET3zujDlB3mNlOVl69sHnAmcmOUgrQ8NZ
         hpFCtdKl+KA/SnaT9Sp00dzuAQf51C0JpdvsPx2D/+4H96l2Xgh/qvGvUMGIT8nThhI2
         4grBGj3JfQHgnmaqoCW0V0T3zwQ7I+iIfmzqL2hqMZa59iESEZcX0zu9O3w+7K9j535S
         xuJg==
X-Gm-Message-State: AOAM533rWTyID9YyYapX+nt4kfbLPtCp7n0dn8zUP+PLKhCNfXHhZD6L
        bwdsYc/7w1h0TRzJzIdv4Z4=
X-Google-Smtp-Source: ABdhPJwOVDZdNuyCxOD9UoCaMWITVwXrdhXAHTL3qSQNIVo5TmDJ1ed0abVTIJeR08hq9h9Tw27odg==
X-Received: by 2002:a92:d112:: with SMTP id a18mr5649773ilb.67.1627767752154;
        Sat, 31 Jul 2021 14:42:32 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id q10sm3721040ion.3.2021.07.31.14.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 14:42:31 -0700 (PDT)
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
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Wyatt Wood <Wyatt.Wood@amd.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Jessica Yu <jeyu@kernel.org>, Johan Hovold <johan@kernel.org>,
        Joe Perches <joe@perches.com>, Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Subject: [PATCH v4 2/7] moduleparam: add data member to struct kernel_param
Date:   Sat, 31 Jul 2021 15:41:59 -0600
Message-Id: <20210731214211.657280-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210731214211.657280-1-jim.cromie@gmail.com>
References: <20210731214211.657280-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a void* data member to the struct, to allow attaching private data
that will be used soon by a setter method (via kp->data) to perform
more elaborate actions.

To attach the data at compile time, add new macros:
module_param_cbd() derives from module_param_cb(), adding data param.
It calls __module_param_call_wdata(), which has accepts new data
param and inits .data with it. Re-define __module_param_call() using it.

Use of this new data member will be rare, it might be worth redoing
this as a separate/sub-type to keep the base case.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/moduleparam.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index eed280fae433..e9495b1e794d 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -78,6 +78,7 @@ struct kernel_param {
 		const struct kparam_string *str;
 		const struct kparam_array *arr;
 	};
+	void *data;
 };
 
 extern const struct kernel_param __start___param[], __stop___param[];
@@ -175,6 +176,9 @@ struct kparam_array
 #define module_param_cb(name, ops, arg, perm)				      \
 	__module_param_call(MODULE_PARAM_PREFIX, name, ops, arg, perm, -1, 0)
 
+#define module_param_cbd(name, ops, arg, perm, data)				\
+	__module_param_call_wdata(MODULE_PARAM_PREFIX, name, ops, arg, perm, -1, 0, data)
+
 #define module_param_cb_unsafe(name, ops, arg, perm)			      \
 	__module_param_call(MODULE_PARAM_PREFIX, name, ops, arg, perm, -1,    \
 			    KERNEL_PARAM_FL_UNSAFE)
@@ -284,14 +288,17 @@ struct kparam_array
 
 /* This is the fundamental function for registering boot/module
    parameters. */
-#define __module_param_call(prefix, name, ops, arg, perm, level, flags)	\
+#define __module_param_call(prefix, name, ops, arg, perm, level, flags) \
+	__module_param_call_wdata(prefix, name, ops, arg, perm, level, flags, NULL)
+
+#define __module_param_call_wdata(prefix, name, ops, arg, perm, level, flags, data) \
 	/* Default value instead of permissions? */			\
 	static const char __param_str_##name[] = prefix #name;		\
 	static struct kernel_param __moduleparam_const __param_##name	\
 	__used __section("__param")					\
 	__aligned(__alignof__(struct kernel_param))			\
 	= { __param_str_##name, THIS_MODULE, ops,			\
-	    VERIFY_OCTAL_PERMISSIONS(perm), level, flags, { arg } }
+	    VERIFY_OCTAL_PERMISSIONS(perm), level, flags, { arg }, data }
 
 /* Obsolete - use module_param_cb() */
 #define module_param_call(name, _set, _get, arg, perm)			\
-- 
2.31.1

