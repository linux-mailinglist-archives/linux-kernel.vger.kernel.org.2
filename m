Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6871E343136
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 06:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhCUF0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 01:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhCUF0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 01:26:19 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A448AC061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 22:26:18 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y5so8732064pfn.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 22:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hh7shEFqN+4YQy0DWvjoXzsDlDCaLtw9ra44KHPWHkg=;
        b=CjBgjxTr+npHKRoZHWRNroG1zVN7+AkzcS/lmkSLNlF4EKxZnVNJjDShIuxxxAbDMP
         Zi7BM7SPsQiwW3sjUNxe7wSxx8345a5fj0NJPVkLBGCQUl1vmxZJ8jBKoC1wCrRzdvKX
         XajNGZiZipEMON2F1c0CexM5NZ+JccY+8RIow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hh7shEFqN+4YQy0DWvjoXzsDlDCaLtw9ra44KHPWHkg=;
        b=h+9IFGxGTNiE6pzE7+pIUmDOzJ2NBIpxIuxftjsqKutDEeppIiNiS9vrBZ4p6ssanK
         hVwD/GU+40DcTpidl8T1AWWQqrtdoRB0SOzbl1bS3WRbrH+7hiQ92xyfFQVGQazV2Mr6
         qRkdWmTWBLjBwR5INEoGtPnAlryD97anO208wcdv/lS2EuqeC4rnxBk2/jbGwb5jvQcJ
         t+EecUIOlFrGv7t0688WGaqt95P88Gc7xQV9oDrcF1JF8DILVfXi7i7ydJpTZ8/Wjbmm
         d9N42s/xpFsmu/rm+KRE2jIzNMVmVMGpUrkFGjRfJOoeHaSnYvoEDoD/VWV9VyNcKlU7
         N1nA==
X-Gm-Message-State: AOAM533S90t4/DATP/4MYbUphK43KnXbg5vGBjA3wYxlq2DD4eetT3AG
        r9cWdsj5BlSmCNXRPdUClqGEsQ==
X-Google-Smtp-Source: ABdhPJzWtY3HUJYpBDSoqpysrTRhl3hfq3Gue+pAzMn1TblrjdoVsbczMaY8+SWExQl6c3ccUGZpXA==
X-Received: by 2002:a63:1845:: with SMTP id 5mr18028063pgy.244.1616304378263;
        Sat, 20 Mar 2021 22:26:18 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:2dfa:a0a:77ff:3953])
        by smtp.gmail.com with ESMTPSA id x190sm9815525pfx.60.2021.03.20.22.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 22:26:17 -0700 (PDT)
Date:   Sun, 21 Mar 2021 14:26:10 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Alistair Popple <alistair@popple.id.au>,
        Jordan Niethe <jniethe5@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, Yue Hu <huyue2@yulong.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Rafael Aquini <aquini@redhat.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org
Subject: Re: [PATCH next v1 2/3] printk: remove safe buffers
Message-ID: <YFbY8kF7ilYoxvYp@google.com>
References: <20210316233326.10778-1-john.ogness@linutronix.de>
 <20210316233326.10778-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316233326.10778-3-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/03/17 00:33), John Ogness wrote:
[..]
>  void printk_nmi_direct_enter(void)
>  {
> @@ -324,27 +44,8 @@ void printk_nmi_direct_exit(void)
>  	this_cpu_and(printk_context, ~PRINTK_NMI_DIRECT_CONTEXT_MASK);
>  }
>  
> -#else
> -
> -static __printf(1, 0) int vprintk_nmi(const char *fmt, va_list args)
> -{
> -	return 0;
> -}
> -
>  #endif /* CONFIG_PRINTK_NMI */
>  
> -/*
> - * Lock-less printk(), to avoid deadlocks should the printk() recurse
> - * into itself. It uses a per-CPU buffer to store the message, just like
> - * NMI.
> - */
> -static __printf(1, 0) int vprintk_safe(const char *fmt, va_list args)
> -{
> -	struct printk_safe_seq_buf *s = this_cpu_ptr(&safe_print_seq);
> -
> -	return printk_safe_log_store(s, fmt, args);
> -}
> -
>  /* Can be preempted by NMI. */
>  void __printk_safe_enter(void)
>  {
> @@ -369,7 +70,10 @@ __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
>  	 * Use the main logbuf even in NMI. But avoid calling console
>  	 * drivers that might have their own locks.
>  	 */
> -	if ((this_cpu_read(printk_context) & PRINTK_NMI_DIRECT_CONTEXT_MASK)) {
> +	if (this_cpu_read(printk_context) &
> +	    (PRINTK_NMI_DIRECT_CONTEXT_MASK |
> +	     PRINTK_NMI_CONTEXT_MASK |
> +	     PRINTK_SAFE_CONTEXT_MASK)) {

Do we need printk_nmi_direct_enter/exit() and PRINTK_NMI_DIRECT_CONTEXT_MASK?
Seems like all printk_safe() paths are now DIRECT - we store messages to the
prb, but don't call console drivers.

	-ss
