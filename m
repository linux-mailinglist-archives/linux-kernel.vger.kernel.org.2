Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC4736EF9F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 20:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241002AbhD2Srk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 14:47:40 -0400
Received: from mga14.intel.com ([192.55.52.115]:56820 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233565AbhD2Srj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 14:47:39 -0400
IronPort-SDR: 4K8whC8pH4pZnsglkeESp/n21+Yb9sWonmFXXi66Z9QmtaPBAfKw5UH5oKdabtpj9hgkRIEqiE
 5eePx1rpReCQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="196646490"
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="196646490"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 11:46:53 -0700
IronPort-SDR: 2vVxhEbejwAlySUKZBbM/Mwld9KINWOVFUSrNWwGKtQIUrWfcS8mDGQRHjWmSNl5iXS4+I+qUa
 rJQ25GfKt92g==
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="394010862"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 11:46:52 -0700
Date:   Thu, 29 Apr 2021 11:46:51 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/12] perf inject: Add --vm-time-correlation option
Message-ID: <20210429184651.GD4032392@tassilo.jf.intel.com>
References: <20210429125854.13905-1-adrian.hunter@intel.com>
 <20210429125854.13905-6-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429125854.13905-6-adrian.hunter@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 03:58:47PM +0300, Adrian Hunter wrote:
>  		evsel->handler = drop_sample;
>  }
>  
> +static int parse_vm_time_correlation(const struct option *opt, const char *str, int unset)
> +{
> +	struct perf_inject *inject = opt->value;
> +	const char *args;
> +	char *dry_run;
> +
> +	if (unset)
> +		return 0;
> +
> +	inject->itrace_synth_opts.set = true;
> +	inject->itrace_synth_opts.vm_time_correlation = true;
> +	inject->in_place_update = true;
> +
> +	if (!str)
> +		return 0;
> +
> +	dry_run = strstr(str, "dry-run");

Please use a proper split, otherwise it cannot be extended.

Right now just !strcmp is enough I guess

> 
