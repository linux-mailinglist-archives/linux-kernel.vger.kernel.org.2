Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2132D44FF3D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 08:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhKOHfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 02:35:04 -0500
Received: from smtprelay0017.hostedemail.com ([216.40.44.17]:45014 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229718AbhKOHej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 02:34:39 -0500
Received: from omf02.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 50F488384376;
        Mon, 15 Nov 2021 07:31:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id 07A75B000181;
        Mon, 15 Nov 2021 07:31:33 +0000 (UTC)
Message-ID: <cfcae256344c5b83398944d5609e76d983ccbc1b.camel@perches.com>
Subject: Re: [PATCH] drm/amd/amdgpu: remove useless break after return
From:   Joe Perches <joe@perches.com>
To:     Bernard Zhao <bernard@vivo.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Evan Quan <evan.quan@amd.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 14 Nov 2021 23:31:34 -0800
In-Reply-To: <20211115071429.7314-1-bernard@vivo.com>
References: <20211115071429.7314-1-bernard@vivo.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 07A75B000181
X-Stat-Signature: rxw7ub9mqfb8pxrhxqznk9h8sctub7mm
X-Spam-Status: No, score=0.10
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/BMX1pM41Hx9u3dc67UGKg+oEXxIeNQNY=
X-HE-Tag: 1636961493-426773
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-11-14 at 23:14 -0800, Bernard Zhao wrote:
> This change is to remove useless break after return.
[]
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
[]
> @@ -2092,22 +2092,18 @@ static int dce_v8_0_pick_dig_encoder(struct drm_encoder *encoder)
>  			return 1;
>  		else
>  			return 0;
> -		break;
>  	case ENCODER_OBJECT_ID_INTERNAL_UNIPHY1:
>  		if (dig->linkb)
>  			return 3;
>  		else
>  			return 2;
> -		break;
>  	case ENCODER_OBJECT_ID_INTERNAL_UNIPHY2:
>  		if (dig->linkb)
>  			return 5;
>  		else
>  			return 4;
> -		break;
>  	case ENCODER_OBJECT_ID_INTERNAL_UNIPHY3:
>  		return 6;
> -		break;
>  	default:
>  		DRM_ERROR("invalid encoder_id: 0x%x\n", amdgpu_encoder->encoder_id);
>  		return 0;

Perhaps rewrite to make the sequential numbering more obvious.
---
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index b200b9e722d97..7307524b706b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -2088,26 +2088,13 @@ static int dce_v8_0_pick_dig_encoder(struct drm_encoder *encoder)
 
 	switch (amdgpu_encoder->encoder_id) {
 	case ENCODER_OBJECT_ID_INTERNAL_UNIPHY:
-		if (dig->linkb)
-			return 1;
-		else
-			return 0;
-		break;
+		return !dig->linkb ? 0 : 1;
 	case ENCODER_OBJECT_ID_INTERNAL_UNIPHY1:
-		if (dig->linkb)
-			return 3;
-		else
-			return 2;
-		break;
+		return !dig->linkb ? 2 : 3;
 	case ENCODER_OBJECT_ID_INTERNAL_UNIPHY2:
-		if (dig->linkb)
-			return 5;
-		else
-			return 4;
-		break;
+		return !dig->linkb ? 4 : 5;
 	case ENCODER_OBJECT_ID_INTERNAL_UNIPHY3:
 		return 6;
-		break;
 	default:
 		DRM_ERROR("invalid encoder_id: 0x%x\n", amdgpu_encoder->encoder_id);
 		return 0;


