Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282F83C59CB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354440AbhGLJIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 05:08:32 -0400
Received: from foss.arm.com ([217.140.110.172]:50646 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378130AbhGLIkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 04:40:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B82071FB;
        Mon, 12 Jul 2021 01:37:28 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.2.95])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D21A03F694;
        Mon, 12 Jul 2021 01:37:25 -0700 (PDT)
Date:   Mon, 12 Jul 2021 09:37:17 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Sam Tebbs <sam.tebbs@arm.com>, Robin Murphy <robin.murphy@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Will Deacon <will@kernel.org>, Marco Elver <elver@google.com>
Subject: Re: [PATCH] kasan: fix build for CONFIG_KASAN_HW_TAGS
Message-ID: <20210712083455.GA85732@C02TD0UTHF1T.local>
References: <20210708144411.25467-1-mark.rutland@arm.com>
 <CA+fCnZdHADek_3bFcLdkk7=XiRL25F0n6VaGGOrw-uUpDLxYYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+fCnZdHADek_3bFcLdkk7=XiRL25F0n6VaGGOrw-uUpDLxYYw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2021 at 09:16:14PM +0200, Andrey Konovalov wrote:
> On Thu, Jul 8, 2021 at 4:44 PM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > When CONFIG_KASAN_HW_TAGS is selected, <linux/kasan.h> uses _RET_IP_,
> > but doesn't explicitly include <linux/kernel.h> where this is defined.
> >
> > We used to get this via a transitive include, but since commit:
> >
> >   f39650de687e3576 ("kernel.h: split out panic and oops helpers")
> >
> > ... this is no longer the case, and so we get a build failure:
> >
> > |   CC      arch/arm64/mm/kasan_init.o
> > | In file included from arch/arm64/mm/kasan_init.c:10:
> > | ./include/linux/kasan.h: In function 'kasan_slab_free':
> > | ./include/linux/kasan.h:211:39: error: '_RET_IP_' undeclared (first use in this function)
> > |   211 |   return __kasan_slab_free(s, object, _RET_IP_, init);
> > |       |                                       ^~~~~~~~
> > | ./include/linux/kasan.h:211:39: note: each undeclared identifier is reported only once for each function it appears in
> > | ./include/linux/kasan.h: In function 'kasan_kfree_large':
> > | ./include/linux/kasan.h:219:28: error: '_RET_IP_' undeclared (first use in this function)
> > |   219 |   __kasan_kfree_large(ptr, _RET_IP_);
> > |       |                            ^~~~~~~~
> > | ./include/linux/kasan.h: In function 'kasan_slab_free_mempool':
> > | ./include/linux/kasan.h:226:34: error: '_RET_IP_' undeclared (first use in this function)
> > |   226 |   __kasan_slab_free_mempool(ptr, _RET_IP_);
> > |       |                                  ^~~~~~~~
> > | ./include/linux/kasan.h: In function 'kasan_check_byte':
> > | ./include/linux/kasan.h:277:35: error: '_RET_IP_' undeclared (first use in this function)
> > |   277 |   return __kasan_check_byte(addr, _RET_IP_);
> > |       |                                   ^~~~~~~~
> >
> > Fix this by including <linux/kernel.h> explicitly.
> 
> Hi Mark,
> 
> Marco already sent a fix for this. It should be in the mm tree.
> (Although the link to it in the Andrew's notification email doesn't
> work. But they rarely do :)
> 
> > As a heads-up, there are some unrelated runtime issues with
> > CONFIG_KASAN_HW_TAGS and the recent arm64 string routines rework, which
> > I'm looking into now. If you boot-test with this applied, you should
> > expect to see those.
> 
> +Sam, +Robin
> 
> Looks like the new strlen routine is making accesses past the allocated buffer.
> 
> The guilty commit is 325a1de81287 ("arm64: Import updated version of
> Cortex Strings' strlen").

FWIW, I already have a fix for this, I'm just cleaning it up and will
post shortly.

The issue is that the new strlen() will make unaligned 16-byte accesses
within a naturally-aligned 4096-byte window and over-read by up to 15
bytes; we can fiddle with its alignment fixup to always align to 16
bytes when MTE is in use so any over-read is within the same MTE granule
as the final byte of the string.

I've checked the other routines, and AFAICT they never make accesses
which staddle a 16-byte boundary.

Thanks,
Mark.
