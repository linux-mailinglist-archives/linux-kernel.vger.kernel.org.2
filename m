Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BB6352556
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 04:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbhDBCOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 22:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbhDBCO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 22:14:29 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B590C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 19:14:28 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id i6so2762842pgs.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 19:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JB5UehlmQzvZFx81WrZqpYM4CZPIjgwCICp/Q33dgPY=;
        b=CiQCdaLNqItRdaQBOeJkErTv3n7PjSNnp+YvdQJ1ecNwMtUhwCi8shAehVOT7sxQpo
         nP61ASpB1NgGt9ANL4exn/Z9n7DKxzMjicech11ff/+fm4VxApqGY66Vw5/l8MC+kRoI
         zt+/uQlTX7cj6PZaFPDSywCRWFA6eFe3lXxPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JB5UehlmQzvZFx81WrZqpYM4CZPIjgwCICp/Q33dgPY=;
        b=bA90f9+++RFCV09LLOkl68oBR3wBzmogP5Sise+YYYkOpQgwBw8ZZRg9EFgAgplRJC
         0Jr6HzwhpNMkwtx54iO2c2P3IJpqD0cwslciZ6Lb1OnMcAIZr7kzx6stA4o1QOubh7rR
         fHNU4jizBu7h8BfVOry/EsODXzmJ3WLskkEthSpOkWpf8jTzHYo2HGgEy3+JFLMqkCZJ
         oHJMuB6l/4sXRG/jS4aH5MfZTlYdQhKb9/YBJX5K91cFxuOl349Zs5bhSMxexL1YVK0g
         Lf8kqojhZ4zizIys5BI5UROJSCJLpUYGempqJaVKcHUaEi3+gQaC/BLgd0yhJozls/eS
         FzRQ==
X-Gm-Message-State: AOAM533UPnM3kywzut2U/V5bsCy6D0ORuPGAhjJLyy0antAdKxQ2Yy7W
        gkGiSorFTot6Eh/vuDybFKplWQ==
X-Google-Smtp-Source: ABdhPJy0ejIbP6LV2LsRoOa1rVdM/WfylFauJ7ONnIZVqPdmEwYb/IrcKuqgQDFSQ2rNzG87UypcyQ==
X-Received: by 2002:a65:6a0e:: with SMTP id m14mr10107450pgu.448.1617329667742;
        Thu, 01 Apr 2021 19:14:27 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:918a:96e1:2fd5:8e77])
        by smtp.gmail.com with ESMTPSA id e65sm6959948pfe.9.2021.04.01.19.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 19:14:27 -0700 (PDT)
Date:   Fri, 2 Apr 2021 11:14:18 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alistair Popple <alistair@popple.id.au>,
        Jordan Niethe <jniethe5@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Yue Hu <huyue2@yulong.com>, Rafael Aquini <aquini@redhat.com>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org
Subject: Re: [PATCH printk v2 2/5] printk: remove safe buffers
Message-ID: <YGZ9+kfQKxASmVDR@google.com>
References: <20210330153512.1182-1-john.ogness@linutronix.de>
 <20210330153512.1182-3-john.ogness@linutronix.de>
 <YGW63/elFr/gYW1u@alley>
 <87a6qiqgzr.fsf@jogness.linutronix.de>
 <YGXV8LJarjUJDhvy@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGXV8LJarjUJDhvy@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/04/01 16:17), Petr Mladek wrote:
> > For the long term, we should introduce a printk-context API that allows
> > callers to perfectly pack their multi-line output into a single
> > entry. We discussed [0][1] this back in August 2020.
> 
> We need a "short" term solution. There are currently 3 solutions:
> 
> 1. Keep nmi_safe() and all the hacks around.
> 
> 2. Serialize nmi_cpu_backtrace() by a spin lock and later by
>    the special lock used also by atomic consoles.
> 
> 3. Tell complaining people how to sort the messed logs.

Are we talking about nmi_cpu_backtrace()->dump_stack() or some
other path?

dump_stack() seems to be already serialized by `dump_lock`. Hmm,
show_regs() is not serialized, seems like it should be under the
same `dump_lock` as dump_stack().
