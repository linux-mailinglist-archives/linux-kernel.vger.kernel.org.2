Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AF139B1C9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 07:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhFDFGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 01:06:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229490AbhFDFGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 01:06:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 13F0C61159;
        Fri,  4 Jun 2021 05:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622783103;
        bh=Mb1ozeywktabS+f+cp0NBBM7yBN1fp+yu/m+y6URUIw=;
        h=Date:From:To:Cc:Subject:From;
        b=VWOVDaljlrLSw5RF+zKgJ8gD9QiprK/kp8XAfiY/b46L2+zvyONW1JlUJz4skQ/Cm
         sudPJhRww0BnbDrjcR8q0TDsGg5giFVnvK33YJSiyEdNtSdPddCCNIsJwfwjzsYNUs
         fVukU+l/yVJWJpTHU/i3nuJSZg1hQX1AEBQ9FqiG3pz002TXD3Yl+dlcXl7BjxolZK
         ZJT7vfNHlVayYB0fpItD1f9fOyJR3S/nA7U6cWTcKaHhA02+YmmcPHoaxtxJ5sBM0X
         wcxsNTV2x3yWqo26AmGxW92l3HLt3EYnA1SPnAn3dgF52iIOm/AfRWnJTipojH9whG
         ejUSHMiZC2DWg==
Date:   Fri, 4 Jun 2021 00:06:13 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: [PATCH][next] drm/amd/pm: Fix fall-through warning for Clang
Message-ID: <20210604050613.GA240889@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a break statement instead of letting the code fall
through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
JFYI: We had thousands of these sorts of warnings and now we are down
      to just 22 in linux-next. This is one of those last remaining
      warnings. :)

 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index 8f71f6a4bb49..43c3f6e755e7 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -831,6 +831,7 @@ static int smu10_dpm_force_dpm_level(struct pp_hwmgr *hwmgr,
 		break;
 	case AMD_DPM_FORCED_LEVEL_MANUAL:
 		data->fine_grain_enabled = 1;
+		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
 	default:
 		break;
-- 
2.27.0

