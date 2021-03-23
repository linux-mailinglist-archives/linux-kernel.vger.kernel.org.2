Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B6E34568A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 04:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhCWD6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 23:58:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13662 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhCWD6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 23:58:00 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F4HZn027rznVML;
        Tue, 23 Mar 2021 11:55:29 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.203) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Tue, 23 Mar 2021
 11:57:53 +0800
Subject: Re: [PATCH] coresight: core: Fix typo in coresight-core.c
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        <mathieu.poirier@linaro.org>, <mike.leach@linaro.org>
CC:     <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@openeuler.org>
References: <1616418670-45882-1-git-send-email-liuqi115@huawei.com>
 <914fbf5c-cb1a-47d0-00ec-e971f3e01ba1@arm.com>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <e347f5bf-44c0-275c-441e-fb8f2f89fffe@huawei.com>
Date:   Tue, 23 Mar 2021 11:57:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <914fbf5c-cb1a-47d0-00ec-e971f3e01ba1@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.38.203]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/3/22 22:38, Suzuki K Poulose wrote:
> On 22/03/2021 13:11, Qi Liu wrote:
>> Fix up one typo: compoment->component.
>>
>> Fixes: 8e264c52e1da  ("coresight: core: Allow the coresight core 
>> driver to be built as a module")
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> 
> Thanks for the patch. I will queue this.
> 
> .
Hi Suzuki,

Randy pointed out it should be "components" here, so I'll send a v2 with 
this fixed.
Thanks,
Qi

