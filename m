Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2333AB0F7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 12:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhFQKLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 06:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhFQKL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 06:11:28 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E306C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 03:09:20 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id c9so6094695wrt.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 03:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=85427KYEYrrxwKEdUbPTushEwCA9Yj+mHAXG+be0wiQ=;
        b=ttYfq9i1x7QIrjWzVzFNF0/Yga/Dz40ydsjJEj7uh+PXkMrnUJ2hsdHlomTa6ESs76
         r5zfisWrMys099EXuEPMVK+u1L1+X5n2KNDi95fCUeId8585XBWfYmDhhXGNf6+eIVFF
         roAW5awVpHV4M/3kPttlNbeE1lpFW7P1e+8KWAKTUlnowl/KKyF8ozr0de38aXeUR3p+
         Ejg9E3i+kWn7nPnEPbOb0D7EJq+/NkMe7LY/zK7X+wK+ow4yT5KohD6RkKmc25l/MEiW
         3kbCASbl2CfsT+ldYu2eGdR/MNLH6GumtSF23MqAutzAJHveVt11yFZkfCYDME2XFnH7
         YP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=85427KYEYrrxwKEdUbPTushEwCA9Yj+mHAXG+be0wiQ=;
        b=N/MaYjvuyDE4fTAlmm5Lgv27wg9EOotol5xrWah03rlh0XlJpg2xxUHBTpJFsNcQr/
         uOMqB26yDA8Nxv/0VzoIqiHY2DmDxL/jOrClZK1U2lSaZ+PFv7Ac//HrdHMzE1aXS8Kh
         RbW090KihC1+T3JykmaFnjIrwyuO/py93qyG6Yl1TD7dAU4CbQpIzS2GJOkpwRG09PvB
         DlCPIvBbI9Dykb7OixxnQnz5zWfisbS3BlMVfJP5twg4EM3OCWmzBuwGCeCJ7lPWfJz7
         UdEKt6Sgxid8gC2NMOeYa27VmbXtO8fIQVmjPWZHAYNih13szy+zp8OiMPExVATO5/Up
         x/KQ==
X-Gm-Message-State: AOAM533KY3qOuu7tKUnnPqd9/gQM+OzK3HbpFEklL1MEOdpBEOWlQwtC
        I9B1vYTpOEXgMawllbzoQrx9fA==
X-Google-Smtp-Source: ABdhPJyMRnQGkJqXInfJRRkjjvjeyqgSs/jdM6jdSZaC5UXJ6ejRI+yr8yC8Hw65Qu43dQuGuEf4dw==
X-Received: by 2002:a5d:6d8b:: with SMTP id l11mr4647383wrs.21.1623924558847;
        Thu, 17 Jun 2021 03:09:18 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id h18sm4993756wrs.64.2021.06.17.03.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:09:18 -0700 (PDT)
Date:   Thu, 17 Jun 2021 11:09:16 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Eric Biederman <ebiederm@xmission.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Oleg Nesterov <oleg@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        kgdb-bugreport <kgdb-bugreport@lists.sourceforge.net>,
        kexec <kexec@lists.infradead.org>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] kgdb: Fix spelling mistakes
Message-ID: <20210617100916.ynovtwbtsq7eaabw@maple.lan>
References: <20210529110305.9446-1-thunder.leizhen@huawei.com>
 <20210529110305.9446-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210529110305.9446-3-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2021 at 07:03:03PM +0800, Zhen Lei wrote:
> Fix some spelling mistakes in comments:
> initalization ==> initialization
> detatch ==> detach
> represntation ==> representation
> hexidecimal ==> hexadecimal
> delimeter ==> delimiter
> architecure ==> architecture
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Applied, thanks.


