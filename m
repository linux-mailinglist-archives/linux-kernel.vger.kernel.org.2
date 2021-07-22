Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0323D3019
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 01:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhGVWe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 18:34:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232628AbhGVWeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 18:34:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 138C260E8F;
        Thu, 22 Jul 2021 23:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626995699;
        bh=eb3jIUA27WuZiqMOHyn3peGQmh5dVT3HqvvzBdRVFcc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NCx0VafwcDUgQxdGiVGEH1WRvGiDrLfm0PIdW0M228ZK6/JTb696B+7u64PQXaKI3
         QilW7jzh5eKLnvVOxSkf/xCln1frHvUr+Nnm0EDmcGKQwVDaxLXUFunUFcqOrBDFko
         M5RqW53Cm2gRsSWgmwi8uLw988ZfglpLaB5RZ/TdFv7nQzHPsg92J63qymesa503jY
         A61B4w8GtQtRYIcHCNpPmmqljoR1A7m0OokV0TYJxQ9QLCTiVJHUlIYdu/pxI2XDUL
         ssmoC5bm37yf5PbOQkMeieWlZyhgHDyPIDG7pVkhLW3vPszn3ygX5UW4lQl3JJy37o
         iDgC9qWsxTKFQ==
Subject: Re: [f2fs-dev] [PATCH] f2fs: simplify accounting inflight directIO
 request
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     jaegeuk@kernel.org, Chao Yu <chao.yu@linux.dev>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20210722131617.749204-1-chao@kernel.org>
 <YPmTP5EixgTp1Wze@gmail.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <e1b61b7f-a492-f28b-8a98-557e81a2022a@kernel.org>
Date:   Fri, 23 Jul 2021 07:14:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YPmTP5EixgTp1Wze@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/22 23:48, Eric Biggers wrote:
> On Thu, Jul 22, 2021 at 09:16:17PM +0800, Chao Yu wrote:
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index ba120d55e9b1..d0a1ca6ae38e 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -1720,6 +1720,9 @@ static int __get_data_block(struct inode *inode, sector_t iblock,
>>   		map_bh(bh, inode->i_sb, map.m_pblk);
>>   		bh->b_state = (bh->b_state & ~F2FS_MAP_FLAGS) | map.m_flags;
>>   		bh->b_size = blks_to_bytes(inode, map.m_len);
>> +
>> +		if (flag == F2FS_GET_BLOCK_DIO)
>> +			bh->b_private = (void *)may_write;
> 
> Why is this hunk needed?

For passing rw info from get_block() to dio->private.

> 
>> +static int f2fs_dio_end_io(struct kiocb *iocb, loff_t offset,
>> +					ssize_t bytes, void *private)
>>   {
>> -	struct f2fs_private_dio *dio = bio->bi_private;
>> -
>> -	dec_page_count(F2FS_I_SB(dio->inode),
>> -			dio->write ? F2FS_DIO_WRITE : F2FS_DIO_READ);
>> -
>> -	bio->bi_private = dio->orig_private;
>> -	bio->bi_end_io = dio->orig_end_io;
>> -
>> -	kfree(dio);
>> +	struct inode *inode = file_inode(iocb->ki_filp);
>> +	bool may_write = private;
>>   
>> -	bio_endio(bio);
>> +	dec_dio_req_count(F2FS_I_SB(inode), may_write ? WRITE : READ);
>> +	return 0;
>>   }
>>   
>>   static void f2fs_dio_submit_bio(struct bio *bio, struct inode *inode,
>>   							loff_t file_offset)
>>   {
>> -	struct f2fs_private_dio *dio;
>> -	bool write = (bio_op(bio) == REQ_OP_WRITE);
>> -
>> -	dio = f2fs_kzalloc(F2FS_I_SB(inode),
>> -			sizeof(struct f2fs_private_dio), GFP_NOFS);
>> -	if (!dio)
>> -		goto out;
>> -
>> -	dio->inode = inode;
>> -	dio->orig_end_io = bio->bi_end_io;
>> -	dio->orig_private = bio->bi_private;
>> -	dio->write = write;
>> -
>> -	bio->bi_end_io = f2fs_dio_end_io;
>> -	bio->bi_private = dio;
>> -
>> -	inc_page_count(F2FS_I_SB(inode),
>> -			write ? F2FS_DIO_WRITE : F2FS_DIO_READ);
>> +	inc_dio_req_count(F2FS_I_SB(inode),
>> +			op_is_write(bio_op(bio)) ? WRITE : READ);
>>   
>>   	submit_bio(bio);
>> -	return;
>> -out:
>> -	bio->bi_status = BLK_STS_IOERR;
>> -	bio_endio(bio);
>>   }
> 
> The inc and dec here aren't correctly paired, since f2fs_dio_submit_bio() is
> called once per bio whereas f2fs_dio_end_io() is called when the entire direct
> I/O request (which may have consisted of multiple bios) has completed.

Correct, it still needs to hook bio->bi_end_io rather than hooking dio->end_io,
however, w/o one extra allocated memory, we have no way to pass sbi to
f2fs_dio_end_io() for dec_dio_req_count(sbi, ...) invoking.

> 
> The correct way to do this would be to do the inc before calling
> __blockdev_direct_IO(), and do the dec in end_io or if __blockdev_direct_IO()
> returned without actually issuing any I/O.
> 
> But I think you shouldn't bother with this part of the change before we switch
> to iomap, as it will then need to be changed again anyway.

Agreed.

Thanks,

> 
> - Eric
> 
