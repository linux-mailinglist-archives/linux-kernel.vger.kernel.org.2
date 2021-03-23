Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B443458E6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 08:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhCWHjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 03:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhCWHjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 03:39:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B552AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 00:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RGMLJxoDesJqef8f3sGKy1sYg0YpdWsc2D6459IXq6E=; b=T6MxdMiciqJ1kYvMbnb1JL0oej
        hDNX9C84sRTiG5RNOJIKtbnd5VXkep14eFa20+4bTt/dqfxKwhgJWBJpOarOjysxfBA0kVyFnz+J7
        2h4XQ0jQh/nwKlkuLpPyUktnYPxzyulxznaIhkTCXNs/V5c3puNg7ynAJf0lpuT6VnDEaMGmBbGHA
        wmee0lr5mjyYi9rAJwQcEaR1TMJmQs8rJyBS3hCurhCucHBkj+kviBNmIQfL/VfS7Tr/3R32kClsi
        ODNU6q+IgWvcv57oPGTZOxsDUliRlsDGJGcaFqHh7rdYpcC5roF9JxytI9F31Rxli1B1cneJF8ioY
        zP4Qc+Uw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lObd7-00EB56-Qq; Tue, 23 Mar 2021 07:39:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3446B30477A;
        Tue, 23 Mar 2021 08:39:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2652123601885; Tue, 23 Mar 2021 08:39:08 +0100 (CET)
Date:   Tue, 23 Mar 2021 08:39:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: shut up -Wcast-function-type warning for
 ftrace_ops_no_ops
Message-ID: <YFmbHI4hnKg5UH2M@hirez.programming.kicks-ass.net>
References: <20210322215006.1028517-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322215006.1028517-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 10:49:58PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> With 'make W=1', gcc warns about casts between incompatible function
> types:
> 
> kernel/trace/ftrace.c:128:31: error: cast between incompatible function types from 'void (*)(long unsigned int,  long unsigned int)' to 'void (*)(long unsigned int,  long unsigned int,  struct ftrace_ops *, struct ftrace_regs *)' [-Werror=cast-function-type]
>   128 | #define ftrace_ops_list_func ((ftrace_func_t)ftrace_ops_no_ops)
>       |                               ^
> 
> As the commet here explains, this one was intentional, so shut up the
> warning harder by using a double cast.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  kernel/trace/ftrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 4d8e35575549..d8fc87a17421 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -125,7 +125,7 @@ static void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
>  #else
>  /* See comment below, where ftrace_ops_list_func is defined */
>  static void ftrace_ops_no_ops(unsigned long ip, unsigned long parent_ip);
> -#define ftrace_ops_list_func ((ftrace_func_t)ftrace_ops_no_ops)
> +#define ftrace_ops_list_func ((ftrace_func_t)(void *)ftrace_ops_no_ops)

So now we're making perfectly fine code worse, because GCC is stupid?

Please just kill the warning, like we do with so many other warnings.
It's broken!
