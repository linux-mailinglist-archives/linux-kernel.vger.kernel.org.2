Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0346C41DE4B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 18:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348002AbhI3QDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 12:03:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:43368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346745AbhI3QDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 12:03:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC71A61267;
        Thu, 30 Sep 2021 16:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633017722;
        bh=0+sb2XqH5BquPP7EjtdnYr/NxYIMmonry0L2K3JYAFo=;
        h=From:To:Cc:Subject:Date:From;
        b=tnqVKO6f7eLz2tpcuRDdCbw3uKJ9pnWBRYsHY3fEabEYitSik4nVI1i5qhZ2pTrT2
         knPSWujATtrB4RkrITDzAhDWSwvT6b4yORb+jJERgymY5ew+ej61QUcWzSAmI0fxsc
         DZpUgmX0LDW15rxFHYvo0NMd2PoWWKmwFARS4prSYnowHmSaH14Y1v6iddHhGRmvWt
         /cwqiAJ4WpR07zC0H4Y7krVUE6bvb9O1Vw36+mguqO5DGxY88G7KWjQj10lQ9KT6V2
         12S4/oGlFGpQx4aE9MQHj2BFxij3G+wSanDMk6ummf01Ft/KZA6/dT8Sa2Dw6G/Hfo
         gzrRn/wUwDKcA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] drm/amd: Guard IS_OLD_GCC assignment with CONFIG_CC_IS_GCC
Date:   Thu, 30 Sep 2021 09:01:42 -0700
Message-Id: <20210930160142.2301257-1-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0.591.gddb1055343
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cc-ifversion only works for GCC, as clang pretends to be GCC 4.2.1 for
glibc compatibility, which means IS_OLD_GCC will get set and unsupported
flags will be passed to clang when building certain code within the DCN
files:

clang-14: error: unknown argument: '-mpreferred-stack-boundary=4'
make[5]: *** [scripts/Makefile.build:277: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.o] Error 1

Guard the call to cc-ifversion with CONFIG_CC_IS_GCC so that everything
continues to work properly. See commit 00db297106e8 ("drm/amdgpu: fix stack
alignment ABI mismatch for GCC 7.1+") for more context.

Fixes: ff7e396f822f ("drm/amd/display: add cyan_skillfish display support")
Link: https://github.com/ClangBuiltLinux/linux/issues/1468
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn201/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
index d98d69705117..96cbd4ccd344 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
@@ -14,9 +14,11 @@ ifdef CONFIG_PPC64
 CFLAGS_$(AMDDALPATH)/dc/dcn201/dcn201_resource.o := -mhard-float -maltivec
 endif
 
+ifdef CONFIG_CC_IS_GCC
 ifeq ($(call cc-ifversion, -lt, 0701, y), y)
 IS_OLD_GCC = 1
 endif
+endif
 
 ifdef CONFIG_X86
 ifdef IS_OLD_GCC

base-commit: b47b99e30cca8906753c83205e8c6179045dd725
-- 
2.33.0.591.gddb1055343

