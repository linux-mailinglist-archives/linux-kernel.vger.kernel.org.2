Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD42B3A4F91
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 17:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbhFLPyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 11:54:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230200AbhFLPyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 11:54:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16AAD610FC;
        Sat, 12 Jun 2021 15:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623513139;
        bh=/MvUw+4oP5YH+nNQUGSiupDVJ+3XAmXQq5g0t8ptRJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q1VvwNIyaBk2XHBcSAH6CgjViFyHVw7h7O3u3o2CqQwzvAsXYHdOK6k7IqY14s7bS
         Piy9vKBDSKe0/Yap0ZCof/B61KIZtN8W3BsYeanO+FIc4fKSBx0zqgNQFlFKeu+s53
         twKvrY7G/cEgMqB2YJrA1cOrQBux8WYRy8Ye/B2Y=
Date:   Sat, 12 Jun 2021 17:52:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marco Elver <elver@google.com>
Cc:     Kuan-Ying Lee <kylee0686026@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v2 2/3] kasan: integrate the common part of two KASAN
 tag-based modes
Message-ID: <YMTYMebTk7tJEmXX@kroah.com>
References: <20210612045156.44763-1-kylee0686026@gmail.com>
 <20210612045156.44763-3-kylee0686026@gmail.com>
 <CANpmjNMLzxMO0k_kvGaAvzyGoyKxBTtjx4PH=-MKKgDb1-dQaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMLzxMO0k_kvGaAvzyGoyKxBTtjx4PH=-MKKgDb1-dQaA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12, 2021 at 04:42:44PM +0200, Marco Elver wrote:
> On Sat, 12 Jun 2021 at 06:52, Kuan-Ying Lee <kylee0686026@gmail.com> wrote:
> > diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
> > new file mode 100644
> > index 000000000000..9c33c0ebe1d1
> > --- /dev/null
> > +++ b/mm/kasan/tags.c
> > @@ -0,0 +1,58 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * This file contains common tag-based KASAN code.
> > + *
> > + * Author: Kuan-Ying Lee <kylee0686026@gmail.com>
> 
> We appreciate your work on this, but this is misleading. Because you
> merely copied/moved the code, have a look what sw_tags.c says -- that
> should either be preserved, or we add nothing here.
> 
> I prefer to add nothing or the bare minimum (e.g. if the company
> requires a Copyright line) for non-substantial additions because this
> stuff becomes out-of-date fast and just isn't useful at all. 'git log'
> is the source of truth.
> 
> Cc'ing Greg for process advice. For moved code, does it have to
> preserve the original Copyright line if there was one?

Yes, it does have to.  Unless you want to talk to a lot of lawyers about
the issues involved here and can defend the removal of the copyright
lines to them.

So please keep them.  Unless you can get your corporate lawyer to sign
off on the patch that does the removal.

thanks,

greg k-h
