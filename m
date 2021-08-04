Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E2A3DF90F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 02:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbhHDAzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 20:55:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231704AbhHDAzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 20:55:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D76560EFD;
        Wed,  4 Aug 2021 00:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628038501;
        bh=aJH3kOdf8qd5RXoedFR4M2Cq1LOGvclWPP+/896MrNs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=S/6vQY8ThuIEr1Lq8yWPTcCQwrgF2wLQbzHS/JYyCzDSpWnvScsdx07CnoG3uflZJ
         j5KPw3Q0pA4JfGi031sivlece5NjCmXAqwTp2quXcrIiNNxlwMQg9h2mN3oCEnXyAg
         sUgvZ9I3d7JOlfBKuKkIc+4x8WgDggE0FxUh0P5CeI75Jx/53ADY/iXwO+WRkVp+rc
         JqYk8eJOexrzENIgxdVNMY5FZhej1xfyGC2601FKlddg1DiOiPisTE3EJWFP3q+RHz
         F8SCAHdiFNEJEMXNGEAtHHfVI/UtIReuKXWzL0FkmCvaA5DiJPa6rs9FdW/Q4/KYbf
         s3QPWyKpnNLGQ==
Subject: Re: [RFC v2] f2fs: extent cache: support unaligned extent
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>
References: <20210803023912.26667-1-chao@kernel.org>
 <YQmNzBofsqv/zEdb@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <d08ada1d-b0a3-6ed8-449b-10bf2518f5ba@kernel.org>
Date:   Wed, 4 Aug 2021 08:55:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQmNzBofsqv/zEdb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/4 2:41, Jaegeuk Kim wrote:
>> @@ -247,6 +247,11 @@ static struct extent_node *__attach_extent_node(struct f2fs_sb_info *sbi,
>>   	INIT_LIST_HEAD(&en->list);
>>   	en->et = et;
>>   
>> +#ifdef CONFIG_F2FS_FS_COMPRESSION
> 
> Can we avoid the above ifdef?

What do you mean by "avoid", getting rid of CONFIG_F2FS_FS_COMPRESSION directly?
or wrapping codes into function and define as below?

#ifdef CONFIG_F2FS_FS_COMPRESSION
void foo() { implementation here }
#else
void foot() {}
#endif

>>   static inline bool __is_extent_mergeable(struct extent_info *back,
>> -						struct extent_info *front)
>> +				struct extent_info *front, bool unaligned)
>>   {
>> +#ifdef CONFIG_F2FS_FS_COMPRESSION
> 
> Can we avoid this ifdef?