> ---
>  include/linux/kgdb.h           | 8 ++++----
>  kernel/debug/debug_core.c      | 2 +-
>  kernel/debug/kdb/kdb_main.c    | 8 ++++----
>  kernel/debug/kdb/kdb_private.h | 2 +-
>  4 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> index 392a3670944c..258cdde8d356 100644
> --- a/include/linux/kgdb.h
> +++ b/include/linux/kgdb.h
> @@ -105,9 +105,9 @@ extern int dbg_set_reg(int regno, void *mem, struct pt_regs *regs);
>   */
>  
>  /**
> - *	kgdb_arch_init - Perform any architecture specific initalization.
> + *	kgdb_arch_init - Perform any architecture specific initialization.
>   *
> - *	This function will handle the initalization of any architecture
> + *	This function will handle the initialization of any architecture
>   *	specific callbacks.
>   */
>  extern int kgdb_arch_init(void);
> @@ -229,9 +229,9 @@ extern int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt);
>  extern int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt);
>  
>  /**
> - *	kgdb_arch_late - Perform any architecture specific initalization.
> + *	kgdb_arch_late - Perform any architecture specific initialization.
>   *
> - *	This function will handle the late initalization of any
> + *	This function will handle the late initialization of any
>   *	architecture specific callbacks.  This is an optional function for
>   *	handling things like late initialization of hw breakpoints.  The
>   *	default implementation does nothing.
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index 4708aec492df..a1f26766eb90 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -1032,7 +1032,7 @@ dbg_notify_reboot(struct notifier_block *this, unsigned long code, void *x)
>  	/*
>  	 * Take the following action on reboot notify depending on value:
>  	 *    1 == Enter debugger
> -	 *    0 == [the default] detatch debug client
> +	 *    0 == [the default] detach debug client
>  	 *   -1 == Do nothing... and use this until the board resets
>  	 */
>  	switch (kgdbreboot) {
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index 622410c45da1..d8ee5647b732 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -253,7 +253,7 @@ static char *kdballocenv(size_t bytes)
>   * Parameters:
>   *	match	A character string representing a numeric value
>   * Outputs:
> - *	*value  the unsigned long represntation of the env variable 'match'
> + *	*value  the unsigned long representation of the env variable 'match'
>   * Returns:
>   *	Zero on success, a kdb diagnostic on failure.
>   */
> @@ -356,7 +356,7 @@ static void kdb_printenv(void)
>   * Parameters:
>   *	arg	A character string representing a numeric value
>   * Outputs:
> - *	*value  the unsigned long represntation of arg.
> + *	*value  the unsigned long representation of arg.
>   * Returns:
>   *	Zero on success, a kdb diagnostic on failure.
>   */
> @@ -470,7 +470,7 @@ static int kdb_check_regs(void)
>   *	symbol name, and offset to the caller.
>   *
>   *	The argument may consist of a numeric value (decimal or
> - *	hexidecimal), a symbol name, a register name (preceded by the
> + *	hexadecimal), a symbol name, a register name (preceded by the
>   *	percent sign), an environment variable with a numeric value
>   *	(preceded by a dollar sign) or a simple arithmetic expression
>   *	consisting of a symbol name, +/-, and a numeric constant value
> @@ -894,7 +894,7 @@ static void parse_grep(const char *str)
>   *	Limited to 20 tokens.
>   *
>   *	Real rudimentary tokenization. Basically only whitespace
> - *	is considered a token delimeter (but special consideration
> + *	is considered a token delimiter (but special consideration
>   *	is taken of the '=' sign as used by the 'set' command).
>   *
>   *	The algorithm used to tokenize the input string relies on
> diff --git a/kernel/debug/kdb/kdb_private.h b/kernel/debug/kdb/kdb_private.h
> index ccbed9089808..170c69aedebb 100644
> --- a/kernel/debug/kdb/kdb_private.h
> +++ b/kernel/debug/kdb/kdb_private.h
> @@ -64,7 +64,7 @@
>  
>  /*
>   * KDB_MAXBPT describes the total number of breakpoints
> - * supported by this architecure.
> + * supported by this architecture.
>   */
>  #define KDB_MAXBPT	16
>  
> -- 
> 2.25.1
