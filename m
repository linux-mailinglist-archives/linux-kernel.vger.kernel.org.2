Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E31A31B197
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 18:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhBNRkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 12:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhBNRku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 12:40:50 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC04C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 09:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=kKPziAPtrcIG/eP7kvwMAQ1K0Wh3oRboDlPxiXguht0=; b=iPjaljoD6/0kY2r3KQOVOmIgG7
        vR5+QGqPozKGC5bQJBymH0lORW7i1NN2GNhNWnlVCntU9PnGtzsagN2/kIzQJTHMojA/J2KGkXFr3
        ZcL3bEo5MiCq626eKBHF3g8plDfWIYZ647iekE1zUzBdFqdQoNzvCLq8cYYEsGJ+lDxOuz2DO97Pd
        GuJksaHhPoqny/Ang2QlM2zy/j6DLffFCsZPMDksT/d/GB7stV5gKFiURVa4w8YZc4GDG4veRRN5z
        CedcPI3uSQgNgHnGs71cVYLCHPTXT6kKTQ4iNa8m47kyN3lpXxCQKr3K+W0Wn/x30I1ZNZj5PzWI0
        LiolSZaw==;
Received: from [2601:1c0:6280:3f0::6444]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lBLNL-00056L-Da; Sun, 14 Feb 2021 17:40:03 +0000
Subject: Re: [PATCH v6 25/34] misc: Add Keem Bay VPU manager
To:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        "Li, Tingqian" <tingqian.li@intel.com>,
        Zhou Luwei <luwei.zhou@intel.com>,
        Wang jue <wang.jue@intel.com>
References: <20210212222304.110194-1-mgross@linux.intel.com>
 <20210212222304.110194-26-mgross@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <569d29f2-d976-4a5d-271e-f762d59bce70@infradead.org>
Date:   Sun, 14 Feb 2021 09:39:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210212222304.110194-26-mgross@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/21 2:22 PM, mgross@linux.intel.com wrote:
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

