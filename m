Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B451245AF14
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 23:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhKWWdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 17:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhKWWdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 17:33:49 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A036AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 14:30:40 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id f186so1603447ybg.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 14:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9LZSLFw1Wl8AbiBfHIocSEqkLLyf3Er+KsJ4COxHFyg=;
        b=BzfXvyuslPAW/Io/nY2641n3Wxf/om+wr0w3/vtl/jsIu10/PkWYGDx0S+8T9sHdsQ
         vMs+r4tLwDXtIjRAx9bpXyJdpG7e4WeOYigeSR8iWUwiSEsxeOiiJ6Z3ljoYqyKueSqi
         7Yt6lUlUQeN9mfcdk6D2y2jzVyTdsrwBQWYcVLYjyFksDIr+MKXXSI7yw2PsJYe1OfzB
         fB4YxINuG6CNAHMhrVUZua4MW36/EHiFTrxlFtiw7i2JnxBY3cSJSVaQWNhaeFW/Qv2w
         LyJQ2fyfKJUcpAqU24MO/h2lr/e1jWwLpWJJwuJ+fnYUl2uGHfdBuAakxRcJbxEywKWz
         Gu2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9LZSLFw1Wl8AbiBfHIocSEqkLLyf3Er+KsJ4COxHFyg=;
        b=rrH8yPjct/9C6sDLDgaS5Len1jABqFSOMiRExOnPU0pdW5PgQku6VVK7k+iwXhyxE4
         lCEy9Q1CoA0WNc2SV6nn7aPQj3gPDDZ5qu4D2EZcQLVWTWQKhfxbtMQyHBTPG4qU9gi/
         dVzQIs1YLLz+oiuEXgdHR57c2jcl7sERuo/7BGL/fVA9sdXpKhZO/PoOZvZjW2shQKW+
         I/3GOpt4DTZuz2u0UmXg8m4cANIeMd6oncvHtdE5+zafGux/oaKudlTn0+nBL72MjH+t
         ssNZ3YrJf4blxmoNRipymr3kZSR2YLxSac2IlR6GfzO+vKdHEVuLu5rFp3E0gKuVWsJf
         SNfw==
X-Gm-Message-State: AOAM5300mpPohfE+xbs+99cd8xZrPXeh2p8hVSfVcP6ab6ghQhXAjVHi
        MJVvZxSXyIZdza3XqjS9ztJUIpmOJlNNM3ASa5pEhw==
X-Google-Smtp-Source: ABdhPJw8Qqgjgr2zjnN8FdggfNLonPT3TvIGolsrYfbjW1x6XDMjll4z7qPLYkBgmYRVPQ9CNjLfWQAg35q0yY2dE94=
X-Received: by 2002:a25:a429:: with SMTP id f38mr10182603ybi.34.1637706639550;
 Tue, 23 Nov 2021 14:30:39 -0800 (PST)
MIME-Version: 1.0
References: <20211123162635.29c8bccb@canb.auug.org.au> <CAJuCfpEvDOsNGcN9cqStx3PpoG_pJgQevvc+V6gcRrCUBa0YWA@mail.gmail.com>
 <CAJuCfpF6gyCNzkaq5QnthhV886ueFhkAJv4sJ6rtW+8Z-t0qmA@mail.gmail.com> <20211124092613.4a7d370a@canb.auug.org.au>
In-Reply-To: <20211124092613.4a7d370a@canb.auug.org.au>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 23 Nov 2021 14:30:28 -0800
Message-ID: <CAJuCfpEhPD6T1S1t_wBh7dWN35rNdTH+mtpb5_tPGd-8h30vfg@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the akpm-current tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 2:26 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Suren,
>
> On Tue, 23 Nov 2021 11:03:47 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > I just posted a fix for the warning at
> > https://lore.kernel.org/linux-next/20211123185928.2513763-1-surenb@google.com/T/#u
> > One thing I'm not sure is that I used SHA from linux-next in the Fixes: field:
> >
> > Fixes: 2df148be9486 ("mm: add a field to store names for private
> > anonymous memory")
> >
> > Not sure if that's acceptable. Please let me know if you want me to
> > repost the fix without that line.
>
> It doesn't really matter as Andrew will most likely squash this fixup
> into the original patch.

Perfect! Please let me know if anything else is needed.
Thanks,
Suren.

>
> --
> Cheers,
> Stephen Rothwell
