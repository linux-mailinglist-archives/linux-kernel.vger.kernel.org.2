Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E427F3991AD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 19:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhFBRb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 13:31:27 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:54936 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230054AbhFBRb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 13:31:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622654982; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=rWyDRLYvTj153Y6LMqrDm4b5DQDQp0JKt+VaaEm4PFg=;
 b=TDCgVFmbk7a1S/UQMoSLRm6R3itS43K0G6NG5oOg5xu27X3gkS4LaHxB3mNfLv8EgcEmZQbq
 rvTHmJ/4EMP8U8NzgJ8KcL9TYn4o2awwK4E/qRjm7s5CWmVas43caHIJ9iJWGHQq3xkWgY//
 GJ6NeXefRmaAIqpdME5bVwdbIgc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60b7c0062eaeb98b5e616955 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Jun 2021 17:29:42
 GMT
Sender: abhinavk=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 01F56C4338A; Wed,  2 Jun 2021 17:29:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: abhinavk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 888C3C433F1;
        Wed,  2 Jun 2021 17:29:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 02 Jun 2021 10:29:41 -0700
From:   abhinavk@codeaurora.org
To:     Lee Jones <lee.jones@linaro.org>
Cc:     freedreno@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>
Subject: Re: [Freedreno] [RESEND 11/26] drm/msm/disp/dpu1/dpu_plane: Fix a
 couple of naming issues
In-Reply-To: <20210602143300.2330146-12-lee.jones@linaro.org>
References: <20210602143300.2330146-1-lee.jones@linaro.org>
 <20210602143300.2330146-12-lee.jones@linaro.org>
Message-ID: <686bffdf7fd5cb5dcec7155559a74258@codeaurora.org>
X-Sender: abhinavk@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-02 07:32, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c:373: warning: expecting
> prototype for _dpu_plane_set_panic_lut(). Prototype was for
> _dpu_plane_set_danger_lut() instead
>  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c:498: warning: expecting
> prototype for _dpu_plane_set_vbif_qos(). Prototype was for
> _dpu_plane_set_qos_remap() instead
> 
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: freedreno@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Abhinav Kumar <abhinavk@codeaurora.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> index 7a993547eb751..ed05a7ab58f53 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> @@ -364,7 +364,7 @@ static void _dpu_plane_set_qos_lut(struct drm_plane 
> *plane,
>  }
> 
>  /**
> - * _dpu_plane_set_panic_lut - set danger/safe LUT of the given plane
> + * _dpu_plane_set_danger_lut - set danger/safe LUT of the given plane
>   * @plane:		Pointer to drm plane
>   * @fb:			Pointer to framebuffer associated with the given plane
>   */
> @@ -491,7 +491,7 @@ static void _dpu_plane_set_ot_limit(struct 
> drm_plane *plane,
>  }
> 
>  /**
> - * _dpu_plane_set_vbif_qos - set vbif QoS for the given plane
> + * _dpu_plane_set_qos_remap - set vbif QoS for the given plane
>   * @plane:		Pointer to drm plane
>   */
>  static void _dpu_plane_set_qos_remap(struct drm_plane *plane)
