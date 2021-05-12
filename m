Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700E237EB7D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380658AbhELTcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 15:32:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:38016 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346307AbhELRNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 13:13:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9EDD9B1BF;
        Wed, 12 May 2021 17:12:04 +0000 (UTC)
Subject: Re: [PATCH v1 7/8] null_blk: add error handling support for
 add_disk()
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210512064629.13899-1-mcgrof@kernel.org>
 <20210512064629.13899-8-mcgrof@kernel.org>
 <842b6a8d-8880-a0da-a38b-39378dc6ebb9@suse.de>
 <20210512164709.GA4332@42.do-not-panic.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <d519b9ce-ad28-a266-786f-4128e0b91b9f@suse.de>
Date:   Wed, 12 May 2021 19:12:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210512164709.GA4332@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/21 6:47 PM, Luis Chamberlain wrote:
> On Wed, May 12, 2021 at 05:16:39PM +0200, Hannes Reinecke wrote:
>> On 5/12/21 8:46 AM, Luis Chamberlain wrote:
>>> We never checked for errors on add_disk() as this function
>>> returned void. Now that this is fixed, use the shiny new
>>> error handling.
>>>
>>> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
>>> ---
>>>    drivers/block/null_blk/main.c | 9 +++++++--
>>>    1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
>>> index 5f006d9e1472..2346d1292b26 100644
>>> --- a/drivers/block/null_blk/main.c
>>> +++ b/drivers/block/null_blk/main.c
>>> @@ -1699,6 +1699,7 @@ static int init_driver_queues(struct nullb *nullb)
>>>    static int null_gendisk_register(struct nullb *nullb)
>>>    {
>>> +	int ret;
>>>    	sector_t size = ((sector_t)nullb->dev->size * SZ_1M) >> SECTOR_SHIFT;
>>>    	struct gendisk *disk;
>>> @@ -1719,13 +1720,17 @@ static int null_gendisk_register(struct nullb *nullb)
>>>    	strncpy(disk->disk_name, nullb->disk_name, DISK_NAME_LEN);
>>>    	if (nullb->dev->zoned) {
>>> -		int ret = null_register_zoned_dev(nullb);
>>> +		ret = null_register_zoned_dev(nullb);
>>>    		if (ret)
>>>    			return ret;
>>>    	}
>>> -	add_disk(disk);
>>> +	ret = add_disk(disk);
>>> +	if (ret) {
>>
>> unregister_zoned_device() ?
> 
> That function does not exist, do you mean null_free_zoned_dev()? If so
> that is done by the caller.
> 
What I intended to say is that you are calling 
'null_register_zoned_dev()' at one point, but don't call a cleanup 
function if there is an error later in the path, leaving the caller to 
guess whether null_register_zoned_dev() has been called or not.
So we should call the cleanup function here, too.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
