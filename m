Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB05441E99
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 17:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbhKAQjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 12:39:33 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:23693 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232764AbhKAQig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 12:38:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635784562; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=oIzVbbzHUp4YCB1+mUedFM1+EtezAnqorjwUh9w5z4U=;
 b=cXW8jnsEffYqUX6AMZL1bcZ+W19VtZMCy3L8wTwHjrBJ99ch6RijhVYvCZ5pZ3NIkwCP5Uqw
 rtqYNypghnlQJRRQc4gKLQL4pG5NfSGPVhtSKsT8Z+g1Lob6kCTYx2RJ8UOpM6jdXGBFfZmV
 UmyYjALBBKr6kxkaHNZpEqlOAa8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 61801760648aeeca5c190e2c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 01 Nov 2021 16:35:44
 GMT
Sender: rishabhb=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 282E1C43616; Mon,  1 Nov 2021 16:35:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AF3E5C4338F;
        Mon,  1 Nov 2021 16:35:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 01 Nov 2021 09:35:42 -0700
From:   rishabhb@codeaurora.org
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, avajid@codeaurora.org,
        adharmap@codeaurora.org
Subject: Re: [PATCH v3] firmware: arm_scmi: Free mailbox channels if probe
 fails
In-Reply-To: <20210901093558.GL13160@e120937-lin>
References: <1628111999-21595-1-git-send-email-rishabhb@codeaurora.org>
 <20210805105427.GU6592@e120937-lin>
 <51782599a01a6a22409d01e5fc1f8a50@codeaurora.org>
 <20210831054835.GJ13160@e120937-lin> <20210901093558.GL13160@e120937-lin>
Message-ID: <aab71610e11c2dd293159576cc53e277@codeaurora.org>
X-Sender: rishabhb@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-01 02:35, Cristian Marussi wrote:
> On Tue, Aug 31, 2021 at 06:48:35AM +0100, Cristian Marussi wrote:
>> On Mon, Aug 30, 2021 at 02:09:37PM -0700, rishabhb@codeaurora.org 
>> wrote:
>> > Hi Christian
>> 
>> Hi Rishabh,
>> 
>> thanks for looking into this kind of bad interactions.
>> 
>> > There seems to be another issue here. The response from agent can be delayed
>> > causing a timeout during base protocol acquire,
>> > which leads to the probe failure. What I have observed is sometimes the
>> > failure of probe and rx_callback (due to a delayed message)
>> > happens at the same time on different cpus.
>> > Because of this race, the device memory may be cleared while the
>> > interrupt(rx_callback) is executing on another cpu.
>> 
>> You are right that concurrency was not handled properly in this kind 
>> of
>> context and moreover, if you think about it, even the case of out of
>> order reception of responses and delayed_responses (type2 SCMI 
>> messages)
>> for asynchronous SCMI commands was not handled properly.
>> 
>> > How do you propose we solve this? Do you think it is better to take the
>> > setting up of base and other protocols out of probe and
>> > in some delayed work? That would imply the device memory is not released
>> > until remove is called. Or should we add locking to
>> > the interrupt handler(scmi_rx_callback) and the cleanup in probe to avoid
>> > the race?
>> >
>> 
>> These issues were more easily exposed by SCMI Virtio transport, so in
>> the series where I introduced scmi-virtio:
>> 
>> https://lore.kernel.org/linux-arm-kernel/162848483974.232214.9506203742448269364.b4-ty@arm.com/
>> 
>> (which is now queued for v5.15 ...  now on -next I think...finger 
>> crossed)
>> 
>> I took the chance to rectify a couple of other things in the SCMI core
>> in the initial commits.
>> As an example, in the above series
>> 
>>  [PATCH v7 05/15] firmware: arm_scmi: Handle concurrent and 
>> out-of-order messages
>> 
>> cares to add a refcount to xfers and some locking on xfers between TX
>> and RX path to avoid that a timed out xfer can vanish while the rx 
>> path
>> is concurrently working on it (as you said); moreover I handle the
>> condition (rare if not unplausible anyway) in which a transport 
>> delivers
>> out of order responses and delayed responses.
>> 
>> I tested this scenarios on some fake emulated SCMI Virtio transport
>> where I could play any sort of mess and tricks to stress this limit
>> conditions, but you're more than welcome to verify if the race you are
>> seeing on Base protocol time out is solved (as I would hope :D) by 
>> this
>> series of mine.
>> 
>> Let me know, any feedback is welcome.
>> 
>> Btw, in the series above there are also other minor changes, but there
>> is also another more radical change needed to ensure correctness and
>> protection against stale old messages which maybe could interest you
>> in general if you are looking into SCMI:
>> 
>> [PATCH v7 04/15] firmware: arm_scmi: Introduce monotonically 
>> increasing tokens
>> 
>> Let me know if yo have other concerns.
>> 
> 
> Hi Rishabhb,
> 
> just a quick remark, thinking again about your fail @probe scenario 
> above
> I realized that while the concurrency patch I mentioned above could 
> help on
> races against vanishing xfers when late timed-out responses are 
> delivered,
> here we really are then also shutting down everything on failure, so 
> there
> could be further issues between a very late invokation of 
> scmi_rx_callback
> and the core devm_ helpers freeing the underlying xfer/cinfo/etc.. 
> structs
> used by scmi-rx-callback itself (maybe this was already what you meant 
> and
> I didn't get it,...sorry)
> 
> On the other side, I don't feel that delaying Base init to a deferred
> worker is a viable solution since we need Base protocol init to be
> initialized and we need to just give up if we cannot communicate with
> the SCMI platform fw in such early stages. (Base protocol is really the
> only mandatory proto is I remember correctly the spec)
> 
> Currenly I'm off and only glancing at mails but I'll have a thought 
> about
> these issues once back in a few weeks time.
> 
> Thanks,
> Cristian
> 
Hi Cristian
I hope you enjoyed your vacation. Did you get a chance to look at the 
issue stated above
and have some idea as to how to solve this?
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
