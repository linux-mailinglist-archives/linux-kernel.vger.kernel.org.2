Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3EA9420850
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 11:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbhJDJec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 05:34:32 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46722 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbhJDJeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 05:34:31 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A8BD422208;
        Mon,  4 Oct 2021 09:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633339961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cVbR2AIszwjTu+A/NL6X3/123fGAWjpDPUfYJkyefYg=;
        b=k9QSkT/CMufpYhIXrC+LwvfrQfjiGkp8+OjIFosOO/CHZOZ0CICesmEuublBNaRRjwnB2Y
        u3JNVKrHeuOKSf/Iryx3832vIw0VT7efcAfwzRHAVNy8Da9FYo5olH5eww1gk9w1tzTrk9
        TwdGnSbLCtdaBej7s8qiC1r8NKEtcl8=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 32880A3B9C;
        Mon,  4 Oct 2021 09:32:41 +0000 (UTC)
Date:   Mon, 4 Oct 2021 11:32:41 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Santosh Sivaraj <santosh@fossix.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv2 1/4] kernel/watchdog: trival cleanups
Message-ID: <YVrKOUVnDFjKOiNZ@alley>
References: <20210923140951.35902-1-kernelfans@gmail.com>
 <20210923140951.35902-2-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923140951.35902-2-kernelfans@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-09-23 22:09:48, Pingfan Liu wrote:
> No reference to WATCHDOG_DEFAULT, remove it.
> 
> And nobody cares about the return value of watchdog_nmi_enable(),
> changing its prototype to void.
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Wang Qing <wangqing@vivo.com>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Santosh Sivaraj <santosh@fossix.org>
> Cc: linux-arm-kernel@lists.infradead.org
> To: linux-kernel@vger.kernel.org
> ---
>  include/linux/nmi.h | 2 +-
>  kernel/watchdog.c   | 5 +----
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/nmi.h b/include/linux/nmi.h
> index 750c7f395ca9..b7bcd63c36b4 100644
> --- a/include/linux/nmi.h
> +++ b/include/linux/nmi.h
> @@ -119,7 +119,7 @@ static inline int hardlockup_detector_perf_init(void) { return 0; }
>  void watchdog_nmi_stop(void);
>  void watchdog_nmi_start(void);
>  int watchdog_nmi_probe(void);
> -int watchdog_nmi_enable(unsigned int cpu);
> +void watchdog_nmi_enable(unsigned int cpu);
>  void watchdog_nmi_disable(unsigned int cpu);
>  
>  /**
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index ad912511a0c0..6e6dd5f0bc3e 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -30,10 +30,8 @@
>  static DEFINE_MUTEX(watchdog_mutex);
>  
>  #if defined(CONFIG_HARDLOCKUP_DETECTOR) || defined(CONFIG_HAVE_NMI_WATCHDOG)
> -# define WATCHDOG_DEFAULT	(SOFT_WATCHDOG_ENABLED | NMI_WATCHDOG_ENABLED)
>  # define NMI_WATCHDOG_DEFAULT	1
>  #else
> -# define WATCHDOG_DEFAULT	(SOFT_WATCHDOG_ENABLED)
>  # define NMI_WATCHDOG_DEFAULT	0
>  #endif
>  
> @@ -95,10 +93,9 @@ __setup("nmi_watchdog=", hardlockup_panic_setup);
>   * softlockup watchdog start and stop. The arch must select the
>   * SOFTLOCKUP_DETECTOR Kconfig.
>   */
> -int __weak watchdog_nmi_enable(unsigned int cpu)
> +void __weak watchdog_nmi_enable(unsigned int cpu)

It is __weak. spart specific implementation is in
arch/sparc/kernel/nmi.c. It has to be updated as well.

Best Regards,
Petr
