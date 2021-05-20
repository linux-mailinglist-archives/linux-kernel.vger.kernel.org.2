Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9DE038B824
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 22:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239827AbhETUOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 16:14:41 -0400
Received: from ms.lwn.net ([45.79.88.28]:59484 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233675AbhETUOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 16:14:40 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 56D88301;
        Thu, 20 May 2021 20:13:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 56D88301
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1621541598; bh=0XsqVNaBunY2oxqRx1tgHQyOQAW56aEQpUFm5jq+18M=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ViSzjdDkE7+0H5CgQerElyVF/Rzxj0DHIshcFb61xvLOu59B7VBC9bH8N9uXOoV2P
         Dvi8g+Pfsu/b2MEQW8MGim0yPNhGL2fRXCynhS4nvmB0WPP639WP/sVkCKw4+tp5GM
         wDVUozSNS4GVmY51+p1v6rDQQxqk12N0yyeZP0fr4zrWmxlUqtk1PrwLXId7gJQXmt
         fVXjNPddeWgntsd8kwcanIS+3EUXxUCRN30J2y8RW64eoM0o2p6B2l66CZ9cWOc9Lh
         76khHj05Iydg/DTWh/kDu1iLnfB6aayuCE/FlVqLHYqz6SkWvD6FPGDdmYiTLawNJc
         uakVgLmf2875Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>, mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        linux-doc@vger.kernel.org, Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: Re: [PATCH] docs: Add more message type documentations for checkpatch
In-Reply-To: <20210515132348.19082-1-dwaipayanray1@gmail.com>
References: <20210515132348.19082-1-dwaipayanray1@gmail.com>
Date:   Thu, 20 May 2021 14:13:17 -0600
Message-ID: <87k0ntnoyq.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dwaipayan Ray <dwaipayanray1@gmail.com> writes:

> - Document a couple of more checkpatch message types.
> - Add a blank line before all `See:` lines to improve the
>   rst output.
> - Create a new subsection `Permissions` and move a few types
>   to it.
>
> Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
> ---
>  Documentation/dev-tools/checkpatch.rst | 170 ++++++++++++++++++++++++-
>  1 file changed, 163 insertions(+), 7 deletions(-)

So this seems good, but I just notice something that has evidently
escaped me until now...

> diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
> index 51fed1bd72ec..e409f27f48b6 100644
> --- a/Documentation/dev-tools/checkpatch.rst
> +++ b/Documentation/dev-tools/checkpatch.rst
> @@ -246,6 +246,7 @@ Allocation style
>      The first argument for kcalloc or kmalloc_array should be the
>      number of elements.  sizeof() as the first argument is generally
>      wrong.
> +
>      See: https://www.kernel.org/doc/html/latest/core-api/memory-allocation.html
>  
>    **ALLOC_SIZEOF_STRUCT**
> @@ -264,6 +265,7 @@ Allocation style
>    **ALLOC_WITH_MULTIPLY**
>      Prefer kmalloc_array/kcalloc over kmalloc/kzalloc with a
>      sizeof multiply.
> +
>      See: https://www.kernel.org/doc/html/latest/core-api/memory-allocation.html
>  
>  
> @@ -284,6 +286,7 @@ API usage
>      BUG() or BUG_ON() should be avoided totally.
>      Use WARN() and WARN_ON() instead, and handle the "impossible"
>      error condition as gracefully as possible.
> +
>      See: https://www.kernel.org/doc/html/latest/process/deprecated.html#bug-and-bug-on
>  
>    **CONSIDER_KSTRTO**
> @@ -292,12 +295,23 @@ API usage
>      may lead to unexpected results in callers.  The respective kstrtol(),
>      kstrtoll(), kstrtoul(), and kstrtoull() functions tend to be the
>      correct replacements.
> +
>      See: https://www.kernel.org/doc/html/latest/process/deprecated.html#simple-strtol-simple-strtoll-simple-strtoul-simple-strtoull
>  
> +  **IN_ATOMIC**
> +    in_atomic() is not for driver use so any such use is reported as an ERROR.
> +    Also in_atomic() is often used to determine if we may sleep, but it is not
> +    reliable in this use model therefore its use is strongly discouraged.
> +
> +    However, in_atomic() is ok for core kernel use.
> +
> +    See: https://lore.kernel.org/lkml/20080320201723.b87b3732.akpm@linux-foundation.org/
> +
>    **LOCKDEP**
>      The lockdep_no_validate class was added as a temporary measure to
>      prevent warnings on conversion of device->sem to device->mutex.
>      It should not be used for any other purpose.
> +
>      See: https://lore.kernel.org/lkml/1268959062.9440.467.camel@laptop/
>  
>    **MALFORMED_INCLUDE**
> @@ -308,11 +322,18 @@ API usage
>    **USE_LOCKDEP**
>      lockdep_assert_held() annotations should be preferred over
>      assertions based on spin_is_locked()
> +
>      See: https://www.kernel.org/doc/html/latest/locking/lockdep-design.html#annotations
>  
>    **UAPI_INCLUDE**
>      No #include statements in include/uapi should use a uapi/ path.
>  
> +  **USLEEP_RANGE**
> +    usleep_range() should be preferred over udelay(). The proper way of
> +    using usleep_range() is mentioned in the kernel docs.
> +
> +    See: https://www.kernel.org/doc/html/latest/timers/timers-howto.html#delays-information-on-the-various-kernel-delay-sleep-mechanisms

We really shouldn't be linking to outside sites - even kernel.org - when
referring to the kernel docs themselves.  Just say
"Documentation/timers/timers-howto" and let the build system handle the
links.

There's a lot of these in this file, alas...

I've applied this patch since it makes things better overall, but I
would really like to see all those URLs go away if possible.

Thanks,

jon
