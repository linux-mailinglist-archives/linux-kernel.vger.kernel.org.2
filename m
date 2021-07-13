Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D4C3C6802
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 03:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbhGMBXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 21:23:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59267 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233668AbhGMBXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 21:23:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626139235;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LFDPWJMPXLTaGBNimWBNvQUJexQfku2Sy2ULaI6Wx8A=;
        b=f5pbdjGt/pTM01bufjvzr8IjwugaDiBSqQVG1JpTD5TVjM2/+qpMRtNznP7odyF4uZd4wT
        s7XS93jb/oNXul4nFP795v491fJksfB7k9zoZtdB4dTdQPYs4axngYh36bGHLADLY2UjCr
        Mb9a3rJPrX7MMO0Tj4yW09zq5Hv9VRM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-VyItZFU6NKWe2o5virut4g-1; Mon, 12 Jul 2021 21:20:31 -0400
X-MC-Unique: VyItZFU6NKWe2o5virut4g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24EA25074B;
        Tue, 13 Jul 2021 01:20:30 +0000 (UTC)
Received: from [10.64.54.119] (vpn2-54-119.bne.redhat.com [10.64.54.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 376375C232;
        Tue, 13 Jul 2021 01:20:26 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH 00/12] mm/debug_vm_pgtable: Enhancements
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, shan.gavin@gmail.com,
        chuhu@redhat.com
References: <20210706061748.161258-1-gshan@redhat.com>
 <42a26202-10f7-e744-3fc5-c9e5a7445193@arm.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <a8539200-35ac-2478-c763-e13c95556b25@redhat.com>
Date:   Tue, 13 Jul 2021 11:20:23 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <42a26202-10f7-e744-3fc5-c9e5a7445193@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On 7/12/21 2:14 PM, Anshuman Khandual wrote:
> Though I have not jumped into the details for all individual
> patches here but still have some high level questions below.
> 
> On 7/6/21 11:47 AM, Gavin Shan wrote:
>> There are couple of issues with current implementations and this series
>> tries to resolve the issues:
>>
>>    (a) All needed information are scattered in variables, passed to various
>>        test functions. The code is organized in pretty much relaxed fashion.
> All these variables are first prepared in debug_vm_pgtable(), before
> getting passed into respective individual test functions. Also these
> test functions receive only the required number of variables not all.
> Adding a structure that captures all test parameters at once before
> passing them down will be unnecessary. I am still wondering what will
> be the real benefit of this large code churn ?
> 

Thanks for your review. There are couple of reasons to have "struct vm_pgtable_debug".

(1) With the struct, the old and new implementation can coexist. In this way,
     the patches in this series can be stacked up easily.
(2) I think passing single struct to individual test functions improves the
     code readability. Besides, it also makes the empty stubs simplified.
(3) The code can be extended easily if we need in future.

>>
>>    (b) The page isn't allocated from buddy during page table entry modifying
>>        tests. The page can be invalid, conflicting to the implementations
>>        of set_{pud, pmd, pte}_at() on ARM64. The target page is accessed
>>        so that the iCache can be flushed when execution permission is given
>>        on ARM64. Besides, the target page can be unmapped and access to
>>        it causes kernel crash.
> 
> Using 'start_kernel' based method for struct page usage, enabled this
> test to run on platforms which might not have enough memory required
> for various individual test functions. This method is not a problem for
> tests that just need an aligned pfn (which creates a page table entry)
> not a real struct page.
> 
> But not allocating and owning the struct page might be problematic for
> tests that expect a real struct page and transform its state via set_
> {pud, pmd, pte}_at() functions as reported here.
> 

Yeah, I totally agree. The series follows what you explained: Except the
test cases where set_{pud, pmd, pte}_at() is used, the allocated page
is used. For other test cases, 'start_kernel' based PFN is used as before.

>>
>> "struct vm_pgtable_debug" is introduced to address issue (a). For issue
>> (b), the used page is allocated from buddy in page table entry modifying
>> tests. The corresponding tets will be skipped if we fail to allocate the
>> (huge) page. For other test cases, the original page around to kernel
>> symbol (@start_kernel) is still used.
> 
> For all basic pfn requiring tests, existing 'start_kernel' based method
> should continue but allocate a struct page for other tests which change
> the passed struct page. Skipping the tests when allocation fails is the
> right thing to do.
> 

Yes, it's exactly what this series does. Hope you can jump into the details
when you get a chance :)

Thanks,
Gavin

