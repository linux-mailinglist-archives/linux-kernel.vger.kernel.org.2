Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429043106B0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 09:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhBEIae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 03:30:34 -0500
Received: from foss.arm.com ([217.140.110.172]:51880 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229466AbhBEIac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 03:30:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB71331B;
        Fri,  5 Feb 2021 00:29:45 -0800 (PST)
Received: from [10.163.93.198] (unknown [10.163.93.198])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F6733F73B;
        Fri,  5 Feb 2021 00:29:42 -0800 (PST)
Subject: Re: [RFC 2/3] arm64/hugetlb: Enable HUGETLB_PAGE_SIZE_VARIABLE
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        akpm@linux-foundation.org
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <1612422084-30429-1-git-send-email-anshuman.khandual@arm.com>
 <1612422084-30429-3-git-send-email-anshuman.khandual@arm.com>
 <616578ec-8a61-ce0a-a467-50915b3a9967@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <ca668991-4ea1-6476-8be0-8c0db96a682e@arm.com>
Date:   Fri, 5 Feb 2021 14:00:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <616578ec-8a61-ce0a-a467-50915b3a9967@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/5/21 1:50 PM, David Hildenbrand wrote:
> On 04.02.21 08:01, Anshuman Khandual wrote:
>> MAX_ORDER which invariably depends on FORCE_MAX_ZONEORDER can be a variable
>> for a given page size, depending on whether TRANSPARENT_HUGEPAGE is enabled
>> or not. In certain page size and THP combinations HUGETLB_PAGE_ORDER can be
>> greater than MAX_ORDER, making it unusable as pageblock_order.
> 
> Just so I understand correctly, this does not imply that we have THP that exceed the pageblock size / MAX_ORDER size, correct?

Correct. MAX_ORDER gets incremented when THP is enabled.

config FORCE_MAX_ZONEORDER
        int
        default "14" if (ARM64_64K_PAGES && TRANSPARENT_HUGEPAGE)
        default "12" if (ARM64_16K_PAGES && TRANSPARENT_HUGEPAGE)
        default "11"
