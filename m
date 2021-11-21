Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98AC3458343
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 13:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238172AbhKUMVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 07:21:34 -0500
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:59161 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238114AbhKUMVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 07:21:33 -0500
Received: from [192.168.1.18] ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id olnZmM9iGMxZuolnamk7Oo; Sun, 21 Nov 2021 13:18:27 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 21 Nov 2021 13:18:27 +0100
X-ME-IP: 86.243.171.122
Subject: Re: [PATCH linux-next] drm/i915/request: Remove unused variables
To:     cgel.zte@gmail.com, jani.nikula@linux.intel.com
Cc:     joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        yong yiran <yong.yiran@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20211121101309.23577-1-yong.yiran@zte.com.cn>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <80173779-5c91-a56e-6bac-ad4ff7c435f7@wanadoo.fr>
Date:   Sun, 21 Nov 2021 13:18:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211121101309.23577-1-yong.yiran@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 21/11/2021 à 11:13, cgel.zte@gmail.com a écrit :
> From: yong yiran <yong.yiran@zte.com.cn>
> 
> The clang_analyzer complains as follows:
> drivers/gpu/drm/i915/i915_request.c:2119:2 warning:
> Value stored to 'x' is never read
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: yong yiran <yong.yiran@zte.com.cn>
> ---
>   drivers/gpu/drm/i915/i915_request.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
> index 820a1f38b271..5e4420f461e9 100644
> --- a/drivers/gpu/drm/i915/i915_request.c
> +++ b/drivers/gpu/drm/i915/i915_request.c
> @@ -2047,7 +2047,6 @@ void i915_request_show(struct drm_printer *m,
>   {
>   	const char *name = rq->fence.ops->get_timeline_name((struct dma_fence *)&rq->fence);
>   	char buf[80] = "";
> -	int x = 0;
>   
>   	/*
>   	 * The prefix is used to show the queue status, for which we use
> @@ -2079,8 +2078,6 @@ void i915_request_show(struct drm_printer *m,
>   	 *      from the lists
>   	 */
>   
> -	x = print_sched_attr(&rq->sched.attr, buf, x, sizeof(buf));
> -

Seriously?

CJ


>   	drm_printf(m, "%s%.*s%c %llx:%lld%s%s %s @ %dms: %s\n",
>   		   prefix, indent, "                ",
>   		   queue_status(rq),
> 

