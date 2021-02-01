Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C371F30A044
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 03:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhBACJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 21:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbhBACIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 21:08:07 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEFEC061574
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 18:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=XVJZ9wz/6HNxtVFj0zTWaJZ0E2MH/K++SyLauHW1yL0=; b=wVqC6KQNWOSqWRUIzUuhCs7OZf
        dDPIRWuZijqFZiNw7puY3ICMmHMeu3tbCPNzhES9hQB5omytgM5ADzxiSRUwouC60g9isJrwoCYre
        k8qrq62Nei8J7Xq9LAk5HM5mhW4o/o5o9H1rDCtCZ6vXpz69jgWjTKySNdHQvZU+fQWNK8RGsS+Mt
        O+2SNQ/9g/EiyVKh9MAziHuiWzp2TC/s8fwxKsA0gi9/a8KojCj0jjY5ItW1Rk157YCtinQ0kjrIP
        ArS4HAI/kHB6ML4Wk8iUFRbl1iYSbGhPADm98nWUnYTJeVjoy0NIXX//3e+eOox9S3qJdsbEC7rhe
        atBtZ5ew==;
Received: from [2601:1c0:6280:3f0::9abc]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l6OcW-0005V8-T9; Mon, 01 Feb 2021 02:07:17 +0000
Subject: Re: [PATCH v3 29/34] Intel tsens i2c slave driver.
To:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        "C, Udhayakumar" <udhayakumar.c@intel.com>, C@linux.intel.com
References: <20210130022124.65083-1-mgross@linux.intel.com>
 <20210130022124.65083-30-mgross@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <30eccbdb-86ab-76ab-7cf5-ef1eabe94e46@infradead.org>
Date:   Sun, 31 Jan 2021 18:07:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210130022124.65083-30-mgross@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/21 6:20 PM, mgross@linux.intel.com wrote:
> diff --git a/drivers/misc/intel_tsens/Kconfig b/drivers/misc/intel_tsens/Kconfig
> index 8b263fdd80c3..9b2198ab28c3 100644
> --- a/drivers/misc/intel_tsens/Kconfig
> +++ b/drivers/misc/intel_tsens/Kconfig
> @@ -14,6 +14,21 @@ config INTEL_TSENS_LOCAL_HOST
>  	  Say Y if using a processor that includes the Intel VPU such as
>  	  Keem Bay.  If unsure, say N.
>  
> +config INTEL_TSENS_I2C_SLAVE
> +	bool "I2C slave driver for intel tsens"
> +	depends on INTEL_TSENS_LOCAL_HOST
> +	select I2C

Repeating:

No, do not select I2C. Use:
	depends on I2C


> +	select I2C_SLAVE
> +	help
> +	  This option enables tsens I2C slave driver.
> +
> +	  This driver is used for reporting thermal data via I2C
> +	  SMBUS to remote host.
> +	  Enable this option if you want to have support for thermal
> +	  management controller.
> +	  Say Y if using a processor that includes the Intel VPU such as
> +	  Keem Bay.  If unsure, say N.


-- 
~Randy

