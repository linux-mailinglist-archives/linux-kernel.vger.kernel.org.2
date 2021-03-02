Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376BC32A3D6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382619AbhCBJkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 04:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240744AbhCBJUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 04:20:40 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B88DC061756
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 01:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n+hLSIAYyK/Uw/x0vonbD56+QIeIjoNQnAuL5VLwhr8=; b=uaRamYrLoO9Guter62fKCGRifG
        1skDMBpJeYua+A7KjKaxANLB6rG+AET3Xi/wN8GomdciRG02iVDPsVmRuH3eJVo9bGS5Z6eXqP7OP
        8UBVAkDhHDeUwr1V2nIqZoUUtxZjqf8xIneX591HJsowXDlYxZTSfe5Fss1zmE1g03O8s0SiP5NM8
        dSEg0NBEvdiMT/y8FF98Vz8N6Eg0SPthoPxPKBywJkPFLaVS1zavqqbCwaCkS5PdMQX2r5puzFKEg
        LZdHs3L09LwfHxjVI/EtlUJelp1pE9wzkqHOvmAs5coFsYBouZIOLyWB/nCfdsbbESIsqOh0RG3WU
        X47R9Vrg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lH1C1-0001Kx-Uw; Tue, 02 Mar 2021 09:19:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D6DFF30018A;
        Tue,  2 Mar 2021 10:19:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C033E234E17C3; Tue,  2 Mar 2021 10:19:47 +0100 (CET)
Date:   Tue, 2 Mar 2021 10:19:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        kernel test robot <oliver.sang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [x86, build] 6dafca9780:
 WARNING:at_arch/x86/kernel/ftrace.c:#ftrace_verify_code
Message-ID: <YD4DM6uAETid7j4l@hirez.programming.kicks-ass.net>
References: <20210301074027.GD12822@xsang-OptiPlex-9020>
 <CABCJKuc8H83b_8_Ccp+Cb7O9x5oEu6sPNq63sjGcAJcgiwy0bw@mail.gmail.com>
 <20210301184524.7aa05ac1@gandalf.local.home>
 <CABCJKudQme=bcNJtNCORUpBnVA_Pkr2Zk_3Nu2EsfnuoE7LJ3g@mail.gmail.com>
 <20210301201526.65ce7f1c@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301201526.65ce7f1c@oasis.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 08:15:26PM -0500, Steven Rostedt wrote:
> diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
> index 7edbd5ee5ed4..e8afc765e00a 100644
> --- a/arch/x86/kernel/ftrace.c
> +++ b/arch/x86/kernel/ftrace.c
> @@ -36,6 +36,7 @@
>  #ifdef CONFIG_DYNAMIC_FTRACE
>  
>  static int ftrace_poke_late = 0;
> +static const char p6_nop[] = { P6_NOP5 };

I don't understand this approach, why not simply rewrite all the nops at
boot and not worry about it when modifying the code later?
