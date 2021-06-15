Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3493A74EB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 05:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhFODV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 23:21:29 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:4777 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhFODV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 23:21:28 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G3rxZ6km8zXg13;
        Tue, 15 Jun 2021 09:55:30 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 10:00:30 +0800
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 10:00:29 +0800
Subject: Re: [PATCH -next] powerpc/spider-pci: Remove set but not used
 variable 'val'
To:     <arnd@arndb.de>, <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>
References: <20210601085319.140461-1-libaokun1@huawei.com>
From:   "libaokun (A)" <libaokun1@huawei.com>
Message-ID: <29287300-6b6b-1773-a950-61ea20f1959c@huawei.com>
Date:   Tue, 15 Jun 2021 10:00:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210601085319.140461-1-libaokun1@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping

在 2021/6/1 16:53, Baokun Li 写道:
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> arch/powerpc/platforms/cell/spider-pci.c: In function 'spiderpci_io_flush':
> arch/powerpc/platforms/cell/spider-pci.c:28:6: warning:
> variable ‘val’ set but not used [-Wunused-but-set-variable]
>
> It never used since introduction.
>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>   arch/powerpc/platforms/cell/spider-pci.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/platforms/cell/spider-pci.c b/arch/powerpc/platforms/cell/spider-pci.c
> index 93ea41680f54..a1c293f42a1f 100644
> --- a/arch/powerpc/platforms/cell/spider-pci.c
> +++ b/arch/powerpc/platforms/cell/spider-pci.c
> @@ -25,10 +25,9 @@ struct spiderpci_iowa_private {
>   static void spiderpci_io_flush(struct iowa_bus *bus)
>   {
>   	struct spiderpci_iowa_private *priv;
> -	u32 val;
>   
>   	priv = bus->private;
> -	val = in_be32(priv->regs + SPIDER_PCI_DUMMY_READ);
> +	in_be32(priv->regs + SPIDER_PCI_DUMMY_READ);
>   	iosync();
>   }
>   
