Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11706365F15
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 20:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbhDTSQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 14:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbhDTSQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 14:16:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E00C06174A;
        Tue, 20 Apr 2021 11:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=B8wdXqMqUBLzsCivp+edaOcFTlLJLF22BvmBImW3Cds=; b=idQGC38rPRBjbmYwZbtyZOm3jE
        6dHdTfCI3TU2tQDB+jpBCRy7jAANYERDUPDCn1zPAvNNhKLwmJgHQdkPnuCGUgXe4OLSvdasZwwEV
        vGnhMchBXwHkGiegv9uTQMK4CE6ct+pa6L17ZpY33ur9mazKAqLDjhLEj3v7lmkbjJcCpF7ZCNR2Q
        8oXOj+in3tu1t5ajV4nsp8QhCc8HzzGkgzfruWz/wYkoPdgpPr1Ogq1T/4Xd2446qkLVW1yn/qHxX
        Y/m9ahMvYiCdElUwTNd/ravPIY24mm8yU8lIFGAucoiyjLTNoIuDbjsvxaxMKqHP/wTyCNh0agJbi
        GDEmOr/A==;
Received: from [2601:1c0:6280:3f0::df68]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lYuu5-00FUHM-Cw; Tue, 20 Apr 2021 18:15:24 +0000
Subject: Re: [PATCH 5/5] misc: zynqmp: Add afi config driver
To:     Nava kishore Manne <nava.manne@xilinx.com>, robh+dt@kernel.org,
        michal.simek@xilinx.com, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, rajan.vaja@xilinx.com,
        jolly.shah@xilinx.com, tejas.patel@xilinx.com,
        amit.sunil.dhamne@xilinx.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        chinnikishore369@gmail.com, git@xilinx.com
References: <20210420081153.17020-1-nava.manne@xilinx.com>
 <20210420081153.17020-6-nava.manne@xilinx.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c16bb43d-a4e6-cece-85f0-beef3797ee8f@infradead.org>
Date:   Tue, 20 Apr 2021 11:15:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210420081153.17020-6-nava.manne@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/21 1:11 AM, Nava kishore Manne wrote:
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 877b43b3377d..d1ea1eeb3ac1 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -456,6 +456,17 @@ config ZYNQ_AFI
>  	  between PS and PL, the AXI port data path should be configured
>  	  with the proper Bus-width values
>  
> +config ZYNQMP_AFI
> +        tristate "Xilinx ZYNQMP AFI support"
> +        help
> +	  ZynqMP AFI driver support for writing to the AFI registers for
> +	  configuring PS_PL Bus-width. Xilinx Zynq US+ MPSoC connect the
> +	  PS to the programmable logic (PL) through the AXI port. This AXI
> +	  port helps to establish the data path between the PS and PL.
> +	  In-order to establish the proper communication path between
> +	  PS and PL, the AXI port data path should be configured with
> +	  the proper Bus-width values
> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"

Hi,
from my notabot:

Please follow coding-style for Kconfig files:

from Documentation/process/coding-style.rst, section 10):

For all of the Kconfig* configuration files throughout the source tree,
the indentation is somewhat different.  Lines under a ``config`` definition
are indented with one tab, while help text is indented an additional two
spaces.


thanks.
-- 
~Randy

