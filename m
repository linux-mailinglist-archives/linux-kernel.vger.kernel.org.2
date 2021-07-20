Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42EC73CF143
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 03:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240989AbhGTAlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 20:41:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:43114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345169AbhGTAij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 20:38:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1175160C3D;
        Tue, 20 Jul 2021 01:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626743952;
        bh=IYePbHY2sD319NqCb3FPOmyytqnU6F0vrlI4hwuRhJY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=sl++5t77WUdsoedpKVHWuNLdUkd7yIt6kDWHypUlIlbHKDCcT3eI57gRiOexFHLYP
         uWjcvX2ChsNW3UMSCF9dx0jUOj7G2tr2TsDU7YciTHV2ERyRXjSjwYLdFTKk8MGZyR
         4fYV4F6NyH8oDpi0MvMzd5uQ8ifu0PstUG8QjquyL+im514arw43paScUbbYmEaqNY
         H72bhcgqIvOqCTgP0FEQOYUDDTj3di4IMwwJtz8jcgeMeKZ+DEu+xlne96FNMSLfEx
         RxWMbzn+y8Euv3gYess8USQxn+YSH5l0T45FIHjMJ10TSIUVBr/n4ioFW2yQWHbSkE
         +LADWSWdVS1mg==
Subject: Re: [PATCH v3] f2fs: fix to force keeping write barrier for strict
 fsync mode
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>
References: <20210720010329.3975-1-chao@kernel.org>
 <YPYjzAVq04LfUO2Y@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <014d1b9d-0698-fda1-0765-cce81d915280@kernel.org>
Date:   Tue, 20 Jul 2021 09:19:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YPYjzAVq04LfUO2Y@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/20 9:15, Jaegeuk Kim wrote:
> Wasn't it supposed to be v1?

I skip IPU case for v1, and resend it as v3, is it fine to you?

Thanks,

> 
> On 07/20, Chao Yu wrote:
>> [1] https://www.mail-archive.com/linux-f2fs-devel@lists.sourceforge.net/msg15126.html
>>
>> As [1] reported, if lower device doesn't support write barrier, in below
>> case:
>>
>> - write page #0; persist
>> - overwrite page #0
>> - fsync
>>   - write data page #0 OPU into device's cache
>>   - write inode page into device's cache
>>   - issue flush
>>
>> If SPO is triggered during flush command, inode page can be persisted
>> before data page #0, so that after recovery, inode page can be recovered
>> with new physical block address of data page #0, however there may
>> contains dummy data in new physical block address.
>>
>> Then what user will see is: after overwrite & fsync + SPO, old data in
>> file was corrupted, if any user do care about such case, we can suggest
>> user to use STRICT fsync mode, in this mode, we will force to use atomic
>> write sematics to keep write order in between data/node and last node,
>> so that it avoids potential data corruption during fsync().
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/file.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 6afd4562335f..00b45876eaa1 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -301,6 +301,18 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
>>   				f2fs_exist_written_data(sbi, ino, UPDATE_INO))
>>   			goto flush_out;
>>   		goto out;
>> +	} else {
>> +		/*
>> +		 * for OPU case, during fsync(), node can be persisted before
>> +		 * data when lower device doesn't support write barrier, result
>> +		 * in data corruption after SPO.
>> +		 * So for strict fsync mode, force to use atomic write sematics
>> +		 * to keep write order in between data/node and last node to
>> +		 * avoid potential data corruption.
>> +		 */
>> +		if (F2FS_OPTION(sbi).fsync_mode ==
>> +				FSYNC_MODE_STRICT && !atomic)
>> +			atomic = true;
>>   	}
>>   go_write:
>>   	/*
>> -- 
>> 2.22.1
