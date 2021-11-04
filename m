Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBA1445CBC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 00:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhKDXmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 19:42:46 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:57367 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229725AbhKDXmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 19:42:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1636069206; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=ClTodIMDy7GD1VDiDFYQwXhlGL0o88vwo6+goEeSxGg=;
 b=JZhXEcaa384HC3sK6KORFY9A37Hvww6eHaHwdL+0Jk/vJXjKuk0T39o2g9p68twdf8k0hqyO
 jyaisxd9BjsTByPfjcavWOKmAD9b4sI9Zb0ae+8m1J6wRk95ieNkjjwRx2PD6ADd+FjvU5R2
 p8xtDB2NFF85bIkKGtOROCpF+nU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 61846f56c19d3d1257e82deb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 04 Nov 2021 23:40:06
 GMT
Sender: rishabhb=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 14FC0C4360D; Thu,  4 Nov 2021 23:40:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DBDCBC4338F;
        Thu,  4 Nov 2021 23:40:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 04 Nov 2021 16:40:03 -0700
From:   rishabhb@codeaurora.org
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        avajid@codeaurora.org, adharmap@codeaurora.org
Subject: Re: [PATCH v3] firmware: arm_scmi: Free mailbox channels if probe
 fails
In-Reply-To: <20211102113221.w7ivffssjb6jmggj@bogus>
References: <1628111999-21595-1-git-send-email-rishabhb@codeaurora.org>
 <20210805105427.GU6592@e120937-lin>
 <51782599a01a6a22409d01e5fc1f8a50@codeaurora.org>
 <20210831054835.GJ13160@e120937-lin> <20210901093558.GL13160@e120937-lin>
 <aab71610e11c2dd293159576cc53e277@codeaurora.org>
 <20211102113221.w7ivffssjb6jmggj@bogus>
