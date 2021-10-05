Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBE2421BD9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhJEB32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhJEB31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:29:27 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0C1C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 18:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=WZWqxRhSm0wLUNBnfyuC+B/rrQM3O25LpejmzAYBNQI=; b=E7OYIpmEw5pgRAZrkM4PxexlFp
        zsDwYMh9WE1l54DvYWcifAfdU59sKGk9U5nJfR5vxgX6Yg7202km9vBwnCIUBqjPwkSZN+s4b5xhu
        p2umUvJWW3rHV4Ihh1d9BrcK7NjcGSm7LM5Iq3BaQS9fPNd/sQBYtH3nW9MFZ3xIYxMd31LLMnxT1
        b35+Zc5MVXGjp22LD5y6uKTzo9PelatS7UBveB8F9SeuSUDCoOrrtI34rscTb994HD8/n1be82RmM
        kWcNuJVxNIeqSq9hnONuy9p1syPNg2ByiyWRTOI7BUFDXPpR+SfxR7z9gl273A6nRj7u0zdEn8iP5
        k9n9/psg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXZF1-008XHw-I9; Tue, 05 Oct 2021 01:27:35 +0000
Subject: Re: [PATCH 3/5] ipmi:ipmb: Add initial support for IPMI over IPMB
To:     minyard@acm.org, openipmi-developer@lists.sourceforge.net
Cc:     Andrew Manley <andrew.manley@sealingtech.com>,
        linux-kernel@vger.kernel.org, Corey Minyard <cminyard@mvista.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20211005004019.2670691-1-minyard@acm.org>
 <20211005004019.2670691-4-minyard@acm.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1d2c2c50-8f79-03ec-5c5c-e1cd8ce07b3d@infradead.org>
Date:   Mon, 4 Oct 2021 18:27:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211005004019.2670691-4-minyard@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/4/21 5:40 PM, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> This provides access to the management controllers on an IPMB bus to a
> device sitting on the IPMB bus.  It also provides slave capability to
> respond to received messages on the bus.
> 
> Signed-off-by: Corey Minyard <minyard@acm.org>
> Tested-by: Andrew Manley <andrew.manley@sealingtech.com>
> Reviewed-by: Andrew Manley <andrew.manley@sealingtech.com>
> ---
>   drivers/char/ipmi/Kconfig     |   9 +
>   drivers/char/ipmi/Makefile    |   1 +
>   drivers/char/ipmi/ipmi_ipmb.c | 510 ++++++++++++++++++++++++++++++++++
>   3 files changed, 520 insertions(+)
>   create mode 100644 drivers/char/ipmi/ipmi_ipmb.c
> 
> diff --git a/drivers/char/ipmi/Kconfig b/drivers/char/ipmi/Kconfig
> index 249b31197eea..1c92209f023b 100644
> --- a/drivers/char/ipmi/Kconfig
> +++ b/drivers/char/ipmi/Kconfig
> @@ -75,6 +75,15 @@ config IPMI_SSIF
>   	  have a driver that must be accessed over an I2C bus instead of a
>   	  standard interface.  This module requires I2C support.
>   
> +config IPMI_IPMB
> +       tristate 'IPMI IPMB interface'
> +       select I2C

How can this select I2C unconditionally? At this point we don't
even know if this platform has/supports I2C.

Ditto for IPMI_SSIF in the current Kconfig file, while
IPMB_DEVICE_INTERFACE depends on I2C (as it should IMO).



> +       help
> +	 Provides a driver for a system running right on the IPMB bus.
> +	 It supports normal system interface messages to a BMC on the IPMB
> +	 bus, and it also supports direct messaging on the bus using
> +	 IPMB direct messages.  This module requires I2C support.

<form-letter-bot>

Please follow coding-style for Kconfig files:

(from Documentation/process/coding-style.rst, section 10):

For all of the Kconfig* configuration files throughout the source tree,
the indentation is somewhat different.  Lines under a ``config`` definition
are indented with one tab, while help text is indented an additional two
spaces.

> +
>   config IPMI_POWERNV
>   	depends on PPC_POWERNV
>   	tristate 'POWERNV (OPAL firmware) IPMI interface'


> diff --git a/drivers/char/ipmi/ipmi_ipmb.c b/drivers/char/ipmi/ipmi_ipmb.c
> new file mode 100644
> index 000000000000..b10a1fd9c563
> --- /dev/null
> +++ b/drivers/char/ipmi/ipmi_ipmb.c
> @@ -0,0 +1,510 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Driver to talk to a remote management controller on IPMB.
> + */
> +

[...]

> +
> +static int ipmi_ipmb_start_processing(void            *send_info,

Odd spacing/formatting above.

> +				      struct ipmi_smi *new_intf)
> +{
> +	struct ipmi_ipmb_dev *iidev = send_info;
> +
> +	iidev->intf = new_intf;
> +	iidev->ready = true;
> +	return 0;
> +}
> +
> +
> +static void ipmi_ipmb_sender(void                *send_info,

Ditto.

> +			     struct ipmi_smi_msg *msg)
> +{


-- 
~Randy
