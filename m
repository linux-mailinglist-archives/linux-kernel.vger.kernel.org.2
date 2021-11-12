Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD69244DFDB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 02:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhKLBox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 20:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhKLBou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 20:44:50 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEBDC061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 17:42:00 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so5838603pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 17:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8/uPIhj4a152zs5ky6AQ+g9VVeaVVjatNXSvVlJ4M8w=;
        b=jGVvYXLEDwf7XWXN29xWSuesfdQB5MMOhcMxTooJpId4NfOcPDh2MmF7YcTpTJM/Yw
         nd21pyL3cm/wGdDuZiWkVny0on5DlxNAESk5RNSA4NBr3n774ER4T3EWw/hh2TtErDbM
         NrHBIb98nMPEkiKja6s40mFtwsgiJiHZvWFr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8/uPIhj4a152zs5ky6AQ+g9VVeaVVjatNXSvVlJ4M8w=;
        b=gZhf5SycSyIJoSXI30LP2Z84LST1iqiji8k+l7/VfLsSVnEQmrSUI1J5YVW+/Osm/q
         eaftHo11e620CekRhwhjUYD0qSna0TbZVpt7zCZt5TgVwaz3aH1FtJGRIOB4DJlpeK9z
         tgD1dMjN65AVpE+Q2ptqeoeTC6a/sBQpb2xdACjHGCgJUT0f4z+2W/VRdq/ftahWgozu
         7/2erOJIvyLGC6h9MqF26X5PZ0zbyVGZmi5896q0hp9LGn2XPSGX+pm41kqdAEBkzYvN
         x6toFDLzLlyQiuA0yu0UQBLbW799rM4I73EbKxZcmwrMRm/H4Lglil08xzN/o3miSF7P
         fskA==
X-Gm-Message-State: AOAM531ubFZwLUh14ZMUS4kU484zTaYef0NcDA/qhb3x4F8gjAlJR0VF
        B6NbCDp6KWN/xxwivZaDTUo89x48JTmebA==
X-Google-Smtp-Source: ABdhPJySEwe+TRB70395FlI2vkJcM8K0z4UD8H+SEWFS6ye9JiRUvwbe0VT7MHKQ83VNa2JS7VasGg==
X-Received: by 2002:a17:90a:3b02:: with SMTP id d2mr13066830pjc.159.1636681320128;
        Thu, 11 Nov 2021 17:42:00 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:d5e0:1bf2:605:ae8e])
        by smtp.gmail.com with ESMTPSA id s30sm4387004pfg.17.2021.11.11.17.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 17:41:59 -0800 (PST)
Date:   Fri, 12 Nov 2021 10:41:55 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v2 1/1] printk: suppress rcu stall warnings caused by
 slow console devices
Message-ID: <YY3GY8ZSH5ACaZZS@google.com>
References: <20211111195904.618253-1-wander@redhat.com>
 <20211111195904.618253-2-wander@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111195904.618253-2-wander@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/11/11 16:59), Wander Lairson Costa wrote:
> 
> If we have a reasonable large dataset to flush in the printk ring
> buffer in the presence of a slow console device (like a serial port
> with a low baud rate configured), the RCU stall detector may report
> warnings.
> 
> This patch suppresses RCU stall warnings while flushing the ring buffer
> to the console.
> 
[..]
> +extern int rcu_cpu_stall_suppress;
> +
> +static void rcu_console_stall_suppress(void)
> +{
> +	if (!rcu_cpu_stall_suppress)
> +		rcu_cpu_stall_suppress = 4;
> +}
> +
> +static void rcu_console_stall_unsuppress(void)
> +{
> +	if (rcu_cpu_stall_suppress == 4)
> +		rcu_cpu_stall_suppress = 0;
> +}
> +
>  /**
>   * console_unlock - unlock the console system
>   *
> @@ -2634,6 +2648,9 @@ void console_unlock(void)
>  	 * and cleared after the "again" goto label.
>  	 */
>  	do_cond_resched = console_may_schedule;
> +
> +	rcu_console_stall_suppress();
> +
>  again:
>  	console_may_schedule = 0;
>  
> @@ -2645,6 +2662,7 @@ void console_unlock(void)
>  	if (!can_use_console()) {
>  		console_locked = 0;
>  		up_console_sem();
> +		rcu_console_stall_unsuppress();
>  		return;
>  	}
>  
> @@ -2716,8 +2734,10 @@ void console_unlock(void)
>  
>  		handover = console_lock_spinning_disable_and_check();
>  		printk_safe_exit_irqrestore(flags);
> -		if (handover)
> +		if (handover) {
> +			rcu_console_stall_unsuppress();
>  			return;
> +		}
>  
>  		if (do_cond_resched)
>  			cond_resched();
> @@ -2738,6 +2758,8 @@ void console_unlock(void)
>  	retry = prb_read_valid(prb, next_seq, NULL);
>  	if (retry && console_trylock())
>  		goto again;
> +
> +	rcu_console_stall_unsuppress();
>  }

May be we can just start touching watchdogs from printing routine?
