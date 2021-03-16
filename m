Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1022833CCF1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbhCPFJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235197AbhCPFIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:08:31 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C644AC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:08:30 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id v14so11529497ilj.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IFxUsc0/h40X/iJz/qz/uzE3jI8sBkcl6UajEO+XCIU=;
        b=jrxXaOR0thEgxYcYLPTzrSHMdG40Ux5MRZm4XoQFpWHYR2pBH2CQCu9ZlQpESTlpPb
         hBzeBixVvGrAbTw01SKNZtuQOsNWbmck0DOLIVW8tp/nC9qAfVFod1kihgBpPcZGxdMq
         PX9d64mCeMp0w7NLR3BqZFuRYNMYAbdDnkntuMulq5orntrS2Z++b4ezky9c0I35nzES
         v2wu4az4JS8uVOcBpAbGUydKH4T25470j5doHN0GOKiqxSyMvXLEu78mObj2fP/hBPv6
         mx6y7O9yEosqsmI/XxkC1qxoaeGF40tN4zEaSJcDD8c2Qo/byMlNxcUBztoEyF6TwIH7
         yJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IFxUsc0/h40X/iJz/qz/uzE3jI8sBkcl6UajEO+XCIU=;
        b=iv30fGkeKqeua0B17mszVUgMdVDx2Eo3BQSwU/ITVea8BbS55eXTODCoh1rJ4sqLAB
         H03YY4abStC4SozGUlDqtFP1SyqBCFuYFlWiM/JtvMzqILmoDU8TJbLPw3HTPCFt0wE/
         fzE9c1wFUKkE7XBRAba9F4aw4V3kXT/IQniALbIVINR1XePbtFPPwFjkqYE9qNaVSUqu
         v/hMCuSfSpGrTb8vyxYml3/vVE7ZQx9JP2Sud7PUIxQrAdxU9w3H5sJCwo4zDCfXMd2V
         nn2JDZGTX0cf/6vMaOs+Tu04mB1ZYg583gnS54pl2AZR+2pcKcWBT1As2i7sExOBXTGU
         S3SA==
X-Gm-Message-State: AOAM530h300uUdKiH3UPKa9x2rKl9N3LBGt6aCnr1wIijJ0j6TD9L/7W
        hyqL3COVrCyX8jViOlCEx1k=
X-Google-Smtp-Source: ABdhPJzXw4jsyQHKLUxaynbzqwS5vH133RZJOxD02owmM2uV+KwP+euCOUHk9cJ9BPGl4v+Ji3sumw==
X-Received: by 2002:a92:cccb:: with SMTP id u11mr2362600ilq.44.1615871310240;
        Mon, 15 Mar 2021 22:08:30 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y9sm8587469ill.15.2021.03.15.22.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 22:08:29 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v3 12/18] dyndbg: allow deleting site info via control interface
Date:   Mon, 15 Mar 2021 23:07:55 -0600
Message-Id: <20210316050801.2446401-13-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210316050801.2446401-1-jim.cromie@gmail.com>
References: <20210316050801.2446401-1-jim.cromie@gmail.com>
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
index aa4a3f5d8d35..d811273c8484 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -40,6 +40,7 @@ struct _ddebug {
 #define _DPRINTK_FLAGS_INCL_FUNCNAME	(1<<2)
 #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
 #define _DPRINTK_FLAGS_INCL_TID		(1<<4)
+#define _DPRINTK_FLAGS_DELETE_SITE	(1<<7) /* drop site info to save ram */
 
 #define _DPRINTK_FLAGS_INCL_ANYSITE		\
 	(_DPRINTK_FLAGS_INCL_MODNAME		\
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 6fbd9099c2fa..fdc2d0e15731 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -92,6 +92,7 @@ static struct { unsigned flag:8; char opt_char; } opt_array[] = {
 	{ _DPRINTK_FLAGS_INCL_LINENO, 'l' },
 	{ _DPRINTK_FLAGS_INCL_TID, 't' },
 	{ _DPRINTK_FLAGS_NONE, '_' },
+	{ _DPRINTK_FLAGS_DELETE_SITE, 'D' },
 };
 
 struct flagsbuf { char buf[ARRAY_SIZE(opt_array)+1]; };
@@ -201,6 +202,14 @@ static void ddebug_alter_site(struct _ddebug *dp,
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
2.29.2

