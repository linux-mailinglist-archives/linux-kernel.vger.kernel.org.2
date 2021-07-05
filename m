Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1F13BC164
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 18:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhGEQL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 12:11:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229495AbhGEQL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 12:11:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62D73613AB;
        Mon,  5 Jul 2021 16:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625501361;
        bh=2XzMBDCWTuZKTJpPDkKpokzuPVPOTBI/2bclffIorx4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=u7D924a+RJH1J56edLLyj9U6oNbUsWpUHVDhsrgfQpJGWcXCcn7WbgahQeBWXD1bz
         PCrSCeCTpGQkJZo3ZkfMiDVRRhV+nIhnT2wC1wo/IfLfyfRPV9VOBo9TIoH3Xm9URD
         QXGL2qKbavinIC1Iik8uGys28/D8IEroD2tuTox4ZPCAPA32skpiohwQJgzXidUYAW
         ryZr0JjzJHbzibg4KUyv8t/U9wtjtKwhY2RhJD3ACP5Fa3NHiIKtX2cQp0IqOYk/CF
         momhsPDmeAgGI8YuLyeiHrsvpInbnw7lFVfCxk6tifSHxpSEc9ELsJykzl72cCpWba
         xYTjLdDVji5Gw==
Subject: Re: [f2fs-dev] [PATCH] f2fs: initialize page->private when using for
 our internal use
To:     Matthew Wilcox <willy@infradead.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org
References: <20210705052216.831989-1-jaegeuk@kernel.org>
 <c32642d6-6de2-eb2d-5771-c7cefa62fab5@kernel.org>
 <YOLJW0IgCagMk2tF@google.com>
 <e2fdf628-f25c-7495-cfd1-952899f7ff9a@kernel.org>
 <YOLxZAnaKSwBIlK9@casper.infradead.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <5ab8d01a-8fac-60b2-9c2c-a32c5a81b394@kernel.org>
Date:   Tue, 6 Jul 2021 00:09:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOLxZAnaKSwBIlK9@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/5 19:47, Matthew Wilcox wrote:
> On Mon, Jul 05, 2021 at 07:33:35PM +0800, Chao Yu wrote:
>> On 2021/7/5 16:56, Jaegeuk Kim wrote:
>>> On 07/05, Chao Yu wrote:
>>>> On 2021/7/5 13:22, Jaegeuk Kim wrote:
>>>>> We need to guarantee it's initially zero. Otherwise, it'll hurt entire flag
>>>>> operations.
>>>>
>>>> Oops, I didn't get the point, shouldn't .private be zero after page was
>>>> just allocated by filesystem? What's the case we will encounter stall
>>>> private data left in page?
>>>
>>> I'm seeing f2fs_migrate_page() has the newpage with some value without Private
>>> flag. That causes a kernel panic later due to wrong private flag used in f2fs.
>>
>> I'm not familiar with that part of codes, so Cc mm mailing list for help.
>>
>> My question is newpage in .migrate_page() may contain non-zero value in .private
>> field but w/o setting PagePrivate flag, is it a normal case?
> 
> I think freshly allocated pages have a page->private of 0.  ie this
> code in mm/page_alloc.c:
> 
>                  page = rmqueue(ac->preferred_zoneref->zone, zone, order,
>                                  gfp_mask, alloc_flags, ac->migratetype);
>                  if (page) {
>                          prep_new_page(page, order, gfp_mask, alloc_flags);
> 
> where prep_new_page() calls post_alloc_hook() which contains:
>          set_page_private(page, 0);
> 
> Now, I do see in __buffer_migrate_page() (mm/migrate.c):
> 
>          attach_page_private(newpage, detach_page_private(page));
> 
> but as far as I can tell, f2fs doesn't call any of the
> buffer_migrate_page() paths.  So I'm not sure why you're seeing
> a non-zero page->private.

Well, that's strange.

Jaegeuk, let's add a BUGON in f2fs to track the call path where newpage
has non-zero private value? if this issue is reproducible.

Thanks,

> 
