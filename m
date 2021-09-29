Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E616F41BB8D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 02:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243314AbhI2AGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 20:06:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:47262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230137AbhI2AGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 20:06:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F26561357;
        Wed, 29 Sep 2021 00:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632873913;
        bh=UR8mhaZAktczckqcX1PnjQA6DuF3fDOJXNa+Z/PJeFY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cj6LsqPDLb5dIheuh9WcdqaMEXOa+zisI1IQe4/8hW/reYkyOccUL2//w0XYiUve0
         NDHFxqj7/yDbmuKYHU4wYLrY8vW/oXOkpP1fGoFXqgtm4gPJL74wUmIAzazVPD+9aH
         A9jH6xIyqM3oYsr8t6mR+Di8lY+zzVJJPeRzwiV23g/j56Y/CHX8fTocrKANVF6Z1z
         wideb00Rcog3BgNJIEo7+7PKOjf9bdXTv2PnuduK07HBcwx+VrKn7JXQGc3HH2Nzyb
         l0M0EIbyW26dtRkpKCEYWtGJjPL31EtR88TaiaG1x9c1ro6xsRiiAyK5Pcw5lJrM4e
         PhU9xSxRqMA7Q==
Subject: Re: [PATCH] f2fs: skip f2fs_preallocate_blocks() for overwrite case
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20210928151911.11189-1-chao@kernel.org>
 <YVNoHudG5c65X85G@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <65f6c366-9e5b-fe7f-7c38-061996d1882b@kernel.org>
Date:   Wed, 29 Sep 2021 08:05:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YVNoHudG5c65X85G@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/9/29 3:08, Jaegeuk Kim wrote:
> On 09/28, Chao Yu wrote:
>> In f2fs_file_write_iter(), let's use f2fs_overwrite_io() to
>> check whethere it is overwrite case, for such case, we can skip
>> f2fs_preallocate_blocks() in order to avoid f2fs_do_map_lock(),
>> which may be blocked by checkpoint() potentially.
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/file.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 13deae03df06..51fecb2f4db5 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -4321,6 +4321,10 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>   		preallocated = true;
>>   		target_size = iocb->ki_pos + iov_iter_count(from);
>>   
>> +		if (f2fs_overwrite_io(inode, iocb->ki_pos,
>> +						iov_iter_count(from)))
>> +			goto write;
> 
> This calls f2fs_map_blocks() which can be duplicate, if it's not the overwirte
> case. Do we have other benefit?

f2fs_overwrite_io() will break for append write case w/ below check:

	if (pos + len > i_size_read(inode))
		return false;

I guess we may only suffer double f2fs_map_blocks() for write hole
case, e.g. truncate to large size & write inside the filesize. For
this case, how about adding a condition to allow double f2fs_map_blocks()
only if write size is smaller than a threshold?

Thanks,

> 
>> +
>>   		err = f2fs_preallocate_blocks(iocb, from);
>>   		if (err) {
>>   out_err:
>> -- 
>> 2.32.0
