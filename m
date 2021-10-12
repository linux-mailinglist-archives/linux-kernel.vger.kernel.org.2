Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D98E42AB87
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 20:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbhJLSF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 14:05:58 -0400
Received: from foss.arm.com ([217.140.110.172]:53410 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230002AbhJLSF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:05:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71A3C1FB;
        Tue, 12 Oct 2021 11:03:52 -0700 (PDT)
Received: from bogus (unknown [10.57.21.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14FD43F694;
        Tue, 12 Oct 2021 11:03:50 -0700 (PDT)
Date:   Tue, 12 Oct 2021 19:03:48 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     op-tee@lists.trustedfirmware.org, jens.wiklander@linaro.org,
        jerome@forissier.org, daniel.thompson@linaro.org,
        maxim.uvarov@linaro.org, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tee: optee: Fix missing devices unregister during
 optee_remove
Message-ID: <20211012180348.zalanzdw3ykqg4db@bogus>
References: <20211012073116.4156054-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012073116.4156054-1-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 01:01:16PM +0530, Sumit Garg wrote:
> When OP-TEE driver is built as a module, OP-TEE client devices
> registered on TEE bus during probe should be unregistered during
> optee_remove. So implement optee_unregister_devices() accordingly.
> 
> Fixes: c3fa24af9244 ("tee: optee: add TEE bus device enumeration support")
> Reported-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/tee/optee/core.c          |  3 +++
>  drivers/tee/optee/device.c        | 22 ++++++++++++++++++++++
>  drivers/tee/optee/optee_private.h |  1 +
>  3 files changed, 26 insertions(+)
> 
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index ccad3c7c8f6d..3915dc574503 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -586,6 +586,9 @@ static int optee_remove(struct platform_device *pdev)
>  {
>  	struct optee *optee = platform_get_drvdata(pdev);
>  
> +	/* Unregister OP-TEE specific client devices on TEE bus */
> +	optee_unregister_devices();
> +

This is not based on FF-A support series by Jens I assume. I added
optee_unregister_devices to optee_remove_common and that fixes the issue
I reported. I haven't followed the comments by Jens on the approach yet.

-- 
Regards,
Sudeep
