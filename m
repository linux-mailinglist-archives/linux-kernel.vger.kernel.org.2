Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B2638823C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 23:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352520AbhERVji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 17:39:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233448AbhERVji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 17:39:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6EB7361073;
        Tue, 18 May 2021 21:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1621373899;
        bh=V0EkkymkSx4zJbmlnUoix5lpcu0oSr/abv8c1zdHT7g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YtFMuRJOz7aVPib2P3dDy6iI8PgF4lhzpg7+eeEWR2uDIJO/P0u3lFFsQnrULnq6J
         QUNKDDIPDWnjgV66+FkaONJbIb+amMxLTKkQ3mW+cnxn8cAN/PHdgkZnYEWSEF8C3C
         m6ofjQvZyrns4zp0U0eD+GLZUeJUAuT2sDtnkOPg=
Date:   Tue, 18 May 2021 14:38:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Vitor Massaru Iha <vitor@massaru.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH 1/1] lib: kunit: Suppress a compilation warning of frame
 size
Message-Id: <20210518143818.51564964d8f6fe228cb055ee@linux-foundation.org>
In-Reply-To: <20210518094533.7652-1-thunder.leizhen@huawei.com>
References: <20210518094533.7652-1-thunder.leizhen@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 May 2021 17:45:33 +0800 Zhen Lei <thunder.leizhen@huawei.com> wrote:

> lib/bitfield_kunit.c: In function ‘test_bitfields_constants’:
> lib/bitfield_kunit.c:93:1: warning: the frame size of 7456 bytes is larger than 2048 bytes [-Wframe-larger-than=]
>  }
>  ^
> 
> As the description of BITFIELD_KUNIT in lib/Kconfig.debug, it "Only useful
> for kernel devs running the KUnit test harness, and not intended for
> inclusion into a production build". Therefore, it is not worth modifying
> variable 'test_bitfields_constants' to clear this warning. Just suppress
> it.

Well, it would be better to fix this rather than hiding it.  The
warning is there for a reason!

Firstly, why is this happening?  Do those macros end up generating a
vast number of `kunit_assert' instances and gcc dumbly fails to reuse
the same stack slots?

It would be trivial to split test_bitfields_constants() into four
functions.  Probably those should use noinline_for_stack to prevent gcc
from just inlining everything into the caller.

Also, what's up with this?

	/*
	 * NOTE
	 * This whole function compiles (or at least should, if everything
	 * is going according to plan) to nothing after optimisation.
	 */

If that's the case then why did the function use all this stack?

> diff --git a/lib/Makefile b/lib/Makefile
> index e11cfc18b6c0826..2cc359ec1fdd3e1 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -348,6 +348,7 @@ obj-$(CONFIG_OBJAGG) += objagg.o
>  obj-$(CONFIG_PLDMFW) += pldmfw/
>  
>  # KUnit tests
> +CFLAGS_bitfield_kunit.o := $(call cc-option,-Wframe-larger-than=10240)
>  obj-$(CONFIG_BITFIELD_KUNIT) += bitfield_kunit.o
>  obj-$(CONFIG_LIST_KUNIT_TEST) += list-test.o
>  obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o

