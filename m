Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBB63B6BF0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 03:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbhF2BKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 21:10:11 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:19560 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbhF2BKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 21:10:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624928863; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=DniW7efyyS7ES8PwQW5VveHX361k3FnVCGW5YegW91I=;
 b=uKEBlDReudJ4oGWOvZnNYOuVnyG0/qZwyQkCKayjQXsai0bg3Bc+uZo8e2XKbEIrHHWEKbHJ
 oy0bDP2TUftEp4I2fs+fKTtjxMv7Lfm02Rf5BpZAS/ahPx2wr4KvbL1xOO356NR4CWYf7YG1
 hlyF/G3TpCQXQqnyLEAm5zx9UZ8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 60da725e5e3e57240baac884 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 29 Jun 2021 01:07:42
 GMT
Sender: abhinavk=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D57E2C43217; Tue, 29 Jun 2021 01:07:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: abhinavk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7597BC433D3;
        Tue, 29 Jun 2021 01:07:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 28 Jun 2021 18:07:39 -0700
From:   abhinavk@codeaurora.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dp: Make it possible to enable the test pattern
In-Reply-To: <YNpvf8rpWoMFTcBt@yoga>
References: <20210629002234.1787149-1-bjorn.andersson@linaro.org>
 <b3456d3e4376ae1e9776f03e14513a35@codeaurora.org> <YNpvf8rpWoMFTcBt@yoga>
Message-ID: <2d922441927d1c2a757b5b197f496906@codeaurora.org>
X-Sender: abhinavk@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-28 17:55, Bjorn Andersson wrote:
> On Mon 28 Jun 19:31 CDT 2021, abhinavk@codeaurora.org wrote:
> 
>> Hi Bjorn
>> 
>> On 2021-06-28 17:22, Bjorn Andersson wrote:
>> > The debugfs interface contains the knobs to make the DisplayPort
>> > controller output a test pattern, unfortunately there's nothing
>> > currently that actually enables the defined test pattern.
>> >
>> > Fixes: de3ee25473ba ("drm/msm/dp: add debugfs nodes for video pattern
>> > tests")
>> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> 
>> This is not how this debugfs node works. This is meant to be used 
>> while
>> running
>> DP compliance video pattern test.
>> 
>> https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/blob/master/tools/msm_dp_compliance.c
>> 
>> While the compliance test is being run with this msm_dp_compliance app
>> running,
>> it will draw the test pattern when it gets the "test_active" from the
>> driver.
>> 
>> The test pattern which this app draws is as per the requirements of 
>> the
>> compliance test
>> as the test equipment will match the CRC of the pattern which is 
>> drawn.
>> 
>> The API dp_panel_tpg_config() which you are trying to call here draws 
>> the DP
>> test pattern
>> from the DP controller hardware but not the pattern which the 
>> compliance
>> test expects.
>> 
> 
> So clearly not an oversight, but rather me not understanding how to use
> the test pattern.
> 
> You say that I should run msm_dp_compliance while the test is running,
> so how do I run the test?

There are two test patterns with different purposes. The one which the 
msm_dp_compliance
draws is strictly for the DP compliance test and it needs even the DPU 
to draw the frame because
it sets up the display pipeline and just draws the buffer.

That is not what you are looking for here.

So rather than trying to run msm_dp_compliance on your setup, just try 
calling dp_panel_tpg_config().
We typically just call this API, right after the link training is done.
But if you really need a debugfs node for this, you can write up a 
separate debugfs for it
Something like:

echo 1 > dp/tpg/en

Lets not disturb this one.

> 
>> Its just a debug API to call when required during bringup/debug 
>> purposes.
>> 
> 
> Yes, I was trying to isolate the DP code from some misconfiguration in
> the DPU during bringup and with this fix the debugfs interface became
> useful.

> 
> Regards,
> Bjorn
> 
>> Hence this is not the place to call it as it will end up breaking CTS.
>> 
>> Thanks
>> 
>> Abhinav
>> 
>> > ---
>> >  drivers/gpu/drm/msm/dp/dp_debug.c | 2 ++
>> >  1 file changed, 2 insertions(+)
>> >
>> > diff --git a/drivers/gpu/drm/msm/dp/dp_debug.c
>> > b/drivers/gpu/drm/msm/dp/dp_debug.c
>> > index 2f6247e80e9d..82911af44905 100644
>> > --- a/drivers/gpu/drm/msm/dp/dp_debug.c
>> > +++ b/drivers/gpu/drm/msm/dp/dp_debug.c
>> > @@ -305,6 +305,8 @@ static ssize_t dp_test_active_write(struct file
>> > *file,
>> >  				debug->panel->video_test = true;
>> >  			else
>> >  				debug->panel->video_test = false;
>> > +
>> > +			dp_panel_tpg_config(debug->panel, debug->panel->video_test);
>> >  		}
>> >  	}
>> >  	drm_connector_list_iter_end(&conn_iter);
