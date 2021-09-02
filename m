Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 543DA3FF0B1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 18:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbhIBQG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 12:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhIBQGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 12:06:23 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE310C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 09:05:24 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id h1so4498329ljl.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 09:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F57f7dVpJfotG0ZNhC9Jf0r1S23wHXlht59pY76lP5Q=;
        b=dn11zXMq7ooJ/wfmhg8E+OLuNJ5QEsMU7P/mm3M/yU8U6EmtmkLHvwPSHOyZJBA/tq
         lzIg5qITAnC5ZlDTbPdqkUYQuPljtkB27eKVU7OqT/rTtxnTf46Q1mq0ts0hPKpZ9TW+
         mlG98gvUPhvCnaKD3f02Jt+wVXhVi3Xzt8kek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F57f7dVpJfotG0ZNhC9Jf0r1S23wHXlht59pY76lP5Q=;
        b=jfw6wvQjNW3KhwPjoRiSpf2g1EZGrj3UfB7ntYtPFGN/odG2KDeJPWRtesxpBjJ+uS
         8ZPMr4CE5zolyzbk9THXc6QxNLuu7QpPl4tA6EowdO+nnouBmd+wETu9qunzydN67fHD
         m+wkz1ibkLtwsc7IYN2JRaVcHwUQB9+8TbncmGlZlJ+lNP6eRb31my4wU+KVfkTrAKfi
         dbFUEqQD1OmzRqurjKMzbBvUKxIRbI1KdgXIIKlitfh087Vr2HRuRPZfXE/HX79S2rpn
         Kz0q+LKRvyBsgwKtFRuKacdEbuWfCD4GWUQsxaUtRI0cb/bWMK+Kw8osnMHvEqPEJneQ
         V5bQ==
X-Gm-Message-State: AOAM532r4Y8fz9mFC2EcD1fNXawMbc+jFPDUaXPXj5DxTkzYAal5WG7N
        EBZl5zLoPpcmQfgYV0OtKRgNiQkWRKOOzC1e
X-Google-Smtp-Source: ABdhPJyKyBFFVD5Rf46M8CcfGe8BeIpAioZf5k6MqfGxJ2q/PjoK+PCQumsV9rCxFIpNwKkALBv12w==
X-Received: by 2002:a2e:9805:: with SMTP id a5mr3213554ljj.155.1630598722182;
        Thu, 02 Sep 2021 09:05:22 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id i21sm238156lfc.92.2021.09.02.09.05.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 09:05:21 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id s10so5371006lfr.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 09:05:21 -0700 (PDT)
X-Received: by 2002:a05:6512:230b:: with SMTP id o11mr2990046lfu.377.1630598720898;
 Thu, 02 Sep 2021 09:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <fd7938d94008711d441551c06b25a033669a0618.1629732940.git.christophe.leroy@csgroup.eu>
 <a94be61f008ab29c231b805e1a97e9dab35cb0cc.1629732940.git.christophe.leroy@csgroup.eu>
 <YTB1F7o15FrxmmP1@infradead.org>
In-Reply-To: <YTB1F7o15FrxmmP1@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Sep 2021 09:05:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjUN=Eu_FqY8sSU3yT+NUD+khQwhaD8FvfvgbhDYE-mqw@mail.gmail.com>
Message-ID: <CAHk-=wjUN=Eu_FqY8sSU3yT+NUD+khQwhaD8FvfvgbhDYE-mqw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] signal: Add unsafe_copy_siginfo_to_user()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 1, 2021 at 11:55 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> I'm a little worried about all these unsafe helper in powerpc and the
> ever increasing scope of the unsafe sections.  Can you at least at
> powerpc support to objtool to verify them?  objtool verifications has
> helped to find quite a few bugs in unsafe sections on x86.

.. yeah, objdump was particularly useful for the really subtle ones
where there are random function calls due to things like KASAN etc.

No human would ever have noticed "oh, we're walking the kernel stack
with user mode accesses enabled because the compiler inserted magical
debug code here". Objdump sees those things - assuming you teach it
about that special user space access enable/disable sequence.

            Linus
