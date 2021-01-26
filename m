Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5E8304FE9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236402AbhA0DeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:34:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:46504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727992AbhAZV2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 16:28:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25982204EF;
        Tue, 26 Jan 2021 21:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611696464;
        bh=fa4EdQCB1j6I4oHeFH8GkkOIEFDNCsjvkpTBxa3GXX0=;
        h=From:To:Cc:Subject:Date:From;
        b=TOjwruSnZZnHiGbREjXb0H2YDJK6pg6zCmxjw9baYEQFKJxOcZP3r8ssEA+ywnKM7
         kvBkrAwf47tX01ICtbKtqvarJDBKLHKw78a7/CXs32zuJWvODPKZR+7x6n5/fITfhK
         J7raM8kvUJ7Gv7iXryoRxQpfrRL1VNCnOSRsTMAwASTQTc/omsORAmPCl1eSSzD0bf
         hHSePODqPJSci+3sBaTmBaRCOqywscsKTOyoJ0WA9pn5EnbuaK/3dPcQ8Hv5VEnyuF
         vhowtN1usQ+LlMwP9iEbWPyWtb77xgsRhT4JIxHAJ/4wv7FeBquDsh662jJXLcYgVh
         7ZzH5H6g0DDqA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] MAINTAINERS/.mailmap: Use my @kernel.org address
Date:   Tue, 26 Jan 2021 14:27:30 -0700
Message-Id: <20210126212730.2097108-1-nathan@kernel.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use my @kernel.org for all points of contact so that I am always
accessible.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index b1ab0129c7d6..b25a44ab5ba6 100644
--- a/.mailmap
+++ b/.mailmap
@@ -247,6 +247,7 @@ Morten Welinder <welinder@anemone.rentec.com>
 Morten Welinder <welinder@darter.rentec.com>
 Morten Welinder <welinder@troll.com>
 Mythri P K <mythripk@ti.com>
+Nathan Chancellor <nathan@kernel.org> <natechancellor@gmail.com>
 Nguyen Anh Quynh <aquynh@gmail.com>
 Nicolas Ferre <nicolas.ferre@microchip.com> <nicolas.ferre@atmel.com>
 Nicolas Pitre <nico@fluxnic.net> <nicolas.pitre@linaro.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index 992fe3b0900a..f9a360103daa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4303,7 +4303,7 @@ S:	Maintained
 F:	.clang-format
 
 CLANG/LLVM BUILD SUPPORT
-M:	Nathan Chancellor <natechancellor@gmail.com>
+M:	Nathan Chancellor <nathan@kernel.org>
 M:	Nick Desaulniers <ndesaulniers@google.com>
 L:	clang-built-linux@googlegroups.com
 S:	Supported

base-commit: f8ad8187c3b536ee2b10502a8340c014204a1af0
-- 
2.30.0

