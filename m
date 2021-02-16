Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C9331C79E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 09:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhBPIvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 03:51:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:39048 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229896AbhBPIvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 03:51:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3C4DFAE19;
        Tue, 16 Feb 2021 08:51:01 +0000 (UTC)
Subject: Re: [PATCH] nvme-tcp: Check if request has started before processing
 it
To:     Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>,
        linux-kernel@vger.kernel.org
References: <20210212181738.79274-1-dwagner@suse.de>
 <c3a682d3-58f7-f5cc-caaa-75c36ca464e2@grimberg.me>
 <20210212210929.GA3851@redsun51.ssa.fujisawa.hgst.com>
 <ddf87227-1ad3-b8be-23ba-460433f70a85@grimberg.me>
 <73e4914e-f867-c899-954d-4b61ae2b4c33@suse.de>
 <5b45835b-eb81-29e8-e319-a8509474e27f@grimberg.me>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <a18701ad-6880-37bb-7978-7ea6b7079c9e@suse.de>
Date:   Tue, 16 Feb 2021 09:51:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <5b45835b-eb81-29e8-e319-a8509474e27f@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/21 10:23 PM, Sagi Grimberg wrote:
> 
>>>>>> blk_mq_tag_to_rq() will always return a request if the command_id is
>>>>>> in the valid range. Check if the request has been started. If we
>>>>>> blindly process the request we might double complete a request which
>>>>>> can be fatal.
>>>>>
>>>>> How did you get to this one? did the controller send a completion for
>>>>> a completed/bogus request?
>>>>
>>>> If that is the case, then that must mean it's possible the driver could
>>>> have started the command id just before the bogus completion check. 
>>>> Data
>>>> iorruption, right?
>>>
>>> Yes, which is why I don't think this check is very useful..
>>
>> I actually view that as a valid protection against spoofed frames.
>> Without it it's easy to crash the machine by injecting fake 
>> completions with random command ids.
> 
> And this doesn't help because the command can have been easily reused
> and started... What is this protecting against? Note that none of the
> other transports checks that, why should tcp?

Because it's particularly easy to spoof packets on tcp.
All other nvme-of transports are layered on top of other transports 
which do some sanity checks already, so it becomes really hard to inject 
invalid NVMe-oF frames for those.
NVMe-TCP has none of these protections, making it really easy to inject 
faulty frames (or, heaven forbid, running a packet fuzzer).

And crashing the machine on invalid frames is always a bad idea; I would 
have expected NVMe-TCP to drop them.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
