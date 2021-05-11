Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C1A37A054
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 09:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhEKHIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 03:08:37 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:2624 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbhEKHIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 03:08:34 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FfTT66dx3zklfW;
        Tue, 11 May 2021 15:05:14 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.87) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Tue, 11 May 2021
 15:07:16 +0800
Subject: Re: [PATCH -next] crypto: hisilicon -: switch to memdup_user_nul()
To:     Zou Wei <zou_wei@huawei.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>
References: <1620715031-107265-1-git-send-email-zou_wei@huawei.com>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <c3bfff60-5e78-c0b0-797b-499c70da0ff2@hisilicon.com>
Date:   Tue, 11 May 2021 15:07:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <1620715031-107265-1-git-send-email-zou_wei@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.188.87]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/5/11 14:37, Zou Wei wrote:
> Use memdup_user_nul() helper instead of open-coding to
> simplify the code.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/crypto/hisilicon/qm.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
> index ce439a0..83a5d30 100644
> --- a/drivers/crypto/hisilicon/qm.c
> +++ b/drivers/crypto/hisilicon/qm.c
> @@ -1570,17 +1570,10 @@ static ssize_t qm_cmd_write(struct file *filp, const char __user *buffer,
>  	if (count > QM_DBG_WRITE_LEN)
>  		return -ENOSPC;
>  
> -	cmd_buf = kzalloc(count + 1, GFP_KERNEL);
> -	if (!cmd_buf)
> +	cmd_buf = memdup_user_nul(buffer, count);
> +	if (IS_ERR(cmd_buf))
>  		return -ENOMEM;
>  
> -	if (copy_from_user(cmd_buf, buffer, count)) {
> -		kfree(cmd_buf);
> -		return -EFAULT;
> -	}
> -
> -	cmd_buf[count] = '\0';
> -
>  	cmd_buf_tmp = strchr(cmd_buf, '\n');
>  	if (cmd_buf_tmp) {
>  		*cmd_buf_tmp = '\0';
>

It is fine to me, thanks!

BTW, normally we use crypto: hisilicon - switch to memdup_user_nul() as the subject line,
just like other patches :)

