Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C00638CA02
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 17:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbhEUPXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 11:23:45 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:24979 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232517AbhEUPXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 11:23:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621610540; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=86OWpz/tqXg2kGyaZsm4R0nkBNpu+9RJz9i6K7XU7C0=;
 b=U8SNfFh0AHonbgRJ7Bsr8URW+BVmP03glh/qQ01gU4nUMuQ9rhtztEjwC0XGIK8GyJqvEZ9t
 bUjciblR5tUrnbCyD8emImmLZjOLfZ9vAEUUFie+ROfe9s+Kme0CqAjgRZPgXqEzslONEC6W
 d3maFhZzXrVcqiHTV78/8WIgMew=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 60a7d0177b9a7a2b6cded9f1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 21 May 2021 15:21:59
 GMT
Sender: khsieh=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 93E41C4360C; Fri, 21 May 2021 15:21:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: khsieh)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 60600C433D3;
        Fri, 21 May 2021 15:21:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 21 May 2021 08:21:58 -0700
From:   khsieh@codeaurora.org
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robdclark@gmail.com,
        sean@poorly.run, vkoul@kernel.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] drm/msm/dp: handle irq_hpd with sink_count = 0
 correctly
In-Reply-To: <CAE-0n50u-qGvqzJThc+ggghv6ZErPr8g8dhvgequBm5CWOR2Kw@mail.gmail.com>
References: <1621013713-6860-1-git-send-email-khsieh@codeaurora.org>
 <CAE-0n53VUr=f=PKnO5HhXZ3BAG_mNBwmQrfQPxHvxLZPDReA+g@mail.gmail.com>
 <c1a3ced9ac4682bae310712a11576322@codeaurora.org>
 <CAE-0n50yRCA00ck_FtXwzKw_R8UcocMzTh8V7NOe4ob__3G3bg@mail.gmail.com>
 <e071434531947e5c4275a1a14b77b2c3@codeaurora.org>
 <CAE-0n52rBrjy-=dpqK+dae2GNk1rAaQnKqCjzdqiAoS13gHpSQ@mail.gmail.com>
 <f476d82d0798e0d7eb9e12949aa2c8f1@codeaurora.org>
 <CAE-0n51+mbCAqWWTOMDA4Rx_=96V4tK8g+UWVZ-nnp50dFzRPA@mail.gmail.com>
 <5d341df202facb3240a72cfb35e18167@codeaurora.org>
 <CAE-0n50u-qGvqzJThc+ggghv6ZErPr8g8dhvgequBm5CWOR2Kw@mail.gmail.com>
