Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE95337579E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 17:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235461AbhEFPjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 11:39:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:40524 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236071AbhEFPhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 11:37:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 398A7AC36;
        Thu,  6 May 2021 15:36:33 +0000 (UTC)
To:     Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
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
 <756aef10-e693-276f-82ac-514a2832b07f@grimberg.me>
From:   Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Subject: Re: [PATCH v2] nvme-tcp: Check if request has started before
 processing it
Message-ID: <492b8393-fc35-f58a-3768-94632a083c93@suse.de>
Date:   Thu, 6 May 2021 17:36:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <756aef10-e693-276f-82ac-514a2832b07f@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/21 12:37 AM, Sagi Grimberg wrote:
> 
>>>>> It is, but in this situation, the controller is sending a second
>>>>> completion that results in a use-after-free, which makes the
>>>>> transport irrelevant. Unless there is some other flow (which is
>>>>> unclear
>>>>> to me) that causes this which is a bug that needs to be fixed rather
>>>>> than hidden with a safeguard.
>>>>>
>>>>
>>>> The kernel should not crash regardless of any network traffic that is
>>>> sent to the system.  It should not be possible to either intentionally
>>>> of mistakenly contruct packets that will deny service in this way.
>>>
>>> This is not specific to nvme-tcp. I can build an rdma or pci controller
>>> that can trigger the same crash... I saw a similar patch from Hannes
>>> implemented in the scsi level, and not the individual scsi transports..
>>
>> If scsi wants this too, this could be made generic at the blk-mq level.
>> We just need to make something like blk_mq_tag_to_rq(), but return NULL
>> if the request isn't started.
> 
> Makes sense...
> 
>>> I would also mention, that a crash is not even the scariest issue that
>>> we can see here, because if the request happened to be reused we are
>>> in the silent data corruption realm...
>>
>> If this does happen, I think we have to come up with some way to
>> mitigate it. We're not utilizing the full 16 bits of the command_id, so
>> maybe we can append something like a generation sequence number that can
>> be checked for validity.
> 
> That's actually a great idea. scsi needs unique tags so it encodes the
> hwq in the upper 16 bits giving the actual tag the lower 16 bits which
> is more than enough for a single queue. We can do the same with
> a gencnt that will increment in both submission and completion and we
> can validate against it.
> 
> This will be useful for all transports, so maintaining it in
> nvme_req(rq)->genctr and introducing a helper like:
> rq = nvme_find_tag(tagset, cqe->command_id)
> That will filter genctr, locate the request.
> 
> Also:
> nvme_validate_request_gen(rq, cqe->command_id) that would
> compare against it.
> 
> 
> And then a helper to set the command_id like:
> cmd->common.command_id = nvme_request_command_id(rq)
> that will both increment the genctr and build a command_id
> from it.
> 
> Thoughts?
> 

Well, that would require a modification to the CQE specification, no?
fmds was not amused when I proposed that :-(

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)
