Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E943051C3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 06:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbhA0FMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 00:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbhA0Ehu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 23:37:50 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D41C061786
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 20:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=9kwK2OH86rVjbs1kMhcEiUURcx/UySsphNOb5yQesCc=; b=dieY+qjjMdeJlt68JY05zRNAQV
        6rRSBucBkcCZsgW8TyaYfaatOpXfACWxcDSTFIw/aDoBuf15j95mbOE127bGZmLZQjIJdO4aLx3Mi
        cnA3IDdJKsU7Wl4uotg3pliefmHFRvFCUUJn3ijC5ySWc/4ubmuBDXCzEuO2uLAfENY7FX26/RfNu
        SXopD20vXMAPHMhUW8UInvnv9wBDS8GyfEcLGdqgoaZ0+4DnqLTbHIIU9Fgk/k++LUtdI+1Y87j00
        JDtpun0q/IRP3XpE3VYCetWShPpmDyMh51PPOgwHEPhtRr9Ov/vwYHcvG2n2j92wsNYUAW6olillX
        +2DUn1ww==;
Received: from [2601:1c0:6280:3f0::7650]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l4cYs-0002bT-Cr; Wed, 27 Jan 2021 04:36:10 +0000
Subject: Re: [PATCH v3 29/34] Intel tsens i2c slave driver.
To:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        "C, Udhayakumar" <udhayakumar.c@intel.com>, C@linux.intel.com
References: <20210126054036.61587-1-mgross@linux.intel.com>
 <20210126054036.61587-30-mgross@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7bd63c54-607a-5cc6-420c-2c2ff59a5c8e@infradead.org>
Date:   Tue, 26 Jan 2021 20:36:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210126054036.61587-30-mgross@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/21 9:40 PM, mgross@linux.intel.com wrote:
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

	depends on I2C
as I believe Arnd has already said.

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
netiquette: https://people.kernel.org/tglx/notes-about-netiquette
