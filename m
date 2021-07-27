Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78133D764D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 15:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237021AbhG0N0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 09:26:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:60380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237381AbhG0NZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 09:25:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D12D761A07;
        Tue, 27 Jul 2021 13:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627392303;
        bh=F5FO0KwrjkIdpxIRGWjqMSMQQWb+eHq3L3DMaWH6RQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u9q5p5jH2mYJrV8HkMu2/aUtXlP3FXBATy73XY6OdDb3OxuwwLVfTkwz882JyDAQS
         64+TfrckXAJ8gK6cvMKQT2aygMD5TCe94r0F7G7oPxQOnpEYdiWjYYId5I23tf+vpr
         E7f8hbHdl8LCfkXDtsJDtU0hSRFqjBcsok1GkgHU=
Date:   Tue, 27 Jul 2021 15:25:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ojaswin Mujoo <ojaswin98@gmail.com>
Cc:     nsaenz@kernel.org, stefan.wahren@i2se.com,
        dan.carpenter@oracle.com, phil@raspberrypi.com,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/5] staging: vchiq: Make creation of vchiq cdev
 optional
Message-ID: <YQAJLao8H1Hl5VVf@kroah.com>
References: <cover.1626882325.git.ojaswin98@gmail.com>
 <846c424dd4aae14d1cc28c8f30877a06e2b7dd10.1626882325.git.ojaswin98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <846c424dd4aae14d1cc28c8f30877a06e2b7dd10.1626882325.git.ojaswin98@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 09:50:52PM +0530, Ojaswin Mujoo wrote:
> Before this commit, vchiq cdev (/dev/vchiq) was always created during
> platform initialization. Introduce a new Kconfig option
> CONFIG_VCHIQ_CDEV which determines if the cdev will be created or not.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin98@gmail.com>
> ---
>  drivers/staging/vc04_services/Kconfig                  | 10 ++++++++++
>  drivers/staging/vc04_services/Makefile                 |  5 ++++-
>  .../vc04_services/interface/vchiq_arm/vchiq_arm.h      |  9 +++++++++
>  3 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vc04_services/Kconfig b/drivers/staging/vc04_services/Kconfig
> index 4b886293f198..63caa6818d37 100644
> --- a/drivers/staging/vc04_services/Kconfig
> +++ b/drivers/staging/vc04_services/Kconfig
> @@ -19,6 +19,16 @@ config BCM2835_VCHIQ
>  		Defaults to Y when the Broadcom Videocore services
>  		are included in the build, N otherwise.
>  
> +if BCM2835_VCHIQ
> +
> +config VCHIQ_CDEV
> +	bool "VCHIQ Character Driver"
> +	help
> +		Enable the creation of VCHIQ character driver to help
> +		communicate with the Videocore platform.

I'll take this, but this really should say more about what this really
is for.  Who needs this?  Why will I know if I want a character driver
interface?  What tools talk to this?

Or conversely, why would I want to turn this off?

Can you send a follow-on patch that makes this more descriptive?

thanks,

greg k-h
