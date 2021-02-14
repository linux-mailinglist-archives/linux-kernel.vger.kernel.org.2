Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E240A31B19D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 18:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhBNRnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 12:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbhBNRnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 12:43:12 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A9BC061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 09:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=9xnvIpXIqBm9+5bnx60Um6vDcBEkk8BXUoaVf66wBRY=; b=FzjuzjMuz06P625zR5VrIUiM/o
        yHzydzvGKZbD3DXC7OATSsqmkMegQ3Dy9aSUXQVjasDKYqTa5FZy4NHSOAMsTiGeJEwsXITnBZ8Q5
        fAsCac/KZ5e0l7hfF+7DuL13wOFlMPKU9rB7X7JUWHRY/AUhQIVKP4umzf8HFzgzh5jfvWSg9zK0P
        pSMHuUMwES91VlHStWgzbD7nY+fGxaOZVixQ+fPHlKDhcD8p1NDFWo4h/5mPH6yZS/63bvCD4w8AR
        8h1huudmPKdobxDo0hgvavzohEY5KgcmEAUOEWJUpoSaJhUZ8RminWDuU6Oe9Jdu/zcKkkrboD4S8
        AJ5VWcfA==;
Received: from [2601:1c0:6280:3f0::6444]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lBLPh-0005C0-F4; Sun, 14 Feb 2021 17:42:29 +0000
Subject: Re: [PATCH v6 30/34] misc:intel_tsens: Intel Keem Bay tsens driver.
To:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        "C, Udhayakumar" <udhayakumar.c@intel.com>
References: <20210212222304.110194-1-mgross@linux.intel.com>
 <20210212222304.110194-31-mgross@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9f79622d-8985-42f8-ab25-87908ccdb89a@infradead.org>
Date:   Sun, 14 Feb 2021 09:42:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210212222304.110194-31-mgross@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/21 2:23 PM, mgross@linux.intel.com wrote:
> diff --git a/drivers/misc/intel_tsens/Kconfig b/drivers/misc/intel_tsens/Kconfig
> index be8d27e81864..5cfe6b4004e5 100644
> --- a/drivers/misc/intel_tsens/Kconfig
> +++ b/drivers/misc/intel_tsens/Kconfig
> @@ -28,6 +28,18 @@ config INTEL_TSENS_I2C_SLAVE
>  	  Say Y if using a processor that includes the Intel VPU such as
>  	  Keem Bay.  If unsure, say N.
>  
> +config KEEMBAY_THERMAL
> +	tristate "Temperature sensor driver for intel Keem Bay"

s/intel/Intel/ ?

as above and below.

> +	depends on INTEL_TSENS_LOCAL_HOST && ARCH_KEEMBAY
> +	help
> +	  Enable this option if you want to have support for Keem Bay
> +	  thermal management sensors.
> +
> +	  This driver is used for reading onchip temperature sensor
> +	  values from Keem Bay SoC.
> +	  Say Y if using a processor that includes the Intel VPU such as
> +	  Keem Bay.  If unsure, say N.


-- 
~Randy

