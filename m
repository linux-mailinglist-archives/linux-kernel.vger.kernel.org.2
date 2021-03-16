Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499AB33CEB8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 08:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhCPHfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 03:35:05 -0400
Received: from mga07.intel.com ([134.134.136.100]:47310 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232838AbhCPHem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 03:34:42 -0400
IronPort-SDR: E0XN4LYqtuDBwSIO0JkEc2q35r6a8aU4naiXSGtEL3DDBNF81w8vvUKM3W68c1BRXl4igLZG+R
 YAOkZeijVZow==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="253231572"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="253231572"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 00:34:41 -0700
IronPort-SDR: XgammK7Fid0KhXiSmkIOAU9ivrhMv/zxVVO9Dy+2AhAo0jvnUfRGUmh11+ffgQTpvTyI6Oh9Mp
 9EGNMwmg7L2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="605158781"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by fmsmga005.fm.intel.com with ESMTP; 16 Mar 2021 00:34:40 -0700
Date:   Tue, 16 Mar 2021 15:34:39 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] tools/x86/kcpuid: Check last token too
Message-ID: <20210316073439.GB49151@shbuild999.sh.intel.com>
References: <20210315125901.30315-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315125901.30315-1-bp@alien8.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 01:59:00PM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Input lines like
> 
>   0x8000001E,     0, EAX,   31:0, Extended APIC ID
> 
> where the short name is missing lead to a segfault because the loop
> takes the long name for the short name and tokens[5] becomes NULL which
> explodes later in strcpy().
> 
> Check its value too before further processing.
 
Thanks for the fix!

Acked-by: Feng Tang <feng.tang@intel.com>

> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  tools/arch/x86/kcpuid/kcpuid.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
> index 6048da34fcc6..dae75511fef7 100644
> --- a/tools/arch/x86/kcpuid/kcpuid.c
> +++ b/tools/arch/x86/kcpuid/kcpuid.c
> @@ -324,6 +324,8 @@ static int parse_line(char *line)
>  		str = NULL;
>  	}
>  	tokens[5] = strtok(str, "\n");
> +	if (!tokens[5])
> +		goto err_exit;
>  
>  	/* index/main-leaf */
>  	index = strtoull(tokens[0], NULL, 0);
> -- 
> 2.29.2
