Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36D23FAAEC
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 12:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbhH2Kf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 06:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233920AbhH2KfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 06:35:25 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DFDC061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 03:34:33 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id k24so8208967vsg.9
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 03:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cFa0z+8tZXoXVohz3bA4teT10uueXUcgoj4/QykJ7Dg=;
        b=tDNKhmtz2UihxgLgra36E4OtwVK/2Cvka4Oa5mN0sWEWxmm9ebnp/P0NXMk/STNL4t
         +ZOi/VjH0zYVxeqPUM2mK/1pxs4VHMhfndGq5oGlOEgcVJ9yo3X46mP6GYyKMQcWDxGV
         Db7/S7aIA9rQygT+jrUN+guBju81SB1PagRRPVlBq8bhw/KajEE/rEL7I0nVaYRYiJhz
         QaDquBKKsiJhwJQ+jPrBdeiLH0zpJ+Em7xS7alDrgZircHIBxeN9Fr/+7CMhnJzIaEFj
         TvLBo/Og/mTUMFrTfkVScvlWvJGqWbfuBJXBGnkbLIxj2gc9VXp6Cwjec33vknYBArXL
         mBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cFa0z+8tZXoXVohz3bA4teT10uueXUcgoj4/QykJ7Dg=;
        b=XEzAiFZcOVZ39E1DrAGZWSkk3dO5+SR6VW6fnVLzqOowxwdx8htB8lNhXgV0erMhMl
         z1dIBbvkaN5sZHeDznmLCKiOKpWQbsY+VqmYk5VTf8w4D95LFgVtmbUO86igEOdmYJiO
         B9o01A+7zfGZyVGqFeR8WuVYxP04YHXG38U0oMrJRQ+HZXfJrDcevnZnQ1gjeAl6vrRo
         PC+DxzGas2UMc9WiGRZUR2whx4n5Ttt5po9r7CpebVSmLAfZVM+PPVmRm+wyQ1/oYCYn
         37MPQAJDfbfMLLxtIuWtxWayusD8pYfWxTEdizVr+ltn+LHJCBsMun5dc+kjpLmSL7iB
         MzTA==
X-Gm-Message-State: AOAM53350AaEbZkNS1Hw7mT2mPNjm4IL+SEtj5+PuDo6mL5x9FRsz/QE
        xZTo6gm0LPxnKCWmWGyYrLV5himaRB1EqV/og4Q=
X-Google-Smtp-Source: ABdhPJxN5aAtGPJwEYD4lKYZYHWpnZJmavNjywQk8+4g9ErEDknneIFfLOQWbhvOtpyPvcO0FkINqhcQ7dDvYOQM9wI=
X-Received: by 2002:a67:f510:: with SMTP id u16mr12392210vsn.60.1630233272549;
 Sun, 29 Aug 2021 03:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210825061152.3396398-1-chenhuacai@loongson.cn>
 <20210825061152.3396398-9-chenhuacai@loongson.cn> <87pmu1q5ms.wl-maz@kernel.org>
 <CAAhV-H5yadRbTt9a-i-65Mvd6mBxm58R_+mWLfJrauuAe3+qyg@mail.gmail.com>
 <87v93pddzu.wl-maz@kernel.org> <CAAhV-H41rridOo_3Eq5t9LPz-mefketAKNdhgbguFtZ0Cqz5Ng@mail.gmail.com>
 <87tuj8d0ie.wl-maz@kernel.org>
In-Reply-To: <87tuj8d0ie.wl-maz@kernel.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sun, 29 Aug 2021 18:34:21 +0800
Message-ID: <CAAhV-H5cf0N5RAQTRN9MqO-=bsf7YNMCvqVLtwOTpXJ7zaFU=Q@mail.gmail.com>
Subject: Re: [PATCH V3 08/10] irqchip: Add LoongArch CPU interrupt controller support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marc,

On Sun, Aug 29, 2021 at 6:10 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Sun, 29 Aug 2021 10:37:48 +0100,
> Huacai Chen <chenhuacai@gmail.com> wrote:
>
> > > Are you saying that there is no way for the interrupt controller
> > > driver to figure out the hwirq number on its own?  That would seem
> > > pretty odd (even the MIPS GIC has that). Worse case, you can provide
> > > an arch-specific helper that exposes the current hwirq based on the
> > > vector that triggered.
> > We can get the hwirq number by reading CSR.ESTAT register, but in this
> > way "vectored interrupts" is meaningless.
>
> Let's face it, the way you use vectored interrupts makes zero sense
> already. The whole point of vectored interrupts is that the CPU can
> branch to the handler directly, making the interrupt handling cheaper
> as there should be no additional decoding and you can run the final
> handler immediately. Here, all your interrupts point to the same
> "default handler"...
The default handler can be overridden by arch code.

Huacai
>
> What do vectored interrupts bring? "Absolutely Nothing! (say it again!)"
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
