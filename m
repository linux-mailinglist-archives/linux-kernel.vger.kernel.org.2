Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD1231F283
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 23:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhBRWt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 17:49:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:48708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhBRWtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 17:49:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 82CD164DFD;
        Thu, 18 Feb 2021 22:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613688545;
        bh=SGNPeiZEIHSwqt1VUZYZ9K9idlNdJU7dXBV+/C03bbc=;
        h=From:To:Cc:Subject:Date:From;
        b=qf72mZ0ibMde6JSaiwo3z9u0PSmey7GqBjkO/kHW63QNTDh5qTnC+v3pZM2cK8m53
         kci+DlNpoQSBrLdL9n+ve0IIHyu75/z4/3RDexTH0x6qtfCCACtJaV05iEd/Puw+LJ
         9JY6MSC2ke9p2aMSKoHNW6x3GJ7DWeakB3dZGBMk5eRbRqbqMIbYOMCuJdTLMZZHps
         +0kznePsP6inGcIO3y5s91gwIN9qnTyATqgCf/mMdWquxETo2RNlYOnY8gPgaJASSi
         boUX1t/+bTKj+pUBP3WNRdCxoGfudBGGt//XgihjphTVawJmKjRSEVhja34s0KlH8Y
         Jn+gBttahZe+A==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Kevin Wang <kevin1.wang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] drm/amd/pm/swsmu: Avoid using structure_size uninitialized in smu_cmn_init_soft_gpu_metrics
Date:   Thu, 18 Feb 2021 15:48:50 -0700
Message-Id: <20210218224849.5591-1-nathan@kernel.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c:764:2: warning:
variable 'structure_size' is used uninitialized whenever switch default
is taken [-Wsometimes-uninitialized]
        default:
        ^~~~~~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c:770:23: note:
uninitialized use occurs here
        memset(header, 0xFF, structure_size);
                             ^~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c:753:25: note:
initialize the variable 'structure_size' to silence this warning
        uint16_t structure_size;
                               ^
                                = 0
1 warning generated.

Return in the default case, as the size of the header will not be known.

Fixes: de4b7cd8cb87 ("drm/amd/pm/swsmu: unify the init soft gpu metrics function")
Link: https://github.com/ClangBuiltLinux/linux/issues/1304
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index bb620fdd4cd2..bcedd4d92e35 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -762,7 +762,7 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev)
 		structure_size = sizeof(struct gpu_metrics_v2_0);
 		break;
 	default:
-		break;
+		return;
 	}
 
 #undef METRICS_VERSION
-- 
2.30.1

