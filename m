Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAA331B19A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 18:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhBNRmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 12:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhBNRmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 12:42:15 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6028BC061756
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 09:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=sMcoiLpfQ0MZ5YieOUP6KWkgCIKpjfK6l01/HnUlRZw=; b=YBsmIvMqDGEAxBUrdZESwKSzNG
        hfzaOiuBcLDLTszeYcdiwmwLjtDn628jxTnZLma32UcrjENsVy8Jce9BMou1Ccb47C/1PVzZHmBL/
        XMUzSfG3GuFxVmkE71D5ZAnzSsS4vbmfXuY4d1tEU/4M251RTybersU6px7IgFQuM7Eqb2IUYmcsD
        uKbhYKuqXtCIJMXFKAitriTzyvLtUmYeSfU1GVuvPiUh+M0SLciQKdjAZzgHQVXYf6R3zgw9H+5fn
        7DQSntqNBF/F3Wyfb/DXycdm/Y/O239dvDmgk9VJBv4xYfGvrmL9CsSUNwqctSkTV8rwX2Uxb17ko
        LCasdNgQ==;
Received: from [2601:1c0:6280:3f0::6444]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lBLOm-0005AB-Vz; Sun, 14 Feb 2021 17:41:33 +0000
Subject: Re: [PATCH v6 29/34] Intel tsens i2c slave driver.
To:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        "C, Udhayakumar" <udhayakumar.c@intel.com>
References: <20210212222304.110194-1-mgross@linux.intel.com>
 <20210212222304.110194-30-mgross@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <abdb8d8a-d382-7dec-4ce1-a0dc447dea32@infradead.org>
Date:   Sun, 14 Feb 2021 09:41:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210212222304.110194-30-mgross@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/21 2:22 PM, mgross@linux.intel.com wrote:
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

s/intel/Intel/ ?
(as below)

> +	depends on INTEL_TSENS_LOCAL_HOST
> +	depends on I2C=y && I2C_SLAVE
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

