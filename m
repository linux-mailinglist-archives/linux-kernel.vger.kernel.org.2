Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB86331B1AE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 18:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhBNRxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 12:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhBNRxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 12:53:42 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69443C061574;
        Sun, 14 Feb 2021 09:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=iGqt0nHjobZmEO9n22ezQT55DO4AzImZXB6TGp/92FE=; b=dVS7Feb0WaCsjIK9/87IHsZ4KW
        C5OORW2Hioh8jltQGg+Od/5BTv1tqVagn8XTa9guljVuDYGYhs65oA8kUpVXGK77cZ77Q1HhXzMUJ
        fs32NTm8NDiniInNYQb6mf6KocG5Z5YjVSs6EeqbYYqKdy93BaDLEujsvuqlTra9uIjeDCun+AtlX
        fW9Mobn4c6HT/haW2YRlyeRttW99R3ZfG/vgtC/Ygh5dYnMhw3dDIK2sGPQqe5gbSbpWBhEcehRlX
        Q7g5tjDrh/r/vr65t25N4Amy38sHxpPVXAz11Izvjnxtx63cGjSysXDZ1fxvNphNKGwdmroT+czl9
        WV/8P7ZQ==;
Received: from [2601:1c0:6280:3f0::6444]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lBLZq-0005mH-D3; Sun, 14 Feb 2021 17:52:58 +0000
Subject: Re: [PATCH v6 20/34] xlink-core: Add xlink core driver xLink
To:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Seamus Kelly <seamus.kelly@intel.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        linux-doc@vger.kernel.org
References: <20210212222304.110194-1-mgross@linux.intel.com>
 <20210212222304.110194-21-mgross@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ddacd2e2-b491-5443-4006-c8c5d90d583f@infradead.org>
Date:   Sun, 14 Feb 2021 09:52:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210212222304.110194-21-mgross@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/21 2:22 PM, mgross@linux.intel.com wrote:
> diff --git a/drivers/misc/xlink-core/Kconfig b/drivers/misc/xlink-core/Kconfig
> new file mode 100644
> index 000000000000..a0ceb0b48219
> --- /dev/null
> +++ b/drivers/misc/xlink-core/Kconfig
> @@ -0,0 +1,33 @@
> +config XLINK_CORE
> +	tristate "Support for XLINK CORE"
> +	depends on ((XLINK_PCIE_RH_DRIVER || XBAY_XLINK_PCIE_RH_DRIVER) || (XLINK_LOCAL_HOST && (XLINK_PCIE_LH_DRIVER || XBAY_XLINK_PCIE_RH_DRIVER)))

-ELINETOOLONG. Use '\' for line continuation in Kconfig files.

> +	help
> +	  XLINK CORE enables the communication/control subsystem.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called xlink.ko.
> +
> +config XLINK_LOCAL_HOST
> +	tristate "Support for XLINK LOCAL HOST"
> +	depends on XLINK_IPC
> +	help
> +	  XLINK LOCAL HOST enables local host functionality for
> +	  the communication/control Sub-System.
> +
> +	  Enable this config when building the kernel for the Intel Vision
> +	  Processing Unit (VPU) Local Host core.
> +
> +	  If building for a Remote Host kernel, say N.
> +
> +config XLINK_PSS
> +	tristate "Support for XLINK PSS (Pre-Silicon Solution)"
> +	depends on XLINK_LOCAL_HOST
> +	help
> +	  XLINK PSS enables the communication/control subsystem on a PSS platform.
> +
> +	  Enable this config when building the kernel for the Intel Vision
> +	  Processing Unit (VPU) in a simulated env.

Please s/env/environment/.

> +
> +	  If building for a VPU silicon, say N.


-- 
~Randy

