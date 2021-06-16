Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999703A9373
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 09:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhFPHEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 03:04:44 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4939 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbhFPHEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 03:04:42 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G4bdk0Fcgz6wG7;
        Wed, 16 Jun 2021 14:59:22 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 15:02:31 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 15:02:31 +0800
Subject: Re: [PATCH -next] ALSA: fm801: Fix missing pci_release_regions() on
 error in snd_fm801_create()
To:     Takashi Iwai <tiwai@suse.de>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <perex@perex.cz>, <tiwai@suse.com>, <broonie@kernel.org>
References: <20210616025507.2120103-1-yangyingliang@huawei.com>
 <s5hfsxi1ewc.wl-tiwai@suse.de>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <80aeb5eb-f06e-4069-171c-ed8a84a15a69@huawei.com>
Date:   Wed, 16 Jun 2021 15:02:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <s5hfsxi1ewc.wl-tiwai@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/6/16 14:50, Takashi Iwai wrote:
> On Wed, 16 Jun 2021 04:55:07 +0200,
> Yang Yingliang wrote:
>> Fix the missing pci_release_regions() before return
>> from snd_fm801_create() in the error handling case.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> pci_regions() is manated in pcim_release(), hence you don't need to
> call it explicitly.
OK.

Thanks,
Yang
>
>
> thanks,
>
> Takashi
> .
