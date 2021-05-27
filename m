Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1FC5392483
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 03:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbhE0Bsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 21:48:35 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5563 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbhE0Bsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 21:48:35 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fr9bF3Mx9zjX6g;
        Thu, 27 May 2021 09:44:09 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 27 May 2021 09:47:01 +0800
Received: from [10.174.177.91] (10.174.177.91) by
 dggpemm500004.china.huawei.com (7.185.36.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 27 May 2021 09:47:01 +0800
Subject: Re: [PATCH -next v2] module: fix build error when CONFIG_SYSFS is
 disabled
To:     Jessica Yu <jeyu@kernel.org>
CC:     <sfr@canb.auug.org.au>, <swboyd@chromium.org>,
        <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <20210525105049.34804-1-cuibixuan@huawei.com>
 <YK46kiW1gHYAaK7a@p200300cbcf361a0029e37a38368d6727.dip0.t-ipconnect.de>
From:   Bixuan Cui <cuibixuan@huawei.com>
Message-ID: <adff5fff-afa0-219b-ccc1-63303141190a@huawei.com>
Date:   Thu, 27 May 2021 09:47:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <YK46kiW1gHYAaK7a@p200300cbcf361a0029e37a38368d6727.dip0.t-ipconnect.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/5/26 20:09, Jessica Yu wrote:
>> Fix build error when disable CONFIG_SYSFS:
>> kernel/module.c:2805:8: error: implicit declaration of function ‘sect_empty’; did you mean ‘desc_empty’? [-Werror=implicit-function-declaration]
>> 2805 |   if (!sect_empty(sechdr) && sechdr->sh_type == SHT_NOTE &&
>>
>> Fixes: 9ee6682aa528 ("module: add printk formats to add module build ID to stacktraces")
> 
> Hm, can't find this commit in the next-20210526 tree. Commit 7685f91fed25
> ("module: add printk formats to add module build ID to stacktraces")
> seems to be the correct one.
It was my linux-next repository that was abnormal. :-(  I re-downloaded it and commit id is 7685f91fed25.

Thanks,
Bixuan Cui
