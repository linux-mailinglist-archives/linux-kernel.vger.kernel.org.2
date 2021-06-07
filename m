Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF6439E9FE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 01:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhFGXTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 19:19:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230264AbhFGXTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 19:19:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B3FB60FE8;
        Mon,  7 Jun 2021 23:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623107848;
        bh=uAFqAYU/bACW2VW9xPHzguF/tbVX9rGQ9607lmRbWBg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=S3n99o9nkbIypvkfNCnFeQkEgWI4Zv2XzQxtAytJCWhyXx1Yql3SHBHDwmhjnS84d
         Tpu1xPA7U1/H4FeMTDVGPyoThU5pvRYlEwZ6kUtlGziKqfg8wouMBRu13Om8FpWh2u
         b6Ifg0upCmfIcoij86PhuhUoVPhKqc76cneuSchsS9QBZaQqgEmfw9Ou1askDNBBGw
         q2VwJ3XIxNj9UwEgFdVVssOjgIc/KV7jaA9sd7CdQsOTN7t2nPG4Fg544JulsRUd7N
         vAlp/6PJrRRhqLLKZ0Fl6RZiUBSVCEtRzY3sASgpkIExu7A38K94H5cdyvwGxxwOYZ
         Fh4B3SqfAauIA==
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: introduce FI_COMPRESS_RELEASED
 instead of using IMMUTABLE bit
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20210525204955.2512409-1-jaegeuk@kernel.org>
 <20210525204955.2512409-2-jaegeuk@kernel.org>
 <95b5669f-a521-5865-2089-320e2a2493de@kernel.org>
 <YL5P15nLsc/3GQOY@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <3f2c2543-c8a4-3477-76af-5c7614b643e8@kernel.org>
Date:   Tue, 8 Jun 2021 07:17:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YL5P15nLsc/3GQOY@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/6/8 0:56, Jaegeuk Kim wrote:
> On 06/06, Chao Yu wrote:
>> On 2021/5/26 4:49, Jaegeuk Kim wrote:
>>> Once we release compressed blocks, we used to set IMMUTABLE bit. But it turned
>>> out it disallows every fs operations which we don't need for compression.
>>>
>>> Let's just prevent writing data only.
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>
>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>>
>> BTW, we need to expose .i_inline field to userspace since there is no
>> way to check status of inode whether it has released blocks?
> 
> Need to add some in F2FS_IOC_GET_COMPRESS_OPTION?

We should not change this interface, in order to keep its compatibility for
userspace usage. How about adding it in F2FS_IOC_GET_COMPRESS_OPTION_EX?

Thanks,

> 
>>
>> Thanks,
