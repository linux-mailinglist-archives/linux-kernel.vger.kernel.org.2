Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2F83D9B29
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 03:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbhG2BmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 21:42:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233140AbhG2BmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 21:42:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CFC060240;
        Thu, 29 Jul 2021 01:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627522938;
        bh=wsK+uyY4+5MJA4iFYhh1JY0QEIPUPE3hA1KcNMqCDLs=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=C95bXPJTsBTMVsf784HIu6AXFyfFeVZA0RU/3YoqOB1IJ4SXmARiKV8B9jHkzTNhj
         w9dH8YUdLjnPOIniKV6WKU4P8o+8StifTW2yQWB8KpeKxZ8KeYJ1inCHI+azqX9hJd
         vve8AqtVo8jrKcB+8Vaef29gHQU08k0yRiUe8ZDUm+xsrjRj9GUa7iDDVw9hJtYcmJ
         uwKMmAjoVxm65XjJ5ovKe4p96rF5XD45dSi9va8dLAXoPDF8XO8LKOkMqNGTuGPMIZ
         BM0cBU7RNnNrROuIPpoq9at6sJsEmyYUExFgo7MRbeY89dBtLdVr44sqR46jNeYlUN
         TsKLD/hhtgNQQ==
Subject: Re: [f2fs-dev] [PATCH] f2fs: reset free segment to prefree status
 when do_checkpoint() fail
From:   Chao Yu <chao@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
References: <20210427082106.2755-1-frank.li@vivo.com>
 <12ae52df-bc5e-82c3-4f78-1eafe7723f93@huawei.com>
 <5f37995c-2390-e8ca-d002-3639ad39e0d3@kernel.org>
 <YPXDtEyBg5W2ToD/@google.com>
 <8d2e3a63-72f9-bcb2-24e5-dddd84136001@kernel.org>
Message-ID: <09cfcfdc-7461-3035-3ced-8408cd1d00bf@kernel.org>
Date:   Thu, 29 Jul 2021 09:42:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <8d2e3a63-72f9-bcb2-24e5-dddd84136001@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping,

On 2021/7/20 8:04, Chao Yu wrote:
> On 2021/7/20 2:25, Jaegeuk Kim wrote:
>> On 07/19, Chao Yu wrote:
>>> On 2021/4/27 20:37, Chao Yu wrote:
>>>> I think just reverting dirty/free bitmap is not enough if checkpoint fails,
>>>> due to we have updated sbi->cur_cp_pack and nat/sit bitmap, next CP tries
>>>> to overwrite last valid meta/node/data, then filesystem will be corrupted.
>>>>
>>>> So I suggest to set cp_error if do_checkpoint() fails until we can handle
>>>> all cases, which is not so easy.
>>>>
>>>> How do you think?
>>>
>>> Let's add below patch first before you figure out the patch which covers all
>>> things.
>>>
>>>   From 3af957c98e9e04259f8bb93ca0b74ba164f3f27e Mon Sep 17 00:00:00 2001
>>> From: Chao Yu <chao@kernel.org>
>>> Date: Mon, 19 Jul 2021 16:37:44 +0800
>>> Subject: [PATCH] f2fs: fix to stop filesystem update once CP failed
>>>
>>> During f2fs_write_checkpoint(), once we failed in
>>> f2fs_flush_nat_entries() or do_checkpoint(), metadata of filesystem
>>> such as prefree bitmap, nat/sit version bitmap won't be recovered,
>>> it may cause f2fs image to be inconsistent, let's just set CP error
>>> flag to avoid further updates until we figure out a scheme to rollback
>>> all metadatas in such condition.
>>>
>>> Reported-by: Yangtao Li <frank.li@vivo.com>
>>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>> ---
>>>    fs/f2fs/checkpoint.c | 10 +++++++---
>>>    1 file changed, 7 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>>> index 6c208108d69c..096c85022f62 100644
>>> --- a/fs/f2fs/checkpoint.c
>>> +++ b/fs/f2fs/checkpoint.c
>>> @@ -1639,8 +1639,10 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>
>>>    	/* write cached NAT/SIT entries to NAT/SIT area */
>>>    	err = f2fs_flush_nat_entries(sbi, cpc);
>>> -	if (err)
>>> +	if (err) {
>>> +		f2fs_stop_checkpoint(sbi, false);
>>
>> I think we should abuse this, since we can get any known ENOMEM as well.
> 
> Yup, but one critical issue here is it can break A/B update of NAT area,
> so, in order to fix this hole, how about using NOFAIL memory allocation
> in f2fs_flush_nat_entries() first until we figure out the finial scheme?
> 
> Thanks,
> 
>>
>>>    		goto stop;
>>> +	}
>>>
>>>    	f2fs_flush_sit_entries(sbi, cpc);
>>>
>>> @@ -1648,10 +1650,12 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>    	f2fs_save_inmem_curseg(sbi);
>>>
>>>    	err = do_checkpoint(sbi, cpc);
>>> -	if (err)
>>> +	if (err) {
>>> +		f2fs_stop_checkpoint(sbi, false);
>>>    		f2fs_release_discard_addrs(sbi);
>>> -	else
>>> +	} else {
>>>    		f2fs_clear_prefree_segments(sbi, cpc);
>>> +	}
>>>
>>>    	f2fs_restore_inmem_curseg(sbi);
>>>    stop:
>>> -- 
>>> 2.22.1
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
