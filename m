Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41A33ECC81
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 03:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbhHPBzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 21:55:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhHPBzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 21:55:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D78B6136A;
        Mon, 16 Aug 2021 01:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629078870;
        bh=0LbfQkM7HZueVzmxBHA9CYfz7kOuxLMPYbK6Xw0q8y8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MAJB6c3us1VKhpzx3Qdh5KFrxV0ozR3opnGdhI8BVYhgcfYc9KGoM3xLzap9OHoZy
         yZoeCLG9AUOdQ36lZeA07li0HQ2x0p4V+OVUWeZToeROGQlfBhFCxiuhvI2opqvdE8
         +RaZd5NOQWAm3SVrrxRqDT7TwA1uBUw64LZ/NevrCaCziVzoFgvY9SaELrkpfNbugJ
         nlNoSGJZw/WWm/RCssCVwsYwIJfvcIBkUPA16pCajoa575Dqh+0owdrB6ABDC3ObzC
         bOY6YMYRLhHJmbMO0kTIFo3cmbLXwYrRhvwNeLZAFHCNgyDalUbdDYwPRy/m3w23qY
         8Nfg4brMigCdg==
Subject: Re: [PATCH v5 1/2] f2fs: introduce proc/fs/f2fs/<dev>/fsck_stack node
To:     =?UTF-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <AEMABgAWDwhd8*f2P*fotqoY.3.1628906905520.Hmail.frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <a6e1f93c-b45e-019b-273f-b5019052739e@kernel.org>
Date:   Mon, 16 Aug 2021 09:54:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <AEMABgAWDwhd8*f2P*fotqoY.3.1628906905520.Hmail.frank.li@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/14 10:08, 李扬韬 wrote:
>>> We can't remove stack from depot, as we store them contiguously one after
>>> another in a contiguous memory allocation.
>>>
>>> Or we can limit the recorded stack number.
>>>
>>> $ grep -nr "SBI_NEED_FSCK" fs/f2fs/ --include=*.c --include=*.h | wc -l
>>> 53
>>> $ grep -nr "f2fs_bug_on" fs/f2fs/ --include=*.c --include=*.h | wc -l
>>> 135
>>
>> I didn't look into details of stack_depot_save(), two stack handles from below
>> call paths will be the same?
>>
>> - move_data_block
>>   - f2fs_wait_on_page_writeback
>>    - f2fs_bug_on
>>
>> - ra_data_block
>>   - f2fs_wait_on_page_writeback
>>    - f2fs_bug_on
>>
>> If they have different stack handles, combination number of
>> set_sbi_flag(NEED_FSCK)/f2fs_bug_on and their callers will be far more than two
>> hundred.
>>
> 
> Yes, these will be two different stacks. In the most extreme case, there will be 1000 (I guess) different places to set fsck?

It may be according to call stack height of each handle record.

> Or we limit the number of recorded stacks to 10?

Yes, please limit the record number, maybe 8? and stack height could be 16 at
maximum?

Thanks,

> what do you think. The stack depot design does not consider removing the stack from the depot.
> 
> MBR,
> Yangtao
> 
