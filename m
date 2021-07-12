Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C703C6176
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 19:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbhGLRHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 13:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235602AbhGLRHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 13:07:19 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38609C0613DD;
        Mon, 12 Jul 2021 10:04:31 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E35772ED;
        Mon, 12 Jul 2021 17:04:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E35772ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1626109471; bh=rNbc78ySoW7E4zNHWiKuoKaf/P5JAEEohrvKvz8M1cg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=gEM/cQUTOgK+5w0wE4y/0uBAtHjN9kKQbjqDua+uedungtXokJNDzCi3keODXdPxp
         EIGm0YDx0abvyHga1hV13In/eip5z24XaRBZojLBWkFMduvu1vgGuoVehnN64O3AZH
         G2WTvs9OG/8Yqmdk5+JUKfs6pp+LnjCe2hUwfsv8PC6rQir08Wab/F0LzV5LFkxOFV
         TplCiipQI6D2TrbJg3QRnWPS5JP2tEXEKy/c039Sx1DZ7vQ+//l2EL39sh4ta7hG6E
         nZgx1h9OQoEI7qKBADQg0sThLw6zdge+4Tuwk7LzwqWfEnjsBYswKuiUgu9yJrMvpv
         o2fw8CpvsVg0Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Cengiz Can <cengiz@kernel.wtf>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cengiz Can <cengiz@kernel.wtf>
Subject: Re: [PATCH] Documentation: sysrq: convert to third person
In-Reply-To: <20210629141508.52229-1-cengiz@kernel.wtf>
References: <20210629141508.52229-1-cengiz@kernel.wtf>
Date:   Mon, 12 Jul 2021 11:04:30 -0600
Message-ID: <87v95fpiox.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cengiz Can <cengiz@kernel.wtf> writes:

> Two parts of the sysrq documentation have sentences written from a first
> person's point of view.
>
> Documentation is generally written from a third person's view in a
> formal way.
>
> Convert those senteces to be less personal and generic.

So this seems like a fine change, but I have one little gripe...

> Signed-off-by: Cengiz Can <cengiz@kernel.wtf>
> ---
>  Documentation/admin-guide/sysrq.rst | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/admin-guide/sysrq.rst b/Documentation/admin-guide/sysrq.rst
> index 60ce5f5ebab6..0a178ef0111d 100644
> --- a/Documentation/admin-guide/sysrq.rst
> +++ b/Documentation/admin-guide/sysrq.rst
> @@ -72,7 +72,7 @@ On PowerPC
>  
>  On other
>  	If you know of the key combos for other architectures, please
> -        let me know so I can add them to this section.
> +	submit a patch to be included in this section.
>  
>  On all
>  	Write a character to /proc/sysrq-trigger.  e.g.::
> @@ -205,10 +205,12 @@ frozen (probably root) filesystem via the FIFREEZE ioctl.
>  Sometimes SysRq seems to get 'stuck' after using it, what can I do?
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
> -That happens to me, also. I've found that tapping shift, alt, and control
> -on both sides of the keyboard, and hitting an invalid sysrq sequence again
> -will fix the problem. (i.e., something like :kbd:`alt-sysrq-z`). Switching to
> -another virtual console (:kbd:`ALT+Fn`) and then back again should also help.
> +When this happens, try tapping shift, alt and control on both sides of the
> +keyboard, and hitting an invalid sysrq sequence again. (i.e., something like
> +:kbd:`alt-sysrq-z`).
> +
> +Switching to another virtual console (:kbd:`ALT+Fn`) and then back again
> +should also help.

The :kbd: stuff is a pretty good example of the sort of extra markup we
try to avoid when we can.  It adds little to the formatted docs and
worsens the reading experience for plain-text.  It sure would be nice if
we could make that kind of stuff go away when we're in the neighborhood.

Anyway, I've applied the patch.

Thanks,

jon
