Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D22D32FD1B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 21:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhCFU2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 15:28:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:35546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231419AbhCFU2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 15:28:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52015650BB
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 20:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615062517;
        bh=FbFUAhMcWk8nluH8AWEZYz/pjD7uDN7+Y6qsWXcBsSM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SvQ/6MZIEae2rVRZGEWKYOktzULZeEIPBHP7KzTwm1XD8jU9H/7ZcHC1nHCtLQkIK
         fSVizAMSLTJ3F2kdJSHZM+GORE0zC8XiQt2WtWGjDYokc4ye/Dr9Eu/NgNB4dlC33t
         6pAbmlpCirwFeuQ5S/9TiMIfumnAVWTze8qqoaAU9nEWqdIpNj2xwNTFEE9PUZXYhm
         eHREVm+alZ6GUgo2Ib8wyu+/VC0uigBSvLdgVY4Zv+K2asxywNp4EH8uoTYf0I0NNS
         /8/JY5Kzv5j/gzmrE+RfwyElCFe8CdYL0saES2/5Xfof6phAfsUdtGXWZrj91dsTrw
         EGkIFJ4WTUsKA==
Received: by mail-qv1-f51.google.com with SMTP id t1so2757045qvj.8
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 12:28:37 -0800 (PST)
X-Gm-Message-State: AOAM532Xv4JK7JI5RtQs4Mn3FbHoD4w6JOoWfxF13iLvM/+XpnROPdsF
        U1qUF6/Gh3oUVlyBJbRZHo6IAIr9FsKx975Iv4g=
X-Google-Smtp-Source: ABdhPJxbRqjPrfKCPrQpb1HQoBTmcwKrCdzTckHk5QJpHmIOL5bXMwGdp7CHMjlVYSYl66gpZT9qkPPePY5KQ63ITa8=
X-Received: by 2002:a0c:f541:: with SMTP id p1mr9066255qvm.14.1615062516404;
 Sat, 06 Mar 2021 12:28:36 -0800 (PST)
MIME-Version: 1.0
References: <20210305194206.3165917-1-elver@google.com> <20210305194206.3165917-2-elver@google.com>
In-Reply-To: <20210305194206.3165917-2-elver@google.com>
From:   Timur Tabi <timur@kernel.org>
Date:   Sat, 6 Mar 2021 14:27:58 -0600
X-Gmail-Original-Message-ID: <CAOZdJXXXweZG0Mgcf4LLt2SV3mONESunLwgx2c4rDaKrWevrYQ@mail.gmail.com>
Message-ID: <CAOZdJXXXweZG0Mgcf4LLt2SV3mONESunLwgx2c4rDaKrWevrYQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] lib/vsprintf: reduce space taken by no_hash_pointers warning
To:     Marco Elver <elver@google.com>
Cc:     lkml <linux-kernel@vger.kernel.org>, vbabka@suse.cz,
        timur@kernel.org, Petr Mladek <pmladek@suse.com>,
        rostedt@goodmis.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        andriy.shevchenko@linux.intel.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 5, 2021 at 1:46 PM Marco Elver <elver@google.com> wrote:
> +static const char no_hash_pointers_warning[8][55] __initconst = {
> +       "******************************************************",
> +       "   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   ",
> +       " This system shows unhashed kernel memory addresses   ",
> +       " via the console, logs, and other interfaces. This    ",
> +       " might reduce the security of your system.            ",
> +       " If you see this message and you are not debugging    ",
> +       " the kernel, report this immediately to your system   ",
> +       " administrator!                                       ",
> +};
> +
>  static int __init no_hash_pointers_enable(char *str)
>  {
> +       /* Indices into no_hash_pointers_warning; -1 is an empty line. */
> +       const int lines[] = { 0, 1, -1, 2, 3, 4, -1, 5, 6, 7, -1, 1, 0 };

You can save a few more bytes by making this an array of s8.

I agree with the __initconst.  The rest seems overkill to me, but I
won't reject it.

Acked-by: Timur Tabi <timur@kernel.org>
