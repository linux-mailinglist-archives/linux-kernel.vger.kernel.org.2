Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0547944F37E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 14:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235864AbhKMOAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 09:00:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:39776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231672AbhKMOAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 09:00:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F1BCC60C41;
        Sat, 13 Nov 2021 13:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636811850;
        bh=0AtVhdkknb9GPuF56icg85mM7xQAkWdQJj8a8JDqWjA=;
        h=Date:From:To:Cc:Subject:From;
        b=RZRIOdjl5z3gc8V3uGhG6+Y86nX60FOrZBOco3P7Y8WwKgkCkGjzyYLNazciWzK3j
         4CX+kAAsi39iWCdnIOqfPOp1zy4S7mUp4VJPUqW/IWDCGvABxcs+1QXz1jYk2qS9zF
         9YfAzGfvNtO07rgN3jkE7A9buo+3hU8QOrhQgHVrFzVGCf+VNV/hvXRziiOr3DO8GR
         FYZi0bxgQfxWScxcWyS6rkwXIsEMIxMu1Ug6k9Xt0DhE0m43WlKKWvhb+wCXmeoZjC
         /3k2DH95IfCdilRVGELrJUVOKticXraJzXNAFkbpd9wAtFYk3Wy2Y63Ir9KSOOK6Qa
         u3PNoCS8pvSoA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 563EB410A2; Sat, 13 Nov 2021 10:57:27 -0300 (-03)
Date:   Sat, 13 Nov 2021 10:57:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     Borislav Petkov <bp@suse.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [FYI][PATCH 1/1] tools headers UAPI: Sync arch prctl headers with
 the kernel sources
Message-ID: <YY/ER104k852WOTK@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Nov 13, 2021 at 10:50:11AM -0300, Arnaldo Carvalho de Melo escreveu:
To pick the changes in this cset:

  db8268df0983adc2 ("x86/arch_prctl: Add controls for dynamic XSTATE components")

This picks these new prctls:

  $ tools/perf/trace/beauty/x86_arch_prctl.sh > /tmp/before
  $ cp arch/x86/include/uapi/asm/prctl.h tools/arch/x86/include/uapi/asm/prctl.h
  $ tools/perf/trace/beauty/x86_arch_prctl.sh > /tmp/after
  $ diff -u /tmp/before /tmp/after
  --- /tmp/before	2021-11-13 10:42:52.787308809 -0300
  +++ /tmp/after	2021-11-13 10:43:02.295558837 -0300
  @@ -6,6 +6,9 @@
   	[0x1004 - 0x1001]= "GET_GS",
   	[0x1011 - 0x1001]= "GET_CPUID",
   	[0x1012 - 0x1001]= "SET_CPUID",
  +	[0x1021 - 0x1001]= "GET_XCOMP_SUPP",
  +	[0x1022 - 0x1001]= "GET_XCOMP_PERM",
  +	[0x1023 - 0x1001]= "REQ_XCOMP_PERM",
   };

   #define x86_arch_prctl_codes_2_offset 0x2001
  $

With this 'perf trace' can translate those numbers into strings and use
the strings in filter expressions:

  # perf trace -e prctl
       0.000 ( 0.011 ms): DOM Worker/3722622 prctl(option: SET_NAME, arg2: 0x7f9c014b7df5)     = 0
       0.032 ( 0.002 ms): DOM Worker/3722622 prctl(option: SET_NAME, arg2: 0x7f9bb6b51580)     = 0
       5.452 ( 0.003 ms): StreamT~ns #30/3722623 prctl(option: SET_NAME, arg2: 0x7f9bdbdfeb70) = 0
       5.468 ( 0.002 ms): StreamT~ns #30/3722623 prctl(option: SET_NAME, arg2: 0x7f9bdbdfea70) = 0
      24.494 ( 0.009 ms): IndexedDB #556/3722624 prctl(option: SET_NAME, arg2: 0x7f562a32ae28) = 0
      24.540 ( 0.002 ms): IndexedDB #556/3722624 prctl(option: SET_NAME, arg2: 0x7f563c6d4b30) = 0
     670.281 ( 0.008 ms): systemd-userwo/3722339 prctl(option: SET_NAME, arg2: 0x564be30805c8) = 0
     670.293 ( 0.002 ms): systemd-userwo/3722339 prctl(option: SET_NAME, arg2: 0x564be30800f0) = 0
  ^C#

This addresses these perf build warnings:

  Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/prctl.h' differs from latest version at 'arch/x86/include/uapi/asm/prctl.h'
  diff -u tools/arch/x86/include/uapi/asm/prctl.h arch/x86/include/uapi/asm/prctl.h

Cc: Borislav Petkov <bp@suse.de>
Cc: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/uapi/asm/prctl.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/arch/x86/include/uapi/asm/prctl.h b/tools/arch/x86/include/uapi/asm/prctl.h
index 5a6aac9fa41f7b56..754a078568171451 100644
--- a/tools/arch/x86/include/uapi/asm/prctl.h
+++ b/tools/arch/x86/include/uapi/asm/prctl.h
@@ -10,6 +10,10 @@
 #define ARCH_GET_CPUID		0x1011
 #define ARCH_SET_CPUID		0x1012
 
+#define ARCH_GET_XCOMP_SUPP	0x1021
+#define ARCH_GET_XCOMP_PERM	0x1022
+#define ARCH_REQ_XCOMP_PERM	0x1023
+
 #define ARCH_MAP_VDSO_X32	0x2001
 #define ARCH_MAP_VDSO_32	0x2002
 #define ARCH_MAP_VDSO_64	0x2003
-- 
2.31.1
