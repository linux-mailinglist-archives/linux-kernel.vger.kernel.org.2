Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44C931B1A3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 18:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhBNRqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 12:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbhBNRqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 12:46:45 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24312C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 09:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=eNo5EzizfNasnRYaSJK7AFP6L281BfiFNpyqxH2bM28=; b=0elxeE5+m/cBsxdrGWu+jxGKvy
        z+tuuHDrAUrBbhmEGQkmvB7JwRPhsBiYsy3H0Rp/UsqxWfZIaJyrn6E/ToFMvQRCU4ZJJ1rxwlFoU
        VV3r6O3K9Hm+TqVCzlHzkajlg2mW4NmMgVYX38/erEfCQjyJYLjcYRkld+TL00uFdnunzGqcNbKOh
        5lKJwsZQ21WVPUN8nGeIk28YBZbx1bXYYqYAhrgQvPrHT+Ftqtq/EYdyH2oQZUWDCVgvvkQbW5bi6
        Thdn80uXIKXboPXAKLKEBIYupMm60FKSaWsoELckLpCvYS41e6cVZwTtC6aF4sccYw7+uAuna8apQ
        s7RSExpg==;
Received: from [2601:1c0:6280:3f0::6444]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lBLT8-0005SY-Hn; Sun, 14 Feb 2021 17:46:02 +0000
Subject: Re: [PATCH v6 28/34] misc: Intel tsens IA host driver.
To:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        "C, Udhayakumar" <udhayakumar.c@intel.com>
References: <20210212222304.110194-1-mgross@linux.intel.com>
 <20210212222304.110194-29-mgross@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <52e882de-62d6-5ec2-dfc4-dda74018df3c@infradead.org>
Date:   Sun, 14 Feb 2021 09:45:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210212222304.110194-29-mgross@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/21 2:22 PM, mgross@linux.intel.com wrote:
> diff --git a/drivers/misc/intel_tsens/Kconfig b/drivers/misc/intel_tsens/Kconfig
> index bfb8fe1997f4..8b263fdd80c3 100644
> --- a/drivers/misc/intel_tsens/Kconfig
> +++ b/drivers/misc/intel_tsens/Kconfig
> @@ -13,3 +13,16 @@ config INTEL_TSENS_LOCAL_HOST
>  	  management controller.
>  	  Say Y if using a processor that includes the Intel VPU such as
>  	  Keem Bay.  If unsure, say N.
> +
> +config INTEL_TSENS_IA_HOST
> +	tristate "Temperature sensor driver for intel tsens remote host"

s/intel/Intel/ ?

as above and below.

> +	depends on I2C && THERMAL
> +	depends on I2C_SMBUS
> +	help
> +	  This option enables tsens i2c and thermal local Host driver.
> +
> +	  This driver is used for reading thermal data via I2C SMBUS
> +	  and registers itself to thermal framework, which can be
> +	  used by thermal daemon in remote IA host
> +	  Say Y if using a processor that includes the Intel VPU such as
> +	  Keem Bay.  If unsure, say N.


-- 
~Randy

