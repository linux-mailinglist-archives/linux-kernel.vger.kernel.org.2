Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1494637EBB0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381846AbhELTf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 15:35:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:44562 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237832AbhELR4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 13:56:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 87A0AB20B;
        Wed, 12 May 2021 17:55:26 +0000 (UTC)
Subject: Re: [PATCH v1 8/8] block: add add_disk() failure injection support
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Akinobu Mita <akinobu.mita@gmail.com>
Cc:     axboe@kernel.dk, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210512064629.13899-1-mcgrof@kernel.org>
 <20210512064629.13899-9-mcgrof@kernel.org>
 <e938c21f-3872-232c-4956-dfa53aec579b@suse.de>
 <20210512165639.GB4332@42.do-not-panic.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <989175a7-5533-02ef-c096-b24b2769c9cf@suse.de>
Date:   Wed, 12 May 2021 19:55:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210512165639.GB4332@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/21 6:56 PM, Luis Chamberlain wrote:
> On Wed, May 12, 2021 at 05:22:48PM +0200, Hannes Reinecke wrote:
[ .. ]
>> So I'd rather delegate the topic of error injection to a more general
>> discussion (LSF springs to mind ...), and then agree on a framework which is
>> suitable for every function.
> 
> Or we just get cranking and produce proof of concepts to compare and
> contrast later. At least I hope this patch and the respective blktests
> patches suffice to help demo what we need to test.
> 
Yeah; I know; 'tis a hard topic.
(Will we have another ALPSS this year? Would be ideal to discuss things 
there. Christoph?)

What I would love to see is to facilitate kernel live patching for 
testing, blanking out the function body under test and just return 
specific error codes.
That would be _ideal_ for testing, as we don't have to modify the kernel 
at all, we just need to compile it with the appropriate compiler options 
for live patching.
And then we should be able compile modules for the functions to test, 
load the module, do the test, remove the module, and everything would be 
back to normal again.

I know, but one can dream ...

But maybe I can trick you in trying it ... hmm?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
