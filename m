Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E43A38C55A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 13:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbhEULDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 07:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbhEULDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 07:03:37 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75106C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 04:02:13 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id z130so10902111wmg.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 04:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zXQwSh/h376ryRkX1oqj9McqXTZcUyFdPl6LOkCUKzE=;
        b=bSo1NMGSqsdxIXWtjA5dlmY3IbKvzh6BIpmMlxsplEc2LI+LjohpJob4vO69efYw8x
         iHIcuUXh+5k7sLC/Q0N1Wxu7PKQwbRaLs6neHa/G4zICfqgmdt/EV049jAiUesud3Ksp
         TMq+8og5aIDywQBrvfnAQagOkpWqiSdtfjbua5SsbwArnO1fQnN3xYdUkrXH/cYgQsES
         h9M7ta7+E57QKE5ztq7nulJeaTogq9/VMQVesM2Zxo8hTjqKKFstsu0/77KOhTCw6yZ/
         Sr98OWCCqfbz5XWR+8pUUn7FJ9ccuvazITqqBAYuoxjVmfXoOd9Pc/KKhUTzQHU2JYBz
         wVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zXQwSh/h376ryRkX1oqj9McqXTZcUyFdPl6LOkCUKzE=;
        b=W74bQqLn5olNSmoVYRwBvtY5NNU1hltY7e+rkhd0ttYiY6jCU85WfhzO4yKVm/mGBx
         Dd/IMcRWTlKQbl1LZeXBXjOw08Byg+m8PwmSBwfrwVJVTss84QCqKbbLjAwphd87DhWc
         da7i7TLhgbMkXsLV4fkBDmCjiCV8ZIqJdoPfZOoDFUYeVZDFfbYaQX8wqUTRMFu6/BVA
         5Rd3ymtIU5QKO7gNHhsvmhFVrKF3RiIrh5+sCVGjfwLPJ9U0yFA++53KgfEPxb1ZXK2z
         +4wv+Zm5tj5ugJp4sL+/8DNmQFNS6Ok4GnfyK0D3lzjBQ5Ki89R8+gsS6HjUltNgoN20
         O8MQ==
X-Gm-Message-State: AOAM530wlIDSdjhV8fMwWTUIz+aQOeM5IfXI8BkHNEH2HJsMrESiThdZ
        ClC/mSCLC38f4QLbIql3vvAU/A==
X-Google-Smtp-Source: ABdhPJwgXmCgSw7C90PmexTvYfs/nHmGZBmqJOyk1tMkQi6xrpB8JCAOa3uOYxwMHKNkdU4RsH0K6A==
X-Received: by 2002:a1c:1d86:: with SMTP id d128mr8567780wmd.121.1621594932077;
        Fri, 21 May 2021 04:02:12 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id m9sm2080479wrs.36.2021.05.21.04.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 04:02:11 -0700 (PDT)
Date:   Fri, 21 May 2021 12:02:06 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Quentin Perret <qperret@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Matthias Maennich <maennich@google.com>,
        Giuliano Procida <gprocida@google.com>, kernel-team@android.com
Subject: Re: [PATCH] export: Make CRCs robust to symbol trimming
Message-ID: <20210521110206.GE2549456@dell>
References: <20210408180105.2496212-1-qperret@google.com>
 <YJkJ21n71SIkUppu@google.com>
 <CAF2Aj3iJ3jGCSTaO0p8WT2TrRX--QxQT0bD6iH1+OGbx5H-muQ@mail.gmail.com>
 <YKePWull0E86SXpm@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YKePWull0E86SXpm@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 May 2021, Greg Kroah-Hartman wrote:

