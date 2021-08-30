Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8720F3FBAF2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 19:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238044AbhH3R2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 13:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbhH3R2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 13:28:51 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49186C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 10:27:57 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id j4so32727034lfg.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 10:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d5bnBdYfK8MREsdQ2ulPLtMZ7uZ5lPMgodPXfNRRTrY=;
        b=sVPP9eZBx+GLi2Ud3Dmd0T5Ee6ZUA8XOsanKSCCBp4laDJ0qalOCc2MlaEcf+TAaS+
         Xci3FDlJ58w8KdFsQedMH40QB056SizVkwBm1jPeq/UHbRYcIZFKZ8uGF139Tl4IWBtP
         z1mIqudvNvQsloBGfwfrQrn+QpaWs00T8br0O2ZCHW9gtJzd1q0k7KkvpscfwEFg4m4h
         /6i00rHCrNyWvNYh9NczrUWgPS8t3UOohlBI0aavjGjCdYeNfvt2fPKqIO0X2td0iCRS
         c2BqOrKsivcTV6NNkP3Bs85szaZXFqCLAq6eWn8Wb/j6Q/tVl0vGIvZ4Jzhu9yz7niaX
         +8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d5bnBdYfK8MREsdQ2ulPLtMZ7uZ5lPMgodPXfNRRTrY=;
        b=Y57T2d4T8XU/D8Msxk7GXBuBvg9ZrOivcJcP1eFaZrfEDrNR9nlt5JT8QeYunPWuZs
         2xgUgbsjekhQ5JyCmj+T6vM2oFP/ciLOMbwCqIzBKNivpe+XrfqmA34np7cK0uHmt2WM
         LlUoPnG+DgELxDDYC4PFlwrPa1neKt1LMx4Rl0gyKpnR+g+IiPM2BgxXOozOCcz80WSX
         K3TbeHXeW07lTP/5LcLehk0fDXfO4HLg3sJiqjR++5CGUUq6OShcGgQz/T1PrnepokpG
         SD1CBLNS+bxQYiSOezMHv2t6qUda7MSE6B/A47o5RvhSMmBp3Y7Y73JdyuZsc1ywMxgD
         /qvQ==
X-Gm-Message-State: AOAM531uVGx57DnYa/k0uoS01gceBEdu3IwbUFfXblRLB9s73DshUoVk
        AJGURKYBupZzJsGMEaSaPQX96FnPzztVhS+7gFM=
X-Google-Smtp-Source: ABdhPJwf0g2OZ7nDm0+I1Aa9jrPZsxH7AMSUcGIVCyJH5WFvCc49EYJ6RYuPBN97ASiAJ3Tg9HSYwufvfqD+qMUYVG0=
X-Received: by 2002:a05:6512:a85:: with SMTP id m5mr10289356lfu.610.1630344474760;
 Mon, 30 Aug 2021 10:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210825185747.1627497-1-daeho43@gmail.com> <1f1e6d38-6bd1-17ea-b8ca-a45d1244728f@kernel.org>
 <CACOAw_yhgo1_wrejKskSm=Rsw27ogx=TS_A=z=-NGLcecA-gYA@mail.gmail.com> <335d5bb5-7055-c934-33df-a03885382034@kernel.org>
In-Reply-To: <335d5bb5-7055-c934-33df-a03885382034@kernel.org>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Mon, 30 Aug 2021 10:27:43 -0700
Message-ID: <CACOAw_wbK8qZ7kNxNXkyZqAdb9XJ7EqC2_GxnkzUDBr1oSwxkA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: introduce fragment allocation mode
 mount option
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 5:43 PM Chao Yu <chao@kernel.org> wrote:
>
> On 2021/8/27 23:22, Daeho Jeong wrote:
> >> I'd like to add a fixed chunk/hole fragmentation mode in addition, then
> >> userspace can control the fragmented chunk/hole with fixed size.
> >>
> >> How do you think of renaming "fragment:block" to "fragment:rand_block", and
> >> then I can add "fragment:fixed_block" option and its logic in addition?
> >>
> >
> > The reason I added the randomness on these values is the segment
> > selection in SSR mode.
> > If all the segments have the same free block counts, f2fs will
> > allocate a new segment sequentially in SSR.
>
> I'm fine with this, since test program can customize different fragment
> degree on segments by setting different chunk/hole size.
>

Got it. Sounds good~

> > This was what I didn't want. Plus, in the real world, the size of hole
> > and chunk will be different in different segments.
> >
> > But, if you think we need this "fragment:fixed_block" mode, I am happy
> > to have it. :)
>
> Thanks a lot. :)
>
> As you said it needs to be aligned to real world fragmentation, I notice that:
> with this way, we can't simulate similar fragment in FTL, due to its page
> mapping architecture, all fragmented data/node in filesystem will be written
> sequentially into its blocks.
>
> In order to simulate fragment in FTL, we need to:
> - write data (chunk size) with dummy pages (hole size) to devices
> - issue discards on those holes
>
> I guess fragmenting device (erase blocks) at the same time wouldn't be
> original intention of this patch, right?
>
> Thanks,
>

Yes, I just meant filesystem fragmentation as I wrote in the comment.

> >
> >> Do we need to consider multiple thread scenario? in such case,
> >> .fragment_remained_chunk may update randomly.
> >>
> >> In addition, multiple log headers share one .fragment_remained_chunk,
> >> it may cause unexpected result, it means there may be continuous holes
> >> or chunks in locality due to swithing between different log headers.
> >>
> >> Thanks,
> >>
> >
> > Oh, I overlooked that point. I am going to add the variable for each
> > segment as you said before.
> >
> > Thanks,
> >
