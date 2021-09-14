Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5CE40B99B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 23:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbhINVIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 17:08:20 -0400
Received: from ms.lwn.net ([45.79.88.28]:41268 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234059AbhINVIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 17:08:19 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 49BE92CA;
        Tue, 14 Sep 2021 21:07:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 49BE92CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1631653621; bh=aRIuKcelosoK7HSq+GC2ST2aT0MMYO+BBP+OHR42Tnk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=DF5eyEPCSfnJMLuEitlrBN1ofw/Bm9eNbLjJM8hQ3CmUUW2YVzeW2shBm9HLfu/5p
         Ob6ojTKZEIP2RLq+DBTXEG1CHIc2Atym7cUat3XVjFfTbpBdCewoXlMjUKLHolV+kN
         SZI8LixJab3flQHeGvMOxYiWlgTNtIbvABZGhQZCOR9lNxyuygNjGn07Cyiz8QK1Aq
         gE7v+nb/TU3LATeSEfi1vjbwGIjBpyO0tV/xvajH5iFnIpIwlFZ0YLFm4vz4QQh7rt
         8iDwky8DJB4GwbGY0mVnX3zVRkXOF0hZY5OnhcQAwQfZYHRXNc4hPngv2JcScbOfS3
         uB5rT4GTT+VOw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Len Baker <len.baker@gmx.com>, Kees Cook <keescook@chromium.org>
Cc:     Len Baker <len.baker@gmx.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Joe Perches <joe@perches.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] docs: deprecated.rst: Clarify open-coded arithmetic
 with literals
In-Reply-To: <20210829144716.2931-1-len.baker@gmx.com>
References: <20210829144716.2931-1-len.baker@gmx.com>
Date:   Tue, 14 Sep 2021 15:07:00 -0600
Message-ID: <87r1dqdfyj.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Len Baker <len.baker@gmx.com> writes:

> Although using literals for size calculation in allocator arguments may
> be harmless due to compiler warnings in case of overflows, it is better
> to refactor the code to avoid the use of open-coded math idiom.
>
> So, clarify the preferred way in these cases.
>
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Len Baker <len.baker@gmx.com>
> ---
> Changelog v1 -> v2
>  - Clarify the sentence by changing "keep <foo> out" with "avoid <foo>"
>    (Joe Perches).
>
>  Documentation/process/deprecated.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
> index 9d83b8db8874..b5a8be914178 100644
> --- a/Documentation/process/deprecated.rst
> +++ b/Documentation/process/deprecated.rst
> @@ -60,7 +60,8 @@ smaller allocation being made than the caller was expecting. Using those
>  allocations could lead to linear overflows of heap memory and other
>  misbehaviors. (One exception to this is literal values where the compiler
>  can warn if they might overflow. Though using literals for arguments as
> -suggested below is also harmless.)
> +suggested below is also harmless. So, the preferred way in these cases is
> +to refactor the code to avoid the open-coded math idiom.)

Sorry for being so slow to get to this...  honestly, though, I've been
staring at it for a bit and cannot figure out what you are trying to
communicate.  What does "math idiom" mean here?  If you are trying to
say that using literals is *not* harmless, then perhaps the first part
of the parenthetical should be taken out?

Confused...

jon