> On Fri, May 21, 2021 at 10:57:44AM +0100, Lee Jones wrote:
> > On Mon, 10 May 2021 at 11:25, Quentin Perret <qperret@google.com> wrote:
> > 
> > > Hi,
> > >
> > > On Thursday 08 Apr 2021 at 18:01:05 (+0000), Quentin Perret wrote:
> > > > The CRC calculation done by genksyms is triggered when the parser hits
> > > > EXPORT_SYMBOL*() macros. At this point, genksyms recursively expands the
> > > > types, and uses that as the input for the CRC calculation. In the case
> > > > of forward-declared structs, the type expands to 'UNKNOWN'. Next, the
> > > > result of the expansion of each type is cached, and is re-used when/if
> > > > the same type is seen again for another exported symbol in the file.
> > > >
> > > > Unfortunately, this can cause CRC 'stability' issues when a struct
> > > > definition becomes visible in the middle of a C file. For example, let's
> > > > assume code with the following pattern:
> > > >
> > > >     struct foo;
> > > >
> > > >     int bar(struct foo *arg)
> > > >     {
> > > >       /* Do work ... */
> > > >     }
> > > >     EXPORT_SYMBOL_GPL(bar);
> > > >
> > > >     /* This contains struct foo's definition */
> > > >     #include "foo.h"
> > > >
> > > >     int baz(struct foo *arg)
> > > >     {
> > > >       /* Do more work ... */
> > > >     }
> > > >     EXPORT_SYMBOL_GPL(baz);
> > > >
> > > > Here, baz's CRC will be computed using the expansion of struct foo that
> > > > was cached after bar's CRC calculation ('UNKOWN' here). But if
> > > > EXPORT_SYMBOL_GPL(bar) is removed from the file (because of e.g. symbol
> > > > trimming using CONFIG_TRIM_UNUSED_KSYMS), struct foo will be expanded
> > > > late, during baz's CRC calculation, which now has visibility over the
> > > > full struct definition, hence resulting in a different CRC for baz.
> > > >
> > > > This can cause annoying issues for distro kernel (such as the Android
> > > > Generic Kernel Image) which use CONFIG_UNUSED_KSYMS_WHITELIST. Indeed,
> > > > as per the above, adding a symbol to the whitelist can change the CRC of
> > > > symbols that are already kept exported. As such, modules built against a
> > > > kernel with a trimmed ABI may not load against the same kernel built
> > > > with an extended whitelist, even though they are still strictly binary
> > > > compatible. While rebuilding the modules would obviously solve the
> > > > issue, I believe this classifies as an odd genksyms corner case, and it
> > > > gets in the way of kernel updates in the GKI context.
> > > >
> > > > To work around the issue, make sure to keep issuing the
> > > > __GENKSYMS_EXPORT_SYMBOL macros for all trimmed symbols, hence making
> > > > the genksyms parsing insensitive to symbol trimming.
> > > >
> > > > Signed-off-by: Quentin Perret <qperret@google.com>
> > >
> > > Gentle ping.
> > >
> > > Is there anything else I should do in this one?
> > >
> > 
> > With Greg's Ack and ~6 weeks on the list, you're probably golden.
> > 
> > I *could* pick this up, but seems wrong somehow.
> > 
> > Greg, is this something you're prepared to merge?  If not, who's the
> > g{uy,al}?
> 
> What does get_maintainer.pl show?

It doesn't [0], which is why I commented in this way. :)

[0]:

 Jessica Yu <jeyu@kernel.org> (commit_signer:2/5=40%)
 Emil Velikov <emil.l.velikov@gmail.com> (commit_signer:2/5=40%)
 Miroslav Benes <mbenes@suse.cz> (commit_signer:2/5=40%)
 Nick Desaulniers <ndesaulniers@google.com> (commit_signer:2/5=40%,authored:1/5=20%,added_lines:1/7=14%,removed_lines:1/11=9%)
 Greg Kroah-Hartman <gregkh@linuxfoundation.org> (commit_signer:1/5=20%)
 Quentin Perret <qperret@google.com> (authored:1/5=20%,added_lines:5/7=71%)
 Joe Perches <joe@perches.com> (authored:1/5=20%,added_lines:1/7=14%,removed_lines:1/11=9%)
 linux-kernel@vger.kernel.org (open list)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
