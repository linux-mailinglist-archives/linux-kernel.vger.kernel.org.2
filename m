Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A13305C2F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 13:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343624AbhA0MzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 07:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238087AbhA0Mwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 07:52:47 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191AFC0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 04:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mtZDQkTPXEcPqbCtS8sQg4qaWBseS8L4LfI1WUkPzDM=; b=b7/25XWblfwizAzTTb+sAOOpDs
        9IWQ/fbUOGYlAjM0+xhCNrPRzPRs/DRp71RqeFo7cmJsHur2taVXlNsHKTgn+vdkC8fFnA9216YIi
        JuwY2P7At8AYYY0PjB7ALiohlhOq5G8Te2xFYS83boIWy7jIx6gS29/tHamvcsio7L2oiAAbocgCb
        KWe/3oohn5Mx+xynqKO+t/20tjZ1WJOPMvDQwzJr1GjV254KlSaMoMdx09OFG+gRmqLnePAaSWk1m
        1yBf4ypReolsEi39mKPYLwYIfmQ/rNprnTDpubeCW75fdUGWbQOzXEnQ3egG6SEsHVHg5OnFrZnhO
        M4JUUeSQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l4kIb-0002ax-Tw; Wed, 27 Jan 2021 12:51:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2ABAF3010C8;
        Wed, 27 Jan 2021 13:51:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EAEDD2C539FEC; Wed, 27 Jan 2021 13:51:47 +0100 (CET)
Date:   Wed, 27 Jan 2021 13:51:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org, lcherian@marvell.com,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        mingo@redhat.com, will@kernel.org, mark.rutland@arm.com,
        acme@kernel.org, jolsa@redhat.com,
        Mathieu Poirier <mathieu.poirer@linaro.org>
Subject: Re: [PATCH V3 13/14] perf: aux: Add flags for the buffer format
Message-ID: <YBFh46OMgFW7FW2I@hirez.programming.kicks-ass.net>
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-14-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611737738-1493-14-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 02:25:37PM +0530, Anshuman Khandual wrote:
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> Allocate a byte for advertising the PMU specific format type
> of the given AUX record. A PMU could end up providing hardware
> trace data in multiple format in a single session.
> 
> e.g, The format of hardware buffer produced by CoreSight ETM
> PMU depends on the type of the "sink" device used for collection
> for an event (Traditional TMC-ETR/Bs with formatting or
> TRBEs without any formatting).

Acked-by: Peter Ziljstra <peterz@infradead.org>

> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  include/uapi/linux/perf_event.h | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index b15e344..9a5ca45 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -1105,10 +1105,11 @@ enum perf_callchain_context {
>  /**
>   * PERF_RECORD_AUX::flags bits
>   */
> -#define PERF_AUX_FLAG_TRUNCATED		0x01	/* record was truncated to fit */
> -#define PERF_AUX_FLAG_OVERWRITE		0x02	/* snapshot from overwrite mode */
> -#define PERF_AUX_FLAG_PARTIAL		0x04	/* record contains gaps */
> -#define PERF_AUX_FLAG_COLLISION		0x08	/* sample collided with another */
> +#define PERF_AUX_FLAG_TRUNCATED			0x01	/* record was truncated to fit */
> +#define PERF_AUX_FLAG_OVERWRITE			0x02	/* snapshot from overwrite mode */
> +#define PERF_AUX_FLAG_PARTIAL			0x04	/* record contains gaps */
> +#define PERF_AUX_FLAG_COLLISION			0x08	/* sample collided with another */
> +#define PERF_AUX_FLAG_PMU_FORMAT_TYPE_MASK	0xff00	/* PMU specific trace format type */
>  
>  #define PERF_FLAG_FD_NO_GROUP		(1UL << 0)
>  #define PERF_FLAG_FD_OUTPUT		(1UL << 1)
> -- 
> 2.7.4
> 
