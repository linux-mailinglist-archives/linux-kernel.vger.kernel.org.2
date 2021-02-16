Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A30F31C7CB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 10:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhBPJGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 04:06:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45794 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229991AbhBPJGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 04:06:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613466277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NKGsnpF0DwP41FkOz2ejwPVACGeq38/XH7vk2Mr5Zog=;
        b=ApMHUmtSpnIJkAAhag89tDhm/9lTdGmltwcTInHeijtQm+rFSCc/NAEhtjYKksmLdbiNXw
        Jz1M6/zFIDp2fA4VaZ2zEeAcqzhkJ3U8U9UZIDDodDuH3/Ra/eRlN/3xK1srrgzI67cQzL
        OSwY/npqU0hChLXfWzXtPs3W0pX++vE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-Lll_nZ2oNxqUAwYKWmpAUQ-1; Tue, 16 Feb 2021 04:04:34 -0500
X-MC-Unique: Lll_nZ2oNxqUAwYKWmpAUQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A5A91020C20;
        Tue, 16 Feb 2021 09:04:31 +0000 (UTC)
Received: from [10.36.114.70] (ovpn-114-70.ams2.redhat.com [10.36.114.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC869163F1;
        Tue, 16 Feb 2021 09:04:28 +0000 (UTC)
Subject: Re: [PATCH 0/3] mm/page_alloc: Fix pageblock_order with
 HUGETLB_PAGE_SIZE_VARIABLE
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        akpm@linux-foundation.org, will@kernel.org
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        Mark Rutland <mark.rutland@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <1613024531-19040-1-git-send-email-anshuman.khandual@arm.com>
 <683c812a-ce3d-ef74-10d1-eaf8a3ae93d4@redhat.com>
 <fb562021-9981-4434-cc4a-e813a7752adb@arm.com>
 <cb92e4a0-47fc-f461-3189-a99142bbed4c@redhat.com>
 <0609df35-dd69-54a7-e839-2d97d77e0016@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <337123b0-b2af-a522-3dfe-fd1098a0cad9@redhat.com>
Date:   Tue, 16 Feb 2021 10:04:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <0609df35-dd69-54a7-e839-2d97d77e0016@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>>
>> But again, if there are valid use cases then sure, let's make the code fully compatible with HUGETLB_PAGE_ORDER > MAX_ORDER.
> 
> Given that gigantic HugeTLB allocation can fallback on alloc_contig_pages()
> or CMA if/when available, is there a real need for HUGETLB_PAGE_ORDER to be
> upto MAX_ORDER, used as pageblock_order or as COMPACTION_HPAGE_ORDER ? With
> gigantic HugeTLB pages being available, HUGETLB_PAGE_ORDER seems to be just
> detached from the buddy allocator. But I am not sure, will keep looking.

Having HPAGE_PMD_ORDER >>= MAX_ORDER ("significantly larger") will make 
it very unlikely that you are able to reliably allocate any huge pages 
at all dynamically at runtime without CMA.

Gigantic pages are problematic by nature :)

-- 
Thanks,

David / dhildenb

