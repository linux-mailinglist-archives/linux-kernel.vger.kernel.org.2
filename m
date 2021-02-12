Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAEA319A25
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 08:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhBLHNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 02:13:18 -0500
Received: from foss.arm.com ([217.140.110.172]:33114 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhBLHNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 02:13:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E568113E;
        Thu, 11 Feb 2021 23:12:30 -0800 (PST)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 107CF3F73D;
        Thu, 11 Feb 2021 23:12:26 -0800 (PST)
Subject: Re: [PATCH 1/3] mm/page_alloc: Fix pageblock_order when
 HUGETLB_PAGE_ORDER >= MAX_ORDER
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, akpm@linux-foundation.org,
        will@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        David Hildenbrand <david@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <1613024531-19040-1-git-send-email-anshuman.khandual@arm.com>
 <1613024531-19040-2-git-send-email-anshuman.khandual@arm.com>
 <20210211080056.GA14448@lst.de>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <b372dcf8-0ccf-8ef2-1375-053da65d4aa9@arm.com>
Date:   Fri, 12 Feb 2021 12:42:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210211080056.GA14448@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/11/21 1:30 PM, Christoph Hellwig wrote:
>> -	if (HPAGE_SHIFT > PAGE_SHIFT)
>> +	if ((HPAGE_SHIFT > PAGE_SHIFT) && (HUGETLB_PAGE_ORDER < MAX_ORDER))
> 
> No need for the braces.

Will drop them.
