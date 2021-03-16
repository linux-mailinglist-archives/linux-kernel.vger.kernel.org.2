Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0A533D129
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 10:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236365AbhCPJvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 05:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236345AbhCPJv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 05:51:27 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A6EC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 02:51:27 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id g185so34532489qkf.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 02:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8k+xZvb93ykF04wglRmys4Onz2hVDSpTVTELCwFU/E4=;
        b=uH7VfeXn2oSR7z9Mym0GtfmwmIVFjVMbSifB9/e27ZooWYMPuUjxpeaphpm8wI0rsK
         Efa1+kovpL3m9JcaiyMuzZiUkjU/bXKqY7nVmKX+0GyePIXOVDz6+kSCb60U6skgmsDQ
         H6lGPxQGoUQgv757uIKkuLtj4nAud2TqsCWZT+iPsxNyxRsyyTkI5xtMSKCvWH38AQA7
         VPPtRM4AUQvxHLSWZeKCMrBT4h4fBau/tkM4LCwhrCoeeXWV1rCMuWPAJtjAd52ZQ4O+
         ZmC7CwCzwDMIvc6L++gNmLtAh+CwJwmYJl4DvmeqZ4/2fX5hiP4I3hyJjyWQkdoq8IDx
         DONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8k+xZvb93ykF04wglRmys4Onz2hVDSpTVTELCwFU/E4=;
        b=srVfEr8rmSTf+tclODkvc36kcMvJgPqSKEkxnPEFu8x9VjJfPJCJlzL3v7CF8IHZYy
         i9Tv7R1w99tRlnz6e3HVl/Smy1dtnvypYAb/LLx0TXARyV9UtWPOO6OYmNYYb545NroR
         mcs+0trnUlq4FhrAjznuXPrTFTVUy7tj5v6AC5SBKtYgVBn0o/W3oidhy5MAeNijgIsl
         SHXTfgUb+78sB4PtVuPCnSnsUsZG/qEaQ1o1zkct387AGeFLhX2/J9wygb1S9J5RSxku
         BqIIaA57R2DPksMqypgnp63y6J8YBqJj21rmpXDTryS0zzDuUSl+cG647cvEexwJi404
         hOJg==
X-Gm-Message-State: AOAM531ImZyuLapcnDdAED/ZQdU0/SbrCquoV3Q7fsf5qnD+ED7MhgGx
        odtlOEntHKuEZ1CDu06L3Y5q/G3gediHg/bxzkvFJQ==
X-Google-Smtp-Source: ABdhPJwCdkQqW5wXTRhCxttbTRQQhBvbFkdnZeCYX+xek6fO36vLgOHSyU6WX9Bjmnsjf7Ye4TfPYj5E4NGxMeGZ38Y=
X-Received: by 2002:a37:a7cb:: with SMTP id q194mr5652450qke.350.1615888286360;
 Tue, 16 Mar 2021 02:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000069802205bda22b7f@google.com> <CACT4Y+Yaq-zDh5FAzHt4g-5jXrXC3rSLw6CM=kjcfR6oxJ1+CA@mail.gmail.com>
 <20210316092420.GN1463@shell.armlinux.org.uk>
In-Reply-To: <20210316092420.GN1463@shell.armlinux.org.uk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 16 Mar 2021 10:51:14 +0100
Message-ID: <CACT4Y+ZhQCU6g28jD5gVxu=2h-Zd+uE6Ski2-sYmd_HrjLioyg@mail.gmail.com>
Subject: Re: [syzbot] kernel panic: corrupted stack end in openat
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     syzbot <syzbot+0b06ef9b44d00d600183@syzkaller.appspotmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 10:24 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Tue, Mar 16, 2021 at 08:59:17AM +0100, Dmitry Vyukov wrote:
> > On Tue, Mar 16, 2021 at 8:18 AM syzbot
> > <syzbot+0b06ef9b44d00d600183@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    1e28eed1 Linux 5.12-rc3
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=167535e6d00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=e0cee1f53de33ca3
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=0b06ef9b44d00d600183
> > > userspace arch: arm
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+0b06ef9b44d00d600183@syzkaller.appspotmail.com
> >
> > +arm32 maintainer
> > I think this is a real stack overflow on arm32, the stack is indeed deep.
>
> There's no way to know for sure because there's no indication of the
> stack pointer in this, so we don't know how much space remains.
> Therefore we don't know whether this is something in the dumped
> path, or an interrupt causing it.

Agree, to know for sure we would need support for VMAP_STACK.
But do we really need to know it? If it's an interrupt on top, it does
not make any difference?
