Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28E145D7D4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 10:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354306AbhKYKBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 05:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348831AbhKYJ7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 04:59:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B6EC06173E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 01:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KLWFnk0otCdqEOWU+eLU0sB6ratNVPpsd91fvyLQz3c=; b=U40aP3Xv8RSfJ9yRTsn/GtJmvI
        vGFahelStsw0Dvvae7Hd0e5INJS5Wc9kJbFFhMj8KsSwgGUP2HP8YJiKpZYYSMFbbH+chSWeeAGb+
        aQD5o6HTNSBv3426N+nPRiU+GRXGQ2zRiXt0oSYBapGJFxhGhWwd+dKqYXm6Ne7+2k8cNH07czxQH
        PtJy9kYRfiBqDOZ72XVny8JNYcOf47Stj9oxRdDCvhJVvn7qGkKUvgTphXVUsdem9XAt95EiYsP1q
        7mWUndfVXoQoHU96b0Xn7fN+fW306jixWNrQ8Gi5kBH3c+SdTrfgwWXhbZ5lnyYL3UBxiMWTnGE0E
        Or8ZWzrA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mqBTu-005njT-96; Thu, 25 Nov 2021 09:55:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9FE15300093;
        Thu, 25 Nov 2021 10:55:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8AD2D2027B00C; Thu, 25 Nov 2021 10:55:54 +0100 (CET)
Date:   Thu, 25 Nov 2021 10:55:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tang Yizhou <tangyizhou@huawei.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org
Subject: Re: [PATCH 2/2] sched/pelt: Change the type of parameter running to
 bool
Message-ID: <YZ9dqgjSkA/Uv+7D@hirez.programming.kicks-ass.net>
References: <20211125030019.10447-1-tangyizhou@huawei.com>
 <20211125030019.10447-3-tangyizhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125030019.10447-3-tangyizhou@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 11:00:19AM +0800, Tang Yizhou wrote:
> Parameter 'running' in function ___update_load_sum() and
> accumulate_sum() describes whether an se is running or not, so change
> the type of it to bool to make the code more readable.
> 
> Signed-off-by: Tang Yizhou <tangyizhou@huawei.com>
> ---
>  kernel/sched/pelt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> index 3584df2a0b8e..2010b3bd6e49 100644
> --- a/kernel/sched/pelt.c
> +++ b/kernel/sched/pelt.c
> @@ -104,7 +104,7 @@ static u32 __accumulate_pelt_segments(u64 periods, u32 d1, u32 d3)
>   */
>  static __always_inline u32
>  accumulate_sum(u64 delta, struct sched_avg *sa,
> -	       unsigned long load, unsigned long runnable, int running)
> +	       unsigned long load, unsigned long runnable, bool running)
>  {
>  	u32 contrib = (u32)delta; /* p == 0 -> delta < 1024 */
>  	u64 periods;
> @@ -182,7 +182,7 @@ accumulate_sum(u64 delta, struct sched_avg *sa,
>   */
>  static __always_inline int
>  ___update_load_sum(u64 now, struct sched_avg *sa,
> -		  unsigned long load, unsigned long runnable, int running)
> +		  unsigned long load, unsigned long runnable, bool running)
>  {
>  	u64 delta;

And this function has:

	runnable = running = 0;

and then people complain about assigning 0 to _Bool, and then we get
idiocy like:

	runnable = running = false;

Please...
