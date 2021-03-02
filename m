Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A0B32AA34
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 20:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444889AbhCBTPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 14:15:55 -0500
Received: from mail-pf1-f176.google.com ([209.85.210.176]:39602 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1576891AbhCBQ1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 11:27:40 -0500
Received: by mail-pf1-f176.google.com with SMTP id e3so10162511pfj.6;
        Tue, 02 Mar 2021 08:27:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rhSN6EJUjlxVTEYhX0PMy9XPYvHtkvkyN9nKIz9f20o=;
        b=YoVGlzjeO1eDA4DGEGUIRhx/CsANqRjZmmV1mtJcCMvhOTaBNc8xeA8Cz273jx7BU4
         6ae8lUeEwIfd+GGcj1Psnavf4GFPtx5tgpONp/QSbc6J/qbRRoZ5y0RRcE4kEv/I3+Ex
         wG8/j03pl/jGptI1wzzu6ocZgtasulHi7zHTLc/JBjy/HH/WgLKcICpGo6LI+WVKRhTl
         KyU6XHUD8omThzHdx/pZiTzuWKohHgfSe/I6fIBy2NabQP/eWoJ3VFKlh0wsZHjO12Ag
         HAa8iLswP6iSPGqb+B3AfaGjImtL+zlCqoCpEAWcOWDDEz0PGfUeOM6HFQau3mexQzYT
         9LlQ==
X-Gm-Message-State: AOAM531YICZjt2t0hkN1aBl3jGtFx2lJDe7PJToM7rb7aYucnA9qj/0M
        UHFA/2fAo3vTpcKF5Ek2G6o=
X-Google-Smtp-Source: ABdhPJxHlIacQIDI0Jp1SP0zuONV5jNgKRu1emvm93y9yY7Dyrwvw7WvrPzaO7ylYa5Y+2D2/O0jvA==
X-Received: by 2002:a65:448c:: with SMTP id l12mr18859525pgq.386.1614702416119;
        Tue, 02 Mar 2021 08:26:56 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id v3sm20806728pff.217.2021.03.02.08.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 08:26:54 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id D41AA403DC; Tue,  2 Mar 2021 16:26:53 +0000 (UTC)
Date:   Tue, 2 Mar 2021 16:26:53 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Borislav Petkov <bp@alien8.de>, Jessica Yu <jeyu@kernel.org>,
        Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH/RFC 1/2] init/initramfs.c: allow asynchronous unpacking
Message-ID: <20210302162653.GO4332@42.do-not-panic.com>
References: <20210224142909.2092914-1-linux@rasmusvillemoes.dk>
 <20210224142909.2092914-2-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224142909.2092914-2-linux@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 03:29:08PM +0100, Rasmus Villemoes wrote:
> This is primarily motivated by an embedded ppc target, where unpacking
> even the rather modest sized initramfs takes 0.6 seconds, which is
> long enough that the external watchdog becomes unhappy that it doesn't
> get enough attention soon enough.
> 
> But normal desktops might benefit as well. On my mostly stock Ubuntu
> kernel, my initramfs is a 26M xz-compressed blob, decompressing to
> around 126M. That takes almost two seconds.
> 
> So add an initramfs_async= kernel parameter, allowing the main init
> process to proceed to handling device_initcall()s without waiting for
> populate_rootfs() to finish.
> 
> Should one of those initcalls need something from the initramfs (say,
> a kernel module or a firmware blob), it will simply wait for the
> initramfs unpacking to be done before proceeding, which should in
> theory make this completely safe to always enable. But if some driver
> pokes around in the filesystem directly and not via one of the
> official kernel interfaces (i.e. request_firmware*(),
> call_usermodehelper*) that theory may not hold - also, I certainly
> might have missed a spot when sprinkling wait_for_initramfs().
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  .../admin-guide/kernel-parameters.txt         | 12 +++++
>  drivers/base/firmware_loader/main.c           |  2 +
>  include/linux/initrd.h                        |  7 +++
>  init/initramfs.c                              | 51 ++++++++++++++++++-
>  init/main.c                                   |  1 +
>  kernel/umh.c                                  |  2 +
>  usr/Kconfig                                   | 10 ++++
>  7 files changed, 84 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 0ac883777318..e9aca86d429b 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1820,6 +1820,18 @@
>  			initcall functions.  Useful for debugging built-in
>  			modules and initcalls.
>  
> +	initramfs_async= [KNL] Normally, the initramfs image is
> +			unpacked synchronously, before most devices
> +			are initialized. When the initramfs is huge,
> +			or on slow CPUs, this can take a significant
> +			amount of time. Setting this option means the
> +			unpacking is instead done in a background
> +			thread, allowing the main init process to
> +			begin calling device_initcall()s while the
> +			initramfs is being unpacked.
> +			Format: <bool>
> +			Default set by CONFIG_INITRAMFS_ASYNC.
> +
>  	initrd=		[BOOT] Specify the location of the initial ramdisk
>  
>  	initrdmem=	[KNL] Specify a physical address and size from which to
> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index 78355095e00d..4fdb8219cd08 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -15,6 +15,7 @@
>  #include <linux/kernel_read_file.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
> +#include <linux/initrd.h>
>  #include <linux/timer.h>
>  #include <linux/vmalloc.h>
>  #include <linux/interrupt.h>
> @@ -504,6 +505,7 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
>  	if (!path)
>  		return -ENOMEM;
>  
> +	wait_for_initramfs();

Some folks might want this to not wait, say for folks who use built-in
firmware, but for such use cases a new API which *purposely* only look
for builtin-firmware would resolve that. The only case I think think of
that folks may explicitly want this today is in
arch/x86/kernel/cpu/microcode/, see get_builtin_firmware() calls, those
should use a proper API, not a hack-in solution like that.
I think Boris was working on this long ago, but he's as usual busy.

But since this use the builtin stuff directly it is not affected. And
even if it was affected by this delay, it would have been before.

Other than what Linus pointed out, I see no reason why folks could
experiment with this, in fact I welcome it.

  Luis
