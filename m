Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0A8392FA5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 15:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236483AbhE0N3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 09:29:50 -0400
Received: from foss.arm.com ([217.140.110.172]:57774 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236430AbhE0N3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 09:29:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5679B14FF;
        Thu, 27 May 2021 06:28:16 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 739EB3F73D;
        Thu, 27 May 2021 06:28:15 -0700 (PDT)
Date:   Thu, 27 May 2021 14:28:12 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2 1/4] firmware: arm_scmi: fix deps arm-smccc-discovery
 deps in Kconfig
Message-ID: <20210527132812.GU28060@e120937-lin>
References: <20210521134055.24271-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521134055.24271-1-etienne.carriere@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Etienne,

On Fri, May 21, 2021 at 03:40:51PM +0200, Etienne Carriere wrote:
> ARM_SCMI_PROTOCOL depends one either MAILBOX or HAVE_ARM_SMCCC_DISCOVERY,
> not MAILBOX only. This change fixes this in Kconfig file and driver
> private header file.
> 
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
> No change since v1
> ---
>  drivers/firmware/Kconfig           | 2 +-
>  drivers/firmware/arm_scmi/common.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index db0ea2d2d75a..a9c613c32282 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -9,7 +9,7 @@ menu "Firmware Drivers"
>  config ARM_SCMI_PROTOCOL
>  	tristate "ARM System Control and Management Interface (SCMI) Message Protocol"
>  	depends on ARM || ARM64 || COMPILE_TEST
> -	depends on MAILBOX
> +	depends on MAILBOX || HAVE_ARM_SMCCC_DISCOVERY
>  	help
>  	  ARM System Control and Management Interface (SCMI) protocol is a
>  	  set of operating system-independent software interfaces that are
> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> index 228bf4a71d23..8685619d38f9 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -331,7 +331,7 @@ struct scmi_desc {
>  };
>  
>  extern const struct scmi_desc scmi_mailbox_desc;
> -#ifdef CONFIG_HAVE_ARM_SMCCC
> +#ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
>  extern const struct scmi_desc scmi_smc_desc;
>  #endif
>  

This seems reasonable to me as of now, but I have to say in the original 
virtio-scmi series from Peter this issue is tackled a bit differently:

(https://lore.kernel.org/linux-arm-kernel/20210511002040.802226-1-peter.hilber@opensynergy.com/)

adding something like ARM_SCMI_HAVE_SHMEM and ARM_SCMI_HAVE_MSG and then
make mailbox and smc transport select HAVE_SHMEM while virtio selects
HAVE_MSG and keeping ARM_SCMI_PROTOCOL depends on either of those.

I found such approach a bit better in term of abstraction indeed, but
given that such virtio-scmi series I'm reworking is still probably a bit
further down the line in terms of posting, I think that your solution is
good enough for now if Sudeep agrees with it, and we can switch to the
above mentioned HAVE_* abstractions once virtio-scmi is pushed forward.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

> -- 
> 2.17.1
> 
