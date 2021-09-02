Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCCF3FE65C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 02:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243101AbhIBAQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 20:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243065AbhIBAQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 20:16:16 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFA5C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 17:15:18 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id l6so124691edb.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 17:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xhEOkWP33yhFB7NNvk81879Ir5dlLowUoKbhLb4yxxI=;
        b=NyyrAAWpHnMGaaDnOCyuyHd3fhM+X+9xBLDIGnis0cKuJpKW+KT1WR48NcbkpPaCvM
         8d0geCI4gkpschCP5E1gkvgXwzCHXeGNIUrUqY5wM+PVnsXFnK4WMQ85S9iGIHksggyb
         EQPn+5Gu7U+O3tA4GzMQW4BFyG5eBXr4iICM4TmML1jVRIxL0ZkzoCst+4dF21zayx4w
         Lv/kEXhYY6wRa8B8FlIT8RZ1QdT/zEEIv94jnRkTSLQf82FfHZHLGL2pFzMHDOKzwNra
         /p6XuljmCisnCopPPSE6I+A89nnv0sBv4B4VaCZLBPH+tSBd/xrckyso1rLdYp73MGsa
         Vycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xhEOkWP33yhFB7NNvk81879Ir5dlLowUoKbhLb4yxxI=;
        b=SbMGRstu27ZoaVSCEAmrcxCGzpG1QHx6ImJN28cSDWBQff/T1GHBg6Xp++sIZeFRIx
         asB0f/eGwrtVVA+d06s2yx+3uRjaTUnFredljTIyy8yldjz5S0yNpdtfDQpE5Qn3jYz/
         ZXMilxKUwZT0yYT5u90IF8i8xajx5xgO5jxCgek95UfyJ9wuBLpN8egDQ6GSxvp8dsxt
         YBAHil8/xeh3sdSLAFhlfKzCTd82/q+xWxok2EHdA62+W4a5+b6t7Ikmc1hw0kwboH3l
         YU1cPWVSfv8kgrF0L2++ULn7bk49jS+wYp7SmrVKLxxl2ion3ByyFpArcu+ENS6fBPss
         uyPg==
X-Gm-Message-State: AOAM530qONGD3GjUHyeZ8XlXQB4u1EIzqOy5+IwSKk6U9J30txJORsU3
        Td7TYihj6B0dRrzBCXFu5CEAUFOsYsrgIYnx1mc=
X-Google-Smtp-Source: ABdhPJyqhMtFYPXxzpWKxfuC+dwe6cwFLrsa90k/sBIiER97yphsd7E/7cKZpT+1VBK6cse9Kw2Z8MLOcBlgFjf4BJY=
X-Received: by 2002:a50:c043:: with SMTP id u3mr576707edd.207.1630541717411;
 Wed, 01 Sep 2021 17:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <a2f423cf-9413-6bc8-e4d8-92374fc0449e@amperemail.onmicrosoft.com>
 <YS7yjcqA6txFHd99@casper.infradead.org> <YS+AhXJGsniaHTS4@hsj>
 <YS+NXmDO0yqDEBmD@hsj> <YTATir09urAUTSI+@casper.infradead.org>
In-Reply-To: <YTATir09urAUTSI+@casper.infradead.org>
From:   Barry Song <21cnbao@gmail.com>
Date:   Thu, 2 Sep 2021 12:15:06 +1200
Message-ID: <CAGsJ_4ySjL9SWaquP4BoWROZ=qPFgyTKnPWuSP_LD08RZB7uzg@mail.gmail.com>
Subject: Re: Is it possible to implement the per-node page cache for programs/libraries?
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Huang Shijie <shijie@os.amperecomputing.com>,
        Shijie Huang <shijie@amperemail.onmicrosoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Frank Wang <zwang@amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 2, 2021 at 12:00 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Sep 01, 2021 at 02:25:34PM +0000, Huang Shijie wrote:
> > On Wed, Sep 01, 2021 at 01:30:45PM +0000, Huang Shijie wrote:
> > > On Wed, Sep 01, 2021 at 04:25:01AM +0100, Matthew Wilcox wrote:
> > > > On Wed, Sep 01, 2021 at 11:07:41AM +0800, Shijie Huang wrote:
> > > > >     In the NUMA, we only have one page cache for each file. For the
> > > > > program/shared libraries, the
> > > > > remote-access delays longer then the  local-access.
> > > > >
> > > > > So, is it possible to implement the per-node page cache for
> > > > > programs/libraries?
> > > >
> > > > At this point, we have no way to support text replication within a
> > > > process.  So what you're suggesting (if implemented) would work for
> > >
> > > I created a glibc patch which can do the text replication within a process.
> > The "text replication" means the shared libraries, not program itself.
>
> Thinking about it some more, if you're ok with it only being shared
> libraries, you can do this:
>
> for i in `seq 0 3`; do \
>         cp --reflink=always /lib/x86_64-linux-gnu/libc.so.6 \
>                 /lib/x86_64-linux-gnu/libc.so.6.numa$i; \
> done
>
> Reflinked files don't share page cache, so you can do this all in
> userspace with no kernel changes.

Not quite sure I catch your point. In case we are running mysql on a
machine with 128 cores
(4numa, 32cores in each numa), how will the reflink help the only
mysql process to leverage
its local libc copy?

Thanks
Barry
