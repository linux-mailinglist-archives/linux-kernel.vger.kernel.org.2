Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7BC3760B1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 08:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhEGGyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 02:54:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17139 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhEGGx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 02:53:57 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fc1Jb73WTzqSx6;
        Fri,  7 May 2021 14:49:19 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 7 May 2021
 14:52:31 +0800
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: reduce expensive checkpoint trigger
 frequency
To:     Eric Biggers <ebiggers@kernel.org>
CC:     <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20210425011053.44436-1-yuchao0@huawei.com>
 <YJTfNeYeDT65GslB@sol.localdomain>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <92386fc3-4c23-f2da-28be-f2285343cce8@huawei.com>
Date:   Fri, 7 May 2021 14:52:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <YJTfNeYeDT65GslB@sol.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/5/7 14:33, Eric Biggers wrote:
> On Sun, Apr 25, 2021 at 09:10:53AM +0800, Chao Yu wrote:
>> +	if (!error && S_ISDIR(inode->i_mode) && f2fs_encrypted_file(inode) &&
>> +			f2fs_is_checkpointed_node(sbi, inode->i_ino))
>> +		f2fs_add_ino_entry(sbi, inode->i_ino, ENC_DIR_INO);
> 
> This will never be true, since S_ISDIR() and f2fs_encrypted_file() are logically
> contradictory (as f2fs_encrypted_file() only returns true when S_ISREG()).
> 
> How did you test this change?

I should add RFC tag in this v2 as v1, since I haven't test both
with specified case because this idea should be discussed first.

Thanks,

> 
> - Eric
> .
> 
