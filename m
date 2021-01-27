Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2183051C1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 06:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhA0FLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 00:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239149AbhA0EcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 23:32:04 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6520FC061573
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 20:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=S/VdBpID10ndBGUS2PKRvIHsR9QbJ7ek8feQSccNKds=; b=MkIrfs/Udm7EH/UKQv33NXMGxX
        5Qt6HW7nXrCcSiL3q7xBumHoOZ1mpoQEJRT5HvwZ8BRZyizefuTw+icBUjJ5N/ONfgMsBkbo2An9y
        Cs+w0+HPetIgvIyXfRrH0TAvRiTwRVQNHjDtSH2DL2HWhBzlUPuVQ64asfMQ7Dlen8ZhvflnbTInU
        o3Mc/rSAq/7uCtG+xOzo1GBk4istloByVbV8u7A0kJ6l58LhryHUaxzUVqr+uka9yB9tJhDUubrWN
        +rIg8rE6MP/dl4B3GCYEBM5GtuPjREsYfczieYzI+tIhLz4ofAq9yVDeav1duxlstbv2pMkfavxw6
        wqaA/dCA==;
Received: from [2601:1c0:6280:3f0::7650]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l4cU3-0002A6-05; Wed, 27 Jan 2021 04:31:11 +0000
Subject: Re: [PATCH v3 25/34] misc: Add Keem Bay VPU manager
To:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        "Li, Tingqian" <tingqian.li@intel.com>, Li@linux.intel.com,
        Zhou@linux.intel.com, Luwei <luwei.zhou@intel.com>,
        Wang@linux.intel.com, jue <wang.jue@intel.com>
References: <20210126054036.61587-1-mgross@linux.intel.com>
 <20210126054036.61587-26-mgross@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <36b4770e-2dbe-6c26-57d0-803f29972c99@infradead.org>
Date:   Tue, 26 Jan 2021 20:31:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210126054036.61587-26-mgross@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/21 9:40 PM, mgross@linux.intel.com wrote:
> diff --git a/drivers/misc/vpumgr/Kconfig b/drivers/misc/vpumgr/Kconfig
> new file mode 100644
> index 000000000000..bb82ff83afd3
> --- /dev/null
> +++ b/drivers/misc/vpumgr/Kconfig
> @@ -0,0 +1,9 @@
> +config VPUMGR
> +	tristate "VPU Manager"
> +	depends on ARM64 && XLINK_CORE
> +	help
> +	  VPUMGR manages life-cycle of VPU related resources which were
> +	  dynamically allocated on demands of user-space application

End the sentence above with a period ('.').

> +
> +	  Select y or m if you have a processor including the Intel
> +	  Vision Processor (VPU) on it.


-- 
~Randy
netiquette: https://people.kernel.org/tglx/notes-about-netiquette
