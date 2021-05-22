Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD4138D507
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 12:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhEVKKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 06:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhEVKKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 06:10:49 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E989DC06138A;
        Sat, 22 May 2021 03:09:23 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id z4so10050432plg.8;
        Sat, 22 May 2021 03:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vXo9PEU8VQaNYnelzoUWGPAVtoFV8TMWgCwmCtjZOHs=;
        b=BQEteZBp77wgAJklXkz28+IH6mdjZI/DnO5JE3iRv4YweTs70qgO7IGcDuIURpmon0
         RkEehoFSVs6N116h/MqJm5crRUrDADg5jzRVz6JNKAWoauNjwDTmoilWapDaTf5dA3s9
         OSRCoU6SrknwNQ0Y8HJB0TqNRfeuGY3tmmiYewqhlL8rfmpznwFFNlZQhgBxDUDJsrjF
         HHTQnY5lxotBEYhAaDdmH1a0uD2qJFZlQXx+aTJlUEDOkl9w4t9X5b58bu2wicQ5Psx7
         D//BbWenSXQMq850/jca+VDtAhmhAPrDc4v90S9CpTM5iXKF3kxlOcU0B0GIW56Of7mB
         IHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vXo9PEU8VQaNYnelzoUWGPAVtoFV8TMWgCwmCtjZOHs=;
        b=g2m7v2svFrWn1xVwv/t1Kp5z/ndUr/PexI96dF5+BbtZfKWNjfSlLXDUfpBaUOEHGB
         u3VmB0jujtAlY3tf3/ThSp+UdTuLJKfBFXCW1kpvjsuVngeI54FOw3LyhrU+7CU7EAWN
         nCjrld02gr3TPtImV13nrGaR9WHedKhTv+/8ooPOVlg5yXbioUxRn2MlH5vXRS+/V95F
         rrNvPrHNVmwKHIfES/hIbtpXwJzZSVuawG71WZeUZLSuzYi/M3YjfKbHs3cJsj3Sx1hm
         cijMu4KpX/5VOknm9hSMEvzs7N5Z+Nlx5QS4m6o/RFJV4RvSNL4pSEZblgDXcykXcts6
         TywA==
X-Gm-Message-State: AOAM530dYcro5cB2X2AlQOhyWPIh/iG51DLnb4JgCoX5EGDaToBpzZwn
        73ZRUvlz9QOUDDFIEdJYC4pYTFBES8dJ88NJIgs=
X-Google-Smtp-Source: ABdhPJxD9utDaa75zm2vpfWCKuvLj5xAvfW2DZrl3Dpl+cMKklM+mhEhIGMi9SqWg8jcaSLHPzob/k6a6a+6fJ8aOHc=
X-Received: by 2002:a17:90b:1091:: with SMTP id gj17mr13891307pjb.129.1621678162995;
 Sat, 22 May 2021 03:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1621665058.git.christophe.jaillet@wanadoo.fr>
 <9212cdc8c1e5c187a2f1129a6190085c2a10d28a.1621665058.git.christophe.jaillet@wanadoo.fr>
 <CAHp75VdhgEEeOoJZNXu9RMR0QppDv7HZ-_Lmy4PC=ptXHaz_Lw@mail.gmail.com>
In-Reply-To: <CAHp75VdhgEEeOoJZNXu9RMR0QppDv7HZ-_Lmy4PC=ptXHaz_Lw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 22 May 2021 13:09:06 +0300
Message-ID: <CAHp75Vct5cHgSDU4oQ8ScEoKviiZZgYCKN62AEy0MS=V4oGTiQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] misc/pvpanic: Make 'pvpanic_probe()' resource managed
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        pizhenwei@bytedance.com, Paolo Bonzini <pbonzini@redhat.com>,
        bobo.shaobowang@huawei.com, linqiheng@huawei.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22, 2021 at 1:06 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sat, May 22, 2021 at 9:56 AM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:

Hmm... Couple of (minor) comments though.

> > Simplify code and turn 'pvpanic_probe()' into a managed resource version.
> > This simplify callers that don't need to do some clean-up on error in the

simplifies
errors

> > probe and on remove.
> >
> > Update pvpanic-mmio.c and pvpanic-pci.c accordingly.
> >
> > 'pvpanic_remove()' don't need to be exported anymore.
>
> LGTM, thanks!
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> > +static void pvpanic_remove(void *param)
> >  {
> >         struct pvpanic_instance *pi_cur, *pi_next;
> > +       struct pvpanic_instance *pi = param;

> >         if (!pi)
> >                 return;

Looking at this I'm wondering why it's not a dead code.

-- 
With Best Regards,
Andy Shevchenko
