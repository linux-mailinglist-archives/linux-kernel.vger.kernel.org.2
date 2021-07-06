Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD403BC452
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 02:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbhGFASv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 20:18:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229729AbhGFASu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 20:18:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C8C261369;
        Tue,  6 Jul 2021 00:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625530572;
        bh=fqgzG4+YdYoZurlm67YVOrIFeRf44ClBBF+6X3iuwcQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eCJQMY5HKRT2+u6RtUoTlB8PcxLAr5pgMWFH7Ao/crZh0YbROxhfTm0UnfEkl+0qO
         ix9MDz60WwZxOEQnMAgupiPgeEeuj0BbrFroqE6cpIKmu7bO6x4e/NtSQIQJebixsQ
         z9y558GVFtIHaTA/f1QST5mopjTvr1/DE/7G4NcgEaVrYE9r4/CXmjERSXpeL8I7i1
         W/SvbYuBie6NFVs7uo//DhBxVDm60QNzaQrlzDKmWo92MsqWEx3LC9d0JXkJJJImn4
         hPHuU7jbz5BZFhv51PImowmsY90oo+5i10ps0+Q4jLbgxWw3EQplCBJf5uO3287COe
         r0YfW4QzuCrtg==
Subject: Re: [f2fs-dev] [PATCH] f2fs: initialize page->private when using for
 our internal use
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org
References: <20210705052216.831989-1-jaegeuk@kernel.org>
 <c32642d6-6de2-eb2d-5771-c7cefa62fab5@kernel.org>
 <YOLJW0IgCagMk2tF@google.com>
 <e2fdf628-f25c-7495-cfd1-952899f7ff9a@kernel.org>
 <YOLxZAnaKSwBIlK9@casper.infradead.org>
 <5ab8d01a-8fac-60b2-9c2c-a32c5a81b394@kernel.org>
 <YONKKOBwPUdORO59@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <5700f9ec-20e9-7de9-7f8e-c11ec7279c20@kernel.org>
Date:   Tue, 6 Jul 2021 08:16:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YONKKOBwPUdORO59@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/6 2:06, Jaegeuk Kim wrote:
> On 07/06, Chao Yu wrote:
>> On 2021/7/5 19:47, Matthew Wilcox wrote:
>>> On Mon, Jul 05, 2021 at 07:33:35PM +0800, Chao Yu wrote:
>>>> On 2021/7/5 16:56, Jaegeuk Kim wrote:
>>>>> On 07/05, Chao Yu wrote:
>>>>>> On 2021/7/5 13:22, Jaegeuk Kim wrote:
>>>>>>> We need to guarantee it's initially zero. Otherwise, it'll hurt entire flag
>>>>>>> operations.
>>>>>>
>>>>>> Oops, I didn't get the point, shouldn't .private be zero after page was
>>>>>> just allocated by filesystem? What's the case we will encounter stall
>>>>>> private data left in page?
>>>>>
>>>>> I'm seeing f2fs_migrate_page() has the newpage with some value without Private
>>>>> flag. That causes a kernel panic later due to wrong private flag used in f2fs.
>>>>
>>>> I'm not familiar with that part of codes, so Cc mm mailing list for help.
>>>>
>>>> My question is newpage in .migrate_page() may contain non-zero value in .private
>>>> field but w/o setting PagePrivate flag, is it a normal case?
>>>
>>> I think freshly allocated pages have a page->private of 0.  ie this
>>> code in mm/page_alloc.c:
>>>
>>>                   page = rmqueue(ac->preferred_zoneref->zone, zone, order,
>>>                                   gfp_mask, alloc_flags, ac->migratetype);
>>>                   if (page) {
>>>                           prep_new_page(page, order, gfp_mask, alloc_flags);
>>>
>>> where prep_new_page() calls post_alloc_hook() which contains:
>>>           set_page_private(page, 0);
>>>
>>> Now, I do see in __buffer_migrate_page() (mm/migrate.c):
>>>
>>>           attach_page_private(newpage, detach_page_private(page));
>>>
>>> but as far as I can tell, f2fs doesn't call any of the
>>> buffer_migrate_page() paths.  So I'm not sure why you're seeing
>>> a non-zero page->private.
>>
>> Well, that's strange.
>>
>> Jaegeuk, let's add a BUGON in f2fs to track the call path where newpage
>> has non-zero private value? if this issue is reproducible.
> 
> We can debug anything tho, this issue is blocking the production, and I'd
> like to get this in this merge windows. Could you please check the patch
> has any holes?

The code looks good to me,

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> 
>>
>> Thanks,
>>
>>>
