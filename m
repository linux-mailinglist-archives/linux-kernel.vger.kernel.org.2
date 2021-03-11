Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363C4337BA4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 19:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhCKSDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 13:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhCKSCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 13:02:47 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5A4C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 10:02:47 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id k9so41230699lfo.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 10:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R+nPiG6vkXVlpG0JfN9IBkVkQ5Q1BHXRP+POXCPvqWs=;
        b=RfVV2NlIoXvjgBN+MjqHNPZjMwJ7f1GySZu69VjmlSCHT9vB7gDkLJMGaGVd+gfl6S
         3AXhEAMoKM1POI0aLmTsS7dwirCfOK7QPCP1QdArVeyk9BxH5EJrJOcsotdcTserIXAw
         zxKU/Q9qimD17W9cALS+5QaSsEUao3z7RFmyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R+nPiG6vkXVlpG0JfN9IBkVkQ5Q1BHXRP+POXCPvqWs=;
        b=oiFJcp+Y9pdq9T6EdmqbCH5bYh0FyyOGrkDF46HIqlvWvCFGmxhmN/YgsJPyoIkviJ
         q+YpMsdHsFWU3yVUyGikrQd4huyrqRUky3If/YO0noqmYiaBwbPU3I+GenkgoKJSgj95
         xvYeLSRzLh7Y1EVJkVCjVRmKTSTN1ia8jARbg9fWGdPK2P0Nmi+a7Df3tr2R9s+XJoP4
         dTFI/1kytBUUQlKex+huS+2lRAvb/uVI8hT7CGDf2oIgn153hhC/H408K0tuRblBEyeO
         F+ZAxYbQdz4UUZgROQoXG40DbSzfycb+oVLY5qdDPEATI65rQXyaZyXdIu52qs2MAAhO
         FAnw==
X-Gm-Message-State: AOAM531cMpriMhriTGiHoM6QZaxJjd+9g8Txnfy5G8NNq8kfrvMRgxoA
        bMyxwEAV3EoE9VQtny6IwRxOOQmQRVgTBQ==
X-Google-Smtp-Source: ABdhPJxv/dgDj6k6AioVUU/i+2q3ET1kbuPOABAtMIlD0gXYz9GHAbEv4E/YHLFSpGTEbWqzyWTfsA==
X-Received: by 2002:a05:6512:3249:: with SMTP id c9mr3081864lfr.5.1615485765505;
        Thu, 11 Mar 2021 10:02:45 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id d7sm1047386lfg.303.2021.03.11.10.02.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 10:02:44 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id n16so41290372lfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 10:02:44 -0800 (PST)
X-Received: by 2002:a05:6512:104b:: with SMTP id c11mr2839064lfb.421.1615485763863;
 Thu, 11 Mar 2021 10:02:43 -0800 (PST)
MIME-Version: 1.0
References: <20210224142909.2092914-1-linux@rasmusvillemoes.dk>
 <20210309211700.2011017-1-linux@rasmusvillemoes.dk> <20210309211700.2011017-2-linux@rasmusvillemoes.dk>
 <CAHk-=wgfMQyYSkdRkCuHOQEcvoyw=fN7q+0cU-s9dNqDHkSmrw@mail.gmail.com>
 <2a33d478-b7a8-5b3c-7bc5-f33eb27b44fa@rasmusvillemoes.dk> <2a8c6ceb-9dda-f8b6-1a96-6e75dd3b4eea@rasmusvillemoes.dk>
In-Reply-To: <2a8c6ceb-9dda-f8b6-1a96-6e75dd3b4eea@rasmusvillemoes.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 11 Mar 2021 10:02:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjiNDC9QAnVGS9w9enXiErHJLdm6982VJAZFmNoPH-AEg@mail.gmail.com>
Message-ID: <CAHk-=wjiNDC9QAnVGS9w9enXiErHJLdm6982VJAZFmNoPH-AEg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] init/initramfs.c: allow asynchronous unpacking
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 5:45 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> Hm, gcc does elide the test of the return value, but jumps back to a
> place where it always loads state from its memory location and does the
> whole switch(). To get it to jump directly to the code implementing the
> various do_* helpers it seems one needs to avoid that global variable
> and instead return the next state explicitly. The below boots, but I
> still can't see any measurable improvement on ppc.

Ok. That's definitely the right way to do efficient statemachines that
the compiler can actually generate ok code for, but if you can't
measure the difference I guess it isn't even worth doing.

Thanks for checking, though.

        Linus
