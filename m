Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C837541FD49
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 18:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbhJBRBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 13:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbhJBRBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 13:01:11 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8498C0613EC
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 09:59:24 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id p13so18593448edw.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 09:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7qMFTJ7wxvDKx7RqRNbyM5iYJL53fzpBAX1Z0cXGDYo=;
        b=BnC7AWn2t7U8hcMvbZB6+f8WRPJ/wlLxLWqJMBBFQqlt2pJ7o9Cq+PY7G8zlvkboG0
         +aMmZjmiZyWkpgq/2TNa5lv+hVLEInO3k7cx6j+7mNevTzx3z8dSx+JapPEMt+QE7qnM
         jYwoWfCyKbjfVLLEkVydAP4vUyV5gl74Dwa/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7qMFTJ7wxvDKx7RqRNbyM5iYJL53fzpBAX1Z0cXGDYo=;
        b=TBJkL8QXcQNdmTSo8zr1gsZuffwos94PXXYqRKt1KcW7PkZPlnWMAlOCk84JZYgchf
         vjwvXnWQCBZuT7HYkWyQoeZ+4L1l+g/u/pfnhNHQjmq/rux2RfNZzyTUK+EAYR3i1GtJ
         aneRxm29hB6M3Dqo+DpamCjAhreQh3X1pZWCjuy6zlc6ChpnKDnh0k55xrjaXE368QuD
         BCCMHShxyUdS3JZFID+iJSuEa7/5hszsn/lYaijSrdD4g45wYAexTLajn94/By3WxP08
         qfLNsgYOr/FcHe2E6ORfyorojFvaefMONJG/piWaHXTtxZDcbHDGLrOGxpXy9kel6G9J
         dG3A==
X-Gm-Message-State: AOAM532l4vmazKpA63dvZircNk0SjK2Sz+EOpyAk27uogfX/ZUdwWRQg
        VYRol3mv1cKA70bHbCytVAWnvOBTdroz0UqvBCA=
X-Google-Smtp-Source: ABdhPJw56ri9MNP16arJtQ2hXlTRSLuoYkG6NheJyA1Rfnq1aCoOApZ777hQt9tF3KPBuL+usXneNw==
X-Received: by 2002:aa7:cd41:: with SMTP id v1mr5134868edw.393.1633193963321;
        Sat, 02 Oct 2021 09:59:23 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id j16sm4845144edw.23.2021.10.02.09.59.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Oct 2021 09:59:23 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id b8so12237308edk.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 09:59:23 -0700 (PDT)
X-Received: by 2002:a2e:3309:: with SMTP id d9mr4559712ljc.249.1633193585297;
 Sat, 02 Oct 2021 09:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210929185823.499268-1-alex.popov@linux.com> <d290202d-a72d-0821-9edf-efbecf6f6cef@linux.com>
 <20210929194924.GA880162@paulmck-ThinkPad-P17-Gen-1> <YVWAPXSzFNbHz6+U@alley>
 <CAHk-=widOm3FXMPXXK0cVaoFuy3jCk65=5VweLceQCuWdep=Hg@mail.gmail.com> <ba67ead7-f075-e7ad-3274-d9b2bc4c1f44@linux.com>
In-Reply-To: <ba67ead7-f075-e7ad-3274-d9b2bc4c1f44@linux.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 2 Oct 2021 09:52:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=whrLuVEC0x+XzYUNV2de5kM-k39GkJWwviQNuCdZ0nfKg@mail.gmail.com>
Message-ID: <CAHk-=whrLuVEC0x+XzYUNV2de5kM-k39GkJWwviQNuCdZ0nfKg@mail.gmail.com>
Subject: Re: [PATCH] Introduce the pkill_on_warn boot parameter
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Maciej Rozycki <macro@orcam.me.uk>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>, Wei Liu <wl@xen.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jann Horn <jannh@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will.deacon@arm.com>,
        David S Miller <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-hardening@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        notify@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 2, 2021 at 4:41 AM Alexander Popov <alex.popov@linux.com> wrote:
>
> And what do you think about the proposed pkill_on_warn?

Honestly, I don't see the point.

If you can reliably trigger the WARN_ON some way, you can probably
cause more problems by fooling some other process to trigger it.

And if it's unintentional, then what does the signal help?

So rather than a "rationale" that makes little sense, I'd like to hear
of an actual _use_ case. That's different. That's somebody actually
_using_ that pkill to good effect for some particular load.

That said, I don't much care in the end. But it sounds like a
pointless option to just introduce yet another behavior to something
that should never happen anyway, and where the actual
honest-to-goodness reason for WARN_ON() existing is already being
fulfilled (ie syzbot has been very effective at flushing things like
that out).

                   Linus
