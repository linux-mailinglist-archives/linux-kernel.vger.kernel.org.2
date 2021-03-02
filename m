Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC3F32A657
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384102AbhCBOhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 09:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350742AbhCBMrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 07:47:01 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CB1C0611C1
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 04:45:19 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id u3so1598859otg.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 04:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P8t0odw1Ol/O1AJt7AOmSfFmioJI8iKFTJw2MTf4RQk=;
        b=VZjeLG/VmDpZEhwakOm/C7M36eMfX6VH99FsCxtBHuYibjeDhhGg0cvUo2xWhk1xRl
         ITnbW5pDNNm56LVLMnz95TVyMZw+4ye6JeNNjAEsfZYQKO/W8vdbJgBitWYG/tebNzPB
         WYvO2W38Wf26BYXZCc/RMeN2U9HVeGdS/4gwMAuDHuzCcVugyFUQIZ0rscZ7URyxhAxm
         Q4umHI/3xPuOnfRQLxoQW3coC09JsYLpUsh1IYZWG6H1xOfJXlXLPOoDpMLoWmKsJ3Uh
         GQtmjfxr++rj1kZyGqmAlts79oqlRgX4Vky41WcNJR816vx2cPIp7u9fPZbLqi3gh9Jy
         RMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P8t0odw1Ol/O1AJt7AOmSfFmioJI8iKFTJw2MTf4RQk=;
        b=VYPT5ryeO8FJiVFM/jc0VVbRoPcjsy892rjz+5e17t20XI6q/PPmR4IgUhPBUA7+3q
         CXP90HahRLtCnq0jcE8UMNUV6dr0HlgrgSdjWizhDWzZsXJ2kP0+ZI0+EBGq/W3DCUif
         EQq+cHeLrOu9fICFVQBJo3r1Lrh474b9ydQ6anykNtjM8ylkjNXmhiwBORjTWhcwCY5R
         1eLbWT4En+bqLBJLqjhC0CsIxIllGOoMBPNUObIux7ekgaF4GeqiNvHsQqAKliZYFVos
         nOKkvg5GjBy4i/cYgLh9yk7u+iwsc7S59+Hfz8nh0eRn+mfyq7EcYLK4LHBvfhthj0za
         DeTQ==
X-Gm-Message-State: AOAM533DPRcBnIZiCX8vwxFncVwSGn67IyBXRp+Fd6unues3McF5lExi
        /N2oUlcURHkf7EBytUQTnWwnnTswlgEdm1+RFPctgA==
X-Google-Smtp-Source: ABdhPJyGXDUaQ/MAp0WJLrNiWCaoxAmzqfRb4UmrtY0aYzTzPJlcOYXZsSlIzaZOPMCY5y/NSLo60vriP34sVPMT4NY=
X-Received: by 2002:a05:6830:1355:: with SMTP id r21mr10547387otq.17.1614689118519;
 Tue, 02 Mar 2021 04:45:18 -0800 (PST)
MIME-Version: 1.0
References: <20210214161348.369023-1-timur@kernel.org> <20210214161348.369023-4-timur@kernel.org>
 <CAMuHMdULKZCJevVJcp7TxzLdWLjsQPhE8hqxhnztNi9bjT_cEw@mail.gmail.com>
In-Reply-To: <CAMuHMdULKZCJevVJcp7TxzLdWLjsQPhE8hqxhnztNi9bjT_cEw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 2 Mar 2021 13:45:07 +0100
Message-ID: <CANpmjNNm-4s16_KQ1_NqFN4XOESJh4_=33LHQzt+p4V0Cy=Xzw@mail.gmail.com>
Subject: Re: [PATCH 3/3] [v4] lib/vsprintf: no_hash_pointers prints all
 addresses as unhashed
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Timur Tabi <timur@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        roman.fietze@magna.com, Kees Cook <keescook@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pavel Machek <pavel@ucw.cz>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Mar 2021 at 12:51, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Timur,
>
> On Sun, Feb 14, 2021 at 5:17 PM Timur Tabi <timur@kernel.org> wrote:
> > If the no_hash_pointers command line parameter is set, then
> > printk("%p") will print pointers as unhashed, which is useful for
> > debugging purposes.  This change applies to any function that uses
> > vsprintf, such as print_hex_dump() and seq_buf_printf().
> >
> > A large warning message is displayed if this option is enabled.
> > Unhashed pointers expose kernel addresses, which can be a security
> > risk.
> >
> > Also update test_printf to skip the hashed pointer tests if the
> > command-line option is set.
> >
> > Signed-off-by: Timur Tabi <timur@kernel.org>
>
> Thanks for your patch, which is now commit 5ead723a20e0447b
> ("lib/vsprintf: no_hash_pointers prints all addresses as unhashed") in
> v5.12-rc1.
>
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -2090,6 +2090,32 @@ char *fwnode_string(char *buf, char *end, struct fwnode_handle *fwnode,
> >         return widen_string(buf, buf - buf_start, end, spec);
> >  }
> >
> > +/* Disable pointer hashing if requested */
> > +bool no_hash_pointers __ro_after_init;
> > +EXPORT_SYMBOL_GPL(no_hash_pointers);
> > +
> > +static int __init no_hash_pointers_enable(char *str)
> > +{
> > +       no_hash_pointers = true;
> > +
> > +       pr_warn("**********************************************************\n");
> > +       pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> > +       pr_warn("**                                                      **\n");
> > +       pr_warn("** This system shows unhashed kernel memory addresses   **\n");
> > +       pr_warn("** via the console, logs, and other interfaces. This    **\n");
> > +       pr_warn("** might reduce the security of your system.            **\n");
> > +       pr_warn("**                                                      **\n");
> > +       pr_warn("** If you see this message and you are not debugging    **\n");
> > +       pr_warn("** the kernel, report this immediately to your system   **\n");
> > +       pr_warn("** administrator!                                       **\n");
> > +       pr_warn("**                                                      **\n");
> > +       pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> > +       pr_warn("**********************************************************\n");
> > +
> > +       return 0;
> > +}
> > +early_param("no_hash_pointers", no_hash_pointers_enable);
>
> While bloat-o-meter is not smart enough to notice the real size impact,
> this does add more than 500 bytes of string data to the kernel.
> Do we really need such a large message?
> Perhaps the whole no_hash_pointers machinery should be protected by
> "#ifdef CONFIG_DEBUG_KERNEL"?

We recently stumbled across this, and it appears an increasing number
of production kernels enable CONFIG_DEBUG_KERNEL [1], so it likely
isn't the solution (we tried to use CONFIG_DEBUG_KERNEL in similar
way, and it wasn't reliable). Having no_hash_pointers frees us of
having to rely on CONFIG_DEBUG_KERNEL. (Perhaps somebody else will
comment, but I believe there were strong objections to making the
pointer hashing dependent on more Kconfig options.)

[1] https://lkml.kernel.org/r/20210223082043.1972742-1-elver@google.com

Would placing the strings into an __initconst array help?

Thanks,
-- Marco
