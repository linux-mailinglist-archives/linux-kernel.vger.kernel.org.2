Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6ABD30A033
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 03:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhBACGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 21:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbhBACF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 21:05:57 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C80C061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 18:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=eoooCpZwTVXeeTRxKiCG/eePOrWkIW+ctS2RKBSU07A=; b=jV4904rYZUSlJUGhiR1hx7ZwyD
        WHCKL+gIdgCnq+Ohjm56fu0t4QWfl6QUyzxb7O2hXK9/Bw4tqVjhzByk5XTQkBO/TZByRDi9ZrcZO
        aI8XfqvJNv6z5hWeMsVvrTAwio/TgC3bUvjyd2LdKYz6JuHNj/RkiKr8Y9Hx+Vh3fT7K/0r4Dw6wU
        e1dXX7SghsfLqxslsBEW+EZQqi21TIz+s9eDqGX63A3uM6bUVsYvnX/uIJisgvZ2uoKbsazvE2rlJ
        Td6G572YPddMfcPocCbDJyKNHbTXfjcq323ksRhPOKteueitj5F/oQFGCTn+/9NUmbLhvlJnYbRtY
        4NBMT7aw==;
Received: from [2601:1c0:6280:3f0::9abc]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l6OaP-0005KE-Qm; Mon, 01 Feb 2021 02:05:06 +0000
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
References: <20210130022124.65083-1-mgross@linux.intel.com>
 <20210130022124.65083-26-mgross@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8781412f-ede1-e740-67d8-994e41ff02e2@infradead.org>
Date:   Sun, 31 Jan 2021 18:04:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210130022124.65083-26-mgross@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/21 6:20 PM, mgross@linux.intel.com wrote:
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

End above sentence with a period ('.').

Hm, same as I said the previous round of patches (also v3).

> +
> +	  Select y or m if you have a processor including the Intel
> +	  Vision Processor (VPU) on it.


-- 
~Randy

