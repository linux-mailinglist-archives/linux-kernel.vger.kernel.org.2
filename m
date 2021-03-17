Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B5A33F735
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 18:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbhCQRhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 13:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbhCQRgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 13:36:48 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB4EC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 10:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=M1xeYmGKBJ6jj7ewaYpCNZMnUhqNoOaDnwmcpBB6Ipw=; b=eitn96kY7ksBTtF2NO8KNdOf65
        WmGjefSOr0x1ADE2l28kKACyXUPBJevfltnkJ36x99d74ggXuSqp+doZYpkGXQWjNwWMrTF8n3jrP
        eFntoWG8X8xNiQ8Bq9q0vq4NQlrWf29SMLUoKyqBYxq6bLGYbQUEfie3QPmOxl0sHBUUUnB6VpkEd
        5XSm8luLy5V43JVoJ+axOwM3Do0NKb7YuGluwnCppP7ziU0qlqgCEKctngZgKohVuDCVAdCYMO1zT
        w25BxMPRusIuB1Xh1HYcRBAtv2SIfskyI4lmFr4JtubN4F2peUM7cGDSLMkaSH6OIgsNO2GWcuB//
        JU4nI5oQ==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMa69-001fXK-2i; Wed, 17 Mar 2021 17:36:45 +0000
Subject: Re: [PATCH] gpu: drm: Rudimentary typo fix in the file drm_drv.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210317085210.3788782-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2296de34-e9d3-e520-34df-db6f520762ef@infradead.org>
Date:   Wed, 17 Mar 2021 10:36:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210317085210.3788782-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/21 1:52 AM, Bhaskar Chowdhury wrote:
> 
> s/refence-count/reference-count/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  drivers/gpu/drm/drm_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 20d22e41d7ce..2bfc724e8e41 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -203,7 +203,7 @@ static void drm_minor_unregister(struct drm_device *dev, unsigned int type)
> 
>  /*
>   * Looks up the given minor-ID and returns the respective DRM-minor object. The
> - * refence-count of the underlying device is increased so you must release this
> + * reference-count of the underlying device is increased so you must release this
>   * object with drm_minor_release().
>   *
>   * As long as you hold this minor, it is guaranteed that the object and the
> --


-- 
~Randy

