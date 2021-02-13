Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3454431AA8D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 09:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhBMIr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 03:47:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:33106 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhBMIrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 03:47:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8ECD7AC32;
        Sat, 13 Feb 2021 08:46:42 +0000 (UTC)
Subject: Re: [PATCH] nvme-tcp: Check if request has started before processing
 it
To:     Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Cc:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@fb.com>
References: <20210212181738.79274-1-dwagner@suse.de>
 <c3a682d3-58f7-f5cc-caaa-75c36ca464e2@grimberg.me>
 <20210212210929.GA3851@redsun51.ssa.fujisawa.hgst.com>
 <ddf87227-1ad3-b8be-23ba-460433f70a85@grimberg.me>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <73e4914e-f867-c899-954d-4b61ae2b4c33@suse.de>
Date:   Sat, 13 Feb 2021 09:46:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <ddf87227-1ad3-b8be-23ba-460433f70a85@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/21 10:49 PM, Sagi Grimberg wrote:
> 
>>>> blk_mq_tag_to_rq() will always return a request if the command_id is
>>>> in the valid range. Check if the request has been started. If we
>>>> blindly process the request we might double complete a request which
>>>> can be fatal.
>>>
>>> How did you get to this one? did the controller send a completion for
>>> a completed/bogus request?
>>
>> If that is the case, then that must mean it's possible the driver could
>> have started the command id just before the bogus completion check. Data
>> iorruption, right?
> 
> Yes, which is why I don't think this check is very useful..

I actually view that as a valid protection against spoofed frames.
Without it it's easy to crash the machine by injecting fake completions 
with random command ids.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