Message-ID: <1e9970ee1a7109e336bc6ed51e727442@codeaurora.org>
X-Sender: khsieh@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-05-20 22:00, Stephen Boyd wrote:
> Quoting khsieh@codeaurora.org (2021-05-20 15:39:09)
>> On 2021-05-20 14:28, Stephen Boyd wrote:
>> > Quoting khsieh@codeaurora.org (2021-05-20 13:05:48)
>> >> On 2021-05-20 12:28, Stephen Boyd wrote:
>> >> >> Put dongle to D3 state so that it will not issue the unnecessary
>> >> >> second
>> >> >> irq_hpd with sink_count = 0. this will prevent the annoy but unharmful
>> >> >> DP_LINK_STATUS_UPDATED warning message.
>> >> >> Again, we can not disable hpd interrupt since dongle still attached
>> >> >> and
>> >> >> hdmi cable can be plugged in at any instant.
>> >> >>
>> >> >
>> >> > Right I'm not suggesting to disable hpd interrupt, just the hpd_irq
>> >> > interrupt once an unplug irq comes in, and do that in hardirq context.
>> >> > Also, I'm suggesting that we consider unplug as a higher priority if
>> >> > the
>> >> > hard irq handler is delayed for some reason and both an unplug irq and
>> >> > an hpd irq are pending in the hardware when the hard irq handler is
>> >> > running. Putting the dongle into D3 state won't fix these problems.
>> >>
>> >>
>> >>
>> >> The unplug interrupt is not happen in this case since dongle still
>> >> attached.
>> >> The unplug interrupt only happen when dongle unplugged.
>> >
>> > Agreed.
>> >
>> >>
>> >> I think you mistakenly think DP_LINK_STATUS_UPDATED is caused by
>> >> unplug
>> >> interrupt.
>> >
>> > Ok, got it.
>> >
>> >> DP_LINK_STATUS_UPDATED happen is due to dongle issue two consecutive
>> >> irq_hpd with sink_count = 0 when hdmi cable unplugged from dongle.
>> >> The first irq_hpd with sink_count = 0 is handled as expected to turn
>> >> off
>> >> display.
>> >> After that the second irq_hpd with sink_count = 0 is handled.
>> >> Since display had turned off, then there is nothing to do but spill
>> >> DP_LINK_STATUS_UPDATED warning message.
>> >> There is no unplug (hpd become low) happen in this case since dongle
>> >> still attached.
>> >
>> > Agreed.
>> >
>> >>
>> >> All interrupt (plug/irq_hpd and unplug) are required to be handled in
>> >> the order of happening.
>> >> We can not ignore any one.
>> >> For example, you plug/unplug two different resolution monitor
>> >> alternative to/from dongle and unplug dongle once for while.
>> >>
>> >> I think the race condition you describe here all had been taken care
>> >> with
>> >> 1) convert irq into event and store at event q in order.
>> >> 2) irq handled base on transaction. Next irq can be handled when
>> >> previous irq transaction is done.
>> >>
>> >
>> > I'm mostly trying to point out that the irq handling and masking needs
>> > to be done in the hard irq context and not in the kthread. It may or
>> > may
>> > not be related to this message that's printed.
>> >
>> > What happens if the hardirq is blocked by some other irq that takes a
>> > long time to process? Imagine this scenario:
>> >
>> > CPU0                                CPU1
>> > ----                                ----
>> >  really_long_other_hardirq() {
>> >                                     hpd_irq
>> >                                   hpd_irq
>> >                                   hpd low
>> >  }
>> >
>> >  dp_display_irq_handler() {
>> >
>> 
>> 
>> >    <fork things to kthread>
>> >  }
>> >
>> > Shouldn't we ignore any hpd_irq events in this scenario? And shouldn't
>> > we be disabling the hpd_irq by masking it with DP_DP_IRQ_HPD_INT_MASK
>> > when hpd goes low (i.e. DP_DP_HPD_UNPLUG_INT_MASK)?
>> 
>> 
>> 
>> 1) irq_hpd interrupt always happen before unplug interrupt
>> 2)if hdp_isr_status = (DP_DP_IRQ_HPD_INT_MASK |
>> DP_DP_HPD_UNPLUG_INT_MASK) at the time when read at
>> dp_display_irq_handler(),
>> then DP_DP_IRQ_HPD_INT_MASK will be add into evetn q first followed by
>> DP_DP_HPD_UNPLUG_INT_MASK be add into event q.
>> So that DP_DP_IRQ_HPD_INT_MASK will be executed by the event thread
>> before DP_DP_HPD_UNPLUG_INT_MASK.
>> On the other word, IRQ_HPD has higher priority over UNPLUG in the 
>> timing
>> matter.
>> By doing that we can shut down display gracefully.
> 
> Ok. So you're saying that we want to put both events on the queue
> regardless, and put IRQ_HPD there first because we want to check the
> status bit? Doesn't reading the status bit require the dongle to be
> connected though? So if an unplug came in along with an irq_hpd we may
> queue both the irq_hpd and the unplug, but when it comes time to 
> process
> the irq_hpd in the kthread the link will be gone and so trying the dpcd
> read for the link status will fail?
> 
yes,
we had a previous bug with this scenarios already.
https://partnerissuetracker.corp.google.com/issues/170598152
At this case, dongle produce two interrupts, irq_hpd followed by unplug 
immediately (not presented at isr status register at same time), at the 
time dongle unplugged form DTU.
But due to dp ctrl reset at handling irq_hpd which cause unplug mask bit 
be cleared so that unplug interrupt got lost.


I think V6 patch is good to go.


>> 
>> If you insist, at hdp_isr_status = (DP_DP_IRQ_HPD_INT_MASK |
>> DP_DP_HPD_UNPLUG_INT_MASK) case,
>> we can have only add DP_DP_HPD_UNPLUG_INT_MASK to event q only by
>> dropping DP_DP_IRQ_HPD_INT_MASK.
>> Is this will work for you?
>> 
> 
> I'm not insisting on anything. I'm just trying to think of various
> corner cases that we're not handling in the code so we don't have to
> worry about them in the future.
