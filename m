Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E187325F4B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 09:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhBZImL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 03:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhBZIl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 03:41:59 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FA9C061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 00:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6jDXhPxVkvhfSi52+DhefKMrrODHFkTHURgX/igrPZY=; b=s17MDbIOOdIsN0G/yTl1wm3Thc
        j/QGVcBBo9VUIWv/YUjGb4I/L7RpoVgy6WPVGMBtgceKk4QXEGOmlQ2PpdC5cQ+46WSCL5OSlVWaK
        Tx3CsgzQHXnBRHV6QKHBQCpyzmb7+gV2oRsXc2dbvmAJTCRa7CYFntVd2ePUq13wghkmFyRvmWXy9
        skvMMMul1i5ie+UanuapHxyq8Q9ZFlcUX9AS9ZPbyZpQkliuPwtxo7gWGE002Bpnl6R1qwoVqA0Jp
        p+AUCvIqP3WA6TSfJ/3p0CRarpl4El2IbV7tuQdw0Dlg8kbR276POtSC2gCT6mZ8HfvmyhxTUwh9G
        e53Wj2HQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lFYgR-0007pP-7H; Fri, 26 Feb 2021 08:41:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8E3F23006D0;
        Fri, 26 Feb 2021 09:41:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6DD682D985669; Fri, 26 Feb 2021 09:41:06 +0100 (CET)
Date:   Fri, 26 Feb 2021 09:41:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     mingo@readhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com
Subject: Re: [PATCH v2] sched/pelt: Fix task util_est update filtering
Message-ID: <YDi0Ip11fpOubQqz@hirez.programming.kicks-ass.net>
References: <20210225165820.1377125-1-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225165820.1377125-1-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 04:58:20PM +0000, Vincent Donnefort wrote:
> +#define UTIL_EST_MARGIN (SCHED_CAPACITY_SCALE / 100)
> +
>  /*
> - * Check if a (signed) value is within a specified (unsigned) margin,
> + * Check if a (signed) value is within the (unsigned) util_est margin,
>   * based on the observation that:
>   *
>   *     abs(x) < y := (unsigned)(x + y - 1) < (2 * y - 1)
>   *
> - * NOTE: this only works when value + maring < INT_MAX.
> + * NOTE: this only works when value + UTIL_EST_MARGIN < INT_MAX.
>   */
> -static inline bool within_margin(int value, int margin)
> +static inline bool util_est_within_margin(int value)
>  {
> -	return ((unsigned int)(value + margin - 1) < (2 * margin - 1));
> +	return ((unsigned int)(value + UTIL_EST_MARGIN - 1) <
> +		(2 * UTIL_EST_MARGIN - 1));
>  }

> -	if (within_margin(last_ewma_diff, (SCHED_CAPACITY_SCALE / 100)))
> +	if (util_est_within_margin(last_ewma_diff)) {

What was the purpose of this change? What was a generic helper is now
super specific.
