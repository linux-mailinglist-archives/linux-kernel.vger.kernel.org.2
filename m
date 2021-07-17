Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6FBA3CC3D3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 16:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbhGQOdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 10:33:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230003AbhGQOdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 10:33:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69FB060E0C;
        Sat, 17 Jul 2021 14:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626532245;
        bh=14WzMwXfvvUALR/o3/B01DobiAum7gdNjkRKMGRhoAs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=m8vjV62TtAP8tiyTNpo4pnmCmdchWW1SamKFORsv7Vi67qYK+1CUiCMrWb1PinJk7
         b2iUlVJNh6MR1NKYaKUZIgBxVTZmf6gEBxk/EmXOGzwCC0vH8yaQlC4TXzzQrjWPJf
         HdlNmZKKA+LMsEP5K4d8cM52N2S0TZhBtNPoJV8Qu3J80/0Yjs8kkzOCcgTTK7c+Xc
         3sAoRRBU2Lj3TqgKFcPyoIKsU5N4NIThpgJY67tpwe0jnAUniB/Ld6JlPEXEOIEqVH
         PMjAa/Q8FXxaIud7NVjZdt8rvc7yG/2WCBcBkivkfKupsWqwKFIWgukF6u/pKdvt3+
         2eYON/LB6NGlw==
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix ctx->pos in f2fs_read_inline_dir()
To:     =?UTF-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <AAoAygBXD7UuY6twAU03JKpm.3.1626528346162.Hmail.frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <1030f9ed-d7af-3fc5-a1ac-a53e0d1a46c3@kernel.org>
Date:   Sat, 17 Jul 2021 22:30:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <AAoAygBXD7UuY6twAU03JKpm.3.1626528346162.Hmail.frank.li@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/17 21:25, 李扬韬 wrote:
> HI Chao,
> 
> From: Chao Yu <chao@kernel.org>
> Date: 2021-07-17 16:56:01
> To:  Yangtao Li <frank.li@vivo.com>,jaegeuk@kernel.org
> Cc:  linux-kernel@vger.kernel.org,linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH] f2fs: fix ctx->pos in f2fs_read_inline_dir()>On 2021/7/17 11:49, Yangtao Li wrote:
>>> I recently found a case where de->name_len is 0 in f2fs_fill_dentries() easily reproduced,
>>> and finally set the fsck flag.
>>>
>>> Thread A					Thread B
>>>
>>> f2fs_readdir
>>> 	f2fs_read_inline_dir
>>> 		ctx->pos = d.max
>>> 						f2fs_add_dentry
>>> 							f2fs_add_inline_entry
>>> 								do_convert_inline_dir
>>> 							f2fs_add_regular_entry
>>> f2fs_readdir
>>> 	f2fs_fill_dentries
>>> 		set_sbi_flag(sbi, SBI_NEED_FSCK)
>>>
>>> Process A opens the folder, and has been reading without closing it. During this period,
>>> Process B created a file under the folder (occupying multiple f2fs_dir_entry, exceeding
>>> the d.max of the inline dir). After creation, process A uses the d.max of inline dir to
>>> read it again, and it will read that de->name_len is 0.
>>
>> Nice catch!
>>
>>>
>>> And returning early in f2fs_read_inline_dir will cause the process to be unable to see
>>> the changes before reopening the file.
>>>
>>> So don't return early and remove the modification of ctx->pos in f2fs_read_inline_dir().
>>>
>>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>>> ---
>>>    fs/f2fs/inline.c | 5 -----
>>>    1 file changed, 5 deletions(-)
>>>
>>> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
>>> index 56a20d5c15da..fc6551139a3d 100644
>>> --- a/fs/f2fs/inline.c
>>> +++ b/fs/f2fs/inline.c
>>> @@ -729,9 +729,6 @@ int f2fs_read_inline_dir(struct file *file, struct dir_context *ctx,
>>>    
>>>    	make_dentry_ptr_inline(inode, &d, inline_dentry);
>>>    
>>> -	if (ctx->pos == d.max)
>>> -		return 0;
>>> -
>>>    	ipage = f2fs_get_node_page(F2FS_I_SB(inode), inode->i_ino);
>>>    	if (IS_ERR(ipage))
>>>    		return PTR_ERR(ipage);
>>> @@ -747,8 +744,6 @@ int f2fs_read_inline_dir(struct file *file, struct dir_context *ctx,
>>>    	make_dentry_ptr_inline(inode, &d, inline_dentry);
>>>    
>>>    	err = f2fs_fill_dentries(ctx, &d, 0, fstr);
>>
>> After this function, ctx->pos will point to start position of first free slot after
>> last dir_entry, we can't guarantee that the free slot won't be used in above race
>> condition, right?
>>
>> Moreover, w/o inline conversion, the race condition still can happen as below, right?
>>
>> dir_entry1: A
>> dir_entry2: B
>> dir_entry3: C
>> free slot: _
>>
>> Before:
>> AAAABBBB___
>>          ^
>> Thread B delete dir_entry2, and create dir_entry3.
>>
>> After:
>> AAAACCCCC__
>>          ^
> 
> Taking into account the above situations, I think this case where de->name_len is 0 in f2fs_fill_dentries()
> should be normal and there is no way to avoid it. Maybe we shouldn't set fsck flag at this time?
> Because the file system is not damaged.

Yangtao,

IMO, it should bypass tagging FSCK flag only if:
a) bit_pos (:= ctx->pos % d->max) is non-zero & b) before bit_pos moves to first
valid dir_entry.

Thanks,

> 
> MBR / Yangtao
> 
> 
