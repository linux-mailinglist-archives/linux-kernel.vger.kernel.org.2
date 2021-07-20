Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368193CF1F9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 04:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245579AbhGTBjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 21:39:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244850AbhGSXYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 19:24:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7995161107;
        Tue, 20 Jul 2021 00:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626739478;
        bh=FmOi7LB6sM3yskT4hpeEOKvwOActkEpDjdVbw31j9A8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Kfkck7+dC4vvU1YW0Sos9aaKCOl8CXXpYXVqUc+gb+3UAIB9ulKJa6PJaM6Zv5YXX
         nAptJ7ZNP9y0Ou+O0FdCjo1mu7wcR0JQ02nS7QC4AWIsl3shnyqNgVrv1IA1j0rso8
         ItFL6zYHxTU3EKjOCYdT9Mr8X9k4Vd/+ToeclZPe6r6kRI8GvQgcdGYE3z2U9SEMQc
         Kd60eDWn0aOTeYQ7bm8hgK/7pbbUjd06xFi6hKXc5JFTBvk+yJrjTGZdYwWCQ1vlxR
         +IFe8zkAqO7LjxXVe5r/ztuzkFvZ76wDjJzaHb1aNNPIMx3CGLNnlD/nF+OYReHsnu
         8sFEBH/8aZOAQ==
Subject: Re: [f2fs-dev] [PATCH] f2fs: reset free segment to prefree status
 when do_checkpoint() fail
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20210427082106.2755-1-frank.li@vivo.com>
 <12ae52df-bc5e-82c3-4f78-1eafe7723f93@huawei.com>
 <5f37995c-2390-e8ca-d002-3639ad39e0d3@kernel.org>
 <YPXDtEyBg5W2ToD/@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <8d2e3a63-72f9-bcb2-24e5-dddd84136001@kernel.org>
Date:   Tue, 20 Jul 2021 08:04:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YPXDtEyBg5W2ToD/@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/20 2:25, Jaegeuk Kim wrote:
> On 07/19, Chao Yu wrote:
>> On 2021/4/27 20:37, Chao Yu wrote:
>>> I think just reverting dirty/free bitmap is not enough if checkpoint fails,
>>> due to we have updated sbi->cur_cp_pack and nat/sit bitmap, next CP tries
>>> to overwrite last valid meta/node/data, then filesystem will be corrupted.
>>>
>>> So I suggest to set cp_error if do_checkpoint() fails until we can handle
>>> all cases, which is not so easy.
>>>
>>> How do you think?
>>
>> Let's add below patch first before you figure out the patch which covers all
>> things.
>>
>>  From 3af957c98e9e04259f8bb93ca0b74ba164f3f27e Mon Sep 17 00:00:00 2001
>> From: Chao Yu <chao@kernel.org>
>> Date: Mon, 19 Jul 2021 16:37:44 +0800
>> Subject: [PATCH] f2fs: fix to stop filesystem update once CP failed
>>
>> During f2fs_write_checkpoint(), once we failed in
>> f2fs_flush_nat_entries() or do_checkpoint(), metadata of filesystem
>> such as prefree bitmap, nat/sit version bitmap won't be recovered,
>> it may cause f2fs image to be inconsistent, let's just set CP error
>> flag to avoid further updates until we figure out a scheme to rollback
>> all metadatas in such condition.
>>
>> Reported-by: Yangtao Li <frank.li@vivo.com>
>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/checkpoint.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>> index 6c208108d69c..096c85022f62 100644
>> --- a/fs/f2fs/checkpoint.c
>> +++ b/fs/f2fs/checkpoint.c
>> @@ -1639,8 +1639,10 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>
>>   	/* write cached NAT/SIT entries to NAT/SIT area */
>>   	err = f2fs_flush_nat_entries(sbi, cpc);
>> -	if (err)
>> +	if (err) {
>> +		f2fs_stop_checkpoint(sbi, false);
> 
> I think we should abuse this, since we can get any known ENOMEM as well.

Yup, but one critical issue here is it can break A/B update of NAT area,
so, in order to fix this hole, how about using NOFAIL memory allocation
in f2fs_flush_nat_entries() first until we figure out the finial scheme?

Thanks,

> 
>>   		goto stop;
>> +	}
>>
>>   	f2fs_flush_sit_entries(sbi, cpc);
>>
>> @@ -1648,10 +1650,12 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>   	f2fs_save_inmem_curseg(sbi);
>>
>>   	err = do_checkpoint(sbi, cpc);
>> -	if (err)
>> +	if (err) {
>> +		f2fs_stop_checkpoint(sbi, false);
>>   		f2fs_release_discard_addrs(sbi);
>> -	else
>> +	} else {
>>   		f2fs_clear_prefree_segments(sbi, cpc);
>> +	}
>>
>>   	f2fs_restore_inmem_curseg(sbi);
>>   stop:
>> -- 
>> 2.22.1
