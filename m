Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4681B3A13ED
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 14:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbhFIMPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 08:15:35 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5471 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbhFIMPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 08:15:34 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G0QtG24LVzZdQj;
        Wed,  9 Jun 2021 20:10:46 +0800 (CST)
Received: from dggema761-chm.china.huawei.com (10.1.198.203) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 20:13:36 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 dggema761-chm.china.huawei.com (10.1.198.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 9 Jun 2021 20:13:35 +0800
Subject: Re: [PATCH] mailbox: bcm-flexrm-mailbox: Remove redundant dev_err
 call in flexrm_mbox_probe()
To:     <jaswinder.singh@linaro.org>, <eric@anholt.net>,
        <jassisinghbrar@gmail.com>
CC:     <bcm-kernel-feedback-list@broadcom.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-rpi-kernel@lists.infradead.org>, <yukuai3@huawei.com>
References: <20210601082834.129587-1-chengzhihao1@huawei.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <cfa3162b-32eb-487a-d01e-6d69293c9965@huawei.com>
Date:   Wed, 9 Jun 2021 20:13:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20210601082834.129587-1-chengzhihao1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema761-chm.china.huawei.com (10.1.198.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2021/6/1 16:28, Zhihao Cheng Ð´µÀ:
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
>   drivers/mailbox/bcm-flexrm-mailbox.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
> index b4f33dc399a0..78073ad1f2f1 100644
> --- a/drivers/mailbox/bcm-flexrm-mailbox.c
> +++ b/drivers/mailbox/bcm-flexrm-mailbox.c
> @@ -1523,7 +1523,6 @@ static int flexrm_mbox_probe(struct platform_device *pdev)
>   	mbox->regs = devm_ioremap_resource(&pdev->dev, iomem);
>   	if (IS_ERR(mbox->regs)) {
>   		ret = PTR_ERR(mbox->regs);
> -		dev_err(&pdev->dev, "Failed to remap mailbox regs: %d\n", ret);
>   		goto fail;
>   	}
>   	regs_end = mbox->regs + resource_size(iomem);

friendly ping.

