Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040483A99AA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 13:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbhFPL5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 07:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhFPL5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 07:57:47 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60403C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 04:55:41 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id t17so1760883pga.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 04:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ziF5kb6kVKhUNrqTdlpIOtuDgVDBVnkKgznX45jGdpw=;
        b=jVzI51Or9cpRb1TFp1tGk5p7aYjm5d0CkHylLxYypRK6vmmMwxB+jQEm5xPI1izvQh
         ML6zNA9wT3L69DVhJ+5HKHUfmzilxQRwR51bfz95Nh5uxicOExTYEgd/NsngUe2yzUNE
         /Cs9cAGTMEYKTDw5WSQZFOxsGvP+NgpulS4QA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ziF5kb6kVKhUNrqTdlpIOtuDgVDBVnkKgznX45jGdpw=;
        b=Gkm6mAgV8hAtzm6aIofADYV4vuEHZUu2AUOjJFEWsHA77LkCmG3K1beKURl7/Wumx2
         MmBqqB+BlDqS1WbDN3TE49s5zcVJFGPB8C2qgljCkgA8WmUOBoZAo8R+lWmne49lVe5o
         yTPX2X13y5MJ466xES52R70p92DL5cX8H3pHnbomchK9ZkA2z5ns4fmuzr++jbjYHp8Z
         lbtJf3lusnVGsHKm/pKtet5lhKIytsnfUEc2ma7gqShxZQpRcQq0k8D6Ur/a9POnqk7A
         +yzzKJSFKx35ZF5Gd1rNVHmcx1UeXHiz9YxXLXg4g4PYu7yX50yfptSwuruUbJriHTkV
         y75g==
X-Gm-Message-State: AOAM533jDSKMCGdKVuYnCAKBY9SSl+QQR/mVr9+EtfjgiUO2kOXv/wTa
        MBm6smDb/rnZ1m7nxjsOeDa9jg==
X-Google-Smtp-Source: ABdhPJxksM84JUBuqoqEPdq6Y5UaaC3VN3QFd9sWp4hQROm6LMLL/VOMHM5sD5vIksYkh/xheRd1Iw==
X-Received: by 2002:a62:7cca:0:b029:2e9:c89d:d8a9 with SMTP id x193-20020a627cca0000b02902e9c89dd8a9mr8970349pfc.55.1623844540882;
        Wed, 16 Jun 2021 04:55:40 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:da79:71b5:dd21:f72])
        by smtp.gmail.com with ESMTPSA id c16sm2090272pfi.76.2021.06.16.04.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 04:55:40 -0700 (PDT)
Date:   Wed, 16 Jun 2021 20:55:33 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH next v3 1/2] dump_stack: move cpu lock to printk.c
Message-ID: <YMnmtXG4WE9/xp8f@google.com>
References: <20210615174947.32057-1-john.ogness@linutronix.de>
 <20210615174947.32057-2-john.ogness@linutronix.de>
 <8735tiq0d8.fsf@jogness.linutronix.de>
 <YMmi5xoTOb82TKtJ@google.com>
 <87mtrqnu74.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mtrqnu74.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/06/16 09:35), John Ogness wrote:
> It isn't about limiting. It is about tracking.

Oh, yes. I missed it.
>
[..]

> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index e67dc510fa1b..5376216e4f3d 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3535,7 +3535,7 @@ EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
>  
>  #ifdef CONFIG_SMP
>  static atomic_t printk_cpulock_owner = ATOMIC_INIT(-1);
> -static bool printk_cpulock_nested;
> +static atomic_t printk_cpulock_nested = ATOMIC_INIT(0);
>  
>  /**
>   * __printk_wait_on_cpu_lock() - Busy wait until the printk cpu-reentrant
> @@ -3596,7 +3598,7 @@ int __printk_cpu_trylock(void)
>  
>  	} else if (old == cpu) {
>  		/* This CPU is already the owner. */
> -		printk_cpulock_nested = true;
> +		atomic_inc(&printk_cpulock_nested);
>  		return 1;
>  	}
>  
> @@ -3613,8 +3615,8 @@ EXPORT_SYMBOL(__printk_cpu_trylock);
>   */
>  void __printk_cpu_unlock(void)
>  {
> -	if (printk_cpulock_nested) {
> -		printk_cpulock_nested = false;
> +	if (atomic_read(&printk_cpulock_nested)) {
> +		atomic_dec(&printk_cpulock_nested);
>  		return;
>  	}

Looks good.
