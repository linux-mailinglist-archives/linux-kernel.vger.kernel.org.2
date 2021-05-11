Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB22E37AEC0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbhEKSxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbhEKSwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:52:40 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA38C06138C
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:31 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id v13so18058069ilj.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vrCRdPvqXLwfcbFZbk4xQpB3sIke8Dnzk1UweHKnIBI=;
        b=dRr3KBsHvvPSrSla5VPoixzJBzTf66tdvr8gPMUovf9iq5F56zOW/lEq6odKFyTWLC
         oBmjsWdBBtCN1OvEj5/WAZdG6AG6FmazcEiQmkNPc2JO9l6eU/ZeX7+HJJXakfqPng8w
         JvJ8Cner1TYHinpJ7X3EPrqAPLIVAQWLTg6X2FbWTnvrcz41yUxGM1id+DAxGMAJURZw
         QiXknxxLJuW6gKOvfdMgHi2pVFvtFhNE/TpT8yM9LmxRYWa2O1O3yiQnMsurd5kjUMyG
         SWTXtuQhm2TphnRfSpw3e8/rbtqsfb2fW6L9KLxsnS+8RIvkUYosYCZ03D6wNDjix5S2
         IQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vrCRdPvqXLwfcbFZbk4xQpB3sIke8Dnzk1UweHKnIBI=;
        b=durhYuk30xzVMwEIVZV2QhmqD91N/dL+JxZGDFRJl4MAjeJ5uVsx8ZATjVOGVwI/g5
         kvF59RyEzgFiOycfU2JzlW0tQ8GJQyRHd5pYNBgkH0dPb8vRlHATEhVnOwOkqAyKVtOs
         Nr+oEr3LsKomMgruFsgnxwSmis2hdDvhAxfa8W9bJ7qWO3tyowx6rASFTxRI8vD7mODb
         Ip1P9l6moCbUQUghTULzNtdathZg/DwDUcHDXwAAytvf9qF+gXJGxJ6vzqI14svAq0V3
         mhgOyLBwtFfoWdHPoyUTBjVIzEIyy7CbH9q99azLessSTRcjLKakTAIgakX85JCmwtVP
         W2Jg==
X-Gm-Message-State: AOAM530wHR0ScNn9mKQRE4psC8a1diKBJpBb9cXF+QCeAlOm/q/1PLlF
        wKyLAiZKkDUkPK1GSGAwhzQy8i7LKj9JdA==
X-Google-Smtp-Source: ABdhPJzC3t6Smaaz6DordybL+mPFu1KmPHHpUWPJwrtzJBCyU8yCSfpMYbtaMuwiMQkDPdu1dkN//A==
X-Received: by 2002:a92:1a12:: with SMTP id a18mr27989630ila.168.1620759091205;
        Tue, 11 May 2021 11:51:31 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t10sm405096ils.36.2021.05.11.11.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:51:30 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v5 12/28] dyndbg: allow deleting site info via control interface
Date:   Tue, 11 May 2021 12:50:41 -0600
Message-Id: <20210511185057.3815777-13-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511185057.3815777-1-jim.cromie@gmail.com>
References: <20210511185057.3815777-1-jim.cromie@gmail.com>
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
index d56c02ed0c45..bc4e778b755c 100644
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
index a4ddafdbd9a1..76315d20672a 100644
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
2.31.1

