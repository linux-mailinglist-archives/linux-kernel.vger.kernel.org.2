Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3CDF3FB34F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 11:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbhH3Jkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 05:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235535AbhH3Jkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 05:40:51 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68446C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 02:39:58 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id z24-20020a17090acb1800b0018e87a24300so9592868pjt.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 02:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4K4KPnfZ/gCT08w+pd2wyU6nZ/Ehph2hJiXGD3bxjk8=;
        b=qFQBDsk+Yx+uPHySteLUjP+jkfIPEKgkQHT8AKTu2SH9WNTmYmR+pu1u3ux7FiNzEg
         IDpX3N5qIOsPBsPrZivEvdlLqfsDUn2i+eQGWPBDqjmQusTF6O501w/yVM3MsSXfxGwx
         Q3h9Kvr50KTSWLYbRH97Q47d4hT+sdkFjPTN15KzkrDk6pNXtmGV/NpVIGpBcjvCThg/
         rjWjvWSQWmfQT71dJFNJExwJd2g4vruB0LVttaGMnbWm7pIDyvuGYnbdBqVNP0uEk14F
         QD3ZcAWbRO2CCGEiTn68cdI555EIIBTEa4mX7ft3dZ3IIYKrVyN/bgSaOmZ4jO7tiRK5
         j9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4K4KPnfZ/gCT08w+pd2wyU6nZ/Ehph2hJiXGD3bxjk8=;
        b=AY4GmZqZFWPTkHfGuXmJqfXagl65aHbR0rDVaNPr8RR7EpGmy/z5RxTvVcD8OWCrnr
         Vk1ZlIDqYrRwgXSxDwsuGzjF0MVan7GdHC1oM/pSQ+sZyTWKrtJTGWkMvLKvr9UP8M9t
         Fe1u/21mlOZBfWo+w9DN79U/5SUmSuw6UMQ8VfWpLc20GJJa9nGNC02Q7IN138+4635L
         liUUZnJhMBICiQFFXRry/WOO5qjhGOGVB0kFgx88VUT65EdQ+juddrPg7toxInBWgnwg
         wLSrJUWf6Ko04X9hAw3ZKm4IHpXFq6snDQVXa4jqEFRc8tNbVLJVWSRYvvR5w60sJZE9
         eUUg==
X-Gm-Message-State: AOAM5327EM1S4WeEvswrv+wNlQKTMaDarYpmu3RZCt42N45zjEVsrVT1
        0k9XDClAXeExwSGwWnWQ2nSDTHdaHlLHwl8mlvIUTxCzoRlgNA==
X-Google-Smtp-Source: ABdhPJyiioKfz5Ldnn6xbXRYbNpFqqno8UKdcEgxONbu0vSQzrY9camlbnF2MaPmQB+nxWTkL8x3QUFAqLhQSgPTd6s=
X-Received: by 2002:a17:902:a407:b0:138:849b:56f6 with SMTP id
 p7-20020a170902a40700b00138849b56f6mr19467150plq.0.1630316397893; Mon, 30 Aug
 2021 02:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wh75ELUu99yPkPNt+R166CK=-M4eoV+F62tW3TVgB7=4g@mail.gmail.com>
In-Reply-To: <CAHk-=wh75ELUu99yPkPNt+R166CK=-M4eoV+F62tW3TVgB7=4g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 30 Aug 2021 12:39:21 +0300
Message-ID: <CAHp75Ve_zQctbiOkJbeL6T=5FOukGbL99kcgpLdL3Zf8DfFdDA@mail.gmail.com>
Subject: Re: Linux 5.14
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 1:20 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I realize you must all still be busy with all the galas and fancy
> balls and all the other 30th anniversary events, but at some point you
> must be getting tired of the constant glitz, the fireworks, and the
> champagne. That ball gown or tailcoat isn't the most comfortable
> thing, either. The celebrations will go on for a few more weeks yet,
> but you all may just need a breather from them.
>
> And when that happens, I have just the thing for you - a new kernel
> release to test and enjoy. Because 5.14 is out there, just waiting for
> you to kick the tires and remind yourself what all the festivities are
> about.
>
> Of course, the poor tireless kernel maintainers won't have time for
> the festivities, because for them, this just means that the merge
> window will start tomorrow. We have another 30 years to look forward
> to, after all. But for the rest of you, take a breather, build a
> kernel, test it out, and then you can go back to the seemingly endless
> party that I'm sure you just crawled out of.

Haven't investigated so far, but all 32-bit builds for x86 on Debian unstable
gcc (Debian 10.2.1-6) 10.2.1 20210110
fail for me with
FATAL: modpost: section header offset=11258999068426292 in file
'vmlinux.o' is bigger than filesize=509598908

(hex value is 28000000000034)

Replacing
#if KERNEL_ELFCLASS == ELFCLASS32
with
#if 1

in scripts/mod/modpost.h fixes it to me.

As said, I haven't done any work to find the root cause, so JFYI.

P.S. Yes, I did a completely clean build and tried different kernel
configurations including just default i386_defconfig in the release,
the same error. x86_64 builds are good.

-- 
With Best Regards,
Andy Shevchenko
