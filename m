Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF117445E97
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 04:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbhKEDbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 23:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhKEDbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 23:31:40 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBBCC061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 20:29:01 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id y8so12881910ljm.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 20:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EFhEGzd3uyu/upM/gXOMVH8uE8syXTQEP3bcTaF1vUM=;
        b=bFpgSBejwW0dhsvKWz/Gl9WyeQUV8bS0IHfmuMBgavQbazBkcpoUljvn3agruMgs1T
         MJocHOk2gCyW1AdFDJRJU94NZZlWyYl9EQCs4fWJBesThZelQAKraLpiPXXQKp8Jmd6S
         YdUxo3nem1UNKZVeplLWCJnicWwKSh7vc7WZ06aNc1bO7j7WXUCGqLHK7t6UfVsWGoR2
         pmKSsGFj1fzvzmW4XBb3kLmXMJ5DDpglzWqOG2kRDTTEahKZDQCu1MQGytLrzES4ZULa
         XK2z7oWBVQqbdk1sYiXtKg5cEkipLSLgcKOn4e1NUvoRztIaC5MXUjj0WWkKuqII8p3L
         2HaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EFhEGzd3uyu/upM/gXOMVH8uE8syXTQEP3bcTaF1vUM=;
        b=0ev9rcOTM9JUvtzkY+HaPUUDoKSqfSPt/JsJKa/EVsKjlNQJysW+Kfurpa9TddkM2z
         o7tJMCDV4GqcOoj0Db9Hrp87M5pEIfyB3qbYsTIFXzc0krxE23o/2G9hNw4eolFdEjGx
         UE/8e+KUuUAHX6XMs6B9YlkdGqPL8pC6H6SoN8aUIeNFAOplnLhECNH8NgfS5Z8lWNxL
         NN9QRdbhp+3Lj6prghS4yEZDUZuIa+vvpfOWJ9iEt73w5stI/zD/TUxPnoWLOLHh83gO
         XW5iECJ+7hDsS9FF3fQZfOo/i1A7BwwzB/2dKtC4s9+2DYGbp4Cj6ykpAo2ZbcBDqj1l
         4sYg==
X-Gm-Message-State: AOAM5327hSOX/N0PKIZ5LZ85+ILtorwLQMbpfSSk7r5OP3ed0mYELZyP
        i9CWAxPy00zLxACuyuMtY5nCHuuew9g5hw3g+/gr3g==
X-Google-Smtp-Source: ABdhPJz8qB4ZfOYpsc8hKtslo4tMCaACoDrduKl98yH+ZHvuxpZdu3mSg4Uekql9oE5ax3BjnenSvSAjQ71zsofqEuo=
X-Received: by 2002:a05:651c:1784:: with SMTP id bn4mr59884622ljb.521.1636082939433;
 Thu, 04 Nov 2021 20:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211105005955.107419-1-osk@google.com> <CACPK8XcXR=V5-Q+sC4MniNJZJgvbiysFD-5yu6v30_2BwDRTSA@mail.gmail.com>
 <CABoTLcS=s0XuM9jiisYW3=1gXtiwP8WeopqTOeBwnTX1XCky9Q@mail.gmail.com> <CACPK8XebNsSr3wiMdMxDwQuMGX3p0g2Kid91dekUc6TGcHqfYQ@mail.gmail.com>
In-Reply-To: <CACPK8XebNsSr3wiMdMxDwQuMGX3p0g2Kid91dekUc6TGcHqfYQ@mail.gmail.com>
From:   Oskar Senft <osk@google.com>
Date:   Thu, 4 Nov 2021 23:28:43 -0400
Message-ID: <CABoTLcTb5uGABwe9FG4haj1888NA4mdZqJFTeQcSotBnq1aZVg@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: aspeed: tyan-s7106: Update nct7802 config
To:     Joel Stanley <joel@jms.id.au>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel

> I test the kernels independently of yocto; I recommend doing that with
> a cross compiler when submitting patches upstream. My flow looks like
> this:
> [...]
> A few notes:
>  - I use the cross compiler from my distro. Debian unstable has GCC
> 11.2.0, which is the same as openbmc. You can use the compiler from
> your openbmc build tree if you aren't able to install a modern
> compiler
I couldn't figure out how to use the compiler from the OpenBMC tree.
The biggest issue is that it has "openbmc" in its name and Linux build
was getting confused by it. I gave up on that approach and found how
to install the right cross compiler in our environment. That worked
well. Thanks for the hints!

>  - building with -s means warnings stand out
Excellent idea, thank you!

>  - if you're working on device trees and want to ensure your binary is
> being built each time, omit the -s and build the 'dtbs' target
Ack.

I'll send a PATCH v3 now.

Oskar.
