Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38168305C46
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 13:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237968AbhA0M6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 07:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343648AbhA0MzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 07:55:12 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174A0C061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 04:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=glR96rtD4S81qykzjqvdJG+KBx1k80zyus3xbQPfBQA=; b=afNW9BfEEPP2Sxy2fbrTdw6jSG
        pNTR82CFaMY63irClkWS9SBXxk+MfYwpO0inRaypPa4FFUyHRdmIbQKco0X8uwyzJDZpTWY325UnT
        8MeeDskNfan1FrBwwLnkSJkwHZTPL1R2IqJhqHw40CbwiWeP66ktxDYvCmOMET4rmEHANQz4991XP
        WsA9apoTdA0to4h77KfPNZc6WxieSLn8K6czJV0dBFYQlmCZsJ4CPnMZrXT+GKI5UizKiK1cN8qPQ
        RNwO9jMW22MAtQGUmT35MMMkVQJIQLueCq2OOwW4HfoAcjdSG/8dNeicdO3VkAUpbUjJPJBRqshhw
        wJGZbQSQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l4kKw-00038y-H6; Wed, 27 Jan 2021 12:54:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3B590300455;
        Wed, 27 Jan 2021 13:54:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 256C92C539FEC; Wed, 27 Jan 2021 13:54:17 +0100 (CET)
Date:   Wed, 27 Jan 2021 13:54:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org, lcherian@marvell.com,
        linux-kernel@vger.kernel.org, Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH V3 14/14] coresight: etm-perf: Add support for trace
 buffer format
Message-ID: <YBFiecTmjA30qRaW@hirez.programming.kicks-ass.net>
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-15-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611737738-1493-15-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 02:25:38PM +0530, Anshuman Khandual wrote:

> It is possible to have a
> perf session where some events end up collecting the trace
> in TMC-ETR while the others in TRBE. Thus we need a way
> to identify the type of the trace for each AUX record.

> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 9a5ca45..169e6b3 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -1111,6 +1111,10 @@ enum perf_callchain_context {
>  #define PERF_AUX_FLAG_COLLISION			0x08	/* sample collided with another */
>  #define PERF_AUX_FLAG_PMU_FORMAT_TYPE_MASK	0xff00	/* PMU specific trace format type */
>  
> +/* CoreSight PMU AUX buffer formats */
> +#define PERF_AUX_FLAG_CORESIGHT_FORMAT_CORESIGHT	0x0000 /* Default for backward compatibility */
> +#define PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW		0x0100 /* Raw format of the source */

Would CORESIGHT_FORMAT_ETR / CORESIGHT_FORMAT_TRBE be better names?
