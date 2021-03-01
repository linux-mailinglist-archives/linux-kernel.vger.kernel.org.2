Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C2E328EBE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 20:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242223AbhCATfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 14:35:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:45164 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236420AbhCAQyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 11:54:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 61522AE05;
        Mon,  1 Mar 2021 16:53:26 +0000 (UTC)
Subject: Re: [PATCH] nvme-tcp: Check if request has started before processing
 it
To:     Keith Busch <kbusch@kernel.org>
Cc:     Daniel Wagner <dwagner@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <73e4914e-f867-c899-954d-4b61ae2b4c33@suse.de>
 <20210215104020.yyithlo2hkxqvguj@beryllium.lan>
 <a2064070-b511-ba6d-bd64-0b3abc208356@grimberg.me>
 <20210226123534.4oovbzk4wrnfjp64@beryllium.lan>
 <9e209b12-3771-cdca-2c9d-50451061bd2a@suse.de>
 <20210226161355.GG31593@redsun51.ssa.fujisawa.hgst.com>
 <a42d6285-ff32-3e16-b2b1-808d29f2a743@suse.de>
 <20210226171901.GA3949@redsun51.ssa.fujisawa.hgst.com>
 <20210301132639.n3eowtvkms2n5mog@beryllium.lan>
 <786dcef5-148d-ff34-590c-804b331ac519@suse.de>
 <20210301160547.GB17228@redsun51.ssa.fujisawa.hgst.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <b626504c-3427-e8a5-3502-e44a9e79a006@suse.de>
Date:   Mon, 1 Mar 2021 17:53:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210301160547.GB17228@redsun51.ssa.fujisawa.hgst.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/21 5:05 PM, Keith Busch wrote:
> On Mon, Mar 01, 2021 at 02:55:30PM +0100, Hannes Reinecke wrote:
>> On 3/1/21 2:26 PM, Daniel Wagner wrote:
>>> On Sat, Feb 27, 2021 at 02:19:01AM +0900, Keith Busch wrote:
>>>> Crashing is bad, silent data corruption is worse. Is there truly no
>>>> defense against that? If not, why should anyone rely on this?
>>>
>>> If we receive an response for which we don't have a started request, we
>>> know that something is wrong. Couldn't we in just reset the connection
>>> in this case? We don't have to pretend nothing has happened and
>>> continuing normally. This would avoid a host crash and would not create
>>> (more) data corruption. Or I am just too naive?
>>>
>> This is actually a sensible solution.
>> Please send a patch for that.
> 
> Is a bad frame a problem that can be resolved with a reset?
> 
> Even if so, the reset doesn't indicate to the user if previous commands
> completed with bad data, so it still seems unreliable.
> 
We need to distinguish two cases here.
The one is use receiving a frame with an invalid tag, leading to a 
crash. This can be easily resolved by issuing a reset, as clearly the 
command was garbage and we need to invoke error handling (which is reset).

The other case is us receiving a frame with a _duplicate_ tag, ie a tag 
which is _currently_ valid. This is a case which will fail _even now_, 
as we have simply no way of detecting this.

So what again do we miss by fixing the first case?
Apart from a system which does _not_ crash?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
