Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95A1413589
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 16:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbhIUOoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 10:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbhIUOoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 10:44:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA761C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 07:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DGmMlpMUOkTm4vKPa5AEfE6wFxS3ZaoVAuAsiouoBDs=; b=i9Tw3ddTfL/uisviclxGr07dZc
        HxtkqOTnD4r9N9lLOO+xX4gwRfSReCkhZB9gjFIykZI0RlZxO4P+pC4l1o2ha2HDUrypVLpXQrB/C
        nQYkdcNvLlN7/BLiNnfK4Tf+kbskciQiUl8skyQQO7c5OEjItLxV3+X1MR8R/eSi4Mc6ydtwGFCR7
        osRlydbOnmYlOwNhayYpLYxh8YKoDlgqJ1DND/g9L5fgsLTFW7PPl+KdaKx2tlB41lk5yb8lMy0Ug
        GxwLHU5WMuamwXA1rwnZvWZsq0R8ibYtbdte0I4wrzfTOYiGZObHT8LIDf2KQK9TUZtjKd1l33ze+
        1NA1Qi5Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSgxv-004mZ4-P5; Tue, 21 Sep 2021 14:41:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 96310300252;
        Tue, 21 Sep 2021 16:41:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7B9892659EB7C; Tue, 21 Sep 2021 16:41:45 +0200 (CEST)
Date:   Tue, 21 Sep 2021 16:41:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     sxwjean@me.com
Cc:     x86@kernel.org, linux-mm@kvack.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, luto@kernel.org,
        krisman@collabora.com, chang.seok.bae@intel.com,
        viro@zeniv.linux.org.uk, nivedita@alum.mit.edu,
        adobriyan@gmail.com, oleg@redhat.com, sblbir@amazon.com,
        axboe@kernel.dk, laijs@linux.alibaba.com,
        dave.hansen@linux.intel.com, akpm@linux-foundation.org,
        arnd@arndb.de, davem@davemloft.net, keescook@chromium.org,
        kim.phillips@amd.com, yazen.ghannam@amd.com, dave@stgolabs.net,
        metze@samba.org, elver@google.com, ebiederm@xmission.com,
        christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        Xiongwei Song <sxwjean@gmail.com>
Subject: Re: [PATCH RESEND 2/2] x86/mm: Randomize va with generic
 arch_pick_mmap_layout()
Message-ID: <YUnvKV0Qf6zhiasz@hirez.programming.kicks-ass.net>
References: <20210921143414.70723-1-sxwjean@me.com>
 <20210921143414.70723-3-sxwjean@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921143414.70723-3-sxwjean@me.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 10:34:14PM +0800, sxwjean@me.com wrote:
> diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
> index 7516e4199b3c..c697e377644d 100644
> --- a/arch/x86/include/asm/compat.h
> +++ b/arch/x86/include/asm/compat.h
> @@ -151,6 +151,11 @@ struct compat_shmid64_ds {
>  	compat_ulong_t __unused5;
>  };
>  
> +static inline int is_compat_task(void)
> +{
> +	return IS_ENABLED(CONFIG_COMPAT) && test_thread_flag(TIF_32BIT);
> +}
> +

This is still fundamentally broken for x86. x86 doesn't have compat
tasks, the granularity is at syscall at best.
