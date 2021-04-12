Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68A735C6FA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 15:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241637AbhDLNFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 09:05:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17314 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241518AbhDLNFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 09:05:42 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FJpnQ6z4Zz9yg7;
        Mon, 12 Apr 2021 21:03:06 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.144) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Mon, 12 Apr 2021
 21:05:13 +0800
Subject: Re: [PATCH] staging: fieldbus: simplify
 devm_anybuss_host_common_probe
To:     Sven Van Asbroeck <thesven73@gmail.com>
CC:     Tian Tao <tiantao6@hisilicon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1617957240-53633-1-git-send-email-tiantao6@hisilicon.com>
 <CAGngYiVfattJKO7npMHTagxNfzU-B=rP3FoZ89_yzy-c=Zw2RQ@mail.gmail.com>
 <44f55f42-cb52-f705-c40a-6d5c1844f56b@huawei.com>
 <CAGngYiV2dH4nLkFocyL4YkYkL3qu_kyB5ELZbWLeFMjjsFRpwQ@mail.gmail.com>
From:   "tiantao (H)" <tiantao6@huawei.com>
Message-ID: <b23680d9-f1b8-f458-9d6b-c10f14d13eca@huawei.com>
Date:   Mon, 12 Apr 2021 21:05:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAGngYiV2dH4nLkFocyL4YkYkL3qu_kyB5ELZbWLeFMjjsFRpwQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.188.144]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/4/12 20:40, Sven Van Asbroeck 写道:
> On Sun, Apr 11, 2021 at 9:14 PM tiantao (H) <tiantao6@huawei.com> wrote:
>> What about doing it like this?
>>
>> -static void host_release(struct device *dev, void *res)
>> +static void host_release(void *res)
>>    {
>> -       struct anybuss_host **dr = res;
>> -
>> -       anybuss_host_common_remove(*dr);
>> +       anybuss_host_common_remove(res);
>>    }
> That looks like it could work. Can you resend as a "proper" patch,
> please? To tell the versions apart, simply specify [PATCH v1] [PATCH
> v2] etc in the patch title/subject line. Then below the patch's "---
> line", add the version history.
> .
sure. thanks for helping review。

