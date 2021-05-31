Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20D839603A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 16:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbhEaOXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 10:23:36 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3353 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbhEaNtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 09:49:52 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FtxNV6pjnz67Rs;
        Mon, 31 May 2021 21:44:26 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 21:48:06 +0800
Received: from [10.174.179.129] (10.174.179.129) by
 dggema762-chm.china.huawei.com (10.1.198.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 31 May 2021 21:48:05 +0800
Subject: Re: [PATCH V2] drm: bridge: cdns-mhdp8546: Fix PM reference leak in
 cdns_mhdp_probe()
To:     Robert Foss <robert.foss@linaro.org>
CC:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20210517081601.1563193-1-yukuai3@huawei.com>
 <20210529095554.3150362-1-yukuai3@huawei.com>
 <CAG3jFyt53-MhwgGGcmMVSap3xCE_cQOmN26Rj3TvHtWFeVLZWg@mail.gmail.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <36cef11c-6b33-57ff-f1b1-32c074efa8ac@huawei.com>
Date:   Mon, 31 May 2021 21:48:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAG3jFyt53-MhwgGGcmMVSap3xCE_cQOmN26Rj3TvHtWFeVLZWg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.129]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/05/31 18:54, Robert Foss wrote:
> Hey Yu,
> 
> I'm not finding your this patch with the correct tags. I'd expect the subject:
> [PATCH v2] drm: bridge: cdns-mhdp8546: Fix PM reference leak in
> cdns_mhdp_probe()
> 
> Can you please resubmit using this title, just to be sure I merge the
> right version of this code.
> 
Hi,

I just resubmit v2 patch.

Thanks
Yu Kuai
> On Sat, 29 May 2021 at 11:46, Yu Kuai <yukuai3@huawei.com> wrote:
>>
>> pm_runtime_get_sync will increment pm usage counter even it failed.
>> Forgetting to putting operation will result in reference leak here.
>> Fix it by replacing it with pm_runtime_resume_and_get to keep usage
>> counter balanced.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>> changes in V2:
>>   - change error message.
>>
>>   drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
>> index 0cd8f40fb690..eab959a59214 100644
>> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
>> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
>> @@ -2478,9 +2478,9 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
>>          clk_prepare_enable(clk);
>>
>>          pm_runtime_enable(dev);
>> -       ret = pm_runtime_get_sync(dev);
>> +       ret = pm_runtime_resume_and_get(dev);
>>          if (ret < 0) {
>> -               dev_err(dev, "pm_runtime_get_sync failed\n");
>> +               dev_err(dev, "pm_runtime_resume_and_get failed\n");
>>                  pm_runtime_disable(dev);
>>                  goto clk_disable;
>>          }
>> --
>> 2.25.4
>>
> .
> 
