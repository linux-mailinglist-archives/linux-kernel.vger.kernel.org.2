Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031AC30DED4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbhBCPzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:55:55 -0500
Received: from mga02.intel.com ([134.134.136.20]:53044 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234575AbhBCPyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:54:24 -0500
IronPort-SDR: BcO5KtNdIbQe5D+Ku95ldqJKw43IMIsB0/HWBuXi+mmxOIs3RCcJg2g7cRFWMKIWphqNoeP+6H
 /Bk/3cRl3T+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="168170037"
X-IronPort-AV: E=Sophos;i="5.79,398,1602572400"; 
   d="scan'208";a="168170037"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 07:52:31 -0800
IronPort-SDR: a6h1h6X5m2mN8ZUFzd41FQWCTPnkWDehuhD83kz4sJXUicJA1jRUK+pTuvYwq2xCVbIQoo4x7N
 g46SpazgSH6g==
X-IronPort-AV: E=Sophos;i="5.79,398,1602572400"; 
   d="scan'208";a="359482643"
Received: from jianhu-mobl1.amr.corp.intel.com ([10.209.102.21])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 07:52:31 -0800
Message-ID: <09687ef7f4cc072946486742555acc74938f1129.camel@linux.intel.com>
Subject: Re: [PATCH] platform/x86/intel-uncore-freq: Add Sapphire Rapids
 server support
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 03 Feb 2021 07:52:30 -0800
In-Reply-To: <20210203114320.1398801-1-dedekind1@gmail.com>
References: <20210203114320.1398801-1-dedekind1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-02-03 at 13:43 +0200, Artem Bityutskiy wrote:
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> 
> Sapphire Rapids uncore frequency control is the same as Skylake and
> Ice Lake.
> Add the Sapphire Rapids CPU model number to the match array.
> 
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  drivers/platform/x86/intel-uncore-frequency.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/intel-uncore-frequency.c
> b/drivers/platform/x86/intel-uncore-frequency.c
> index 12d5ab7e1f5d..3ee4c5c8a64f 100644
> --- a/drivers/platform/x86/intel-uncore-frequency.c
> +++ b/drivers/platform/x86/intel-uncore-frequency.c
> @@ -377,6 +377,7 @@ static const struct x86_cpu_id
> intel_uncore_cpu_ids[] = {
>  	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,	NULL),
>  	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,	NULL),
>  	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,	NULL),
> +	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, NULL),
>  	{}
>  };
>  

