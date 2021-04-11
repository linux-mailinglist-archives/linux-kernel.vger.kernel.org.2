Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0F335B71B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 00:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbhDKWDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 18:03:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235284AbhDKWDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 18:03:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE6AD610CB;
        Sun, 11 Apr 2021 22:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1618178599;
        bh=xr7Bko3nkY/hQzyR34sArUT+yy4zsjhEp/ERlDlaFfw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ASNK5lYWJnV08hEwZiPrc6I7AoSedfw99O8NVwSHpYtW/sKTUrJtRS1uIZR9R6wnF
         t038iXV/UBzK/JbJ/OAtnesctxvwAQ68TpuPYGu1G2sQbDxkDAosgxxY6G+aspKiwD
         d9vdXulvY0qHJo7ky7gEeulX+VJurJteIqXR1/1w=
Date:   Sun, 11 Apr 2021 15:03:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Walter Wu <walter-zh.wu@mediatek.com>
Subject: Re: [PATCH v4] kasan: remove redundant config option
Message-Id: <20210411150316.d60aa0b5174adf2370538809@linux-foundation.org>
In-Reply-To: <20210411105332.GA23778@arm.com>
References: <20210226012531.29231-1-walter-zh.wu@mediatek.com>
        <CAAeHK+zyv1=kXtKAynnJN-77dwmPG4TXpJOLv_3W0nxXe5NjXA@mail.gmail.com>
        <20210330223637.f3c73a78c64587e615d26766@linux-foundation.org>
        <20210411105332.GA23778@arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Apr 2021 11:53:33 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:

> Hi Andrew,
> 
> On Tue, Mar 30, 2021 at 10:36:37PM -0700, Andrew Morton wrote:
> > On Mon, 29 Mar 2021 16:54:26 +0200 Andrey Konovalov <andreyknvl@google.com> wrote:
> > > Looks like my patch "kasan: fix KASAN_STACK dependency for HW_TAGS"
> > > that was merged into 5.12-rc causes a build time warning:
> > > 
> > > include/linux/kasan.h:333:30: warning: 'CONFIG_KASAN_STACK' is not
> > > defined, evaluates to 0 [-Wundef]
> > > #if defined(CONFIG_KASAN) && CONFIG_KASAN_STACK
> > > 
> > > The fix for it would either be reverting the patch (which would leave
> > > the initial issue unfixed) or applying this "kasan: remove redundant
> > > config option" patch.
> > > 
> > > Would it be possible to send this patch (with the fix-up you have in
> > > mm) for the next 5.12-rc?
> > > 
> > > Here are the required tags:
> > > 
> > > Fixes: d9b571c885a8 ("kasan: fix KASAN_STACK dependency for HW_TAGS")
> > > Cc: stable@vger.kernel.org
> > 
> > Got it, thanks.  I updated the changelog to mention the warning fix and
> > moved these ahead for a -rc merge.
> 
> Is there a chance this patch makes it into 5.12? I still get the warning
> with the latest Linus' tree (v5.12-rc6-408-g52e44129fba5) when enabling
> KASAN_HW_TAGS.

Trying.   We're still awaiting a tested fix for
https://lkml.kernel.org/r/CA+fCnZf1ABrQg0dsxtoZa9zM1BSbLYq_Xbu+xi9cv8WAZxdC2g@mail.gmail.com
