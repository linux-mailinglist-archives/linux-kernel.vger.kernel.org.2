Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A38538B883
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 22:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238870AbhETUiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 16:38:03 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:48552 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbhETUiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 16:38:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621543000; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=8tvSTWWqWbfweM3Qyf/os8ExRoa7DxBNGE9VA9w7u6c=;
 b=RV3XFgY/O6JMjEk0RWfnggrSNO1Y/sYydcn79CzQ/LAhtkZgyCa/RYkbhUjOCVkqWYdbZvS5
 Qdv4HLiG1hfR0Bf6Jgoq2tnfQh2fQnzRqxRTi+beRfz62RcctGdRS/CTeEG5TZBFoxLzB5D9
 wufr++VWq9mlpSwpax+JNQIcGfk=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 60a6c854f752fca66808a127 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 20 May 2021 20:36:36
 GMT
Sender: khsieh=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4ED84C43460; Thu, 20 May 2021 20:36:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: khsieh)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1B7B1C4338A;
        Thu, 20 May 2021 20:36:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 20 May 2021 13:36:35 -0700
From:   khsieh@codeaurora.org
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robdclark@gmail.com,
        sean@poorly.run, vkoul@kernel.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] drm/msm/dp: handle irq_hpd with sink_count = 0
 correctly
In-Reply-To: <CAE-0n52rBrjy-=dpqK+dae2GNk1rAaQnKqCjzdqiAoS13gHpSQ@mail.gmail.com>
References: <1621013713-6860-1-git-send-email-khsieh@codeaurora.org>
 <CAE-0n53VUr=f=PKnO5HhXZ3BAG_mNBwmQrfQPxHvxLZPDReA+g@mail.gmail.com>
 <c1a3ced9ac4682bae310712a11576322@codeaurora.org>
 <CAE-0n50yRCA00ck_FtXwzKw_R8UcocMzTh8V7NOe4ob__3G3bg@mail.gmail.com>
 <e071434531947e5c4275a1a14b77b2c3@codeaurora.org>
 <CAE-0n52rBrjy-=dpqK+dae2GNk1rAaQnKqCjzdqiAoS13gHpSQ@mail.gmail.com>
Message-ID: <5a6c86f4a5be914102214e45f8afc10c@codeaurora.org>
X-Sender: khsieh@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-05-20 12:28, Stephen Boyd wrote:
> Quoting khsieh@codeaurora.org (2021-05-20 09:08:03)
>> On 2021-05-19 14:06, Stephen Boyd wrote:
>> > Quoting khsieh@codeaurora.org (2021-05-19 09:01:02)
>> >> On 2021-05-18 14:42, Stephen Boyd wrote:
>> >> > Quoting Kuogee Hsieh (2021-05-14 10:35:13)
>> >> >> irq_hpd interrupt should be handled after dongle plugged in and
>> >> >> before dongle unplugged. Hence irq_hpd interrupt is enabled at
>> >> >> the end of the plugin handle and disabled at the beginning of
>> >> >> unplugged handle. Current irq_hpd with sink_count = 0 is wrongly
>> >> >> handled same as the dongle unplugged which tears down the mainlink
>> >> >> and disables the phy. This patch fixes this problem by only tearing
>> >> >> down the mainlink but keeping phy enabled at irq_hpd with
>> >> >> sink_count = 0 handle so that next irq_hpd with sink_count =1 can be
>> >> >> handled by setup mainlink only.
>> >> >>
>> >> >> Changes in v2:
>> >> >> -- add ctrl->phy_Power_count
>> >> >>
>> >> >> Changes in v3:
>> >> >> -- del ctrl->phy_Power_count
>> >> >> -- add phy_power_off to dp_ctrl_off_link_stream()
>> >> >>
>> >> >> Changes in v4:
>> >> >> -- return immediately if clock disable failed at
>> >> >> dp_ctrl_off_link_stream()
>> >> >>
>> >> >> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
>> >> >
>> >> > I think we want some Fixes tag. Not sure what it would be though.
>> >> >
>> >> > I also noticed that if I plug and unplug the HDMI cable from my apple
>> >> > dongle that I see this error message
>> >> >
>> >> >   [drm:dp_display_usbpd_attention_cb] *ERROR* Disconnected, no
>> >> > DP_LINK_STATUS_UPDATED
>> >>
>> >> > *ERROR* Disconnected, no DP_LINK_STATUS_UPDATED <== this is caused by
>> >> > dongle generate the second
>> >> irq_hpd with sink_count = 0 after first first irq_hpd with sink_count
>> >> =
>> >> 0. The fix is you have
>> >> set dongle to D3 (power off) state after first irq_pd with sink_count
>> >> =display_disable
>> >> 0 handled.
>> >> I have a patch fix this problem. I will merge and re submit for
>> >> review.
>> >
>> > That's good. I still don't understand how the kthread can't race with
>> > irq_hpd and hpd going low though. Userspace will have to disable
>> > thectrl_off_link_stream()).
>> > display and that could happen far later than the time that the hpd low
>> > interrupt fires and is processed. Can't hpd go high during that time
>> > and
>> > then blip before userspace notices and disables the display?
>> >
>> > Put another way, putting the dongle into D3 state may make the race
>> > window smaller, but it's not fixing the root cause of the problem which
>> > is that the kthread is running later and userspace is involved in the
>> > state of the dongle while irqs are firing. The three different contexts
>> > have to coordinate work, so it feels like a better approach would be to
>> > shut off the irq_hpd interrupt once hpd goes low for an unplug in
>> > hardirq context so that we don't have to consider the cable state or
>> > userspace changing the state after we notify it.
>> 
>> There is no race condition here.
>> The interrupts are converted into event and stored at event q.
>> event thread service event sequentially and make sure transaction had
>> been completed before service next event.
>> The first irq_hpd with sink_count = 0 is handled and this transaction
>> will not completed until user space frame work turn off display
>> (msm_dp_display_disable()).
>> After that, the second irq_hpd with sink_count will be service which
>> found that display is off so it spill out DP_LINK_STATUS_UPDATED 
>> warning
>> message and do nothing.
>> 
>> Put dongle to D3 state so that it will not issue the unnecessary 
>> second
>> irq_hpd with sink_count = 0. this will prevent the annoy but unharmful
>> DP_LINK_STATUS_UPDATED warning message.
>> Again, we can not disable hpd interrupt since dongle still attached 
>> and
>> hdmi cable can be plugged in at any instant.
>> 
> 
> Right I'm not suggesting to disable hpd interrupt, just the hpd_irq
> interrupt once an unplug irq comes in, and do that in hardirq context.
> Also, I'm suggesting that we consider unplug as a higher priority if 
> the
> hard irq handler is delayed for some reason and both an unplug irq and
> an hpd irq are pending in the hardware when the hard irq handler is
> running. Putting the dongle into D3 state won't fix these problems.

  [drm:dp_display_usbpd_attention_cb] *ERROR* Disconnected, no 
DP_LINK_STATUS_UPDATED <== you can see this warning message by just 
unplugged hdmi cable out of dongle (dongle still attached to DUT).
