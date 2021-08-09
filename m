Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2613E3E01
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 04:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbhHICty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 22:49:54 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:8380 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbhHICtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 22:49:53 -0400
Received: from dggeml759-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GjgS06nT7z85Qx;
        Mon,  9 Aug 2021 10:45:36 +0800 (CST)
Received: from [10.174.178.165] (10.174.178.165) by
 dggeml759-chm.china.huawei.com (10.1.199.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 9 Aug 2021 10:49:31 +0800
Subject: Re: [PATCH -next] erofs: make symbol 'erofs_iomap_ops' static
To:     Chao Yu <chao@kernel.org>, Gao Xiang <hsiangkao@linux.alibaba.com>
CC:     Huang Jianan <huangjianan@oppo.com>, Gao Xiang <xiang@kernel.org>,
        <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
References: <20210808063343.255817-1-weiyongjun1@huawei.com>
 <YQ/ZxZkNCtWGO6X4@B-P7TQMD6M-0146.local>
 <4ddfb962-97fc-28b0-0006-197574a1ec00@kernel.org>
From:   "weiyongjun (A)" <weiyongjun1@huawei.com>
Message-ID: <82bae76e-8811-22d4-0b75-f58df1153def@huawei.com>
Date:   Mon, 9 Aug 2021 10:49:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <4ddfb962-97fc-28b0-0006-197574a1ec00@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.165]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeml759-chm.china.huawei.com (10.1.199.138)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/8/9 7:56, Chao Yu 写道:
> On 2021/8/8 21:19, Gao Xiang wrote:
>> On Sun, Aug 08, 2021 at 06:33:43AM +0000, Wei Yongjun wrote:
>>> The sparse tool complains as follows:
>>>
>>> fs/erofs/data.c:150:24: warning:
>>>   symbol 'erofs_iomap_ops' was not declared. Should it be static?
>>>
>>> This symbol is not used outside of data.c, so marks it static.
>
> Thanks for the patch, I guess it will be better to fix in original patch
> if you don't mind.


Yes, better to fix in original patch.

Regards.

