Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26F9394E09
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 22:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhE2UE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 16:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhE2UEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 16:04:06 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729EBC061574
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:28 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso6941831otl.13
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y62ORwckIayPFlg0wcO0nZkUvVrH3KCOg2Z+/d7jCxA=;
        b=iitpARtoFTQH2fTgLE0xfQS0LOc1HvClvVTDOHOGsGz2tPY8lWV0zdaBJZL2gAlOOU
         kStXWiWoXcKCCMKOu0uwU8UR1Avr03f1p6oO8IaxrtB1BJ4UBhJSlqoKqez1bUAfDLRk
         ZKRczBTrwNLOKB940s8Hff7Ktl+ymQc+VnUmn200598dstjRqqQ6LQAYPKUVM4f0KSSS
         gu7Bi30Vm9MQYF7vCPilwl/8tHO6tjXazIQ0Qz9M0rxvDWLqZATwRYfd6gq7dqHe3C3f
         ecOCY+mBfB6LKPN6WMWylw6pMiXvkgNZvZ9NA79rIZ0cGBO+jglHj9TqVyQw3h6V9Y8y
         wj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y62ORwckIayPFlg0wcO0nZkUvVrH3KCOg2Z+/d7jCxA=;
        b=j6h9PYP1MKSo7DcE0R7zTS615VFJDXorn1mr3k6Wy/rOEPDerXrNp8Ga1r+OCZ600q
         SPsFAEEwmEbyp0y4wI+Ozn0On1IQJJsmOPGsLnpHdteCp227UqgyWiBnU8T9wBn55+67
         CICMSUcr4vqUk1BIwFE+MkC9iu1KThdY/Ey5DK1ArXC6ABvU/PD4SHM0WWHbiCKu3WBG
         h1ac/JJsqfqn5IdXfK6u+BhZY1DZeoKjDMav9OLJv+A86ju8CDXLzU8jbDjdjlFQD03h
         dM2dfzCN4fObSmy+wfCCyJBRcX6L7ypdLSBywXmSNx7qi0lBuTH+li8apKmWPNk0EZng
         Ks9g==
X-Gm-Message-State: AOAM532MIsyzjOkU4ki761h48OSIY3nX1CslTbjIheNTTGobhwwPwAR2
        z+10MpjR6S0P01pJw+AMiNg=
X-Google-Smtp-Source: ABdhPJyXGo5bFUcnGA/XSzR+vrjEGErUUx35rDNvtOdIWeqMnDJOQft1K8jSpscIJb7ddKdfYetwkQ==
X-Received: by 2002:a9d:74c7:: with SMTP id a7mr12188597otl.42.1622318547849;
        Sat, 29 May 2021 13:02:27 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t39sm1868064ooi.42.2021.05.29.13.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 13:02:26 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v6 14/34] dyndbg: allow deleting site info via control interface
Date:   Sat, 29 May 2021 14:00:09 -0600
Message-Id: <20210529200029.205306-15-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210529200029.205306-1-jim.cromie@gmail.com>
References: <20210529200029.205306-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow users & subsystems to selectively delete callsite info for
pr-debug callsites.  Hopefully, this can lead to actual recovery of
memory.

DRM is a potential user which would drop the sites:

- has distinct categories for logging, and can map them over to a
  format prefix, like: "drm:core:", "drm:kms:", etc.

- are happy with group control of all the callsites in a class/cateory.
  individual control is still possible using queries including line numbers

- don't need dynamic "module:function:line:" prefixes in log messages

- don't care about loss of context in /proc/dynamic_debug/control

before:

init/initramfs.c:485 [initramfs]unpack_to_rootfs =_ "Detected %s compressed data\012"
init/main.c:1337 [main]run_init_process =pm "    %s\012"
init/main.c:1335 [main]run_init_process =pm "  with environment:\012"
init/main.c:1334 [main]run_init_process =pm "    %s\012"
init/main.c:1332 [main]run_init_process =pm "  with arguments:\012"
init/main.c:1121 [main]initcall_blacklisted =pm "initcall %s blacklisted\012"
init/main.c:1082 [main]initcall_blacklist =pm "blacklisting initcall %s\012"

then:
  bash-5.0# echo file init/main.c +D > /proc/dynamic_debug/control

after:

init/initramfs.c:485 [initramfs]unpack_to_rootfs =_ "Detected %s compressed data\012"
[main]:1337 =pmD "    %s\012"
[main]:1335 =pmD "  with environment:\012"
[main]:1334 =pmD "    %s\012"
[main]:1332 =pmD "  with arguments:\012"
[main]:1121 =pmD "initcall %s blacklisted\012"
[main]:1082 =pmD "blacklisting initcall %s\012"

Notes:

If Drm adopted dyndbg, i915 + drm* would add ~1600 prdebugs, amdgpu +
drm* would add ~3200 callsites, so the additional memory costs are
substantial.  In trade, drm and drivers would avoid lots of calls to
drm_debug_enabled().  This patch should reduce the costs.

Using this interface, drm could drop site info for all categories /
prefixes controlled by bits in drm.debug, while preserving site info
and individual selectivity for any uncategorized prdebugs, and for all
other modules.

Lastly, because lineno field was not moved into _ddebug_callsite, it
can be used to modify a single[*] callsite even if drm has dropped all
the callsite data:

  echo module $mod format ^$prefix line $line +p >control

Dropping site info is a one-way, information losing operation, so
minor misuse is possible.  Worst case is maybe (depending upon
previous settings) some loss of logging context/decorations.

  echo +D > /proc/dynamic_debug/control

[*] amdgpu has some macros invoking clusters of pr_debugs; each use of
them creates a cluster of pr-debugs with the same line number.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 1 +
 lib/dynamic_debug.c           | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 40ea086853ff..f789608ab935 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -40,6 +40,7 @@ struct _ddebug {
 #define _DPRINTK_FLAGS_INCL_FUNCNAME	(1<<2)
 #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
 #define _DPRINTK_FLAGS_INCL_TID		(1<<4)
+#define _DPRINTK_FLAGS_DELETE_SITE	(1<<7) /* drop site info to save ram */
 
 #define _DPRINTK_FLAGS_INCL_ANY		\
 	(_DPRINTK_FLAGS_INCL_MODNAME | _DPRINTK_FLAGS_INCL_FUNCNAME |\
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index ad7cda840733..a4cb048357fb 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -93,6 +93,7 @@ static struct { unsigned flag:8; char opt_char; } opt_array[] = {
 	{ _DPRINTK_FLAGS_INCL_LINENO, 'l' },
 	{ _DPRINTK_FLAGS_INCL_TID, 't' },
 	{ _DPRINTK_FLAGS_NONE, '_' },
+	{ _DPRINTK_FLAGS_DELETE_SITE, 'D' },
 };
 
 struct flagsbuf { char buf[ARRAY_SIZE(opt_array)+1]; };
@@ -202,6 +203,14 @@ static void ddebug_alter_site(struct _ddebug *dp,
 	} else if (modifiers->flags & _DPRINTK_FLAGS_PRINT)
 		static_branch_enable(&dp->key.dd_key_true);
 #endif
+	/* delete site info for this callsite */
+	if (modifiers->flags & _DPRINTK_FLAGS_DELETE_SITE) {
+		if (dp->site) {
+			vpr_info("dropping site info %s.%s.%d\n", dp->site->filename,
+				dp->site->function, dp->lineno);
+			dp->site = NULL;
+		}
+	}
 }
 
 /*
-- 
2.31.1

