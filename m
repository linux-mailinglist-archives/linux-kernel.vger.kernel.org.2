Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A89A31B1A9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 18:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhBNRtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 12:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhBNRtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 12:49:42 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09F0C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 09:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=fG95AsdhfqTCBtkTC9tiNH/lyJiww81oZ3ce5gIpPSk=; b=p4KB0e7UqyehkHMRk4pRAuJ7NV
        BBKx8c/LJBOtURur2ZktgVN7BeV2bq88Og3hWuVKMmVbbdAWGaS8GaoleHipDzeXZZUehRBDJhNRO
        d3H1qC9Hucimf6uXnlvB1MGPwuqwh1nJbTNFOqt89eMr8u9jmD5NckI44OO6aaoVYsOyX8+k832l1
        I8TRK0HgnoG5OOCVVp9FVzySnntsQTpUdxekaT4BvTz3caN9CSJ9s7ZHDAu4CpKgcXU/i9qtoqDOs
        vqne5mI3htlU+1OXeO499SFDiHoM+WgwX95OKrnujvc9zzDSS1GvcQMsSKiCr6/USpEheDRlSbdvQ
        kt96DdiQ==;
Received: from [2601:1c0:6280:3f0::6444]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lBLW0-0005Yq-7m; Sun, 14 Feb 2021 17:49:00 +0000
Subject: Re: [PATCH v6 34/34] misc: HDDL device management for IA host
To:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        "C, Udhayakumar" <udhayakumar.c@intel.com>
References: <20210212222304.110194-1-mgross@linux.intel.com>
 <20210212222304.110194-35-mgross@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <bf135165-35c3-002f-305a-33019fb52b44@infradead.org>
Date:   Sun, 14 Feb 2021 09:48:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210212222304.110194-35-mgross@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/21 2:23 PM, mgross@linux.intel.com wrote:
> diff --git a/drivers/misc/hddl_device/Kconfig b/drivers/misc/hddl_device/Kconfig
> index e1ae81fdf177..7f9a6a685275 100644
> --- a/drivers/misc/hddl_device/Kconfig
> +++ b/drivers/misc/hddl_device/Kconfig
> @@ -12,3 +12,15 @@ config HDDL_DEVICE_CLIENT
>  	  the device connect/disconnect programming sequence.
>  	  Say Y if using a processor that includes the Intel VPU such as
>  	  Keem Bay.  If unsure, say N.
> +
> +config HDDL_DEVICE_SERVER
> +	tristate "Support for hddl device server"

Please use "HDDL" consistently.

> +	depends on XLINK_CORE && !HDDL_DEVICE_CLIENT
> +	help
> +	  This option enables HDDL device server module.
> +
> +	  This driver is used for sharing time sync data to local host and
> +	  retrives the sensors available on the platform. This also handles
> +	  the device connect/disconnect programming sequence.
> +	  Say Y if using a processor that includes the Intel VPU such as
> +	  Keem Bay.  If unsure, say N.


thanks.
-- 
~Randy

