Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76185312AD6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 07:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhBHGjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 01:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhBHGj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 01:39:28 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4FBC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 22:38:46 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id e9so7288737plh.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 22:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4x8g4SVmzJqTPf9smsHfaxo7jwJgCQqSwNYqpSpJ50c=;
        b=mZEX5AWKp0Bs0Tl+wUUbEqa6uC+YU6nhEhCsg8sTxDOElkxovZgqW6UEIqB4dmHrmX
         T+lQZIKDX5IttxIILew7ZNl0UCT/dHUsBs4bIW/IRNUclAlTY4hHd9p/wLKLoAoC0RIA
         TCOJjvehd1kNQ6GcpV47/FSXXtSzPu6OyZ9Non76zUR18XHC4Xx99s9e4iEJKCt14lhq
         VSZukK8Tzmqq9Ku1i3n87Rxcm9v3CfxgzT9LrM0HFcQUhj6OdTp6q5UQ64sWpOhB6MLC
         8Moqv3ksOr67m7fT+0DDjpSonIMQtd2uuLIlGkWc7o992D9vYBloySGMdWC5+dsEM6oQ
         DeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4x8g4SVmzJqTPf9smsHfaxo7jwJgCQqSwNYqpSpJ50c=;
        b=Yr2N2LXIHug1Ha3uejL54ssEMfTUnOpH6uVqc3RPNDfvcsJI2ga5MPXdny7poqcSvI
         9sWpwfsPc+RGwZsriJrbxiJ4WNHEDNJMrPyxP0eXhWFqh4lrVRLJGFuq2+jrjTBXRtz2
         mNIQeldrn8gOSOj6asD/9hglwUoxfEuXeNtziw9jAk6Npu2x+qmh0rg4DYo5qa5wVrNm
         YqmJujTMwDJkQn7s7reXgHqDvWT7cFjYd5Y3k4q6vVTbuhYNYJewnSCBqTKjY5RUA1i3
         xGFecm8QjtFSsRKyJ6r53Lgys45tE5PyK/vcGSLEVuPQ5yjtow7hhQezIcwBRSLeYzQ0
         HJfQ==
X-Gm-Message-State: AOAM533Ss2XdRuFHZISXwcHN91GK5hOGG4cCIlcXB7Icx4gXFrrDBtDS
        Rd71/eCnlH2dDoSOm1j9hMI=
X-Google-Smtp-Source: ABdhPJzUJkIesoDmlFS7A/+M6+YlgXTEW0V/v8e22tcWOuoMo+P5jb4/qP/Ho2Y0fdvRaalWwf7g0g==
X-Received: by 2002:a17:902:e812:b029:de:5af2:3d09 with SMTP id u18-20020a170902e812b02900de5af23d09mr15211144plg.33.1612766326448;
        Sun, 07 Feb 2021 22:38:46 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id d185sm8340857pfd.110.2021.02.07.22.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 22:38:45 -0800 (PST)
Date:   Mon, 8 Feb 2021 15:38:44 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, john.ogness@linutronix.de,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] printk: fix deadlock when kernel panic
Message-ID: <YCDcAy39BbPItdGY@jagdpanzerIV.localdomain>
References: <20210206054124.6743-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210206054124.6743-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/02/06 13:41), Muchun Song wrote:
> We found a deadlock bug on our server when the kernel panic. It can be
> described in the following diagram.
> 
> CPU0:                                         CPU1:
> panic                                         rcu_dump_cpu_stacks
>   kdump_nmi_shootdown_cpus                      nmi_trigger_cpumask_backtrace
>     register_nmi_handler(crash_nmi_callback)      printk_safe_flush
>                                                     __printk_safe_flush
>                                                       raw_spin_lock_irqsave(&read_lock)
>     // send NMI to other processors
>     apic_send_IPI_allbutself(NMI_VECTOR)
>                                                         // NMI interrupt, dead loop
>                                                         crash_nmi_callback

At what point does this decrement num_online_cpus()? Any chance that
panic CPU can apic_send_IPI_allbutself() and printk_safe_flush_on_panic()
before num_online_cpus() becomes 1?

>   printk_safe_flush_on_panic
>     printk_safe_flush
>       __printk_safe_flush
>         // deadlock
>         raw_spin_lock_irqsave(&read_lock)

	-ss
