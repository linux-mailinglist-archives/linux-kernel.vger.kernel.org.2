Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87E0390694
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 18:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbhEYQZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 12:25:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:32998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232200AbhEYQZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 12:25:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69ABA6140F;
        Tue, 25 May 2021 16:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621959844;
        bh=PTtPFfWu71FFFV88kyJhBICf7yjLVTdmBVvyC8I70Wg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e5/HEqIV6+eUNRUh9RkYb3DbINQiJP1rHcSKxcPJiRislHlIaFNz2ZzJ9HRTGymgD
         3kkb4pbozmXnOo/VDeq/N54KZtC6pLZksf+rv3XxHt4gUpme7mjfEBWRo2N9femp2b
         oKbYnyn9hO8VMx6WDnxcnAHCBcc2dvaYLBL9bYQM=
Date:   Tue, 25 May 2021 18:24:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: hikey9xx: Remove defined but unused macros
Message-ID: <YK0komOt7j8R9045@kroah.com>
References: <20210523172709.19181-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210523172709.19181-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2021 at 07:27:09PM +0200, Fabio M. De Francesco wrote:
> Removed defined but unused macros. Issue detected by GCC running with
> -Wunused-macro warning option set.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  drivers/staging/hikey9xx/hisi-spmi-controller.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/staging/hikey9xx/hisi-spmi-controller.c b/drivers/staging/hikey9xx/hisi-spmi-controller.c
> index 0d42bc65f39b..b64594e2a84b 100644
> --- a/drivers/staging/hikey9xx/hisi-spmi-controller.c
> +++ b/drivers/staging/hikey9xx/hisi-spmi-controller.c
> @@ -21,16 +21,10 @@
>  #define SPMI_APB_SPMI_CMD_BASE_ADDR			0x0100
>  
>  #define SPMI_APB_SPMI_WDATA0_BASE_ADDR			0x0104
> -#define SPMI_APB_SPMI_WDATA1_BASE_ADDR			0x0108
> -#define SPMI_APB_SPMI_WDATA2_BASE_ADDR			0x010c
> -#define SPMI_APB_SPMI_WDATA3_BASE_ADDR			0x0110
>  
>  #define SPMI_APB_SPMI_STATUS_BASE_ADDR			0x0200
>  
>  #define SPMI_APB_SPMI_RDATA0_BASE_ADDR			0x0204
> -#define SPMI_APB_SPMI_RDATA1_BASE_ADDR			0x0208
> -#define SPMI_APB_SPMI_RDATA2_BASE_ADDR			0x020c
> -#define SPMI_APB_SPMI_RDATA3_BASE_ADDR			0x0210
>  
>  #define SPMI_PER_DATAREG_BYTE				4
>  /*
> @@ -64,9 +58,6 @@ enum spmi_controller_cmd_op_code {
>  #define SPMI_APB_TRANS_DONE			BIT(0)
>  #define SPMI_APB_TRANS_FAIL			BIT(2)
>  
> -/* Command register fields */
> -#define SPMI_CONTROLLER_CMD_MAX_BYTE_COUNT	16
> -
>  /* Maximum number of support PMIC peripherals */
>  #define SPMI_CONTROLLER_TIMEOUT_US		1000
>  #define SPMI_CONTROLLER_MAX_TRANS_BYTES		16
> -- 
> 2.31.1
> 
> 

Leaving macros that are not used are fine to keep around, it documents
the hardware.

That's a pretty foolish gcc warning :(


thanks,

greg k-h
