Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A1231B19E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 18:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhBNRpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 12:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhBNRpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 12:45:46 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5615C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 09:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=a+g8rWWli1xRnu3cTWg/CqMbNvnaPWcyQ5daAg9Tj7Q=; b=v8dEM+s6JaWqrEb/cQAzVKiBGZ
        FBbZYHJzJb+P0lHkHzdl0FIbBUStEPqMEAsL861yk2rNcxpadom+NRBRBSH8/QuTKgWk/2+mokzOf
        W3fDAjTEQ92RoXr0ImPDkCEvdQw+bMK+DGFLSgMdUBasqUvDIDqg3SA6XTlPi5IHjC6Tj6QF7HqOx
        UI6BEi7uMZ/XAkA76Kjn1f9jVvOEfIl1ZXBE6sbGmyIYprPwo1oejf5cVVjrwVJFzShnG77kSZ9V/
        Q1RW276fwbZEmnTZYmYgBhfY5R7SB7thAG4C+fsBgfrs9X2mhwkYGyV5QHn3/ymxo3792rZqVNGYB
        gyEipMDg==;
Received: from [2601:1c0:6280:3f0::6444]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lBLS8-0005JB-V4; Sun, 14 Feb 2021 17:45:01 +0000
Subject: Re: [PATCH v6 27/34] misc: Tsens ARM host thermal driver.
To:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        "C, Udhayakumar" <udhayakumar.c@intel.com>
References: <20210212222304.110194-1-mgross@linux.intel.com>
 <20210212222304.110194-28-mgross@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <79f17b05-897c-6851-072b-682932057577@infradead.org>
Date:   Sun, 14 Feb 2021 09:44:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210212222304.110194-28-mgross@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/21 2:22 PM, mgross@linux.intel.com wrote:
> diff --git a/drivers/misc/intel_tsens/Kconfig b/drivers/misc/intel_tsens/Kconfig
> new file mode 100644
> index 000000000000..bfb8fe1997f4
> --- /dev/null
> +++ b/drivers/misc/intel_tsens/Kconfig
> @@ -0,0 +1,15 @@
> +# Copyright (C) 2020 Intel Corporation
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config INTEL_TSENS_LOCAL_HOST
> +	bool "Temperature sensor driver for intel tsens"

s/intel/Intel/ ?

as below.

> +	select THERMAL
> +	help
> +	  This option enables tsens thermal local Host driver.
> +
> +	  This driver is used for reporting thermal data via thermal
> +	  framework.
> +	  Enable this option if you want to have support for thermal
> +	  management controller.
> +	  Say Y if using a processor that includes the Intel VPU such as
> +	  Keem Bay.  If unsure, say N.


-- 
~Randy

