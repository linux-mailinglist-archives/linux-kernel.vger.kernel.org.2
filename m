Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D10365F1C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 20:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbhDTSSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 14:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbhDTSSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 14:18:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A096C06174A;
        Tue, 20 Apr 2021 11:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=H3dQaoXS8ckw81iZTI283xKWDvn2ZygHrb6uQ5sLNKM=; b=ZrAPjsd8rxeMSn08tBp0k9QOwm
        I2G4Uv21p5qNN+FOLUK/k2Mo2pT3LswfXNpmIuY20ECbtcoBm9eKYdDnXSv33OloxI17KswNG9OjV
        x/vITe+RgTWwjNnadyN8P1IJ8vGKfSf1l9nJ/JRRDEgPKUxFJpmnFqskY4i1WmTvqyRj7g7MeVszB
        nKlGPHr57dB8mQk46N7gzyNysG+JEb92eoe2OLLy8BPUnXp+8bC3dkya82RhNOOMTm644bjyTv0Dn
        9h5tjjr2SzP3Wn+aFKFQHInrlAFrQS5Pc7tS+ppGDJdUZx8v4t1FQDIXnKmNVww1cR+DAegIKGqNF
        s36n26AA==;
Received: from [2601:1c0:6280:3f0::df68]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lYuvp-00FUL9-6g; Tue, 20 Apr 2021 18:17:27 +0000
Subject: Re: [PATCH 2/5] misc: zynq: Add afi config driver
To:     Nava kishore Manne <nava.manne@xilinx.com>, robh+dt@kernel.org,
        michal.simek@xilinx.com, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, rajan.vaja@xilinx.com,
        jolly.shah@xilinx.com, tejas.patel@xilinx.com,
        amit.sunil.dhamne@xilinx.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        chinnikishore369@gmail.com, git@xilinx.com
References: <20210420081153.17020-1-nava.manne@xilinx.com>
 <20210420081153.17020-3-nava.manne@xilinx.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c6047330-8683-09f8-3a7b-e615c6cc312f@infradead.org>
Date:   Tue, 20 Apr 2021 11:17:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210420081153.17020-3-nava.manne@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/21 1:11 AM, Nava kishore Manne wrote:
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index f532c59bb59b..877b43b3377d 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -445,6 +445,17 @@ config HISI_HIKEY_USB
>  	  switching between the dual-role USB-C port and the USB-A host ports
>  	  using only one USB controller.
>  
> +config ZYNQ_AFI
> +	tristate "Xilinx ZYNQ AFI support"
> +	help
> +	  Zynq AFI driver support for writing to the AFI registers
> +	  for configuring PS_PL Bus-width. Xilinx Zynq SoC connect
> +	  the PS to the programmable logic (PL) through the AXI port.
> +	  This AXI port helps to establish the data path between the
> +	  PS and PL.In-order to establish the proper communication path
> +	  between PS and PL, the AXI port data path should be configured
> +	  with the proper Bus-width values

End that last sentence with a period ('.').

thanks.
-- 
~Randy

