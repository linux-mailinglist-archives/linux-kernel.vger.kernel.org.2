Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55603333927
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 10:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbhCJJrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 04:47:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:34562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231278AbhCJJrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 04:47:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6938D64DAF;
        Wed, 10 Mar 2021 09:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615369620;
        bh=iVdyLmTZGmXRpZt9aj787c9X5ka8KYvNsypfZN2Uuqc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kL+pGOTns+s3zh+z1YlDB8JiZLn0jpryoSbBNY5zdbM6FdRmv801gx27TfLtJg4b9
         4kYnGDyb8CXcp9+JbinKlwiJkhq4KHzRRN1ch0cO0+37i7td97QdP/ABhUYIxLxQBe
         EN1h6/4JfPHAwrjHG8KzXmSR4HWW4L45N+3nLoZU=
Date:   Wed, 10 Mar 2021 10:46:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2 2/2] modules: add CONFIG_MODPROBE_PATH
Message-ID: <YEiVkZAmWm5D68A2@kroah.com>
References: <20210224142909.2092914-1-linux@rasmusvillemoes.dk>
 <20210309211700.2011017-1-linux@rasmusvillemoes.dk>
 <20210309211700.2011017-3-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309211700.2011017-3-linux@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 10:17:00PM +0100, Rasmus Villemoes wrote:
> Allow the developer to specifiy the initial value of the
> modprobe_path[] string. This can be used to set it to the empty string
> initially, thus effectively disabling request_module() during early
> boot until userspace writes a new value via the
> /proc/sys/kernel/modprobe interface. [1]
> 
> When building a custom kernel (often for an embedded target), it's
> normal to build everything into the kernel that is needed for booting,
> and indeed the initramfs often contains no modules at all, so every
> such request_module() done before userspace init has mounted the real
> rootfs is a waste of time.
> 
> This is particularly useful when combined with the previous patch,
> which allowed the initramfs to be unpacked asynchronously - for that
> to work, it had to make any usermodehelper call wait for the unpacking
> to finish before attempting to invoke the userspace helper. By
> eliminating all such (known-to-be-futile) calls of usermodehelper, the
> initramfs unpacking and the {device,late}_initcalls can proceed in
> parallel for much longer.
> 
> For a relatively slow ppc board I'm working on, the two patches
> combined lead to 0.2s faster boot - but more importantly, the fact
> that the initramfs unpacking proceeds completely in the background
> while devices get probed means I get to handle the gpio watchdog in
> time without getting reset.
> 
> [1] __request_module() already has an early -ENOENT return when
> modprobe_path is the empty string.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  init/Kconfig  | 12 ++++++++++++
>  kernel/kmod.c |  2 +-
>  2 files changed, 13 insertions(+), 1 deletion(-)

Looks sane to me, odd we didn't think of doing this before.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
