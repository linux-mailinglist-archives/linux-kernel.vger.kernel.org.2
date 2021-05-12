Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7436B37EC70
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384047AbhELT4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 15:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241933AbhELSJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 14:09:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8356C061344
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 11:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=MD8daV3kN0gejfU6VKniWGHf2kzOV3GCoEimBhHQ6Mg=; b=iOakIakZMZlv1e6OfHVF2n0Exc
        OswJSthdiCnu89HO1NE1WSXsfp4Smz85+HRrHHlJp8417rEFWPNkQ2bvjaaINzUhMoWYSzRrbd2DX
        1vHhkryhyJ+hym9JLmuiVY0Ya41zpA+CI4obpo3U4QQeC9X/vIVp+DL4dJMbXM64Qp8l0IUolAyZ/
        mkrhNBgRAd1uw55FckefaxqMK6kUceV7mKxV+Q/8YySMZQoZCvt4vCYD0ZM7x4Vdukw/r5vEHSpGj
        cNh2Pl38O/teIz2tfePrbGZNglzJ9O4Y9KoyPDo2RQ18sdz06j6NOrBE15lkMhaWTPzj2g9oDnTQe
        +N5tms0g==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lgtH4-00Agkt-Ej; Wed, 12 May 2021 18:07:58 +0000
Subject: Re: [PATCH 02/15] misc: nnpi: Initialize NNP-I framework and PCIe
 modules
To:     Guy Zadicario <guy.zadicario@intel.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     olof@lixom.net, alexander.shishkin@linux.intel.com,
        andriy.shevchenko@intel.com, yochai.shefi-simchon@intel.com
References: <20210512071046.34941-1-guy.zadicario@intel.com>
 <20210512071046.34941-3-guy.zadicario@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fec29580-b5b3-3e62-05b2-0227de43971d@infradead.org>
Date:   Wed, 12 May 2021 11:07:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210512071046.34941-3-guy.zadicario@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/21 12:10 AM, Guy Zadicario wrote:
> diff --git a/drivers/misc/intel-nnpi/Kconfig b/drivers/misc/intel-nnpi/Kconfig
> new file mode 100644
> index 0000000..ccd39df
> --- /dev/null
> +++ b/drivers/misc/intel-nnpi/Kconfig
> @@ -0,0 +1,18 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +#
> +# Copyright (C) 2019-2021 Intel Corporation
> +#
> +#
> +
> +config INTEL_NNPI
> +	tristate "Intel(R) PCIe NNP-I (AI accelerator for inference) device driver"
> +	depends on PCI
> +	select DMA_SHARED_BUFFER
> +	help
> +	  Device driver for Intel NNP-I PCIe accelerator card for AI inference.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here. Two modules will
> +          get generated intel_nnpi and intel_nnpi_pcie.

For the last help text line, use a tab + 2 spaces for indentation.
Also 2 more changes:  s/get generated/be generated:/


thanks.
-- 
~Randy

