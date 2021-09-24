Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199D2416B67
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 08:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244163AbhIXGFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 02:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244141AbhIXGFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 02:05:46 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F49AC061756
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 23:04:14 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id d13-20020a17090ad3cd00b0019e746f7bd4so3620550pjw.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 23:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=URcHuUR3KotXWwoDq/T1fdJ+3yW74lFiMCYEJPpK4uY=;
        b=kkL7so1ZIJloVpLtCNdL0ilz3NYV+bsAJuKzXwcT7agbHZTVwHPoOIWXSsZwuczcyv
         ayHqCRfDVveUm8N8NzR4Z91wlWa5e6IukAXGZF0mIkYQ7cexCZ7uCVGBYLQVpbiNyxog
         HVIjOw9Gn1Lh1ZsHG0ILF1oKPyv/TUwq1g7rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=URcHuUR3KotXWwoDq/T1fdJ+3yW74lFiMCYEJPpK4uY=;
        b=v/CYKDfpoNWiAtH/76yo0Y9EVXgu8ZHixr6Z84V1uBxfSN4R7yd8qE4G8UzMXldxW9
         lmQlSCZgZN16h7vw5t3N8i/rA7J8BBvEGo1Tg+eu4m1CdgOFYDvtHLVjR1l0yZrkit3i
         epLnsKiNnx6xoqjyDbUnm+fmAyEykls3QLKW5DaV3XBfwc0zkE4wQMkf8BCL/FFyLBVr
         dog8gMYyXbxsZp9qsd89wYIF1TcWZG39575PeGxwaxYVMO7T65EgZjltOXL84Z7mr03T
         +ugEGhEc7RLPyY5KiZeLW2p5gakNZRrl0jEmSXuXNZT7yUVDkYeRV0mn0g1FiIgdJ2uT
         aScQ==
X-Gm-Message-State: AOAM530EzDscdMxQSbaMHd6+IexMTbzLiDzBjrROF2FgAtDJoOaCTbUY
        HxxN4OX9sBkKdrbdV8L4B6RtgQ==
X-Google-Smtp-Source: ABdhPJz2/Qhw9FfLRxSu9FPaPcVlPbYTb1X6R8zc2JpWn8SlRXobSJ7cE8adw+wfpLXpp8/I/dCj4w==
X-Received: by 2002:a17:90b:3901:: with SMTP id ob1mr201990pjb.136.1632463453532;
        Thu, 23 Sep 2021 23:04:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t22sm680585pgb.77.2021.09.23.23.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 23:04:12 -0700 (PDT)
Date:   Thu, 23 Sep 2021 23:04:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jens Axboe <axboe@kernel.dk>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stefan Metzmacher <metze@samba.org>,
        Andy Lutomirski <luto@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Michael =?iso-8859-1?Q?Wei=DF?= 
        <michael.weiss@aisec.fraunhofer.de>,
        Anand K Mistry <amistry@google.com>,
        Alexey Gladkov <legion@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Helge Deller <deller@gmx.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] proc: Disable /proc/$pid/wchan
Message-ID: <202109232301.B0B9753D@keescook>
References: <20210923233105.4045080-1-keescook@chromium.org>
 <20210923191306.664d39866761778a4a6ea56c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923191306.664d39866761778a4a6ea56c@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 07:13:06PM -0700, Andrew Morton wrote:
> On Thu, 23 Sep 2021 16:31:05 -0700 Kees Cook <keescook@chromium.org> wrote:
> 
> > The /proc/$pid/wchan file has been broken by default on x86_64 for 4
> > years now[1].
> 
> [1] is hard to decrypt.  I think it would be better if this changelog
> were to describe the problem directly, completely and succinctly?
> 
> > As this remains a potential leak of either kernel
> > addresses (when symbolization fails) or limited observation of kernel
> > function progress, just remove the contents for good.
> > 
> > Unconditionally set the contents to "0" and also mark the wchan
> > field in /proc/$pid/stat with 0.
> > 
> > This leaves kernel/sched/fair.c as the only user of get_wchan(). But
> > again, since this was broken for 4 years, was this profiling logic
> > actually doing anything useful?
> 
> Agree that returning a hard-wired "0\n" is the way to go.

I must NAK my own patch. ;) It looks like this would be a breaking
userspace-visible change[1].

We need to fix the two bugs though:

1) wchan broken under ORC (patch exists in the thread at [1])

2) wchan leaking raw addresses (152c432b128c needs reverting from v5.12 and later)

-Kees

[1] https://lore.kernel.org/lkml/20210924054647.v6x6risoa4jhuu6s@shells.gnugeneration.com

-- 
Kees Cook
