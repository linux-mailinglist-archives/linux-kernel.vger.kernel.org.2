Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7539B3747FA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 20:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbhEES3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 14:29:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229901AbhEES31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 14:29:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B7DF6101B;
        Wed,  5 May 2021 18:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620239310;
        bh=eO2PNNSkyM/8nStiM+dmWAjzoFFUGeKqODOESPKXzZ0=;
        h=From:To:Cc:Subject:Date:From;
        b=bBkxESGst7chdBRluW3F1OZZIJLkrnb6h+3fScJ0UfxqffCzibDomBdt54x5lGiDe
         n5AGtLCsbrRK98106ySwwRvGSNw3ZKSvTS+aZswPcP71PuDNkkuaJDws0Zdleziqk3
         Cy9b5+s+yltCy8mAI20cMZU52xoe0dzlyqef1HfARwyuMgDXgdIrRESD9qRLLo3xBT
         CHbM/Cu+CXrXPtBQTZxMlA69NVEeffaCDbyD1TBvKcxXjY4qTGlI9MZ/z0LiQrpa1c
         RAkBli/lAJfFXqJZf8mmAScEce84XoBttRuGT9d2aJI2R3dl6jEM6RQZGX92kx48Ra
         PEpq9vuocjIwA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] fbmem: Correct position of '__maybe_unused' in proc_fb_seq_ops
Date:   Wed,  5 May 2021 11:28:08 -0700
Message-Id: <20210505182808.3855516-1-nathan@kernel.org>
X-Mailer: git-send-email 2.31.1.362.g311531c9de
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

 drivers/video/fbdev/core/fbmem.c:736:21: warning: attribute
 declaration must precede definition [-Wignored-attributes]
 static const struct __maybe_unused seq_operations proc_fb_seq_ops = {
                     ^
 ./include/linux/compiler_attributes.h:273:56: note: expanded from macro
 '__maybe_unused'
 #define __maybe_unused                  __attribute__((__unused__))
                                                        ^
 ./include/linux/seq_file.h:31:8: note: previous definition is here
 struct seq_operations {
        ^
 1 warning generated.

The attribute should not split the type 'struct seq_operations'. Move it
before the struct keyword so that it works properly and there is no more
warning.

Fixes: b9d79e4ca4ff ("fbmem: Mark proc_fb_seq_ops as __maybe_unused")
Link: https://github.com/ClangBuiltLinux/linux/issues/1371
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/video/fbdev/core/fbmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 52c606c0f8a2..84c484f37b4a 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -733,7 +733,7 @@ static int fb_seq_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static const struct __maybe_unused seq_operations proc_fb_seq_ops = {
+static const __maybe_unused struct seq_operations proc_fb_seq_ops = {
 	.start	= fb_seq_start,
 	.next	= fb_seq_next,
 	.stop	= fb_seq_stop,

base-commit: b9d79e4ca4ff23543d6b33c736ba07c1f0a9dcb1
-- 
2.31.1.362.g311531c9de