Message-ID: <9385b2ca9b688b00735cc0b7f626f008@codeaurora.org>
X-Sender: rishabhb@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-02 04:32, Sudeep Holla wrote:
> On Mon, Nov 01, 2021 at 09:35:42AM -0700, rishabhb@codeaurora.org 
> wrote:
>> On 2021-09-01 02:35, Cristian Marussi wrote:
>> > On Tue, Aug 31, 2021 at 06:48:35AM +0100, Cristian Marussi wrote:
>> > > On Mon, Aug 30, 2021 at 02:09:37PM -0700, rishabhb@codeaurora.org
>> > > wrote:
>> > > > Hi Christian
>> > >
>> > > Hi Rishabh,
>> > >
>> > > thanks for looking into this kind of bad interactions.
>> > >
>> > > > There seems to be another issue here. The response from agent can be delayed
>> > > > causing a timeout during base protocol acquire,
>> > > > which leads to the probe failure. What I have observed is sometimes the
>> > > > failure of probe and rx_callback (due to a delayed message)
>> > > > happens at the same time on different cpus.
>> > > > Because of this race, the device memory may be cleared while the
>> > > > interrupt(rx_callback) is executing on another cpu.
>> > >
>> > > You are right that concurrency was not handled properly in this kind
>> > > of
>> > > context and moreover, if you think about it, even the case of out of
>> > > order reception of responses and delayed_responses (type2 SCMI
>> > > messages)
>> > > for asynchronous SCMI commands was not handled properly.
>> > >
>> > > > How do you propose we solve this? Do you think it is better to take the
>> > > > setting up of base and other protocols out of probe and
>> > > > in some delayed work? That would imply the device memory is not released
>> > > > until remove is called. Or should we add locking to
>> > > > the interrupt handler(scmi_rx_callback) and the cleanup in probe to avoid
>> > > > the race?
>> > > >
>> > >
>> > > These issues were more easily exposed by SCMI Virtio transport, so in
>> > > the series where I introduced scmi-virtio:
>> > >
>> > > https://lore.kernel.org/linux-arm-kernel/162848483974.232214.9506203742448269364.b4-ty@arm.com/
>> > >
>> > > (which is now queued for v5.15 ...  now on -next I think...finger
>> > > crossed)
>> > >
>> > > I took the chance to rectify a couple of other things in the SCMI core
>> > > in the initial commits.
>> > > As an example, in the above series
>> > >
>> > >  [PATCH v7 05/15] firmware: arm_scmi: Handle concurrent and
>> > > out-of-order messages
>> > >
>> > > cares to add a refcount to xfers and some locking on xfers between TX
>> > > and RX path to avoid that a timed out xfer can vanish while the rx
>> > > path
>> > > is concurrently working on it (as you said); moreover I handle the
>> > > condition (rare if not unplausible anyway) in which a transport
>> > > delivers
>> > > out of order responses and delayed responses.
>> > >
>> > > I tested this scenarios on some fake emulated SCMI Virtio transport
>> > > where I could play any sort of mess and tricks to stress this limit
>> > > conditions, but you're more than welcome to verify if the race you are
>> > > seeing on Base protocol time out is solved (as I would hope :D) by
>> > > this
>> > > series of mine.
>> > >
>> > > Let me know, any feedback is welcome.
>> > >
>> > > Btw, in the series above there are also other minor changes, but there
>> > > is also another more radical change needed to ensure correctness and
>> > > protection against stale old messages which maybe could interest you
>> > > in general if you are looking into SCMI:
>> > >
>> > > [PATCH v7 04/15] firmware: arm_scmi: Introduce monotonically
>> > > increasing tokens
>> > >
>> > > Let me know if yo have other concerns.
>> > >
>> >
>> > Hi Rishabhb,
>> >
>> > just a quick remark, thinking again about your fail @probe scenario
>> > above
>> > I realized that while the concurrency patch I mentioned above could help
>> > on
>> > races against vanishing xfers when late timed-out responses are
>> > delivered,
>> > here we really are then also shutting down everything on failure, so
>> > there
>> > could be further issues between a very late invokation of
>> > scmi_rx_callback
>> > and the core devm_ helpers freeing the underlying xfer/cinfo/etc..
>> > structs
>> > used by scmi-rx-callback itself (maybe this was already what you meant
>> > and
>> > I didn't get it,...sorry)
>> >
>> > On the other side, I don't feel that delaying Base init to a deferred
>> > worker is a viable solution since we need Base protocol init to be
>> > initialized and we need to just give up if we cannot communicate with
>> > the SCMI platform fw in such early stages. (Base protocol is really the
>> > only mandatory proto is I remember correctly the spec)
>> >
>> > Currenly I'm off and only glancing at mails but I'll have a thought
>> > about
>> > these issues once back in a few weeks time.
>> >
>> > Thanks,
>> > Cristian
>> >
>> Hi Cristian
>> I hope you enjoyed your vacation. Did you get a chance to look at the 
>> issue
>> stated above and have some idea as to how to solve this?
> 
> Do you still see the issue with v5.15 ? Can you please check if haven't
> already done that ?
> 
> Also 30ms delay we have is huge IMO and we typically expect the 
> communication
> with remote processor or any entity that implements SCMI to happen in 
> terms
> of one or few ms tops.
> 
> If there is a race, we need to fix that but I am interested in knowing
> why the default time of 30ms not sufficient ? Did increasing that helps
> and is this timeout happening only for the initial commands(guessing 
> the
> SCMI firmware is not yet ready) or does it happen even during run-time 
> ?

Hi Sudeep
I haven't checked on 5.15 but after glancing at the code I believe we 
should see the same issue.
I agree 30ms is a big enough value and should be something that remote 
firmware should resolve. But
if remote firmware goes into a bad state and not functioning properly at 
least kernel should not panic.

The issue we see here happens during scmi probe. The response from the 
remote agent can be delayed
causing a timeout during base protocol acquire, which leads to the probe 
failure.
What I have observed is sometimes the failure of probe and rx_callback 
(due to a delayed message)
happens around the same time on different cpus. Because of this race, 
the device memory may be cleared
while the interrupt(rx_callback) is executing on another cpu.
