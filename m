Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B0741DEE6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 18:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350358AbhI3QZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 12:25:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349659AbhI3QZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 12:25:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B0D3C61139;
        Thu, 30 Sep 2021 16:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633019028;
        bh=SFAuczdPhuuWJXLs0XfQ/hIiVtLdDPdd1uYoA5KobTw=;
        h=From:To:Cc:Subject:Date:From;
        b=t630z/tBR0JsvcDkaupuV6XlaWMEW+/eHqaJUiVwvD83oi7YkijX9RN+M1o+yJ5bG
         ziAJANnhmGQaXAlrigMwECfvl+E9hk/uV6sqO8EagLzYN60qIWNFQ93rdFJ2lds7Hj
         IssDWkkngoQgSVTzeAD3bej+vrLPM07TcDfCAQXipkOodUXqcr291Kb1ey0tMx/wJP
         f4ezOH2JT6+OFB/UnDhnrjrSQgVQYC+a8hsRKvcJfA84QvvxjTR2TNYM4no4CBPYgw
         xDjFVdXShUZSH8x1Wgs2bLHhMOZCPy/rcg1bBSPq+H+FOo4ZLPokMw28p6//9WZfMN
         C447b766TxUdQ==
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
Subject: [PATCH] drm/amd: Return NULL instead of false in dcn201_acquire_idle_pipe_for_layer()
Date:   Thu, 30 Sep 2021 09:23:03 -0700
Message-Id: <20210930162302.2344542-1-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0.591.gddb1055343
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:1017:10: error: expression which evaluates to zero treated as a null pointer constant of type 'struct pipe_ctx *' [-Werror,-Wnon-literal-null-conversion]
                return false;
                       ^~~~~
1 error generated.

Use NULL instead of false since the function is returning a pointer
rather than a boolean.

Fixes: ff7e396f822f ("drm/amd/display: add cyan_skillfish display support")
Link: https://github.com/ClangBuiltLinux/linux/issues/1470
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
index aec276e1db65..8523a048e6f6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
@@ -1014,7 +1014,7 @@ static struct pipe_ctx *dcn201_acquire_idle_pipe_for_layer(
 		ASSERT(0);
 
 	if (!idle_pipe)
-		return false;
+		return NULL;
 
 	idle_pipe->stream = head_pipe->stream;
 	idle_pipe->stream_res.tg = head_pipe->stream_res.tg;

base-commit: b47b99e30cca8906753c83205e8c6179045dd725
-- 
2.33.0.591.gddb1055343

