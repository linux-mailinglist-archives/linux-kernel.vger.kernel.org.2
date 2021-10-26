Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8212B43B013
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 12:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbhJZKfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 06:35:20 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:4029 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbhJZKfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:35:16 -0400
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Hdp3K70Bhz67nP6;
        Tue, 26 Oct 2021 18:29:33 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 26 Oct 2021 12:32:46 +0200
Received: from [10.47.95.85] (10.47.95.85) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 26 Oct
 2021 11:32:46 +0100
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogZHJpdmVyL2J1Zzogc3VzcGVjdGVkIG1pc3Npbmcg?=
 =?UTF-8?Q?null_check_in_hisi=5flpc=2ec?=
To:     YE Chengfeng <cyeaa@connect.ust.hk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <TYCP286MB118803910D5797B4B1B1938D8A839@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
 <TYCP286MB1188596CE44B1236D4EDD4B88A839@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
From:   John Garry <john.garry@huawei.com>
Message-ID: <035fa6a5-2401-abbb-84a0-e46ddc0ce157@huawei.com>
Date:   Tue, 26 Oct 2021 11:32:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <TYCP286MB1188596CE44B1236D4EDD4B88A839@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.95.85]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2021 16:31, YE Chengfeng wrote:
> It is driver/bus, sorry for the typo.
> 
> -----邮件原件-----
> 发件人: YE Chengfeng
> 发送时间: 2021年10月25日 23:22
> 收件人: linux-kernel@vger.kernel.org; john.garry@huawei.com
> 主题: driver/bug: suspected missing null check in hisi_lpc.c
> 
> Hi,
> 
> https://github.com/torvalds/linux/blob/master/drivers/bus/hisi_lpc.c#L483
> 
> Our experimental static analysis tool detects a null-ptr-reference problem. It could be false positive, we report this to you just in case.
> 
> Null check is missing for the return pointer of ACPI_COMPANION at line 483 and line 504. It seems that there could be potential null-ptr-dereference problem at line 488 and line 509. Could you spare some time to have a look at it?
> 
> Thanks so much,
> Chengfeng
> 

I don't think that we should have a problem as ACPI_COMPANION() should 
just not return NULL for us. But I can't give you a better reason than 
that without fully examining the ACPI code, which I'm not keen on...

Thanks,
John
