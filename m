Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2FE6336DF2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 09:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhCKIjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 03:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbhCKIjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 03:39:24 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28255C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 00:39:24 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id y13so10574831pfr.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 00:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7okIhdvDzfeqbdsdHHZ/SSKfCzFnovt5NwmOsmMe63Y=;
        b=GSFD/NWC/G5Tzys2ROvKlEtSr/y4GPOw8htx0NZOA7E8I9FPn41CRB0rdwnd/B3Ng+
         6zeep7LBLaFzTzWAMdwIjbz6tm1Kp1Aj5kwIYb4MbYSZugYz3CBoCaGgIPZtilOic0Ym
         CHLKqIGMd38UATAXSira9gUsas7Ti5e+6UyP9f/RxjBCMpEcPD/UURobfGxN3OAHPg60
         ZKs3ZrAZ52Z1GXEVz2nLOKsoZxYmJgGowTil1v5D32aTt0ng5KpeFUWGh54Q4YRXc3g6
         SPHKZmd9Ukno6gg8KY+yCXIlGA8ydC+0KZu6gttUX2+NxSa1+ySAepJlUvFh780BH5WN
         Tdnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7okIhdvDzfeqbdsdHHZ/SSKfCzFnovt5NwmOsmMe63Y=;
        b=QRqZXvRop4hdVeESYKdzlyU7EpnGEO/h70c9nY/lqh++c7DA8qTCcM4+IEeB3OMk2S
         BLSBQJTSGFSqQHAmdIUJzFPD7snsqyKT+4/Hi8I3wmMe+KqRXXB9GPlKuXqhDlaNkXIO
         m2kXT/Pu1HQnAu65Je77Yu/3gLZaTRP18jRlyuD8276iFO6/ds0+yh+d65pE3yW+q32/
         1cFasmh/c4N2vNRcB8tdvbxlK8Be34WTw1JZ4vNTf5OSpt2ViyXBLozHmj/5g23NubO/
         J1v/HhS+KLBe+bqFpBSD+fS+VTVnslwpeG0mqMVRpMVLES1Us9RGlpOUCVIVeP3l7HDa
         qqlg==
X-Gm-Message-State: AOAM532t/WUVvpaLl4lhsKpC6WbRBG+/jPKzrcRvIMPJ+UrKeZwuQEvy
        A4ItL6boyHbtW/CMSIeIlO8=
X-Google-Smtp-Source: ABdhPJxIO3gpf+kSNnn7hUI/vRvmOKQW3e56B41duHnzN7CYh/eTI4kENgTFFoZKxXymVeZ8Pi5QNQ==
X-Received: by 2002:a62:3085:0:b029:1ec:a570:682c with SMTP id w127-20020a6230850000b02901eca570682cmr6735981pfw.28.1615451963792;
        Thu, 11 Mar 2021 00:39:23 -0800 (PST)
Received: from localhost ([98.126.155.250])
        by smtp.gmail.com with ESMTPSA id u17sm1625480pgl.80.2021.03.11.00.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 00:39:23 -0800 (PST)
From:   Cao jin <jojing64@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        Cao jin <jojing64@gmail.com>
Subject: [PATCH] x86/brk: Drop RESERVE_BRK_ARRAY()
Date:   Thu, 11 Mar 2021 16:39:19 +0800
Message-Id: <20210311083919.27530-1-jojing64@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since a13f2ef168cb ("x86/xen: remove 32-bit Xen PV guest support"),
RESERVE_BRK_ARRAY() has no user anymore, let's drop it.

Update related comments too.

Signed-off-by: Cao jin <jojing64@gmail.com>
---
 arch/x86/include/asm/setup.h | 5 -----
 arch/x86/kernel/setup.c      | 6 +++---
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index 389d851a02c4..a12458a7a8d4 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -130,11 +130,6 @@ void *extend_brk(size_t size, size_t align);
 			: : "i" (sz));					\
 	}
 
-/* Helper for reserving space for arrays of things */
-#define RESERVE_BRK_ARRAY(type, name, entries)		\
-	type *name;					\
-	RESERVE_BRK(name, sizeof(type) * entries)
-
 extern void probe_roms(void);
 #ifdef __i386__
 
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 740f3bdb3f61..3af27bf1f837 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -66,7 +66,7 @@ RESERVE_BRK(dmi_alloc, 65536);
 
 /*
  * Range of the BSS area. The size of the BSS area is determined
- * at link time, with RESERVE_BRK*() facility reserving additional
+ * at link time, with RESERVE_BRK() facility reserving additional
  * chunks.
  */
 unsigned long _brk_start = (unsigned long)__brk_base;
@@ -1039,8 +1039,8 @@ void __init setup_arch(char **cmdline_p)
 
 	/*
 	 * Need to conclude brk, before e820__memblock_setup()
-	 *  it could use memblock_find_in_range, could overlap with
-	 *  brk area.
+	 * it could use memblock_find_in_range, could overlap with
+	 * brk area.
 	 */
 	reserve_brk();
 
-- 
2.29.2

