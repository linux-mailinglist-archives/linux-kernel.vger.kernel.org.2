Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7358E3C5A7C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbhGLKB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 06:01:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234878AbhGLKB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 06:01:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 483AA61002;
        Mon, 12 Jul 2021 09:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626083918;
        bh=tAO2c2XXve5OQIfwuwmw8NDac9gYcA9t8R4T8p3VA0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sp0gWhgawuzzkSTZB9An1dEpC06L7mSKerBgmHNsBuQEZqcX7v/G/eqD1eXNqzWe4
         yZAkZzS6Jq5C0os3RCAFe1lMoJqAY+DAPY2CpxU4/0RukVap9iaXoSgjoHUaZz7PfF
         p6cCtj476QWfjI+v+DjtN/6VgQUdHDWlK9/akaQFyv9Jv7bhQ5OxzaVbvD69pX4stF
         +7Di9KazK8Wt2lnWl3MXvN24QJtGwNkSpiH0cuXUm3lOPnGNAKAwUHUBj4pWWqcjHW
         sOOQNC+TOsXyJqjR+Bu5As4jU8sJnn23PPD6Pw13Nr+3iDT9TTBLnemK86jOnQsmN7
         VzQWv0FdIsWmA==
Date:   Mon, 12 Jul 2021 10:58:32 +0100
From:   Will Deacon <will@kernel.org>
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Sam Tebbs <sam.tebbs@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH] kasan: fix build for CONFIG_KASAN_HW_TAGS
Message-ID: <20210712095832.GA27643@willie-the-truck>
References: <20210708144411.25467-1-mark.rutland@arm.com>
 <CA+fCnZdHADek_3bFcLdkk7=XiRL25F0n6VaGGOrw-uUpDLxYYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+fCnZdHADek_3bFcLdkk7=XiRL25F0n6VaGGOrw-uUpDLxYYw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

Do you have a link to the patch? I couldn't spot it in linux-next.

Thanks,

Will
