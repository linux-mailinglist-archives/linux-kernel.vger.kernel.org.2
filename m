Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3C937F343
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 08:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhEMGzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 02:55:50 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:2306 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbhEMGzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 02:55:38 -0400
Received: from dggemx753-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Fgj2p6QW9z19HC1;
        Thu, 13 May 2021 14:50:10 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by
 dggemx753-chm.china.huawei.com (10.0.44.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 13 May 2021 14:54:27 +0800
Subject: Re: [PATCH] erofs: fix 1 lcluster-sized pcluster for big pcluster
To:     Gao Xiang <xiang@kernel.org>, <linux-erofs@lists.ozlabs.org>
CC:     LKML <linux-kernel@vger.kernel.org>
References: <20210510064715.29123-1-xiang@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <06a646a0-8436-2fd7-4c1b-1d5ea86c600e@huawei.com>
Date:   Thu, 13 May 2021 14:54:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210510064715.29123-1-xiang@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-ClientProxiedBy: dggemx704-chm.china.huawei.com (10.1.199.51) To
 dggemx753-chm.china.huawei.com (10.0.44.37)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/5/10 14:47, Gao Xiang wrote:
> If the 1st NONHEAD lcluster of a pcluster isn't CBLKCNT lcluster type
> rather than a HEAD or PLAIN type instead, which means its pclustersize
> _must_ be 1 lcluster (since its uncompressed size < 2 lclusters),
> as illustrated below:
> 
>         HEAD     HEAD / PLAIN    lcluster type
>     ____________ ____________
>    |_:__________|_________:__|   file data (uncompressed)
>     .                .
>    .____________.
>    |____________|                pcluster data (compressed)
> 
> Such on-disk case was explained before [1] but missed to be handled
> properly in the runtime implementation.
> 
> It can be observed if manually generating 1 lcluster-sized pcluster
> with 2 lclusters (thus CBLKCNT doesn't exist.) Let's fix it now.
> 
> [1] https://lore.kernel.org/r/20210407043927.10623-1-xiang@kernel.org
> Fixes: cec6e93beadf ("erofs: support parsing big pcluster compress indexes")
> Signed-off-by: Gao Xiang <xiang@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
