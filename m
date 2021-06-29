Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C010F3B6BBC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 02:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhF2Aec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 20:34:32 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:44004 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbhF2Aea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 20:34:30 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624926723; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=XXeaGfryzqs7lXB7YGEwtxfK7Ym2WqEHAXJXur+jmUE=;
 b=DKVQWDzQzMtV/55PIMHlDJ6Q7H371S3XxOlqbgdgpTMZcJkPC0TGzAfsApzIYcuQWAwcIBIo
 L2S7oQs0NaOBDBW6KthqHTBoW8BsCnkjHCxjEl6Az4djSOghQ1nKY7JpLuqpFXBEdD+qTv4d
 7778tKgDwGpAQmEmLrJR9yTe6OE=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 60da69ecc4cc543602a4a3d2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 29 Jun 2021 00:31:40
 GMT
Sender: abhinavk=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3D45EC4323A; Tue, 29 Jun 2021 00:31:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: abhinavk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3B30DC433F1;
        Tue, 29 Jun 2021 00:31:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 28 Jun 2021 17:31:39 -0700
From:   abhinavk@codeaurora.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dp: Make it possible to enable the test pattern
In-Reply-To: <20210629002234.1787149-1-bjorn.andersson@linaro.org>
References: <20210629002234.1787149-1-bjorn.andersson@linaro.org>
Message-ID: <b3456d3e4376ae1e9776f03e14513a35@codeaurora.org>
X-Sender: abhinavk@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn

On 2021-06-28 17:22, Bjorn Andersson wrote:
> The debugfs interface contains the knobs to make the DisplayPort
> controller output a test pattern, unfortunately there's nothing
> currently that actually enables the defined test pattern.
> 
> Fixes: de3ee25473ba ("drm/msm/dp: add debugfs nodes for video pattern 
> tests")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

This is not how this debugfs node works. This is meant to be used while 
running
DP compliance video pattern test.

https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/tools/msm_dp_compliance.c

While the compliance test is being run with this msm_dp_compliance app 
running,
it will draw the test pattern when it gets the "test_active" from the 
driver.

The test pattern which this app draws is as per the requirements of the 
compliance test
as the test equipment will match the CRC of the pattern which is drawn.

The API dp_panel_tpg_config() which you are trying to call here draws 
the DP test pattern
from the DP controller hardware but not the pattern which the compliance 
test expects.

Its just a debug API to call when required during bringup/debug 
purposes.

Hence this is not the place to call it as it will end up breaking CTS.

Thanks

Abhinav

> ---
>  drivers/gpu/drm/msm/dp/dp_debug.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_debug.c
> b/drivers/gpu/drm/msm/dp/dp_debug.c
> index 2f6247e80e9d..82911af44905 100644
> --- a/drivers/gpu/drm/msm/dp/dp_debug.c
> +++ b/drivers/gpu/drm/msm/dp/dp_debug.c
> @@ -305,6 +305,8 @@ static ssize_t dp_test_active_write(struct file 
> *file,
>  				debug->panel->video_test = true;
>  			else
>  				debug->panel->video_test = false;
> +
> +			dp_panel_tpg_config(debug->panel, debug->panel->video_test);
>  		}
>  	}
>  	drm_connector_list_iter_end(&conn_iter);
