Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240C93265C6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 17:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhBZQns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 11:43:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:41504 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230213AbhBZQn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 11:43:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 02C2CAE91;
        Fri, 26 Feb 2021 16:42:47 +0000 (UTC)
Subject: Re: [PATCH] nvme-tcp: Check if request has started before processing
 it
To:     Keith Busch <kbusch@kernel.org>
Cc:     Daniel Wagner <dwagner@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210212181738.79274-1-dwagner@suse.de>
 <c3a682d3-58f7-f5cc-caaa-75c36ca464e2@grimberg.me>
 <20210212210929.GA3851@redsun51.ssa.fujisawa.hgst.com>
 <ddf87227-1ad3-b8be-23ba-460433f70a85@grimberg.me>
 <73e4914e-f867-c899-954d-4b61ae2b4c33@suse.de>
 <20210215104020.yyithlo2hkxqvguj@beryllium.lan>
 <a2064070-b511-ba6d-bd64-0b3abc208356@grimberg.me>
 <20210226123534.4oovbzk4wrnfjp64@beryllium.lan>
 <9e209b12-3771-cdca-2c9d-50451061bd2a@suse.de>
 <20210226161355.GG31593@redsun51.ssa.fujisawa.hgst.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <a42d6285-ff32-3e16-b2b1-808d29f2a743@suse.de>
Date:   Fri, 26 Feb 2021 17:42:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210226161355.GG31593@redsun51.ssa.fujisawa.hgst.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/21 5:13 PM, Keith Busch wrote:
> On Fri, Feb 26, 2021 at 01:54:00PM +0100, Hannes Reinecke wrote:
>> On 2/26/21 1:35 PM, Daniel Wagner wrote:
>>> On Mon, Feb 15, 2021 at 01:29:45PM -0800, Sagi Grimberg wrote:
>>>> Well, I think we should probably figure out why that is happening first.
>>>
>>> I got my hands on a tcpdump trace. I've trimmed it to this:
>>>
[ .. ]
>>> NVM Express Fabrics TCP
>>>       Pdu Type: CapsuleResponse (5)
>>>       Pdu Specific Flags: 0x00
>>>           .... ...0 = PDU Header Digest: Not set
>>>           .... ..0. = PDU Data Digest: Not set
>>>           .... .0.. = PDU Data Last: Not set
>>>           .... 0... = PDU Data Success: Not set
>>>       Pdu Header Length: 24
>>>       Pdu Data Offset: 0
>>>       Packet Length: 24
>>>       Unknown Data: 02000400000000001b0000001f000000
>>>
>>> 0000  00 00 0c 9f f5 a8 b4 96 91 41 16 c0 08 00 45 00   .........A....E.
>>> 0010  00 4c 00 00 40 00 40 06 00 00 0a e4 26 af 0a e4   .L..@.@.....&...
>>> 0020  c2 1e 11 44 88 4f b8 58 90 ec 8e 1b 32 ed 80 18   ...D.O.X....2...
>>> 0030  01 01 fe d3 00 00 01 01 08 0a e6 ed ac be d6 a3   ................
>>> 0040  5d 0c 05 00 18 00 18 00 00 00 02 00 04 00 00 00   ]...............
>>> 0050  00 00 1b 00 00 00 1f 00 00 00                     ..........
>>>
>> As I suspected, we did receive an invalid frame.
>> Data digest would have saved us, but then it's not enabled.
>>
>> So we do need to check if the request is valid before processing it.
> 
> That's just addressing a symptom. You can't fully verify the request is
> valid this way because the host could have started the same command ID
> the very moment before the code checks it, incorrectly completing an
> in-flight command and getting data corruption.
> 
Oh, I am fully aware.

Bad frames are just that, bad frames.
We can only fully validate that when digests are enabled, but I gather 
that controllers sending out bad frames wouldn't want to enable digests, 
either. So relying on that is possibly not an option.

So really what I'm trying to avoid is the host crashing on a bad frame.
That kind of thing always resonates bad with customers.
And tripping over an uninitialized command is just too stupid IMO.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
