Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23218449B42
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 18:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbhKHSBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 13:01:48 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:43392 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbhKHSBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 13:01:45 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1636394341; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=bBXqD0ZMHgGmqzRXNg48aBRkd6Bq2tb0u7kpX/3ecBQ=;
 b=DWElvaH88AzSYNem6I+6eLnXAlgEEoJyQ52gGIl/B1UJ0opw8lZ8dTzOJWI4ZMOs3frlh0cQ
 cg9VE9pioH1nLOD2HAEgD0jCQo+BPqRabBdl0VCQGUPxE89+qSmWDvBncGhB+zZyY9tMBlo9
 UbrOM8oRvUMh1sj1/yWt/90W20U=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 6189656463ce33d69b8c506d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 08 Nov 2021 17:59:00
 GMT
Sender: rishabhb=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 063A6C43616; Mon,  8 Nov 2021 17:59:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 79D4FC4360D;
        Mon,  8 Nov 2021 17:58:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 08 Nov 2021 09:58:57 -0800
From:   rishabhb@codeaurora.org
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        avajid@codeaurora.org, adharmap@codeaurora.org
Subject: Re: [PATCH v3] firmware: arm_scmi: Free mailbox channels if probe
 fails
In-Reply-To: <20211107182212.GK6526@e120937-lin>
References: <20210805105427.GU6592@e120937-lin>
 <51782599a01a6a22409d01e5fc1f8a50@codeaurora.org>
 <20210831054835.GJ13160@e120937-lin> <20210901093558.GL13160@e120937-lin>
 <aab71610e11c2dd293159576cc53e277@codeaurora.org>
 <20211102113221.w7ivffssjb6jmggj@bogus>
 <9385b2ca9b688b00735cc0b7f626f008@codeaurora.org>
 <20211105094310.GI6526@e120937-lin>
 <cf928a950dc50e622611f44f08762979@codeaurora.org>
 <20211107103407.GJ6526@e120937-lin> <20211107182212.GK6526@e120937-lin>
