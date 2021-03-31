Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A625634F84D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 07:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbhCaFg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 01:36:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:42052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233469AbhCaFgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 01:36:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47026619D6;
        Wed, 31 Mar 2021 05:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1617168998;
        bh=A+/iyXhYmUd1Chjclmg8Qj+R34Mk/6o9vstaVVjDevk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cBwsi3nspFGQ+Zcaf07hLFV9MUMcPzSNvZdSVqHHq6+xsp0lbYzaL10O2SSPfgKsR
         tv9W+cyaA96DW9Irw5kpvTNp3lP/vgFbX5hqPKASNUBrxHq1sdrLCEULembBIK/FiP
         7uhsj82jjmiPgwvZ7mApOFODlIjjjeyaogjrxaoA=
Date:   Tue, 30 Mar 2021 22:36:37 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
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
Message-Id: <20210330223637.f3c73a78c64587e615d26766@linux-foundation.org>
In-Reply-To: <CAAeHK+zyv1=kXtKAynnJN-77dwmPG4TXpJOLv_3W0nxXe5NjXA@mail.gmail.com>
References: <20210226012531.29231-1-walter-zh.wu@mediatek.com>
        <CAAeHK+zyv1=kXtKAynnJN-77dwmPG4TXpJOLv_3W0nxXe5NjXA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2021 16:54:26 +0200 Andrey Konovalov <andreyknvl@google.com> wrote:

> Looks like my patch "kasan: fix KASAN_STACK dependency for HW_TAGS"
> that was merged into 5.12-rc causes a build time warning:
> 
> include/linux/kasan.h:333:30: warning: 'CONFIG_KASAN_STACK' is not
> defined, evaluates to 0 [-Wundef]
> #if defined(CONFIG_KASAN) && CONFIG_KASAN_STACK
> 
> The fix for it would either be reverting the patch (which would leave
> the initial issue unfixed) or applying this "kasan: remove redundant
> config option" patch.
> 
> Would it be possible to send this patch (with the fix-up you have in
> mm) for the next 5.12-rc?
> 
> Here are the required tags:
> 
> Fixes: d9b571c885a8 ("kasan: fix KASAN_STACK dependency for HW_TAGS")
> Cc: stable@vger.kernel.org

Got it, thanks.  I updated the changelog to mention the warning fix and
moved these ahead for a -rc merge.

