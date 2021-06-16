Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97543A8E0D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 03:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhFPBIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 21:08:14 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7443 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhFPBIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 21:08:13 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G4Rkl0tH4zZhkc;
        Wed, 16 Jun 2021 09:03:11 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 09:06:03 +0800
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 09:06:00 +0800
Subject: Re: [PATCH -next] ide-cd: fix warning: variable 'stat' set but not
 used
To:     Jens Axboe <axboe@kernel.dk>, <davem@davemloft.net>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>
References: <20210529061729.2824082-1-libaokun1@huawei.com>
 <bba1a668-227d-7dd4-59b3-6a90a169f4da@kernel.dk>
From:   "libaokun (A)" <libaokun1@huawei.com>
Message-ID: <35686e99-51e8-48da-bae4-7fdf348b2345@huawei.com>
Date:   Wed, 16 Jun 2021 09:05:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <bba1a668-227d-7dd4-59b3-6a90a169f4da@kernel.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your reminder.

Best Regards.


在 2021/6/16 5:45, Jens Axboe 写道:
> On 5/29/21 12:17 AM, Baokun Li wrote:
>> Fixes gcc '-Wunused-but-set-variable' warning:
>>
>> drivers/ide/ide-cd_ioctl.c: In function 'ide_cdrom_select_speed':
>> drivers/ide/ide-cd_ioctl.c:212:6: warning:
>>   variable ‘stat’ set but not used [-Wunused-but-set-variable]
>>
>> It never used since introduction.
> This code is being removed shortly, so better to just leave it alone.
>
