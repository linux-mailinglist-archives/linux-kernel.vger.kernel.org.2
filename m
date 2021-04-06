Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD762354B37
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 05:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240019AbhDFDYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 23:24:38 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15550 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbhDFDYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 23:24:37 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FDt9M209bzPlyy;
        Tue,  6 Apr 2021 11:21:43 +0800 (CST)
Received: from [10.67.110.136] (10.67.110.136) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Tue, 6 Apr 2021 11:24:23 +0800
Subject: Re: [PATCH] firmware: qcom-scm: Fix QCOM_SCM configuration
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <nsaenzjulienne@suse.de>, <sudeep.holla@arm.com>,
        <linus.walleij@linaro.org>, <robh@kernel.org>,
        <john.stultz@linaro.org>, <colin.king@canonical.com>,
        <linux-kernel@vger.kernel.org>
References: <20210331064941.134333-1-heying24@huawei.com>
 <YGcpdDrDJiXQX2ZJ@kroah.com>
From:   "heying (H)" <heying24@huawei.com>
Message-ID: <4abf2891-87f3-ffe5-db36-059d31ac3761@huawei.com>
Date:   Tue, 6 Apr 2021 11:24:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YGcpdDrDJiXQX2ZJ@kroah.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.136]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

ÔÚ 2021/4/2 22:25, Greg KH Ð´µÀ:
> On Wed, Mar 31, 2021 at 02:49:41AM -0400, He Ying wrote:
>> When CONFIG_QCOM_SCM is y while CONFIG_HAVE_ARM_SMCCC
>> is not set, compiling errors are encountered as follows:
>>
>> drivers/firmware/qcom_scm-smc.o: In function `__scm_smc_do_quirk':
>> qcom_scm-smc.c:(.text+0x36): undefined reference to `__arm_smccc_smc'
>> drivers/firmware/qcom_scm-legacy.o: In function `scm_legacy_call':
>> qcom_scm-legacy.c:(.text+0xe2): undefined reference to `__arm_smccc_smc'
>> drivers/firmware/qcom_scm-legacy.o: In function `scm_legacy_call_atomic':
>> qcom_scm-legacy.c:(.text+0x1f0): undefined reference to `__arm_smccc_smc'
>>
>> So add dependency on HAVE_ARM_SMCCC in QCOM_SCM configuration.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: He Ying <heying24@huawei.com>
>> ---
>>   drivers/firmware/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
> What commit caused this problem to show up?  Please add a "Fixes:" tag
> in here and resend.

OK. I'll resend.


Thanks.

