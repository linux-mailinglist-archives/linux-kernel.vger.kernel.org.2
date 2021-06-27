Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0143B53F3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 17:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhF0PD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 11:03:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229927AbhF0PD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 11:03:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 776F96161C;
        Sun, 27 Jun 2021 15:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624806091;
        bh=7/B22glLEoCb0RDdvXFkykmhtwP4ub1qksrbrrnFj/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zmt08efp+LWSVmlXPfUtrB3FqAsKiIFdK94LlCfZSrMQoNxC9pG73A896qF1PWSAe
         4eZz8va8vTMZQRrOW6tzCVrhnTtNKzPWcYbthSPKVyfLsFT2RMEOYtFqXUw3rsZjHP
         BMRmUsbjMNyO9T3glDdouT46cwm+rBnd+xMSu5yI=
Date:   Sun, 27 Jun 2021 17:01:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] x86/tools/relocs: add __printf attribute to die()
Message-ID: <YNiSyFNbAMVxN6wO@kroah.com>
References: <YNRzSy3NuwBDYWwr@kroah.com>
 <YNR7aw+C+7AJnBIG@zn.tnic>
 <YNXG472lXPHlbuCF@kroah.com>
 <YNXkVBcmBvZL7khv@zn.tnic>
 <F8B4FDC6-851F-4EC5-A308-BBAB52A75EF3@zytor.com>
 <YNYJ9vVQPVWqCvVq@zn.tnic>
 <1EFF7FE1-D341-41DF-8681-D386A1BD6F7A@zytor.com>
 <YNZFkG/tuHkwpyug@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNZFkG/tuHkwpyug@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 11:07:28PM +0200, Borislav Petkov wrote:
> On Fri, Jun 25, 2021 at 01:38:51PM -0700, H. Peter Anvin wrote:
> > 64-bit cross build on a 32-bit platform... or Windows.
> 
> Meh, nobody cares about those... :)
> 
> Hmm, so looking at the PRI* inttypes.h things again, they're C99 and
> they kinda look more elegant as they don't make us cast stuff.
> 
> So how does that look?
> 
> ---
> 
> diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
> index 04c5a44b9682..2582991ba216 100644
> --- a/arch/x86/tools/relocs.c
> +++ b/arch/x86/tools/relocs.c
> @@ -26,6 +26,9 @@ static struct relocs relocs32;
>  #if ELF_BITS == 64
>  static struct relocs relocs32neg;
>  static struct relocs relocs64;
> +#define FMT PRIu64
> +#else
> +#define FMT PRIu32
>  #endif

<snip>

This works for me!  It should fix the static checking tool that keeps
tripping over this pointless warning :)

Want to turn it into a real patch?

thanks,

greg k-h
