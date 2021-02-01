Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A932930A04C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 03:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhBACOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 21:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhBACOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 21:14:33 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D8AC061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 18:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=V/IebqQk3h8MBWYv6rvKZ41ct4qnwDNCUGFINvgQ6n4=; b=FGcRRZPq/5pnlE/eZeS49TN9P4
        Dew8eKGwqFmcxAAtme3kvDydfQuplwg0lR4WU3QNTMLU9gVALjxaXVmnO91h/RuYINMjOLee6tP4F
        1kYtEC2eXWgRCIu5Na8pDlvsuPHwYPxRnXQ8EtEiU4sZI0mh82HTcATOHbvqR7I9rEMwONuqbmaHw
        GnKZtGYIX+dPkwzsQxyiGN7ch7tyx25WsrBGDxgTw3rhklpJhqE8k4isGk7QxyFiet0+mKn/ksmfV
        QkF7EEu4y4R/oAh9FyUV8nsgbr6pj0iOhak9Q5225VEpq+bw4GrTjto/cn7eotad06/hC7anbGDKD
        LzaK0XKA==;
Received: from [2601:1c0:6280:3f0::9abc]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l6Oir-0005mw-CX; Mon, 01 Feb 2021 02:13:49 +0000
Subject: Re: [PATCH v4 29/34] Intel tsens i2c slave driver.
To:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        "C, Udhayakumar" <udhayakumar.c@intel.com>
References: <20210130022124.65083-1-mgross@linux.intel.com>
 <20210130022124.65083-65-mgross@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <016b292b-df7b-db6e-0935-3744d8343aa8@infradead.org>
Date:   Sun, 31 Jan 2021 18:13:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210130022124.65083-65-mgross@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/21 6:21 PM, mgross@linux.intel.com wrote:
> diff --git a/drivers/misc/intel_tsens/Kconfig b/drivers/misc/intel_tsens/Kconfig
> index 8b263fdd80c3..be8d27e81864 100644
> --- a/drivers/misc/intel_tsens/Kconfig
> +++ b/drivers/misc/intel_tsens/Kconfig
> @@ -14,6 +14,20 @@ config INTEL_TSENS_LOCAL_HOST
>  	  Say Y if using a processor that includes the Intel VPU such as
>  	  Keem Bay.  If unsure, say N.
>  
> +config INTEL_TSENS_I2C_SLAVE
> +	bool "I2C slave driver for intel tsens"
> +	depends on INTEL_TSENS_LOCAL_HOST
> +	depends on I2C=y && I2C_SLAVE
> +	help
> +	  This option enables tsens I2C slave driver.

Good, it's OK now.
The repeat v3 and then v4 confused me.

> +
> +	  This driver is used for reporting thermal data via I2C
> +	  SMBUS to remote host.
> +	  Enable this option if you want to have support for thermal
> +	  management controller.
> +	  Say Y if using a processor that includes the Intel VPU such as
> +	  Keem Bay.  If unsure, say N.


-- 
~Randy

