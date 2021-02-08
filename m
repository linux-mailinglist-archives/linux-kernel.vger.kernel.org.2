Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76C03131FB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 13:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhBHMPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 07:15:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:36812 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232854AbhBHLz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 06:55:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612785280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lzj0M0ODVg7irUOYnOdjiNxBrgsVBdOtnhI9h2vRceY=;
        b=GqVgYoTCsAEXTwhIkrKe4y4fnUSBbqbfH23KdRhYyjhWoTUQxU2YjCKiSMxHC0q7DR7pAj
        BjGXzvTTXLSBHZOJetheHO6MsUo02OPb8NcEhBwEO5KrdYtca0SdCU0+ZoRAlBl5pJ6eUr
        VBFfB0utZwpC7HNrBYRpT1Y4P/IPkW8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 400A8AEC2;
        Mon,  8 Feb 2021 11:54:40 +0000 (UTC)
Subject: Re: [PATCH 7/7] xen/evtchn: read producer index only once
To:     =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
References: <20210206104932.29064-1-jgross@suse.com>
 <20210206104932.29064-8-jgross@suse.com>
 <72334160-cffe-2d8a-23b7-2ea9ab1d803a@suse.com>
 <626f500a-494a-0141-7bf3-94fb86b47ed4@suse.com>
 <e88526ac-6972-fe08-c58f-ea872cbdcc14@suse.com>
 <d0ca217c-ecc9-55f7-abb1-30a687a46b31@suse.com>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <a30db278-087b-554c-d5bf-1317e14e8508@suse.com>
Date:   Mon, 8 Feb 2021 12:54:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <d0ca217c-ecc9-55f7-abb1-30a687a46b31@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.02.2021 11:59, Jürgen Groß wrote:
> On 08.02.21 11:51, Jan Beulich wrote:
>> On 08.02.2021 11:41, Jürgen Groß wrote:
>>> On 08.02.21 10:48, Jan Beulich wrote:
>>>> On 06.02.2021 11:49, Juergen Gross wrote:
>>>>> In evtchn_read() use READ_ONCE() for reading the producer index in
>>>>> order to avoid the compiler generating multiple accesses.
>>>>>
>>>>> Signed-off-by: Juergen Gross <jgross@suse.com>
>>>>> ---
>>>>>    drivers/xen/evtchn.c | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/xen/evtchn.c b/drivers/xen/evtchn.c
>>>>> index 421382c73d88..f6b199b597bf 100644
>>>>> --- a/drivers/xen/evtchn.c
>>>>> +++ b/drivers/xen/evtchn.c
>>>>> @@ -211,7 +211,7 @@ static ssize_t evtchn_read(struct file *file, char __user *buf,
>>>>>    			goto unlock_out;
>>>>>    
>>>>>    		c = u->ring_cons;
>>>>> -		p = u->ring_prod;
>>>>> +		p = READ_ONCE(u->ring_prod);
>>>>>    		if (c != p)
>>>>>    			break;
>>>>
>>>> Why only here and not also in
>>>>
>>>> 		rc = wait_event_interruptible(u->evtchn_wait,
>>>> 					      u->ring_cons != u->ring_prod);
>>>>
>>>> or in evtchn_poll()? I understand it's not needed when
>>>> ring_prod_lock is held, but that's not the case in the two
>>>> afaics named places. Plus isn't the same then true for
>>>> ring_cons and ring_cons_mutex, i.e. aren't the two named
>>>> places plus evtchn_interrupt() also in need of READ_ONCE()
>>>> for ring_cons?
>>>
>>> The problem solved here is the further processing using "p" multiple
>>> times. p must not be silently replaced with u->ring_prod by the
>>> compiler, so I probably should reword the commit message to say:
>>>
>>> ... in order to not allow the compiler to refetch p.
>>
>> I still wouldn't understand the change (and the lack of
>> further changes) then: The first further use of p is
>> outside the loop, alongside one of c. IOW why would c
>> then not need treating the same as p?
> 
> Its value wouldn't change, as ring_cons is being modified only at
> the bottom of this function, and nowhere else (apart from the reset
> case, but this can't run concurrently due to ring_cons_mutex).
> 
>> I also still don't see the difference between latching a
>> value into a local variable vs a "freestanding" access -
>> neither are guaranteed to result in exactly one memory
>> access afaict.
> 
> READ_ONCE() is using a pointer to volatile, so any refetching by
> the compiler would be a bug.

Of course, but this wasn't my point. I was contrasting

		c = u->ring_cons;
		p = u->ring_prod;

which you change with

		rc = wait_event_interruptible(u->evtchn_wait,
					      u->ring_cons != u->ring_prod);

which you leave alone.

Jan
