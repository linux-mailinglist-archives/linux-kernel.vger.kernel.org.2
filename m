Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF72E3BBC3D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 13:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhGELgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 07:36:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231126AbhGELgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 07:36:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5033961279;
        Mon,  5 Jul 2021 11:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625484818;
        bh=JCzbfrOBLEoTbgD6Ln3Es2DOUH5lhf543Bz5pCxk8ng=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jLGcleRG3bHdycKc+f5w7I/cPQkXKECKrOn7KDf8dDQ1lXJuG9XxiGqEHg8XBuMXg
         XvjlTmPRS0d5XLk0/f2+kJMvK/ouPg7pqdfEmi5UNknyoTYX+lvHt/99vhRR2BaYfw
         1GlmthWgxTVg62ebKiNrGiWh1MyO2sgMlZK50A8SbJEZPCVwPpFBWULOL+pVBd1QkE
         oKpGaCeL5OslaTC/rG3tRjGeCkMUyW8bExim71Pn6AXzahNuxesqY2CuwYx17Dqgwa
         Mpa4ryg3MYK6wABc99I2wu2ZYiL8oSjds8azi7O/pKnIdpyH+rY+XnTUEvkCgrEAY9
         Prsqfvqf4PRIg==
Subject: Re: [f2fs-dev] [PATCH] f2fs: initialize page->private when using for
 our internal use
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>
References: <20210705052216.831989-1-jaegeuk@kernel.org>
 <c32642d6-6de2-eb2d-5771-c7cefa62fab5@kernel.org>
 <YOLJW0IgCagMk2tF@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <e2fdf628-f25c-7495-cfd1-952899f7ff9a@kernel.org>
Date:   Mon, 5 Jul 2021 19:33:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOLJW0IgCagMk2tF@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/5 16:56, Jaegeuk Kim wrote:
> On 07/05, Chao Yu wrote:
>> On 2021/7/5 13:22, Jaegeuk Kim wrote:
>>> We need to guarantee it's initially zero. Otherwise, it'll hurt entire flag
>>> operations.
>>
>> Oops, I didn't get the point, shouldn't .private be zero after page was
>> just allocated by filesystem? What's the case we will encounter stall
>> private data left in page?
> 
> I'm seeing f2fs_migrate_page() has the newpage with some value without Private
> flag. That causes a kernel panic later due to wrong private flag used in f2fs.

I'm not familiar with that part of codes, so Cc mm mailing list for help.

My question is newpage in .migrate_page() may contain non-zero value in .private
field but w/o setting PagePrivate flag, is it a normal case?

Thanks,

> 
>>
>> Cc Matthew Wilcox.
>>
>> Thanks,
>>
>>>
>>> Fixes: b763f3bedc2d ("f2fs: restructure f2fs page.private layout")
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>    fs/f2fs/data.c | 2 ++
>>>    fs/f2fs/f2fs.h | 5 ++++-
>>>    2 files changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>> index 3a01a1b50104..d2cf48c5a2e4 100644
>>> --- a/fs/f2fs/data.c
>>> +++ b/fs/f2fs/data.c
>>> @@ -3819,6 +3819,8 @@ int f2fs_migrate_page(struct address_space *mapping,
>>>    		get_page(newpage);
>>>    	}
>>> +	/* guarantee to start from no stale private field */
>>> +	set_page_private(newpage, 0);
>>>    	if (PagePrivate(page)) {
>>>    		set_page_private(newpage, page_private(page));
>>>    		SetPagePrivate(newpage);
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>> index 65befc68d88e..ee8eb33e2c25 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -1331,7 +1331,8 @@ enum {
>>>    #define PAGE_PRIVATE_GET_FUNC(name, flagname) \
>>>    static inline bool page_private_##name(struct page *page) \
>>>    { \
>>> -	return test_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)) && \
>>> +	return PagePrivate(page) && \
>>> +		test_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)) && \
>>>    		test_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
>>>    }
>>> @@ -1341,6 +1342,7 @@ static inline void set_page_private_##name(struct page *page) \
>>>    	if (!PagePrivate(page)) { \
>>>    		get_page(page); \
>>>    		SetPagePrivate(page); \
>>> +		set_page_private(page, 0); \
>>>    	} \
>>>    	set_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)); \
>>>    	set_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
>>> @@ -1392,6 +1394,7 @@ static inline void set_page_private_data(struct page *page, unsigned long data)
>>>    	if (!PagePrivate(page)) {
>>>    		get_page(page);
>>>    		SetPagePrivate(page);
>>> +		set_page_private(page, 0);
>>>    	}
>>>    	set_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page));
>>>    	page_private(page) |= data << PAGE_PRIVATE_MAX;
>>>
