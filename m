Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45BE307FAE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 21:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbhA1U1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 15:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhA1UZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 15:25:46 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE48C061574
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 12:25:06 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id b20so82613ljo.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 12:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1tACUR/LflNb3xiypGIJAOB6qg90kRzu1Bn+isppjuU=;
        b=Z0wOnR+xWLEEYZyJtmF4cIaKTBfBVVe1eeYhMK7xw537F0yzoHCspxlEXjdVuTdK0G
         joZeBK9AflS4N3Vv3DI2P9WSeG9IFXDCJSlQ2a0zsffUznIcHhMevwVEhYdoBUBL29S2
         wnPDvU9qQiBA4rJIkIBFyJ9BVUzB/oe2EmzfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1tACUR/LflNb3xiypGIJAOB6qg90kRzu1Bn+isppjuU=;
        b=WSqCl2PPhu7Z94HwAfVraIWsRPvVhqQ3T0xNBfiJigEtV6MqJYwWZ7GHPSbnXv3Ezh
         ruROA2B/rgsipSXWUYfcFE9BWNQ/W1luX4wCCTKBCCMNILPd/mWMp65oXB23CX8pvIq4
         iQqyiQKoPRlN2P/UnzWmASeH8ywJf81/sCJ6gM9aEs3wIRr5bbn/5cwjDBJ3zvoz/YF/
         UvXEwau5c50+GVNUH5VygV921/MO8ujDwi5CfDhidCoEPBqtWYfFiotDZvaz1/oexj7D
         9y7w/AsqUQdM83u7oPEIUd6OsvAzT8Js/IfZehl/V/xo14+z2ZfRjM7eznGiGU/HO/uE
         6wUw==
X-Gm-Message-State: AOAM533VYysGKWVEKJpR/P/peT0OeFeoKc2X3SeAiecN5LGZcNeHldWg
        ai5D3MA4z26I2V9Ot0BHJk9HUVykFceomQ==
X-Google-Smtp-Source: ABdhPJwMmjn20yBjnlS6cAXZXQ+6jtHuPRjmylqWlU1fewcNWt1xQW4xPgiOZ3vto2oKvvS1z3jjkw==
X-Received: by 2002:a2e:b896:: with SMTP id r22mr566774ljp.234.1611865503957;
        Thu, 28 Jan 2021 12:25:03 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id w13sm1786132lfu.299.2021.01.28.12.25.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 12:25:03 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id p21so9344521lfu.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 12:25:02 -0800 (PST)
X-Received: by 2002:a05:6512:2287:: with SMTP id f7mr379911lfu.40.1611865502453;
 Thu, 28 Jan 2021 12:25:02 -0800 (PST)
MIME-Version: 1.0
References: <fff056a7c9e6050c2d60910f70b6d99602f3bec4.1611863075.git.jpoimboe@redhat.com>
In-Reply-To: <fff056a7c9e6050c2d60910f70b6d99602f3bec4.1611863075.git.jpoimboe@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 Jan 2021 12:24:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wih0rLHsPXodpXJw_0F3bJqu=Pb_YNmPCSsYU_huoMwZA@mail.gmail.com>
Message-ID: <CAHk-=wih0rLHsPXodpXJw_0F3bJqu=Pb_YNmPCSsYU_huoMwZA@mail.gmail.com>
Subject: Re: [PATCH RFC] kbuild: Prevent compiler mismatch with external modules
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Justin Forbes <jforbes@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Jessica Yu <jeyu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 12:08 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> Add a check for compiler mismatch, but only check the major version.

I think this is wrong for multiple reasons.

The most fundamental reason is that it's pointless and doesn't
actually do what you claim it does.

Just doing a "make oldconfig" will reset the CONFIG_xyz_VERSION to
whatever is installed, and now your check doesn't actually do
anything, since you're not actually checking what the kernel was
compiled with!

So I think that check is pointless and entirely misleading. It doesn't
do what you want it to do, and what you claim it does.

I'm not convinced about the whole magic vs minor argument either. The
whole "new compiler features" thing is a red herring - even if you do
have new compiler features, that in itself has very little to do with
whether the resulting object files are compatible or not.

So I say NAK, on the basis that the patch is nonsensical, tests the
wrong thing, and doesn't really have a technical reason for it.

             Linus
