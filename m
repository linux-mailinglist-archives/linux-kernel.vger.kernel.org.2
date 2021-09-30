Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5508841DEAB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 18:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349592AbhI3QSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 12:18:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:46710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349614AbhI3QSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 12:18:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7CF261350;
        Thu, 30 Sep 2021 16:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633018612;
        bh=nCm24fdzKI9A0hhedzu8MKlkLPZNsO0zfw6Ufjqtw1s=;
        h=From:To:Cc:Subject:Date:From;
        b=SNYZDE4cB9ZKnXPiLID0J9mW0WYRHEnkyUwDKacOGjwGmflwsAzAcbT51bZgykUPx
         VtCGKIPqZFfkd/8SgC455IYJwlEeIETYi11AcHBWptBBQqcyq0Kbz1fAcaV7uj0beo
         W3mx3RD3QKnIdlDhSbAm+7RwFWT4G0szsB1eDW0GGe+JjkTo1AAt5BC/42cJLRSNga
         ramwKJB8eU/cbcFoqkkUTUNU4FmIdmQmvJDkS81UpvVDV4g6RbJGZ2xczI3VjofBmO
         O9Qn2kidIO+6b72r4hLtBPgX9KaAMRrG+WyD203dBA+tP3+Vto8P7RG4M2l8EI4vuE
         nEQ9hoaflfUSQ==
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
Subject: [PATCH] drm/amd: Initialize remove_mpcc in dcn201_update_mpcc()
Date:   Thu, 30 Sep 2021 09:16:42 -0700
Message-Id: <20210930161641.2333583-1-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0.591.gddb1055343
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_hwseq.c:505:6: error: variable 'remove_mpcc' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
        if (mpc->funcs->get_mpcc_for_dpp_from_secondary)
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_hwseq.c:509:6: note: uninitialized use occurs here
        if (remove_mpcc != NULL && mpc->funcs->remove_mpcc_from_secondary)
            ^~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_hwseq.c:505:2: note: remove the 'if' if its condition is always true
        if (mpc->funcs->get_mpcc_for_dpp_from_secondary)
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_hwseq.c:442:26: note: initialize the variable 'remove_mpcc' to silence this warning
        struct mpcc *remove_mpcc;
                                ^
                                 = NULL
1 error generated.

The code already handles remove_mpcc being NULL just fine so initialize
it to NULL at the beginning of the function so it is never used
uninitialized.

Fixes: ff7e396f822f ("drm/amd/display: add cyan_skillfish display support")
Link: https://github.com/ClangBuiltLinux/linux/issues/1469
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c
index ceaaeeb8f2de..cfd09b3f705e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c
@@ -439,7 +439,7 @@ void dcn201_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 	bool per_pixel_alpha = pipe_ctx->plane_state->per_pixel_alpha && pipe_ctx->bottom_pipe;
 	int mpcc_id, dpp_id;
 	struct mpcc *new_mpcc;
-	struct mpcc *remove_mpcc;
+	struct mpcc *remove_mpcc = NULL;
 	struct mpc *mpc = dc->res_pool->mpc;
 	struct mpc_tree *mpc_tree_params = &(pipe_ctx->stream_res.opp->mpc_tree_params);
 

base-commit: 30fc33064c846df29888c3c61e30a064aad3a342
-- 
2.33.0.591.gddb1055343

