Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1684154FC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 03:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238768AbhIWBHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 21:07:48 -0400
Received: from iodev.co.uk ([46.30.189.100]:36328 "EHLO iodev.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237852AbhIWBHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 21:07:47 -0400
X-Greylist: delayed 530 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Sep 2021 21:07:46 EDT
Received: from localhost (188.red-79-147-55.dynamicip.rima-tde.net [79.147.55.188])
        by iodev.co.uk (Postfix) with ESMTPSA id 7991C59135;
        Thu, 23 Sep 2021 02:57:24 +0200 (CEST)
From:   Ismael Luceno <ismael@iodev.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ismael Luceno <ismael@iodev.co.uk>
Subject: [PATCH] uapi: Fix undefined __always_inline on non-glibc systems
Date:   Thu, 23 Sep 2021 02:57:06 +0200
Message-Id: <20210923005706.1368-1-ismael@iodev.co.uk>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This macro is defined by glibc itself, which makes the issue go unnoticed on
those systems.  On non-glibc systems it causes build failures on several
utilities and libraries, like bpftool and objtool.

Fixes: 1d509f2a6ebc ("x86/insn: Support big endian cross-compiles")
Fixes: 2d7ce0e8a704 ("tools/virtio: more stubs")
Fixes: 3fb321fde22d ("selftests/net: ipv6 flowlabel")
Fixes: 50b3ed57dee9 ("selftests/bpf: test bpf flow dissection")
Fixes: 9cacf81f8161 ("bpf: Remove extra lock_sock for TCP_ZEROCOPY_RECEIVE")
Fixes: a4b2061242ec ("tools include uapi: Grab a copy of linux/in.h")
Fixes: b12d6ec09730 ("bpf: btf: add btf print functionality")
Fixes: c0dd967818a2 ("tools, include: Grab a copy of linux/erspan.h")
Fixes: c4b6014e8bb0 ("tools: Add copy of perf_event.h to tools/include/linux/")

Signed-off-by: Ismael Luceno <ismael@iodev.co.uk>
---
 include/uapi/linux/byteorder/big_endian.h    | 1 +
 include/uapi/linux/byteorder/little_endian.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/uapi/linux/byteorder/big_endian.h b/include/uapi/linux/byteorder/big_endian.h
index 2199adc6a6c2..80aa5c41a763 100644
--- a/include/uapi/linux/byteorder/big_endian.h
+++ b/include/uapi/linux/byteorder/big_endian.h
@@ -9,6 +9,7 @@ #define __BIG_ENDIAN 4321
 #define __BIG_ENDIAN_BITFIELD
 #endif
 
+#include <linux/stddef.h>
 #include <linux/types.h>
 #include <linux/swab.h>
 
diff --git a/include/uapi/linux/byteorder/little_endian.h b/include/uapi/linux/byteorder/little_endian.h
index 601c904fd5cd..cd98982e7523 100644
--- a/include/uapi/linux/byteorder/little_endian.h
+++ b/include/uapi/linux/byteorder/little_endian.h
@@ -9,6 +9,7 @@ #define __LITTLE_ENDIAN 1234
 #define __LITTLE_ENDIAN_BITFIELD
 #endif
 
+#include <linux/stddef.h>
 #include <linux/types.h>
 #include <linux/swab.h>
 
-- 
2.33.0

