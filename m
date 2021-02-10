Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3595316763
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 14:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhBJNCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 08:02:34 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:61187 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231624AbhBJM5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:57:53 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612961859; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=PbC/OuvX3RajBPxHlNoIH5w45WS04qvTDDuZ2qWSpNk=; b=f8xcknHK43FU4ttEbPUEYXLG7XrYuk9E2R5clIQLIMhoPsgf8MStrmtit6CP2Ld9MkTor0AS
 dnCGjJ3rTiLduGnivZCrwYgYcgh9GJ1ySvCB44HVWiUDAXAOoU4WKGIc7kUWTHqDsxrCw6CI
 dy5wEKzEplM/tp/ftJ+QDIXsp2U=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 6023d81e81f6c45dcec9f1cc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Feb 2021 12:57:02
 GMT
Sender: guptap=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D8FCBC43464; Wed, 10 Feb 2021 12:57:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.1.6] (unknown [117.98.199.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: guptap)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5E205C433C6;
        Wed, 10 Feb 2021 12:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5E205C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=guptap@codeaurora.org
Subject: Re: [PATCH 01/10] mm/page-flags: introduce PageHighMemZone()
To:     Joonsoo Kim <js1304@gmail.com>, Vlastimil Babka <vbabka@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Eric Biederman <ebiederm@xmission.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <1587369582-3882-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1587369582-3882-2-git-send-email-iamjoonsoo.kim@lge.com>
 <20200420112010.GA5820@bombadil.infradead.org>
 <2c45bab6-8c29-e227-56b8-307e8bee46c6@suse.cz>
 <CAAmzW4PUHw4utuS3tzMDFWqjDwUu14z8u=kxJa4wVEfEynFr1g@mail.gmail.com>
From:   Prakash Gupta <guptap@codeaurora.org>
Message-ID: <1b13af90-6e76-bde7-e861-5eb99c249e1d@codeaurora.org>
Date:   Wed, 10 Feb 2021 18:26:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAAmzW4PUHw4utuS3tzMDFWqjDwUu14z8u=kxJa4wVEfEynFr1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/21/2020 12:13 PM, Joonsoo Kim wrote:
> This patchset is a preparation for my future patchset "mm/cma: manage the memory
> of the CMA area by using the ZONE_MOVABLE" [1] to solve the many CMA problems.
>
> CMA areas can be on the all the memory range, from ZONE_DMA to ZONE_HIGHMEM.
> And, in my future patchset [1], all the CMA areas are managed through
> the ZONE_MOVABLE
> and the range of the ZONE_MOVABLE is extended to cover all the CMA
> areas. In this
> case, following scenario would be possible.
>
> CMA area 1: 32MB size on the memory range 16MB~48MB (originally on the
> ZONE_NORMAL)
> CMA area 2: 32MB size on the memory range 896MB~928MB (originally on
> the ZONE_HIGHMEM)
>
> With my future patchset [1], ZONE_MOVABLE manages all the pages from
> CMA area 1 and 2.
> So, ZONE_MOVABLE has both direct mapped page and un-mapped page. Since one zone
> has two types of pages, current PageHighMem() implemented by using
> zone index could not
> work correctly. So, I make this patchset to change the PagHighMem()
> implementation.

Hello Joonsoo,

Resurrecting this thread. I wanted to check if you are still working on [1].

If yes, would you be posting it soon.

I think these would be useful for high CMA system.


Thanks,

Prakash


