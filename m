Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7048633914E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbhCLPbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:31:08 -0500
Received: from mga18.intel.com ([134.134.136.126]:48054 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232296AbhCLPaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:30:52 -0500
IronPort-SDR: 9gFnzml09DRhBU7q5eQxdO3vkmg4C6ivyqGmzmfhVbCt5oAc9q+JWH635J7U0mtocmO22xDorW
 X+a0+NvoLU3A==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="176436690"
X-IronPort-AV: E=Sophos;i="5.81,243,1610438400"; 
   d="scan'208";a="176436690"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 07:30:51 -0800
IronPort-SDR: /MOo4RgUkeskOo5LyvcFj8gURJEvIBko0VV7mgZ8vW4D1omMtxOAPIyuB6BKo3FFBJ0zybdTpu
 xjQc5LFKsWoQ==
X-IronPort-AV: E=Sophos;i="5.81,243,1610438400"; 
   d="scan'208";a="387373804"
Received: from rjones-mobl2.amr.corp.intel.com ([10.209.23.193])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 07:30:50 -0800
Message-ID: <4609846ceedc24505dcaaba40933abb8b3e577e1.camel@linux.intel.com>
Subject: Re: [PATCH] tools/power/x86/intel-speed-select: drop __DATE__ and
 __TIME__ macros
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Antonio Terceiro <antonio.terceiro@linaro.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 12 Mar 2021 07:30:48 -0800
In-Reply-To: <20210312135746.1695294-1-antonio.terceiro@linaro.org>
References: <20210312135746.1695294-1-antonio.terceiro@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-03-12 at 10:57 -0300, Antonio Terceiro wrote:
> These macros introduce nondeterminism in builds, and break
> reproducible
> builds.

Thanks. I will include this change in my pull request.

-Srinivas

> 
> Signed-off-by: Antonio Terceiro <antonio.terceiro@linaro.org>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  tools/power/x86/intel-speed-select/isst-config.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/power/x86/intel-speed-select/isst-config.c
> b/tools/power/x86/intel-speed-select/isst-config.c
> index 582feb88eca3..c50c754a656e 100644
> --- a/tools/power/x86/intel-speed-select/isst-config.c
> +++ b/tools/power/x86/intel-speed-select/isst-config.c
> @@ -2791,7 +2791,6 @@ static void usage(void)
>  static void print_version(void)
>  {
>  	fprintf(outf, "Version %s\n", version_str);
> -	fprintf(outf, "Build date %s time %s\n", __DATE__, __TIME__);
>  	exit(0);
>  }
>  

