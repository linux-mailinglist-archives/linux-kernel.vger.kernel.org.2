Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556DC3DFA07
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 05:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbhHDDdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 23:33:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229571AbhHDDdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 23:33:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81E5D61037;
        Wed,  4 Aug 2021 03:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628047982;
        bh=L4lrzLbH/aV3W5MjROtpuPqG8ncWOO07RWA08kmI+ts=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YFUuXXyxGoUyT/b0+YHP3RTRGNkE+kReB/vVxSbZ9sv/8Vuip8FzQgUGMK/AZrmnt
         QSVtIyrxIGicFU7jbEp6fBH+dXKLBhMtr0o12DNRs4d7RapJG/F7KveUqSJgm8NCCv
         Lvzcn6+28XC6Vc2F13mb5tu2I+4p8hHCdAyDYK9z5C4NBry6n3+hAhoGxLBcKC0zNc
         Mc+ziXtOOHrqwh9zBbeE4zZ2U9EB3dx4kxGR+sqL3Cq+68gLDq9Chf0ug8cEg2FzRJ
         q8+ebDbGgtLc6n75TobFfTL1rzI8YEzC6shta9zzjDbU/SM2i+3fKAVKOKwwl/LAnn
         r+3xLXV9TxERg==
Subject: Re: [PATCH v3] f2fs: Reduce the scope of setting fsck tag when
 de->name_len is zero
To:     =?UTF-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <AJcAmwDXD1QzgUCoyu2cQKql.3.1626784315314.Hmail.frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <2c59c14b-008c-aee9-6775-13b47fbd252f@kernel.org>
Date:   Wed, 4 Aug 2021 11:32:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <AJcAmwDXD1QzgUCoyu2cQKql.3.1626784315314.Hmail.frank.li@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Yangtao,

I did some cleanup in your patch, and resend for you, please
note that. :)

Thanks,

On 2021/7/20 20:31, 李扬韬 wrote:
> HI Chao，
> 
> From: Chao Yu <chao@kernel.org>
> Date: 2021-07-20 18:23:15
> To:  Yangtao Li <frank.li@vivo.com>,jaegeuk@kernel.org
> Cc:  linux-f2fs-devel@lists.sourceforge.net,linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v3] f2fs: Reduce the scope of setting fsck tag when de->name_len is zero>On 2021/7/20 15:06, Yangtao Li wrote:
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
>>>
>>> And Chao pointed out that w/o inline conversion, the race condition still can happen as below
>>>
>>> dir_entry1: A
>>> dir_entry2: B
>>> dir_entry3: C
>>> free slot: _
>>> ctx->pos: ^
>>>
>>> Before:
>>> AAAABBBB___
>>> 	 ^
>>
>> please use blank instead of tab before '^'
> 
> I don't know exactly what happened. In fact, in v2, spaces were used. Then it was changed to tab in v3.
> 
>>
>>> Thread B delete dir_entry2, and create dir_entry3.
>>>
>>> After:
>>> AAAACCCCC__
>>> 	 ^
>>
>> Ditto
>>
>>>
>>> In these scenarios, the file system is not damaged, and it's hard to avoid it. But we can bypass
>>> tagging FSCK flag if:
>>> a) bit_pos (:= ctx->pos % d->max) is non-zero & b) before bit_pos moves to first
>>> valid dir_entry.
>>>
>>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>>> ---
>>>    fs/f2fs/dir.c | 14 +++++++++-----
>>>    1 file changed, 9 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
>>> index 456651682daf..bfe942733b5e 100644
>>> --- a/fs/f2fs/dir.c
>>> +++ b/fs/f2fs/dir.c
>>> @@ -1000,6 +1000,7 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
>>>    	struct f2fs_sb_info *sbi = F2FS_I_SB(d->inode);
>>>    	struct blk_plug plug;
>>>    	bool readdir_ra = sbi->readdir_ra == 1;
>>> +	bool found_valid_dirent  = false;
>>
>> One more blank before '='.
>>
>> bool found_valid_dirent = false;
>>
> 
> OK.
> 
> Thx，
> 
> 
> 
