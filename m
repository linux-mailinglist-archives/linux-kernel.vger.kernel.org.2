Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388D339BB9E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 17:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhFDPUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 11:20:10 -0400
Received: from ale.deltatee.com ([204.191.154.188]:40074 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhFDPUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 11:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=PJRwd6y2fGkVlRreR6Ar4luPs0i6HG0cPOvCC6J0yjQ=; b=lJzGdFWUTCZEigQ+DbDW1nF0WD
        zzCV9LHIvVPfMXLFiYADlNXkJdVqLf0+mQ6cIoo2Nbu7zZKHLBqc5Xud5LGqLRoYXsOIgnVh7r4/w
        hWlBiBPifO8ePzSsn4OnZxM3VID52TwH0Lh1fFk0KMby61opSFMnbhOMsUFnLJCj036ZPwhEduVap
        7gXquvjyG24IAdAi6tlIHSmDKEdgoOLKRN3bWhaUtXad/xCn2UnddfQy5mp/PsYvq0dXCOe0LKmaE
        42vEcSSOFFERjY0BvcHjKZV/1R9JDlH+Qn1tnHlP3vIrp6/iLWQGQtGPWjx/AirgUAha96ndYfV+S
        kn638Ycw==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1lpBaX-0002Uu-Ny; Fri, 04 Jun 2021 09:18:22 -0600
To:     Yang Li <yang.lee@linux.alibaba.com>, jdmason@kudzu.us
Cc:     dave.jiang@intel.com, allenbh@gmail.com,
        linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
References: <1622802051-43464-1-git-send-email-yang.lee@linux.alibaba.com>
 <1622802051-43464-2-git-send-email-yang.lee@linux.alibaba.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <490f9031-7a12-6031-7262-f38cd96cb502@deltatee.com>
Date:   Fri, 4 Jun 2021 09:18:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <1622802051-43464-2-git-send-email-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, allenbh@gmail.com, dave.jiang@intel.com, jdmason@kudzu.us, yang.lee@linux.alibaba.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH 2/2] NTB: Fix an error code in ntb_msit_probe()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




On 2021-06-04 4:20 a.m., Yang Li wrote:
> When the value of nm->isr_ctx is false, the value of ret is 0.
> So, we set ret to -ENOMEM to indicate this error.
> 
> Clean up smatch warning:
> drivers/ntb/test/ntb_msi_test.c:373 ntb_msit_probe() warn: missing error
> code 'ret'.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/ntb/test/ntb_msi_test.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/test/ntb_msi_test.c b/drivers/ntb/test/ntb_msi_test.c
> index 7095ecd..5f9e0be 100644
> --- a/drivers/ntb/test/ntb_msi_test.c
> +++ b/drivers/ntb/test/ntb_msi_test.c
> @@ -369,8 +369,10 @@ static int ntb_msit_probe(struct ntb_client *client, struct ntb_dev *ntb)
>  	if (ret)
>  		goto remove_dbgfs;
>  
> -	if (!nm->isr_ctx)
> +	if (!nm->isr_ctx) {
> +		return -ENOMEM;
>  		goto remove_dbgfs;

I think you made a typo here. You probably meant ret = -ENOMEM.

Thanks,

Logan
