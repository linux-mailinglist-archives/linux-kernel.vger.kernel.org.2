Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68454340F70
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 21:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbhCRU4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 16:56:11 -0400
Received: from linux.microsoft.com ([13.77.154.182]:49890 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbhCRUzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 16:55:39 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 55B36209C384;
        Thu, 18 Mar 2021 13:55:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 55B36209C384
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1616100938;
        bh=vyX3MN32roIAb9I2amriuS+k9RGUN7SP2o/4is7afTA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jlgiy7UkXKsEcCphJLcZ8pmcv/1I6OASqWSOtkMDAvpJM5nn9q6B90uFX4iffLg3j
         sFzNUwG6F1XKYKUiB3RVk7vAIB5SB4SL6PUDVv5xHtr2wZhT8IaYIN+PGm46kadyE4
         RU5mGYnTubFB8ESNyqX89XZ37AQafsu1n1i2aE6g=
Date:   Thu, 18 Mar 2021 15:55:36 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Allen Pais <allen.lkml@gmail.com>
Cc:     jens.wiklander@linaro.org, zajec5@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org,
        Allen Pais <apais@linux.microsoft.com>
Subject: Re: [PATCH v2 2/2] firmware: tee_bnxt: implement shutdown method to
 handle kexec reboots
Message-ID: <20210318205536.GB6446@sequoia>
References: <20210225090610.242623-1-allen.lkml@gmail.com>
 <20210225090610.242623-3-allen.lkml@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225090610.242623-3-allen.lkml@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-25 14:36:10, Allen Pais wrote:
> From: Allen Pais <apais@linux.microsoft.com>
> 
>  On kexec reboot the firmware driver fails to deallocate
> shm memory leading to a memory leak. Implement .shutdown()
> method to handle kexec reboots and to release shm buffers
> correctly.
> 
> Signed-off-by: Allen Pais <apais@linux.microsoft.com>

Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>

Tyler

> ---
>  drivers/firmware/broadcom/tee_bnxt_fw.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/firmware/broadcom/tee_bnxt_fw.c b/drivers/firmware/broadcom/tee_bnxt_fw.c
> index ed10da5313e8..4c62e044a99f 100644
> --- a/drivers/firmware/broadcom/tee_bnxt_fw.c
> +++ b/drivers/firmware/broadcom/tee_bnxt_fw.c
> @@ -242,6 +242,14 @@ static int tee_bnxt_fw_remove(struct device *dev)
>  	return 0;
>  }
>  
> +static void tee_bnxt_fw_shutdown(struct device *dev)
> +{
> +	tee_shm_free(pvt_data.fw_shm_pool);
> +	tee_client_close_session(pvt_data.ctx, pvt_data.session_id);
> +	tee_client_close_context(pvt_data.ctx);
> +	pvt_data.ctx = NULL;
> +}
> +
>  static const struct tee_client_device_id tee_bnxt_fw_id_table[] = {
>  	{UUID_INIT(0x6272636D, 0x2019, 0x0716,
>  		    0x42, 0x43, 0x4D, 0x5F, 0x53, 0x43, 0x48, 0x49)},
> @@ -257,6 +265,7 @@ static struct tee_client_driver tee_bnxt_fw_driver = {
>  		.bus		= &tee_bus_type,
>  		.probe		= tee_bnxt_fw_probe,
>  		.remove		= tee_bnxt_fw_remove,
> +		.shutdown	= tee_bnxt_fw_shutdown,
>  	},
>  };
>  
> -- 
> 2.25.1
> 
