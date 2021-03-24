Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9DD347CFE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 16:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236714AbhCXPux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 11:50:53 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:34848 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236750AbhCXPuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:50:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 19BC23F4C3;
        Wed, 24 Mar 2021 16:50:10 +0100 (CET)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=P4M4/6D1;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
        URIBL_BLOCKED=0.001] autolearn=ham autolearn_force=no
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Yu7IkG0scZsZ; Wed, 24 Mar 2021 16:50:09 +0100 (CET)
Received: by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 1D9B73F4C0;
        Wed, 24 Mar 2021 16:50:07 +0100 (CET)
Received: from [10.249.254.166] (unknown [192.198.151.44])
        by mail1.shipmail.org (Postfix) with ESMTPSA id BEC513605CC;
        Wed, 24 Mar 2021 16:50:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1616601017; bh=LVYFmsFXj0e1zpHSjkB8DcFvTKZT5BbydC++etvHV1o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=P4M4/6D1LgeNspLbb2o1Hp54DiW0ZNauP1DTjhNR3h+MUyHSzrWyvMYSi1sIGu+er
         R2R+O2pCd3UrThkwmu/7GYJhshjSIt+My1In3wYMF5pgI/WTEkbOv27oayzhL5GGIv
         ltOwfYUHBp3R1b3g9VhVSeW2Cd+h0VLlXj7AHJ/w=
Subject: Re: [RFC PATCH 1/2] mm,drm/ttm: Block fast GUP to TTM huge pages
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Koenig <christian.koenig@amd.com>
References: <20210321184529.59006-2-thomas_os@shipmail.org>
 <YFnST5VLcEgv9q+s@phenom.ffwll.local>
 <314fc020-d243-dbf0-acb3-ecfcc9c2443c@shipmail.org>
 <20210323163715.GJ2356281@nvidia.com>
 <5824b731-ca6a-92fd-e314-d986b6a7b101@shipmail.org>
 <YFsM23t2niJwhpM/@phenom.ffwll.local> <20210324122430.GW2356281@nvidia.com>
 <e12e2c49-afaf-dbac-b18c-272c93c83e06@shipmail.org>
 <20210324124127.GY2356281@nvidia.com>
 <6c9acb90-8e91-d8af-7abd-e762d9a901aa@shipmail.org>
 <20210324134833.GE2356281@nvidia.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Message-ID: <0b984f96-00fb-5410-bb16-02e12b2cc024@shipmail.org>
Date:   Wed, 24 Mar 2021 16:50:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210324134833.GE2356281@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/24/21 2:48 PM, Jason Gunthorpe wrote:
> On Wed, Mar 24, 2021 at 02:35:38PM +0100, Thomas Hellström (Intel) wrote:
>
>>> In an ideal world the creation/destruction of page table levels would
>>> by dynamic at this point, like THP.
>> Hmm, but I'm not sure what problem we're trying to solve by changing the
>> interface in this way?
> We are trying to make a sensible driver API to deal with huge pages.
>   
>> Currently if the core vm requests a huge pud, we give it one, and if we
>> can't or don't want to (because of dirty-tracking, for example, which is
>> always done on 4K page-level) we just return VM_FAULT_FALLBACK, and the
>> fault is retried at a lower level.
> Well, my thought would be to move the pte related stuff into
> vmf_insert_range instead of recursing back via VM_FAULT_FALLBACK.
>
> I don't know if the locking works out, but it feels cleaner that the
> driver tells the vmf how big a page it can stuff in, not the vm
> telling the driver to stuff in a certain size page which it might not
> want to do.
>
> Some devices want to work on a in-between page size like 64k so they
> can't form 2M pages but they can stuff 64k of 4K pages in a batch on
> every fault.

Hmm, yes, but we would in that case be limited anyway to insert ranges 
smaller than and equal to the fault size to avoid extensive and possibly 
unnecessary checks for contigous memory. And then if we can't support 
the full fault size, we'd need to either presume a size and alignment of 
the next level or search for contigous memory in both directions around 
the fault address, perhaps unnecessarily as well. I do think the current 
interface works ok, as we're just acting on what the core vm tells us to do.

/Thomas

>
> That idea doesn't fit naturally if the VM is driving the size.
>
> Jason
