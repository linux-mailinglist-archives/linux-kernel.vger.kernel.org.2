Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D7938FCCF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 10:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhEYI3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 04:29:46 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5700 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbhEYI3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 04:29:38 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fq6b03qY1z1BRl2;
        Tue, 25 May 2021 16:25:16 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 16:28:07 +0800
Received: from [10.174.177.91] (10.174.177.91) by
 dggpemm500004.china.huawei.com (7.185.36.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 16:28:06 +0800
Subject: Re: [PATCH -next] module: fix build error when CONFIG_SYSFS is
 disabled
To:     Stephen Boyd <swboyd@chromium.org>, <jeyu@kernel.org>
CC:     <sfr@canb.auug.org.au>, <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
References: <20210525085400.15854-1-cuibixuan@huawei.com>
 <CAE-0n522LiGxorhBXtqE2yj8ZKtnmVCikCPFV_iQp8MJzNA+Zg@mail.gmail.com>
From:   Bixuan Cui <cuibixuan@huawei.com>
Message-ID: <03c7a51d-fad4-da67-36d6-5ab501dea3ed@huawei.com>
Date:   Tue, 25 May 2021 16:28:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAE-0n522LiGxorhBXtqE2yj8ZKtnmVCikCPFV_iQp8MJzNA+Zg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/5/25 15:36, Stephen Boyd wrote:
> Quoting Bixuan Cui (2021-05-25 01:54:00)
>>  kernel/module.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/module.c b/kernel/module.c
>> index decf4601e943..7287ecc76714 100644
>> --- a/kernel/module.c
>> +++ b/kernel/module.c
>> @@ -2794,7 +2794,8 @@ static void add_kallsyms(struct module *mod, const struct load_info *info)
>>  }
>>  #endif /* CONFIG_KALLSYMS */
>>
>> -#if IS_ENABLED(CONFIG_KALLSYMS) && IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
>> +#if IS_ENABLED(CONFIG_KALLSYMS) && IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID) && \
>> +       IS_ENABLED(CONFIG_SYSFS)
> Thanks for the report. It is the wrong fix though as we don't care that
> sysfs is enabled or not. How about this patch?
Hello, your patch solves that problem very well. Will you send a new patch?

Thanks
Bixuan Cui
