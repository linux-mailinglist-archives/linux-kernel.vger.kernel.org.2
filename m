Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E413A2F3B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 17:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbhFJP0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 11:26:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:57694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230329AbhFJP0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 11:26:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F6F760231;
        Thu, 10 Jun 2021 15:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623338681;
        bh=Z9DXrGBlZtJ7EjBpFHqP4z2CDz1wxkr66cHPD11hj/0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JgWUeglEwGBAd0KI4qaetEaUalbQ/G6ksjts/m19OO8rgW4RieRVI1cWNask25La7
         5lfYVHNd8b7UGAGZcDtL0biSM8dfOPQ6ZRV0IPUYmOKsKd2rBhYbzBxbSnhW3BX9vC
         2A6w5QORhE/8FjRe0VwhFbAODOxxmZuDSo2zfm4fz/Rw+uHuVapGU7adJ0UzOTKOvd
         Scbfr0t1RkuaLewqa3qIPZ1VMkjgOHNzI2ILdzOJEg/z0UseJlQFM309ZneGu/f5G5
         WbrMbg/+S+borMPowAaUMz5Mdbl2PSD4K6plT7VrvNLLaLYQHHmOtqsjwhEiFP5GWz
         3LGjnD/DBXUkQ==
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: introduce FI_COMPRESS_RELEASED
 instead of using IMMUTABLE bit
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20210525204955.2512409-1-jaegeuk@kernel.org>
 <20210525204955.2512409-2-jaegeuk@kernel.org>
 <95b5669f-a521-5865-2089-320e2a2493de@kernel.org>
 <YL5P15nLsc/3GQOY@google.com>
 <3f2c2543-c8a4-3477-76af-5c7614b643e8@kernel.org>
 <YMEL06gZC5n3J2bX@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <a7a3078e-918d-53f2-6bff-537934094631@kernel.org>
Date:   Thu, 10 Jun 2021 23:24:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YMEL06gZC5n3J2bX@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/6/10 2:43, Jaegeuk Kim wrote:
> On 06/08, Chao Yu wrote:
>> On 2021/6/8 0:56, Jaegeuk Kim wrote:
>>> On 06/06, Chao Yu wrote:
>>>> On 2021/5/26 4:49, Jaegeuk Kim wrote:
>>>>> Once we release compressed blocks, we used to set IMMUTABLE bit. But it turned
>>>>> out it disallows every fs operations which we don't need for compression.
>>>>>
>>>>> Let's just prevent writing data only.
>>>>>
>>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>>>
>>>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>>>>
>>>> BTW, we need to expose .i_inline field to userspace since there is no
>>>> way to check status of inode whether it has released blocks?
>>>
>>> Need to add some in F2FS_IOC_GET_COMPRESS_OPTION?
>>
>> We should not change this interface, in order to keep its compatibility for
>> userspace usage. How about adding it in F2FS_IOC_GET_COMPRESS_OPTION_EX?
> 
> Hmm, or need to add it in getflags?

Not sure whether the flag may conflict with the bit FS_*_FL used in
lsattr/chattr.

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>>>
>>>> Thanks,
