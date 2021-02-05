Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0497D311255
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 21:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbhBESha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 13:37:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:47018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233115AbhBEPKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:10:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DDE1764EE0;
        Fri,  5 Feb 2021 16:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612543708;
        bh=7f4KP/9lp0Sy/l4DlqL3s3ovyzq5C2oXaRlJC24Sty0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fr0XTPfvLeRI7Bn/dzW1HJkIaa13V7z09YTiB85yeKBnzrM2GkwItSDBB0K152T8v
         0FjoOhRiO1Ao73mDjAiuqKzZCSip90MXWi1NRXxFLuoK8KjqEZM/WuIPu/B55lAA5t
         wM4CCZGiahtYWdjEi2kmb1kzWsg55eyuNOPK2ZvcZIQXfdHdfhBK1lg9HV1ni+bDXa
         OzH5lv1lbfMeVTGbqyCHHqhAEQAkV+3ns4Synt+aCIH/0S+LQdCSKoW1v/kmgrSRda
         ICjby68XItsFRbru8sRXFCm/ks+k4eqAfF/HzveUPSV/3gzmo7VFa7byZVltDeBtKu
         MGSHFF4CXo6Ug==
Date:   Fri, 5 Feb 2021 16:48:22 +0000
From:   Will Deacon <will@kernel.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>
Subject: Re: [PATCH v11 2/5] kasan: Add KASAN mode kernel parameter
Message-ID: <20210205164822.GB22665@willie-the-truck>
References: <20210130165225.54047-1-vincenzo.frascino@arm.com>
 <20210130165225.54047-3-vincenzo.frascino@arm.com>
 <CAAeHK+y=t4c5FfVx3r3Rvwg3GTYN_q1xme=mwk51hgQfJX9MZw@mail.gmail.com>
 <CAAeHK+wdPDZkUSu+q1zb=YWxVD68mXqde9c+gYB4bb=zCsvbZw@mail.gmail.com>
 <96163fa8-c093-8c2f-e085-8c2148882748@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96163fa8-c093-8c2f-e085-8c2148882748@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 04:00:07PM +0000, Vincenzo Frascino wrote:
> 
> 
> On 2/5/21 3:49 PM, Andrey Konovalov wrote:
> > On Mon, Feb 1, 2021 at 9:04 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> >>
> >> On Sat, Jan 30, 2021 at 5:52 PM Vincenzo Frascino
> >> <vincenzo.frascino@arm.com> wrote:
> >>>
> >>> @@ -45,6 +52,9 @@ static enum kasan_arg_fault kasan_arg_fault __ro_after_init;
> >>>  DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
> >>>  EXPORT_SYMBOL(kasan_flag_enabled);
> >>>
> >>> +/* Whether the asynchronous mode is enabled. */
> >>> +bool kasan_flag_async __ro_after_init;
> >>
> >> Just noticed that we need EXPORT_SYMBOL(kasan_flag_async) here.
> > 
> > Hi Vincenzo,
> > 
> > If you post a new version of this series, please include
> > EXPORT_SYMBOL(kasan_flag_async).
> >
> 
> I can do that, no problem.

EXPORT_SYMBOL_GPL, please :)

Will