Message-ID: <cd19354a14edd684c8357cf0c5bcdea0@codeaurora.org>
X-Sender: rishabhb@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-07 10:22, Cristian Marussi wrote:
> On Sun, Nov 07, 2021 at 10:34:07AM +0000, Cristian Marussi wrote:
>> On Fri, Nov 05, 2021 at 10:40:59AM -0700, rishabhb@codeaurora.org 
>> wrote:
>> > On 2021-11-05 02:43, Cristian Marussi wrote:
>> > > On Thu, Nov 04, 2021 at 04:40:03PM -0700, rishabhb@codeaurora.org wrote:
>> > > > On 2021-11-02 04:32, Sudeep Holla wrote:
>> > > > > On Mon, Nov 01, 2021 at 09:35:42AM -0700, rishabhb@codeaurora.org wrote:
>> > > > > > On 2021-09-01 02:35, Cristian Marussi wrote:
>> > > > > > > On Tue, Aug 31, 2021 at 06:48:35AM +0100, Cristian Marussi wrote:
>> > > > > > > > On Mon, Aug 30, 2021 at 02:09:37PM -0700, rishabhb@codeaurora.org
>> > > > > > > > wrote:
>> > > > > > > > > Hi Christian
>> > > > > > > >
>> > > > > > > > Hi Rishabh,
>> > > > > > > >
>> > >
>> > > Hi Rishabh,
>> > >
>> 
>> Hi Rishabh,
>> 
> 
> Hi Rishabhb,
> 
>> > > apologies for the delay in coming back to you.
>> > > A few comments below.
>> > >
>> > > > > > > > thanks for looking into this kind of bad interactions.
>> > > > > > > >
>> > > > > > > > > There seems to be another issue here. The response from agent can be delayed
>> > > > > > > > > causing a timeout during base protocol acquire,
>> > > > > > > > > which leads to the probe failure. What I have observed is sometimes the
>> > > > > > > > > failure of probe and rx_callback (due to a delayed message)
>> > > > > > > > > happens at the same time on different cpus.
>> > > > > > > > > Because of this race, the device memory may be cleared while the
>> > > > > > > > > interrupt(rx_callback) is executing on another cpu.
>> > > > > > > >
>> > > > > > > > You are right that concurrency was not handled properly in this kind
>> > > > > > > > of
>> > > > > > > > context and moreover, if you think about it, even the case of out of
>> > > > > > > > order reception of responses and delayed_responses (type2 SCMI
>> > > > > > > > messages)
>> > > > > > > > for asynchronous SCMI commands was not handled properly.
>> > > > > > > >
>> > > > > > > > > How do you propose we solve this? Do you think it is better to take the
>> > > > > > > > > setting up of base and other protocols out of probe and
>> > > > > > > > > in some delayed work? That would imply the device memory is not released
>> > > > > > > > > until remove is called. Or should we add locking to
>> > > > > > > > > the interrupt handler(scmi_rx_callback) and the cleanup in probe to avoid
>> > > > > > > > > the race?
>> > > > > > > > >
>> > > > > > > >
>> > > > > > > > These issues were more easily exposed by SCMI Virtio transport, so in
>> > > > > > > > the series where I introduced scmi-virtio:
>> > > > > > > >
>> > > > > > > > https://lore.kernel.org/linux-arm-kernel/162848483974.232214.9506203742448269364.b4-ty@arm.com/
>> > > > > > > >
>> > > > > > > > (which is now queued for v5.15 ...  now on -next I think...finger
>> > > > > > > > crossed)
>> > > > > > > >
>> > > > > > > > I took the chance to rectify a couple of other things in the SCMI core
>> > > > > > > > in the initial commits.
>> > > > > > > > As an example, in the above series
>> > > > > > > >
>> > > > > > > >  [PATCH v7 05/15] firmware: arm_scmi: Handle concurrent and
>> > > > > > > > out-of-order messages
>> > > > > > > >
>> > > > > > > > cares to add a refcount to xfers and some locking on xfers between TX
>> > > > > > > > and RX path to avoid that a timed out xfer can vanish while the rx
>> > > > > > > > path
>> > > > > > > > is concurrently working on it (as you said); moreover I handle the
>> > > > > > > > condition (rare if not unplausible anyway) in which a transport
>> > > > > > > > delivers
>> > > > > > > > out of order responses and delayed responses.
>> > > > > > > >
>> > > > > > > > I tested this scenarios on some fake emulated SCMI Virtio transport
>> > > > > > > > where I could play any sort of mess and tricks to stress this limit
>> > > > > > > > conditions, but you're more than welcome to verify if the race you are
>> > > > > > > > seeing on Base protocol time out is solved (as I would hope :D) by
>> > > > > > > > this
>> > > > > > > > series of mine.
>> > > > > > > >
>> > > > > > > > Let me know, any feedback is welcome.
>> > > > > > > >
>> > > > > > > > Btw, in the series above there are also other minor changes, but there
>> > > > > > > > is also another more radical change needed to ensure correctness and
>> > > > > > > > protection against stale old messages which maybe could interest you
>> > > > > > > > in general if you are looking into SCMI:
>> > > > > > > >
>> > > > > > > > [PATCH v7 04/15] firmware: arm_scmi: Introduce monotonically
>> > > > > > > > increasing tokens
>> > > > > > > >
>> > > > > > > > Let me know if yo have other concerns.
>> > > > > > > >
>> > > > > > >
>> > > > > > > Hi Rishabhb,
>> > > > > > >
>> > > > > > > just a quick remark, thinking again about your fail @probe scenario
>> > > > > > > above
>> > > > > > > I realized that while the concurrency patch I mentioned above could help
>> > > > > > > on
>> > > > > > > races against vanishing xfers when late timed-out responses are
>> > > > > > > delivered,
>> > > > > > > here we really are then also shutting down everything on failure, so
>> > > > > > > there
>> > > > > > > could be further issues between a very late invokation of
>> > > > > > > scmi_rx_callback
>> > > > > > > and the core devm_ helpers freeing the underlying xfer/cinfo/etc..
>> > > > > > > structs
>> > > > > > > used by scmi-rx-callback itself (maybe this was already what you meant
>> > > > > > > and
>> > > > > > > I didn't get it,...sorry)
>> > > > > > >
>> > > > > > > On the other side, I don't feel that delaying Base init to a deferred
>> > > > > > > worker is a viable solution since we need Base protocol init to be
>> > > > > > > initialized and we need to just give up if we cannot communicate with
>> > > > > > > the SCMI platform fw in such early stages. (Base protocol is really the
>> > > > > > > only mandatory proto is I remember correctly the spec)
>> > > > > > >
>> > > > > > > Currenly I'm off and only glancing at mails but I'll have a thought
>> > > > > > > about
>> > > > > > > these issues once back in a few weeks time.
>> > > > > > >
>> > > > > > > Thanks,
>> > > > > > > Cristian
>> > > > > > >
>> > > > > > Hi Cristian
>> > > > > > I hope you enjoyed your vacation. Did you get a chance to look at
>> > > > > > the issue
>> > > > > > stated above and have some idea as to how to solve this?
>> > > > >
>> > > > > Do you still see the issue with v5.15 ? Can you please check if haven't
>> > > > > already done that ?
>> > > > >
>> > > > > Also 30ms delay we have is huge IMO and we typically expect the
>> > > > > communication
>> > > > > with remote processor or any entity that implements SCMI to happen in
>> > > > > terms
>> > > > > of one or few ms tops.
>> > > > >
>> > > > > If there is a race, we need to fix that but I am interested in knowing
>> > > > > why the default time of 30ms not sufficient ? Did increasing that helps
>> > > > > and is this timeout happening only for the initial commands(guessing the
>> > > > > SCMI firmware is not yet ready) or does it happen even during run-time ?
>> > > >
>> > > > Hi Sudeep
>> > > > I haven't checked on 5.15 but after glancing at the code I believe
>> > > > we should
>> > > > see the same issue.
>> > > > I agree 30ms is a big enough value and should be something that remote
>> > > > firmware should resolve. But
>> > > > if remote firmware goes into a bad state and not functioning
>> > > > properly at
>> > > > least kernel should not panic.
>> > > >
>> > > > The issue we see here happens during scmi probe. The response from the
>> > > > remote agent can be delayed
>> > > > causing a timeout during base protocol acquire, which leads to the
>> > > > probe
>> > > > failure.
>> > > > What I have observed is sometimes the failure of probe and
>> > > > rx_callback (due
>> > > > to a delayed message)
>> > > > happens around the same time on different cpus. Because of this
>> > > > race, the
>> > > > device memory may be cleared
>> > > > while the interrupt(rx_callback) is executing on another cpu.
>> > >
>> > > So I was looking at the failure path you mentioned: a late concurrent
>> > > reply on Base protocol from the fw, during the probe, leads to an
>> > > invocation
>> > > of scmi_rx_callback() on a different CPU while core data structs like
>> > > cinfo are being freed by the SCMI core on the probe failure path.
>> > > (v5.15-added SCMI concurrrency handling stuff I mentiond shuld help for
>> > > races regarding xfer but not for the cinfo stuff in this case ...)
>> > >
>> > > We cannot defer Base proto init since we just wanna fail early while
>> > > probing if not even the Base protocol can work fine, and also because
>> > > Base protocol information are indeed needed for initial setup, so we
>> > > cannot juts proceed if we did not even got a Base reply on the number of
>> > > protos. (already said)
>> > >
>> > > In my opinion, the proper way to address this kind of races at probe
>> > > failure should be to ensure that the transport you are using is properly
>> > > shut down completely before cleanup starts (same applies for a clean
>> > > remove), i.e. scmi_rx_callback should not even be possibly registered to
>> > > be called when the the final cleanup by the core is started (devm_ frees
>> > > I mean after scmi_probe exit failing...)
>> > >
>> > > BUT indeed looking back at transport layers like mailbox and virtio,
>> > > this
>> > > should be happening already, because the flow is like
>> > >
>> > > scmi_probe()
>> > > {
>> > > ...
>> > >
>> > > clean_tx_rx_setup:
>> > > 	scmi_cleanup_txrx_channels()
>> > > 		....
>> > > 		--->>>  ret = idr_for_each(idr, info->desc->ops->chan_free, idr);
>> > > 			-
>> > > 	return ret;
>> > > }
>> > >
>> > > .... only after this scmi_probe returns the core devm layer starts
>> > > freeing devm_
>> > > allocated stuff like cinfo, AND the above per-transport specific
>> > > .chan_free seems
>> > > to take care to 'deactivate/dregister' the scmi_rx_callback at the
>> > > transport layer:
>> > >
>> > >
>> > > e.g. MBOX transport
>> > > -------------------------
>> > > static int mailbox_chan_free(int id, void *p, void *data)
>> > > {
>> > > 	struct scmi_chan_info *cinfo = p;
>> > > 	struct scmi_mailbox *smbox = cinfo->transport_info;
>> > >
>> > > 	if (smbox && !IS_ERR(smbox->chan)) {
>> > > 		mbox_free_channel(smbox->chan);    <<< THIS MBOX CORE CALL DEACTIVATE
>> > > 		cinfo->transport_info = NULL;
>> > >
>> > >
>> > > e.g. VIRTIO Transport
>> > > -----------------------------
>> > > static int virtio_chan_free(int id, void *p, void *data)
>> > > {
>> > > 	unsigned long flags;
>> > > 	struct scmi_chan_info *cinfo = p;
>> > > 	struct scmi_vio_channel *vioch = cinfo->transport_info;
>> > >
>> > > 	spin_lock_irqsave(&vioch->ready_lock, flags);
>> > > 	vioch->ready = false;                     <<<< THIS VIRTIO FLAG
>> > > DEACTIVATE VIRTIO CBS INVOKCATION
>> > > 	spin_unlock_irqrestore(&vioch->ready_lock, flags);
>> > >
>> > >
>> > > ... AND both of the above call are indeed also spinlocked heavily, so
>> > > that
>> > > the 'deactivation' of the scmi_rx_callback should be visible properly;
>> > > in
>> > > other words I would expect that after the above .chan_free() have
>> > > completed the scmi_rx_callback() cannot be called anymore, because the
>> > > transport itself will properly drop any so-late fw reply.
>> > >
>> > > So I am now wondering, which transport are you using in your tests ?
>> > > since at least for the above 2 example it seems to me that your
>> > > race-on-probe failure condition should be already addressed by the
>> > > transport layer itself....or am I getting wrong the nature of the race ?
>> > >
>> > > Thanks
>> > > Cristian
>> >
>> > Hi Cristian
>> > You caught the scenario perfectly. But there is still a possibility of a
>> > race. To be clear we use
>> > the mbox transport. Let me explain in more detail.
>> > Lets assume that the last command (base protocol acquire) kernel sent to
>> > remote agent timed out.
>> > This will lead to final cleanup before exiting probe like you mentioned.
>> > Once cleanup is done(mailbox_chan_free)
>> > no more responses from remote agent will acknowledged but if the response
>> > comes in between the cleanup in probe
>> > and the last command timing out we will see a race since the response can
>> > come asynchronously. In this scenario cleanup
>> > and scmi_rx_callback race with each other.
>> > I believe to solve this we need to synchronize cleanup with
>> > scmi_rx_callback. we can serialize these two paths
>> > and exit early in rx_callback if cleanup has been completed.
>> >
>> 
>> Yes indeed, but my concern is also not to introduce to much contention
>> on the RX path (with irqsave spinlocking & friends), given that this 
>> racy
>> scenario has surely to be handled but it is also highly unlikely, so I 
>> don't
>> want to slow down all the rx path all the time.
>> 
>> So I tried something along this lines:
>> 
>> ----8<------
>> diff --git a/drivers/firmware/arm_scmi/common.h 
>> b/drivers/firmware/arm_scmi/common.h
>> index dea1bfbe1052..036f8ccff450 100644
>> --- a/drivers/firmware/arm_scmi/common.h
>> +++ b/drivers/firmware/arm_scmi/common.h
>> @@ -340,11 +340,13 @@ void scmi_protocol_release(const struct 
>> scmi_handle *handle, u8 protocol_id);
>>   *	 channel
>>   * @handle: Pointer to SCMI entity handle
>>   * @transport_info: Transport layer related information
>> + * @users: A refcount to track active users of this channel
>>   */
>>  struct scmi_chan_info {
>>  	struct device *dev;
>>  	struct scmi_handle *handle;
>>  	void *transport_info;
>> +	refcount_t users;
>>  };
>> 
>>  /**
>> diff --git a/drivers/firmware/arm_scmi/driver.c 
>> b/drivers/firmware/arm_scmi/driver.c
>> index b406b3f78f46..5814ed3f444e 100644
>> --- a/drivers/firmware/arm_scmi/driver.c
>> +++ b/drivers/firmware/arm_scmi/driver.c
>> @@ -678,6 +678,16 @@ static void scmi_handle_response(struct 
>> scmi_chan_info *cinfo,
>>  	scmi_xfer_command_release(info, xfer);
>>  }
>> 
>> +static inline bool scmi_acquire_channel(struct scmi_chan_info *cinfo)
>> +{
>> +	return refcount_inc_not_zero(&cinfo->users);
>> +}
>> +
>> +static inline void scmi_release_channel(struct scmi_chan_info *cinfo)
>> +{
>> +	return refcount_dec(&cinfo->users);
>> +}
>> +
>>  /**
>>   * scmi_rx_callback() - callback for receiving messages
>>   *
>> @@ -695,6 +705,10 @@ void scmi_rx_callback(struct scmi_chan_info 
>> *cinfo, u32 msg_hdr, void *priv)
>>  {
>>  	u8 msg_type = MSG_XTRACT_TYPE(msg_hdr);
>> 
>> +	/* Bail out if channel freed already */
>> +	if (!scmi_acquire_channel(cinfo))
>> +		return;
>> +
>>  	switch (msg_type) {
>>  	case MSG_TYPE_NOTIFICATION:
>>  		scmi_handle_notification(cinfo, msg_hdr, priv);
>> @@ -707,6 +721,8 @@ void scmi_rx_callback(struct scmi_chan_info 
>> *cinfo, u32 msg_hdr, void *priv)
>>  		WARN_ONCE(1, "received unknown msg_type:%d\n", msg_type);
>>  		break;
>>  	}
>> +
>> +	scmi_release_channel(cinfo);
>>  }
>> 
>>  /**
>> @@ -1506,10 +1522,27 @@ static int scmi_chan_setup(struct scmi_info 
>> *info, struct device *dev,
>>  		return ret;
>>  	}
>> 
>> +	refcount_set(&cinfo->users, 1);
>>  	cinfo->handle = &info->handle;
>>  	return 0;
>>  }
>> 
>> +static int scmi_chan_free(int id, void *p, void *data)
>> +{
>> +	struct scmi_chan_info *cinfo = p;
>> +	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
>> +
>> +	if (refcount_dec_and_test(&cinfo->users)) {
>> +		info->desc->ops->chan_free(id, cinfo, data);
>> +	} else {
>> +		/* Stall till the ongoing rx_callback completes */
>> +		spin_until_cond(refcount_read(&cinfo->users) == 0);
>> +		info->desc->ops->chan_free(id, cinfo, data);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static inline int
>>  scmi_txrx_setup(struct scmi_info *info, struct device *dev, int 
>> prot_id)
>>  {
>> @@ -1792,11 +1825,11 @@ static int scmi_cleanup_txrx_channels(struct 
>> scmi_info *info)
>>  	int ret;
>>  	struct idr *idr = &info->tx_idr;
>> 
>> -	ret = idr_for_each(idr, info->desc->ops->chan_free, idr);
>> +	ret = idr_for_each(idr, scmi_chan_free, idr);
>>  	idr_destroy(&info->tx_idr);
>> 
>>  	idr = &info->rx_idr;
>> -	ret = idr_for_each(idr, info->desc->ops->chan_free, idr);
>> +	ret = idr_for_each(idr, scmi_chan_free, idr);
>>  	idr_destroy(&info->rx_idr);
>> 
>>  	return ret;
>> 
>> ------8<-----
>> 
>> Can you give it a go on your setup ?
>> 
>> Beware it is not really tested on the racy error path (:P) and I could 
>> have
>> still missed something regarding synchro (and I expect an undesired 
>> refcount
>> warn on the scmi_release_channel too when the race is hit....but just 
>> to
>> experiment a bit for now and see if something like this could be 
>> enough while
>> avoiding further locking)
>> o
> 
> Looking back at this patch of mine, even though it could work for the
> racy issue at
> hand, it is currently clearly completely broken on the regular 
> unload/free
> flow since cinfo structs can be re-used multiple times.
> Sorry, please ignore this attempt, I'll rework in a more sensible way.
> 
> Thanks,
> Cristian
Hi Cristian
Thanks for looking into this. One more issue I see with this is cinfo is 
allocated
as part of device memory so it will be freed when probe exit path 
completes. So we can't
really be using that to check the refcount I guess? IMO this should be a 
global memory variable.
Thanks
Rishabh
