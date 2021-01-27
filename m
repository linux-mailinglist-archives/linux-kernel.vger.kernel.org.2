Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C0B3051BF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 06:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbhA0FK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 00:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239051AbhA0Eab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 23:30:31 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC49C061574
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 20:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=GmgcyMiBvrWTbRgBsivgcB0Yc6No+6OhUkYVMTf/Nxg=; b=VKefOFmaNkGeUUJGeo+bC862cD
        q08fZBvE3frnc+EE2+1wqQVaEQgSEwleV2AsqOlr+ed68vcwNV+JeJEqDgW/8ANBnNXd7A+F6bRIn
        ESqVr97eDedOKf7zlUoYB1v5lX5vvTBcIdEDnUUxysiIameJQNXnTs//pN92McTaK3AqM6ksVbm+j
        KSdkvTtG4c1hNfC5Cl7xHje1kDAV6nD4G1mYFtXeGLRYB6uCaGRZCdIxHyaOB+jWJng/l4VCZabfM
        CCsCSKA5nHlqijXAqJa5oZ9kgjYVvQsxEgDvGU8iNuO4g8zLcB6vNj384pKbGAQab6qIkZp3G9Gsq
        0chJQ3cA==;
Received: from [2601:1c0:6280:3f0::7650]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l4cSi-00025D-LJ; Wed, 27 Jan 2021 04:29:48 +0000
Subject: Re: [PATCH v3 31/34] Intel Keem Bay XLink SMBus driver
To:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Ramya P Karanth <ramya.p.karanth@intel.com>
References: <20210126054036.61587-1-mgross@linux.intel.com>
 <20210126054036.61587-32-mgross@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8d0cc185-8e0c-f0a4-dc9c-b0040083254f@infradead.org>
Date:   Tue, 26 Jan 2021 20:29:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210126054036.61587-32-mgross@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/21 9:40 PM, mgross@linux.intel.com wrote:
> diff --git a/drivers/misc/xlink-smbus/Kconfig b/drivers/misc/xlink-smbus/Kconfig
> new file mode 100644
> index 000000000000..e6cdf8b9a096
> --- /dev/null
> +++ b/drivers/misc/xlink-smbus/Kconfig
> @@ -0,0 +1,26 @@
> +# Copyright (C) 2020 Intel Corporation
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config XLINK_SMBUS
> +	tristate "Enable smbus interface over Xlink PCIe"

s/smbus/SMBUS/
as in the other config below.

> +	depends on XLINK_CORE
> +	depends on HDDL_DEVICE_CLIENT || HDDL_DEVICE_SERVER
> +	help
> +	 Enable xlink-pcie as i2c adapter both slave and master. The server

s/i2c/I2C/

> +	 (Remote Host) will use this interface to get sensor data from the soc

s/soc/SOC/  or maybe SoC

> +	 (vision accelerator - Local Host) which is connected over PCIe.
> +	 This driver is loaded on both Remote Host and Local Host.
> +	 Select M to compile the driver as a module, name is xlink-smbus.
> +	 If unsure, select N.

and all of that help text should be indented with one tab + 2 spaces.

> +
> +
> +config XLINK_SMBUS_PROXY
> +	tristate "Enable SMBUS adapter as proxy for I2C controller"
> +	depends on XLINK_CORE
> +	depends on XLINK_SMBUS
> +	help
> +	 Enable this config when SMBUS adapter is acting as proxy for
> +	 another I2C controller.
> +	 Select M or Y if building for Intel Vision Processing Unit (VPU)
> +	 Local Host core.
> +	 Select N, if building for a Remote Host kernel.

All of that help text should be indented with one tab + 2 spaces.


-- 
~Randy
netiquette: https://people.kernel.org/tglx/notes-about-netiquette
