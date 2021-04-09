Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E716035A251
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 17:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbhDIPwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 11:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbhDIPwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 11:52:24 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE17C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 08:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KRifnXSl4b8Fwo8PrSOvt4Qdm+NxRg+4mE/wKXN8m2s=; b=LyrZC9UJlydTi3K20hq3lVUXCj
        qIIEhCwJsqLscxx8bob6UIzJlzekhdQdmv1DLriCNLyeumJ56f8jmPJhvuN+HHhV+gitB/Sz/sBAV
        iyL9Ajy+/3pIdqaWbLy2quxlUgCLPOy1zI+Qq2eJTKNqFp8kf5NA1kE+npdfcpF0XiJMEiNDaPlcq
        LSNLIuYV0VnKR/XvRTy3GLgkiIs0QuvasSonMC2QNdNjhnhiCHCybP10vkc8mJO3+rCXW+IQTBRUi
        31gxC9HHLWRgsrcGrfuIhbiLusZdwYypD4CzA+5nrb2C7dKnsoKbWFnJIYoIvXAWYQOC2LsyzF+M0
        CfhQjVTw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lUtQL-0012t5-De; Fri, 09 Apr 2021 15:51:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 877D330001B;
        Fri,  9 Apr 2021 17:51:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 711B82BE951AE; Fri,  9 Apr 2021 17:51:56 +0200 (CEST)
Date:   Fri, 9 Apr 2021 17:51:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        ricardo.neri-calderon@linux.intel.com,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH V5 21/25] perf: Introduce PERF_TYPE_HARDWARE_PMU and
 PERF_TYPE_HW_CACHE_PMU
Message-ID: <YHB4HO1ttYYzqtes@hirez.programming.kicks-ass.net>
References: <1617635467-181510-1-git-send-email-kan.liang@linux.intel.com>
 <1617635467-181510-22-git-send-email-kan.liang@linux.intel.com>
 <YHActB+bkgBesWM3@hirez.programming.kicks-ass.net>
 <11ed193e-75f9-c060-b757-350612b694aa@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11ed193e-75f9-c060-b757-350612b694aa@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 11:24:07AM -0400, Liang, Kan wrote:

> diff --git a/include/uapi/linux/perf_event.h
> b/include/uapi/linux/perf_event.h
> index ad15e40..7ec80ac9 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -38,6 +38,20 @@ enum perf_type_id {
>  };
> 
>  /*
> + * attr.config layout for type PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE
> + * PERF_TYPE_HARDWARE:			0xEE000000AA
> + *					AA: hardware event ID
> + *					EE: PMU type ID
> + * PERF_TYPE_HW_CACHE:			0xEE00DDCCBB
> + *					BB: hardware cache ID
> + *					CC: hardware cache op ID
> + *					DD: hardware cache op result ID
> + *					EE: PMU type ID

it's: 0xEEEEEEEE00DDCCBB and 0xEEEEEEEE000000AA


