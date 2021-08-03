Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265493DE3F8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 03:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbhHCB3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 21:29:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:53650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233208AbhHCB3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 21:29:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8D3260FC4;
        Tue,  3 Aug 2021 01:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627954174;
        bh=Z4zj/Wb3RgzHIm3MYrz04fRNx1w1p3GirfhhiOyAru8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RS7LyTBIo9E5HN0gl5zfHa23PZfGl3djZT2jwhNdhfl/Vi8B+LnIjRo8tHMwftVaP
         ZCEWxE2t91WRQNDsMgCByL8srq0+R18/SwJ23VOa0xYrKlzHbJNt18bVx3KreEuZg+
         vQLUR4cK/Qf8jjD6dcoEUeNcnPPaxk8XWFXtZ+wn4Ria0XpyvHLbYGiAUAzNpLxXqg
         5ccWWevOdr+CgpUIU47LfgEl9oJu9E+JiInlokFkNLCNmEVZjbCnGnZ6+sqXizxCtm
         orYQNIRdorsIxeKb5YZVuP3jXmWyKPCCkRnysVVk+SbYWo+osgLAIASXMoMjOOsVxl
         OTlOS9/so8Nuw==
Subject: Re: [RFC NO MERGE] f2fs: extent cache: support unaligned extent
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>
References: <20210707015815.1978-1-chao@kernel.org>
 <YQRQ4kHvdRTBnb10@google.com>
 <51565c85-a475-bcb8-bbb2-e3125c5223a3@kernel.org>
 <YQgziuikMr0fvlT7@google.com>
 <3256dc39-2a82-cb60-038b-69e262c32d18@kernel.org>
 <YQia9FBvQIRgr6cm@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <a8291159-f625-c2a0-da73-7c30172f3d9a@kernel.org>
Date:   Tue, 3 Aug 2021 09:29:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQia9FBvQIRgr6cm@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/3 9:25, Jaegeuk Kim wrote:
> On 08/03, Chao Yu wrote:
>> On 2021/8/3 2:03, Jaegeuk Kim wrote:
>>> On 08/01, Chao Yu wrote:
>>>> On 2021/7/31 3:20, Jaegeuk Kim wrote:
>>>>> On 07/07, Chao Yu wrote:
>>>>>> Currently, it only works in readonly format f2fs image.
>>>>
>>>> There wouldn't be any race condition because unaligned extent only works
>>>> for ro feature now?
>>>
>>> Isn't your patch proposing on writable partition?
>>
>> Please check description in patch message, now it was designed only for
>                                                   --
>                                                   what do you refer "it"?
> 
>> compression case w/ ro feature, let's check and support rw partition later.
> 
> Quite confused the patch description and code changes as well. You added some
> change with this as well which is for RW.
> 
> +       if (is_inode_flag_set(dn->inode, FI_COMPRESSED_FILE) &&
> +                       !f2fs_sb_has_readonly(sbi)) {

My bad, I've updated in my dev branch, but forgot to resend it...:

https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?h=dev&id=c3a40f6a186ba064f95432b308173d0a8fe375dc

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>>>
>>>>> Is there any race condition between the address in extent_cache and the one in
>>>>> dnode? I feel that we could synchronize it by locking its dnode block.
>>>>
>>>> Thanks,
