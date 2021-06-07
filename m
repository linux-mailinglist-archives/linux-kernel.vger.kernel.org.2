Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C21139D6DC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 10:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhFGIRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 04:17:33 -0400
Received: from mail-ua1-f42.google.com ([209.85.222.42]:40897 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhFGIRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 04:17:31 -0400
Received: by mail-ua1-f42.google.com with SMTP id e12so6560593ual.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 01:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ltpVj0TZnSAm7Nm7Sf6ejq98h2Pbq2EQteDLv/+/C2c=;
        b=TYOLNeDx7B/WnpnxeD7C+Abu0z9Bh5qWBntpME3bKKaGvHWJkDRfOoFEehudkqLwmV
         noEzg2yNEqsDqqIAuDjzF5CHOday4KXPHwzUQApB94RkYliczrgDjMN1AqwpPnT3ORzB
         7E6HmTa+PCeLmcVt94XKrZ6ofkgYt1Qo4ZanXunPTqqrjrPfrzUHYYyYh9/AvBHCwB6F
         soTe/veNcfKGrzn2chpZpNc5/QSjP90cHFQNjdnoS/62a1AB8MxymE+14bIlSNPFHZ6i
         2yd91xcTDSrL/cYmQBkiyEXQbeajSglIwO/vPVIBbg6KROC5Ja/m/BkLkVc05Pzv3vKl
         NjIQ==
X-Gm-Message-State: AOAM533zhVeUnGqgE+g2pmRb3cq4c1QXgo8mu1K1QtcCG0Rlb08j8ElD
        MykSxki6aP0uUQVrwqcKelD59O0qTIVPd3qB/Mc=
X-Google-Smtp-Source: ABdhPJykJXTpBMRc+s8xp9NUTmOJPCoQNvL5RWXka8MUoLUVSI4QaQfhXcthL2Kgw76oV5hrUTHO31CogIfY+c7gxg8=
X-Received: by 2002:ab0:b09:: with SMTP id b9mr3624984uak.58.1623053727004;
 Mon, 07 Jun 2021 01:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210428063203.691-1-thunder.leizhen@huawei.com>
 <CAMuHMdWX7rC2zswHoo6aFf3CYp3NKAfJ7E0x4W2wbVkybGa84g@mail.gmail.com> <d8d98365-98f6-d0a4-233e-279172004f51@huawei.com>
In-Reply-To: <d8d98365-98f6-d0a4-233e-279172004f51@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Jun 2021 10:15:15 +0200
Message-ID: <CAMuHMdWeJkDvhf-J-S4dLqKmSvqnkf+AcWdjyPNu-G8zu2jOkA@mail.gmail.com>
Subject: Re: [PATCH 1/1] lib: devres: Add error information printing for __devm_ioremap_resource()
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leizhen,

On Mon, Jun 7, 2021 at 9:11 AM Leizhen (ThunderTown)
<thunder.leizhen@huawei.com> wrote:
> On 2021/5/17 15:04, Geert Uytterhoeven wrote:
> > On Wed, Apr 28, 2021 at 8:33 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
> >> Ensure that all error handling branches print error information. In this
> >> way, when this function fails, the upper-layer functions can directly
> >> return an error code without missing debugging information. Otherwise,
> >> the error message will be printed redundantly or missing.
> >>
> >> Fixes: 35bd8c07db2c ("devres: keep both device name and resource name in pretty name")
> >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >
> > Thanks for your patch, which is now commit 5c3e241f5246445d ("lib:
> > devres: Add error information printing for __devm_ioremap_resource()")
> > in driver-core-next.
> >
> >> --- a/lib/devres.c
> >> +++ b/lib/devres.c
> >> @@ -157,8 +157,10 @@ __devm_ioremap_resource(struct device *dev, const struct resource *res,
> >>                                              dev_name(dev), res->name);
> >>         else
> >>                 pretty_name = devm_kstrdup(dev, dev_name(dev), GFP_KERNEL);
> >> -       if (!pretty_name)
> >> +       if (!pretty_name) {
> >> +               dev_err(dev, "can't generate pretty name for resource %pR\n", res);
> >
> > If the above fails, it is due to a memory allocation failure, and the
> > memory allocation core will have already printed an error message.
> > So there is no need to print a second message.
> > Hence IMHO this commit should be reverted.
>
> If the memory allocation fails, only the 'size' is printed, but the start address of
> the 'res' is not printed. So the printing here is not repeated. The start address is
> the more critical help information.

Does that actually matter?
What can the user or developer do to fix this problem, with the
additional knowledge of the resource's start address?

> >>                 return IOMEM_ERR_PTR(-ENOMEM);
> >> +       }
> >>
> >>         if (!devm_request_mem_region(dev, res->start, size, pretty_name)) {
> >>                 dev_err(dev, "can't request region for resource %pR\n", res);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
