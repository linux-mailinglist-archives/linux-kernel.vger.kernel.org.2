Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650DF340F6A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 21:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbhCRUyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 16:54:02 -0400
Received: from linux.microsoft.com ([13.77.154.182]:49620 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhCRUxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 16:53:36 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5258F209C385;
        Thu, 18 Mar 2021 13:53:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5258F209C385
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1616100815;
        bh=P8Q00MkxdNHTzV0x6ph/OeeOS76Ja/xwdh4nzwlgQZ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eu5D4JPPdLkKA6GAlxVfLHNybD0L+96o3qtvz6V980xCQSUFyPQQaTKtdCeojjCKL
         naIy0NAIu0B827IpWnZ31KCnve2K0A4agCTbNiSK0TJhYvHEBnYzjIkkKxLlCnVdav
         mBpeMdd7AElD0bE4TAn4sKmS/If3AswXn6Ly6v5E=
Date:   Thu, 18 Mar 2021 15:51:43 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Allen Pais <allen.lkml@gmail.com>
Cc:     jens.wiklander@linaro.org, zajec5@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org,
        Allen Pais <apais@linux.microsoft.com>
Subject: Re: [PATCH v2 1/2] optee: fix tee out of memory failure seen during
 kexec reboot
Message-ID: <20210318205143.GA6446@sequoia>
References: <20210225090610.242623-1-allen.lkml@gmail.com>
 <20210225090610.242623-2-allen.lkml@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225090610.242623-2-allen.lkml@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-25 14:36:09, Allen Pais wrote:
> From: Allen Pais <apais@linux.microsoft.com>
> 
> The following out of memory errors are seen on kexec reboot
> from the optee core.
> 
> [    0.368428] tee_bnxt_fw optee-clnt0: tee_shm_alloc failed
> [    0.368461] tee_bnxt_fw: probe of optee-clnt0 failed with error -22
> 
> tee_shm_release() is not invoked on dma shm buffer.
> 
> Implement .shutdown() method to handle the release of the buffers
> correctly.
> 
> More info:
> https://github.com/OP-TEE/optee_os/issues/3637
> 
> Signed-off-by: Allen Pais <apais@linux.microsoft.com>
> ---
>  drivers/tee/optee/core.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index cf4718c6d35d..80e2774b5e2a 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -582,6 +582,13 @@ static optee_invoke_fn *get_invoke_func(struct device *dev)
>  	return ERR_PTR(-EINVAL);
>  }
>  
> +/* optee_remove - Device Removal Routine
> + * @pdev: platform device information struct
> + *
> + * optee_remove is called by platform subsystem to alter the driver
                                                      ^ alert?

> + * that it should release the device
> + */
> +
>  static int optee_remove(struct platform_device *pdev)
>  {
>  	struct optee *optee = platform_get_drvdata(pdev);
> @@ -612,6 +619,18 @@ static int optee_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +/* optee_shutdown - Device Removal Routine
> + * @pdev: platform device information struct
> + *
> + * platform_shutdown is called by the platform subsystem to alter
                                                               ^ alert

With those two changes,

Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>

Tyler

> + * the driver that a shutdown/reboot(or kexec) is happening and
> + * device must be disabled.
> + */
> +static void optee_shutdown(struct platform_device *pdev)
> +{
> +	optee_disable_shm_cache(platform_get_drvdata(pdev));
> +}
> +
>  static int optee_probe(struct platform_device *pdev)
>  {
>  	optee_invoke_fn *invoke_fn;
> @@ -738,6 +757,7 @@ MODULE_DEVICE_TABLE(of, optee_dt_match);
>  static struct platform_driver optee_driver = {
>  	.probe  = optee_probe,
>  	.remove = optee_remove,
> +	.shutdown = optee_shutdown,
>  	.driver = {
>  		.name = "optee",
>  		.of_match_table = optee_dt_match,
> -- 
> 2.25.1
> 
