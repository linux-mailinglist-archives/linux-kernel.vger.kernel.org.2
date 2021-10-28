Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7C743D879
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 03:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhJ1B0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 21:26:47 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:29944 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhJ1B0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 21:26:46 -0400
Received: from dggeml757-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Hfnls5mNrzbnK9;
        Thu, 28 Oct 2021 09:19:37 +0800 (CST)
Received: from [10.67.103.22] (10.67.103.22) by dggeml757-chm.china.huawei.com
 (10.1.199.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Thu, 28
 Oct 2021 09:24:17 +0800
Message-ID: <e1d5b35e-5055-34de-5864-f2331c9ac051@hisilicon.com>
Date:   Thu, 28 Oct 2021 09:24:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: drivers/crypto: suspected missing null check in hisi_qm_pre_init
To:     YE Chengfeng <cyeaa@connect.ust.hk>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <TYCP286MB11889662BE368CEEF92CF65E8A859@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
From:   Zhou Wang <wangzhou1@hisilicon.com>
In-Reply-To: <TYCP286MB11889662BE368CEEF92CF65E8A859@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.22]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeml757-chm.china.huawei.com (10.1.199.137)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> 
> https://github.com/torvalds/linux/blob/master/drivers/crypto/hisilicon/qm.c#L3286
> 
> We notice that at #line 3286, the return pointer of ACPI_COMPANION is not null-checked, and then it's dereferenced in acpi_device_power_manageable. Seems that it could be a potential null-pointer-dereference issue.
> 
> This is detected by our experimental static analysis tool, it could be false positive, so we manually check and report those we think may be true bugs. Would you like to have a look at them? If it's real bug, we could like to provide patch to ease your workflow.

Hi Chengfeng,

It will reture NULL when ACPI is disabled, however this driver deponds on
ACPI, which is already set in Kconfig. So no need do null-checked here.

Thanks,
Zhou

> 
> Thanks so much,
> Chengfeng
> .
> 
