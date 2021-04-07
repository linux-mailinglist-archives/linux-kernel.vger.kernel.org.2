Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF34357394
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhDGRwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:52:24 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:21371 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhDGRwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:52:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617817929; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=YrQgPTfY48iGzzVhb/GjqH7aT+xdZHhGl9cpqh8bNVU=;
 b=jqC7+7EIhHUuK7XyZFb8pM4SLkSnvCOKJWgVadJAMPN1QM6mGViByMIYZbZ+kuJF5YhQ9+6f
 yIyXquTL8ZvSJ3wvQahxLpgjVhoVa7ZyNfPpzIoJYgFYguPtP8tSIKYLjqCBYiXxCEhboWEG
 qNzhY71aZFI1dk6GyDkKtt3ReUc=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 606df13bfebcffa80f2a36d3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 07 Apr 2021 17:51:55
 GMT
Sender: abhinavk=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 922C9C43462; Wed,  7 Apr 2021 17:51:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: abhinavk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 706A9C433ED;
        Wed,  7 Apr 2021 17:51:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 07 Apr 2021 10:51:54 -0700
From:   abhinavk@codeaurora.org
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] drm/msm/dp: remove unused local variable 'hpd'
In-Reply-To: <20210407082315.2703-1-thunder.leizhen@huawei.com>
References: <20210407082315.2703-1-thunder.leizhen@huawei.com>
Message-ID: <38969a7640a5067a714fc87fb5aa7d3a@codeaurora.org>
X-Sender: abhinavk@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-04-07 01:23, Zhen Lei wrote:
> Fixes the following W=1 kernel build warning:
> 
> drivers/gpu/drm/msm/dp/dp_display.c: In function
> ‘dp_display_usbpd_attention_cb’:
> drivers/gpu/drm/msm/dp/dp_display.c:496:19: warning: variable ‘hpd’
> set but not used [-Wunused-but-set-variable]
> 
> Fixes: c58eb1b54fee ("drm/msm/dp: fix connect/disconnect handled at 
> irq_hpd")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Reviewed-by: Abhinav Kumar <abhinavk@codeaurora.org>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c
> b/drivers/gpu/drm/msm/dp/dp_display.c
> index 5a39da6e1eaf277..31bf2a40a9eb2c9 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -493,7 +493,6 @@ static int dp_display_usbpd_attention_cb(struct 
> device *dev)
>  	int rc = 0;
>  	u32 sink_request;
>  	struct dp_display_private *dp;
> -	struct dp_usbpd *hpd;
> 
>  	if (!dev) {
>  		DRM_ERROR("invalid dev\n");
> @@ -507,8 +506,6 @@ static int dp_display_usbpd_attention_cb(struct 
> device *dev)
>  		return -ENODEV;
>  	}
> 
> -	hpd = dp->usbpd;
> -
>  	/* check for any test request issued by sink */
>  	rc = dp_link_process_request(dp->link);
>  	if (!rc) {
