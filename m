Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9973F3A937B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 09:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhFPHI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 03:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbhFPHI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 03:08:27 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEF3C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 00:06:21 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id k22-20020a17090aef16b0290163512accedso3164808pjz.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 00:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sXXuhoLRJX2+rrJArKajwCGFhT8GhurCdeZkGKLcGwM=;
        b=glXINbBFF0plMxXAiIq62MgFyjvUIpUrhfyKc3iI0uypsMBL5jn/cEZnhBa0pcSSpA
         hBaa1Ch5vsN/o3E7jMmj0Ilj8qdHJbI/JumRVMiuZgVy6AS3GM0NEws379eEQokOUY+Y
         qJ0/J+xx/Tbrgpwo4IFTmTKdsmYnOyJ7MV1GA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sXXuhoLRJX2+rrJArKajwCGFhT8GhurCdeZkGKLcGwM=;
        b=fu4dpAIFlo0/ajg12EgQU1pVAMZ59PghJWCQFSliVSZqPHGIooCGsUBiXcIV3YXLX1
         jAWCK2cDDMHsx1eGWN/EJCLsOBOd8IeXfXYtUjfbNIC1N1RQ30C6gbxiBzgxoKVL44+s
         fwv9hOD9/bQO9dCYj/E9SVLQb5qHVESHnltLkoHCYFkQDKJhAcUhc6XMbKsXvyuuO0G5
         YsrP0wieRIaHRKFhSPVzzEjwowJiQh/e0PcMvk8FGnmSSMRimDA9KJYmmiwfZoKtlrvS
         YMhpMmbu5XICxFYNU1yaxeoVJjLY+SN5wnXId7vki/njsJmd+cDrV4dpYG1PQnYMkp/y
         i57A==
X-Gm-Message-State: AOAM531My75E4HGOtnDsp1us07FUVehbSWj6HLUmUYFiPOtLfvbYiW1Z
        XbDEebTPseK6oLyB1RffDj0eJA==
X-Google-Smtp-Source: ABdhPJx3wBvpKen63quXCl/lZAagMvoyYHXFGOqjj9nbOG2A6kInN9Y5bDxOCa5XJIQDtFdtaBXWjw==
X-Received: by 2002:a17:902:b181:b029:fc:c069:865c with SMTP id s1-20020a170902b181b02900fcc069865cmr7939920plr.28.1623827181105;
        Wed, 16 Jun 2021 00:06:21 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:da79:71b5:dd21:f72])
        by smtp.gmail.com with ESMTPSA id s11sm4561527pjz.42.2021.06.16.00.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 00:06:20 -0700 (PDT)
Date:   Wed, 16 Jun 2021 16:06:15 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
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
Message-ID: <YMmi5xoTOb82TKtJ@google.com>
References: <20210615174947.32057-1-john.ogness@linutronix.de>
 <20210615174947.32057-2-john.ogness@linutronix.de>
 <8735tiq0d8.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735tiq0d8.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/06/15 23:39), John Ogness wrote:
> On 2021-06-15, John Ogness <john.ogness@linutronix.de> wrote:
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index 114e9963f903..5369d8f33299 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -3532,3 +3532,70 @@ void kmsg_dump_rewind(struct kmsg_dump_iter *iter)
> >  EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
> >  
> >  #endif
> > +
> > +#ifdef CONFIG_SMP
> > +static atomic_t printk_cpulock_owner = ATOMIC_INIT(-1);
> > +static bool printk_cpulock_nested;
> 
> I just realized that @printk_cpulock_nested will need to be an atomic_t
> counter to allow multiple nested levels since nesting can also occur

Strictly speaking, this is not nested printk, right? printk recursion is
handled in printk separately. This one is more like "nested dump_stack()-s",
or nested "error reporinting".

Shall this be a separate patch? Because the original code has never
limited nested error reporting contexts.
