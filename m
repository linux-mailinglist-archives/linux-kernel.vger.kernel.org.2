Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730A3380C21
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 16:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbhENOq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 10:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbhENOqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 10:46:25 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75654C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 07:45:14 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id w22so14763006oiw.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 07:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a4ec9HrK4exLNdFoaRuR+1/fBbQJf79OPKrfXFd1y+Q=;
        b=cCh4rJ+jLCwHOySclWi/hxbsrBN/knU3k6iyeSOpNa029f/gEvfeTen3wcRnSN++DO
         BznnqYVww+aBxCmkZFaUBSIwZ433Kv8pezR8RVI33o8oF64gNctoWSWyCUcDDCosYHGc
         6u1F+9H7rHB5FOhqzYYjiguylGWQEH3G3FU5kUJjGasOcbZvMUiv2aHm6VKBNFv9bccD
         WzC5F0Tkje1HmDIQ6YI+U26AKlElAvuGOTuwjJum2ovaXeyariBT/KqdGVsIAy7nT5/D
         QdJQF5kq2BjURpQ5Df4YM9es8RYQt8WNXHsG+iWDhkkVJXzXIXqA2+Z7fiWLOmY5LsBL
         qDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a4ec9HrK4exLNdFoaRuR+1/fBbQJf79OPKrfXFd1y+Q=;
        b=RdwvKnC0Ump7ft8Xb7H/+7eFiGqka6ISRACPwz6ydqNKacBLLEH0u07FR6hf0x+9ft
         d7RY78nGQmSFtxARE/wxgSJ5lfbPSv7Av9PSHqvui8BQGtw4j2EzFjPlsuhhHxANgRCo
         mrF+s4B4Z8Y0oTjvxSkB5t2sMpzM70tnbwXws1B2K8HtgVX/1mwILybdjEbYxSGEPyg8
         5pLJYbFWZFlyLcBIZyrKumhd8cXwYW0QiD/8PnbJ6I0JGyaWT9xpsYWKcsa8ztd0SNvh
         OvWFC3aTab19LHTgIOPDnMr4VMy21V2JXCi3r8LEhF7G7z6mEj+E1NCpuQBA/fnmyTBY
         Fu/Q==
X-Gm-Message-State: AOAM532qoHKxd+WUXXfzxHk4X4ZOCYdxjTDZ53NiXiUGsuK0ppyN6Slo
        3njSDg9jGAImT7CPqfDmB7wK1wHkxoD7NZaxUO0ZozAqGwOcSQ==
X-Google-Smtp-Source: ABdhPJzji7JCPpwfpxmtJyrdybwjjTdBZYaTphELI3UT0rST6tJp66i9W7DoAeu660DBbHpDHx8qOpXaPmsOZK+U9/A=
X-Received: by 2002:aca:408a:: with SMTP id n132mr34789902oia.70.1621003513688;
 Fri, 14 May 2021 07:45:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210514140015.2944744-1-arnd@kernel.org> <YJ6E1scEoTATEJav@kroah.com>
In-Reply-To: <YJ6E1scEoTATEJav@kroah.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 14 May 2021 16:45:01 +0200
Message-ID: <CANpmjNMgiVwNovVDASz1jrUFXOCaUY9SvC7hzbv2ix_CaaSvJA@mail.gmail.com>
Subject: Re: [PATCH] kcsan: fix debugfs initcall return type
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2021 at 16:10, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Fri, May 14, 2021 at 04:00:08PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > clang points out that an initcall funciton should return an 'int':
> >
> > kernel/kcsan/debugfs.c:274:15: error: returning 'void' from a function with incompatible result type 'int'
> > late_initcall(kcsan_debugfs_init);
> > ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
> > include/linux/init.h:292:46: note: expanded from macro 'late_initcall'
> >  #define late_initcall(fn)               __define_initcall(fn, 7)
> >
> > Fixes: e36299efe7d7 ("kcsan, debugfs: Move debugfs file creation out of early init")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[...]
> >
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Marco Elver <elver@google.com>

Thanks for catching this -- it boggles my mind why gcc nor clang
wouldn't warn about this by default...
Is this a new clang?

Paul, please also add a "Cc: stable <stable@vger.kernel.org>" because
e36299efe7d7 is, too.

Thanks,
-- Marco
