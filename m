Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1EED38D113
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 00:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhEUWRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 18:17:42 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:57527 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230123AbhEUWRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 18:17:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621635339; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=XGg4XjJaanv9ZzeOXODhTUhbTYqAkq+3KJyFLjNKfFg=;
 b=xhSeBRspskKb33amIDvwoWbToG73/E497zm+80vhIkbPG2ZTW1oBVslesvIr/zoLBYd02zdK
 FFTPvFZQxsGD8C797TMJ1rvFaChdpNnhXICq6grCTgMbtJbnwSIecFZeVN2VXH6x8hD6aSLX
 M4k5WkloD2uwaOTJb5/zRpH1hUg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 60a830f07b5af81b5c5a44ff (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 21 May 2021 22:15:12
 GMT
Sender: khsieh=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 305B6C0729F; Fri, 21 May 2021 22:15:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: khsieh)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A90B6C43148;
        Fri, 21 May 2021 22:15:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 21 May 2021 15:15:09 -0700
From:   khsieh@codeaurora.org
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robdclark@gmail.com,
        sean@poorly.run, vkoul@kernel.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] drm/msm/dp: handle irq_hpd with sink_count = 0
 correctly
In-Reply-To: <CAE-0n53WW0jqorW2MPaTczmJP+d+_qaRBcwmoJBP2dL4x8_DqA@mail.gmail.com>
References: <1621455753-28966-1-git-send-email-khsieh@codeaurora.org>
 <CAE-0n53WW0jqorW2MPaTczmJP+d+_qaRBcwmoJBP2dL4x8_DqA@mail.gmail.com>
Message-ID: <1698de8065945746fb165cb7647548f7@codeaurora.org>
X-Sender: khsieh@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-05-21 14:56, Stephen Boyd wrote:
> Quoting Kuogee Hsieh (2021-05-19 13:22:33)
>> irq_hpd interrupt should be handled after dongle plugged in and
>> before dongle unplugged. Hence irq_hpd interrupt is enabled at
>> the end of the plugin handle and disabled at the beginning of
>> unplugged handle. Current irq_hpd with sink_count = 0 is wrongly
>> handled same as the dongle unplugged which tears down the mainlink
>> and disables the phy. This patch fixes this problem by only tearing
>> down the mainlink but keeping phy enabled at irq_hpd with
>> sink_count = 0 handle so that next irq_hpd with sink_count =1 can be
>> handled by setup mainlink only. This patch also set dongle into D3
>> (power off) state at end of handling irq_hpd with sink_count = 0.
>> 
>> Changes in v2:
>> -- add ctrl->phy_Power_count
>> 
>> Changes in v3:
>> -- del ctrl->phy_Power_count
>> -- add phy_power_off to dp_ctrl_off_link_stream()
>> 
>> Changes in v4:
>> -- return immediately if clock disable failed at 
>> dp_ctrl_off_link_stream()
>> 
>> Changes in v5:
>> -- set dongle to D3 (power off) state at dp_ctrl_off_link_stream()
>> 
>> Changes in v6:
>> -- add Fixes tag
>> 
>> Fixes: 94e58e2d06e3 ("drm/msm/dp: reset dp controller only at boot up 
>> and pm_resume")
>> 
>> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
>> ---
> 
> Tested-by: Stephen Boyd <swboyd@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> 
> We can resolve the lingering dual irq issue later on if you don't want
> to send another round of this. Also, the title says 1/2 so I wonder if
> there's another patch? Doesn't look like there is but I have to ask. If
> not, please generate patches with the right -<N> argument or revision
> range.
ok, thanks,
Sorry, the 2nd patch is the xlog debug patch.
I did not submit it.
