Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53BB931B1A6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 18:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhBNRsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 12:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhBNRsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 12:48:40 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DB6C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 09:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Wpegt0jrVcZTYNIgBEdJT9yqySoep38vPF8Qm6jZbuU=; b=yCSPZbULMMah9vmThQUdz43VyB
        BAI9YxEeB802uMgl9zO2b5JuY2Ro296wfDwRY+kfn3h7Wo3Fyi8ET8pDfR8jtA4A7ryNzENnafdKu
        Eh3645oNBKl9+DBQLf61jpNy05CoOzXUOZB5W3rP/sqkxk9hI8TyAsiIvkTo0e0SuQza60hdI6t0O
        s8vxtRSdhehrWZsES6yqjr8WbmRqtMmi50YDJg1sERKPCp67Wk59FwA/G3xhvDxbu1O/DLm26Xzq3
        5GgKug7nw+/apl7eyJ4heMTlj3LBM9gszZulO+xSZKvR+9M84eyT+MM/DKcGP6X4nxYbaSlkqc35V
        pVUUzjuA==;
Received: from [2601:1c0:6280:3f0::6444]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lBLUz-0005Vv-9m; Sun, 14 Feb 2021 17:47:57 +0000
Subject: Re: [PATCH v6 33/34] misc: Hddl device management for local host
To:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        "C, Udhayakumar" <udhayakumar.c@intel.com>
References: <20210212222304.110194-1-mgross@linux.intel.com>
 <20210212222304.110194-34-mgross@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e3bf77bf-d22b-5163-2af4-db88627b5450@infradead.org>
Date:   Sun, 14 Feb 2021 09:47:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210212222304.110194-34-mgross@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/21 2:23 PM, mgross@linux.intel.com wrote:
> diff --git a/drivers/misc/hddl_device/Kconfig b/drivers/misc/hddl_device/Kconfig
> new file mode 100644
> index 000000000000..e1ae81fdf177
> --- /dev/null
> +++ b/drivers/misc/hddl_device/Kconfig
> @@ -0,0 +1,14 @@
> +# Copyright (C) 2020 Intel Corporation
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config HDDL_DEVICE_CLIENT
> +	tristate "Support for hddl device client"

Please use "HDDL" consistently.

> +	depends on XLINK_CORE && INTEL_TSENS_LOCAL_HOST
> +	help
> +	  This option enables HDDL device client module.
> +
> +	  This driver is used for sharing time sync data to local host and
> +	  retrives the sensors available on the platform. This also handles
> +	  the device connect/disconnect programming sequence.
> +	  Say Y if using a processor that includes the Intel VPU such as
> +	  Keem Bay.  If unsure, say N.


-- 
~Randy

