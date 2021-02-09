Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874193154A9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 18:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbhBIRHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 12:07:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:51914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232990AbhBIRHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:07:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5556D64E31;
        Tue,  9 Feb 2021 17:06:57 +0000 (UTC)
Date:   Tue, 9 Feb 2021 17:06:54 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v12 7/7] kasan: don't run tests in async mode
Message-ID: <20210209170654.GH1435@arm.com>
References: <20210208165617.9977-1-vincenzo.frascino@arm.com>
 <20210208165617.9977-8-vincenzo.frascino@arm.com>
 <20210209120241.GF1435@arm.com>
 <0e373526-0fa8-c5c0-fb41-5c17aa47f07c@arm.com>
 <CAAeHK+yj9PR2Tw_xrpKKh=8GyNwgOaEu1pK8L6XL4zz0NtVs3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+yj9PR2Tw_xrpKKh=8GyNwgOaEu1pK8L6XL4zz0NtVs3A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 04:02:25PM +0100, Andrey Konovalov wrote:
> On Tue, Feb 9, 2021 at 1:16 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
> > On 2/9/21 12:02 PM, Catalin Marinas wrote:
> > > On Mon, Feb 08, 2021 at 04:56:17PM +0000, Vincenzo Frascino wrote:
> > >> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> > >> index 7285dcf9fcc1..f82d9630cae1 100644
> > >> --- a/lib/test_kasan.c
> > >> +++ b/lib/test_kasan.c
> > >> @@ -51,6 +51,10 @@ static int kasan_test_init(struct kunit *test)
> > >>              kunit_err(test, "can't run KASAN tests with KASAN disabled");
> > >>              return -1;
> > >>      }
> > >> +    if (kasan_flag_async) {
> > >> +            kunit_err(test, "can't run KASAN tests in async mode");
> > >> +            return -1;
> > >> +    }
> > >>
> > >>      multishot = kasan_save_enable_multi_shot();
> > >>      hw_set_tagging_report_once(false);
> > >
> > > I think we can still run the kasan tests in async mode if we check the
> > > TFSR_EL1 at the end of each test by calling mte_check_tfsr_exit().
> > >
> >
> > IIUC this was the plan for the future. But I let Andrey comment for more details.
> 
> If it's possible to implement, then it would be good to have. Doesn't
> have to be a part of this series though.

I think it can be part of this series but after the 5.12 merging window
(we are a few days away from final 5.11 and I don't think we should
rush the MTE kernel async support in).

It would be nice to have the kasan tests running with async by the time
we merge the patches (at a quick look, I think it's possible but, of
course, we may hit some blockers when implementing it).

-- 
Catalin
