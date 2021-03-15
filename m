Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5ED533C7A3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 21:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbhCOUVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 16:21:18 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:38423 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbhCOUVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 16:21:11 -0400
Received: by mail-pj1-f41.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso108287pji.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 13:21:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tE3KW+4aBQn+aDjatnRbs367+dzc11McNltTJfv0RjI=;
        b=dNrnIybLaP8lmWpfHI7Loci7ZIXZ9/waCiqlmCpYg7laxy6dJeAZ2ME7uZfJ+dH8Ah
         cyFss98Y57Gabjebn/nW4bsTtS/Gr7YXWTTKBhGp3tyWHCwZmam6ykfvLt0OmNVYAIny
         N8DWUPdSOCQB6qrTUS1mPOQ+p9BfMHPe1nHHB2KDIQ6RnJHLX8oWKX1xhWXFZBgHyNnA
         nol7Nmf922Gf13pvqJyZ56cmQIlCAqIULTr4ZV/mG8FPRuGLx/8RQZVh/FLvzZDFoj6a
         pbpm93WLwTaGMxiLisvf1lsKWcnRs6vYa0G4hA2sW0AXo+4OpmrzDAMuihjmJoGPFL64
         SwPw==
X-Gm-Message-State: AOAM533pyPffzMU+xhfJRhyMi0ZKbikuKRxJKP24oi+JxBNUzW0G3OXS
        GUhkdSDIvMNWjeBaggGn57A=
X-Google-Smtp-Source: ABdhPJz6WQo0IztRQ/5mnMM6ZTlFLUBFc51471onQx9ZUay/hAkKEz+ay+dMpImZBozmYJwWDlpGFw==
X-Received: by 2002:a17:902:da91:b029:e5:e7cf:d737 with SMTP id j17-20020a170902da91b02900e5e7cfd737mr13065274plx.24.1615839671382;
        Mon, 15 Mar 2021 13:21:11 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id h14sm472557pjc.37.2021.03.15.13.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 13:21:10 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 558FA40106; Mon, 15 Mar 2021 20:21:09 +0000 (UTC)
Date:   Mon, 15 Mar 2021 20:21:09 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH v3 1/2] init/initramfs.c: do unpacking asynchronously
Message-ID: <20210315202109.GY4332@42.do-not-panic.com>
References: <20210313212528.2956377-1-linux@rasmusvillemoes.dk>
 <20210313212528.2956377-2-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210313212528.2956377-2-linux@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2021 at 10:25:27PM +0100, Rasmus Villemoes wrote:
> Most of the boot process doesn't actually need anything from the
> initramfs, until of course PID1 is to be executed. So instead of doing
> the decompressing and populating of the initramfs synchronously in
> populate_rootfs() itself, push that off to a worker thread.
> 
> This is primarily motivated by an embedded ppc target, where unpacking
> even the rather modest sized initramfs takes 0.6 seconds, which is
> long enough that the external watchdog becomes unhappy that it doesn't
> get attention soon enough. By doing the initramfs decompression in a
> worker thread, we get to do the device_initcalls and hence start
> petting the watchdog much sooner.
> 
> Normal desktops might benefit as well. On my mostly stock Ubuntu
> kernel, my initramfs is a 26M xz-compressed blob, decompressing to
> around 126M. That takes almost two seconds:
> 
> [    0.201454] Trying to unpack rootfs image as initramfs...
> [    1.976633] Freeing initrd memory: 29416K
> 
> Before this patch, these lines occur consecutively in dmesg. With this
> patch, the timestamps on these two lines is roughly the same as above,
> but with 172 lines inbetween - so more than one cpu has been kept busy
> doing work that would otherwise only happen after the
> populate_rootfs() finished.
> 
> Should one of the initcalls done after rootfs_initcall time (i.e.,
> device_ and late_ initcalls) need something from the initramfs (say, a
> kernel module or a firmware blob), it will simply wait for the
> initramfs unpacking to be done before proceeding, which should in
> theory make this completely safe.
> 
> But if some driver pokes around in the filesystem directly and not via
> one of the official kernel interfaces (i.e. request_firmware*(),
> call_usermodehelper*) that theory may not hold - also, I certainly
> might have missed a spot when sprinkling wait_for_initramfs(). So
> there is an escape hatch in the form of an initramfs_async= command
> line parameter.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
