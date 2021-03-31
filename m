Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00FC34F98D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 09:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbhCaHMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 03:12:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:34328 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233895AbhCaHMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 03:12:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7CC63AFFA;
        Wed, 31 Mar 2021 07:12:00 +0000 (UTC)
To:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc:     "Ewan D. Milne" <emilne@redhat.com>,
        Daniel Wagner <dwagner@suse.de>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
References: <20210301175601.116405-1-dwagner@suse.de>
 <6b51a989-5551-e243-abda-5872411ec3ff@grimberg.me>
 <20210311094345.ogm2lxqfuszktuhp@beryllium.lan>
 <70af5b02-10c1-ab0b-1dfc-5906216871b4@grimberg.me>
 <2fc7a320c86f75507584453dd2fbd744de5c170d.camel@redhat.com>
 <ed3ccac0-79ed-fe10-89eb-d403820b4c6a@grimberg.me>
 <20210330232813.GA1935968@dhcp-10-100-145-180.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2] nvme-tcp: Check if request has started before
 processing it
Message-ID: <e4bee13c-647a-55ff-2017-27ccfc314973@suse.de>
Date:   Wed, 31 Mar 2021 09:11:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210330232813.GA1935968@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/21 1:28 AM, Keith Busch wrote:
> On Tue, Mar 30, 2021 at 10:34:25AM -0700, Sagi Grimberg wrote:
>>
>>>> It is, but in this situation, the controller is sending a second
>>>> completion that results in a use-after-free, which makes the
>>>> transport irrelevant. Unless there is some other flow (which is
>>>> unclear
>>>> to me) that causes this which is a bug that needs to be fixed rather
>>>> than hidden with a safeguard.
>>>>
>>>
>>> The kernel should not crash regardless of any network traffic that is
>>> sent to the system.  It should not be possible to either intentionally
>>> of mistakenly contruct packets that will deny service in this way.
>>
>> This is not specific to nvme-tcp. I can build an rdma or pci controller
>> that can trigger the same crash... I saw a similar patch from Hannes
>> implemented in the scsi level, and not the individual scsi transports..
> 
> If scsi wants this too, this could be made generic at the blk-mq level.
> We just need to make something like blk_mq_tag_to_rq(), but return NULL
> if the request isn't started.
>  
>> I would also mention, that a crash is not even the scariest issue that
>> we can see here, because if the request happened to be reused we are
>> in the silent data corruption realm...
> 
> If this does happen, I think we have to come up with some way to
> mitigate it. We're not utilizing the full 16 bits of the command_id, so
> maybe we can append something like a generation sequence number that can
> be checked for validity.
> 
... which will be near impossible.
We can protect against crashing on invalid frames.
We can _not_ protect against maliciously crafted packets referencing any
random _existing_ tag; that's what TLS is for.

What we can do, though, is checking the 'state' field in the tcp
request, and only allow completions for commands which are in a state
allowing for completions.

Let's see if I can whip up a patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
