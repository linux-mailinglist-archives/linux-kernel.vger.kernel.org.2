Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C9533887A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbhCLJVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:21:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:44870 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232556AbhCLJVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:21:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CD17BAF49;
        Fri, 12 Mar 2021 09:21:08 +0000 (UTC)
Subject: Re: [PATCH v2] arm: print alloc free paths for address in registers
To:     maninder1.s@samsung.com,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "cl@linux.com" <cl@linux.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
References: <6f34c594-a840-30a5-5eb0-42b30844ec87@suse.cz>
 <1614239800-27549-1-git-send-email-maninder1.s@samsung.com>
 <CGME20210225075653epcas5p3d9551f01177d0c851c9c37f6ae84f38d@epcms5p6>
 <20210311105115epcms5p679b5dd4fb157f85a73f5a36632ee2c43@epcms5p6>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <9e517b50-de9d-4191-21d0-08f278091b62@suse.cz>
Date:   Fri, 12 Mar 2021 10:21:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210311105115epcms5p679b5dd4fb157f85a73f5a36632ee2c43@epcms5p6>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/21 11:51 AM, Maninder Singh wrote:
> Hi,
> 
>  
> 
>> Instead of your changes to SL*B, could you check mem_dump_obj() and others added
>> by Paul in 5.12-rc1?
> 
>> (+CC Paul, thus not trimming)
> 
>  
> 
> checked mem_dump_obj(), but it only provides path of allocation and not of free.
> 
> /**
>  * mem_dump_obj - Print available provenance information
> 
> ..
> 
>  * if available, the return address and stack trace from the allocation
>  * of that object.
>  */
> void mem_dump_obj(void *object)
> 
> and in case of "Use After Free", Free path is also required.
> 
> So we need to add support for free path in this API if we have to use it.

I think that would make sense.  

> Thanks,
> 
> Maninder Singh
> 

