Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8403E40325C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 03:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346797AbhIHBol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 21:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346153AbhIHBok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 21:44:40 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A1DC061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 18:43:33 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id n11so576139edv.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 18:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cmtZIOS9Ve5xG2iMzkU1sWtv+qTK9kG1NPN7g5hyzNo=;
        b=Avp2QNon6oXLwlm91DcxXo2K8Ngk0nif54gPFAF8gSN1i8UGU3RnS5zbBTY4njddzE
         kRimZCEAjTDErRvXr9NzGnDj9ERJN9NqfNGni7tfa8fg8ZRHueouEt6GdIwj0aLgB6gt
         6fk+gKUyYscFIVOTodXPJQY4t8lVrFzEU6fng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cmtZIOS9Ve5xG2iMzkU1sWtv+qTK9kG1NPN7g5hyzNo=;
        b=oQ86+Zm9t9zs43Lcu967gxToRIBPVBIezsNnrfaqziRQK6DIN0y2RRRFBqrnk+QoTC
         KTz+xAZPjbf9JHGn6TxQ9eAqfrvdcEWGJdzMpzT29YrZDQM/d7STLDjhIUOXw3WtYb47
         qUHZdI3nJ7U4jXJLi2W3Hf/Z1n6/lkB1LUIznFQKdcKkOw/5qOhpakFlHmLHQohKhDD1
         B3j+HgRRDTe8oOfCGZR2Z3jklZN/zbUF20MMss6dZ/NMkRXXOXz/SFRB66aHoh95YzIf
         JFc7VYGz/HKGCjPROLZE3PvXvqvEmtcpMoYfJ4rsRNYuQRX7NG5TsJQs8wE0UoEYPHx4
         994Q==
X-Gm-Message-State: AOAM532fNvthV9/tFoJku4Whkc2zftW1jWUsb6eoAqOkDaEYIRwZ7ne2
        qEvSXAfVaGlna7jyRbcTz82X6tuYG1i9Z5Wsa9I=
X-Google-Smtp-Source: ABdhPJyNjOPkFj/C4N7wLrc11B46FcLx8iGc7aJwPY93CtPytcW8oiCGqh0+i34OXpTNIaR/SQ+v8Q==
X-Received: by 2002:a05:6402:2032:: with SMTP id ay18mr1272345edb.364.1631065411801;
        Tue, 07 Sep 2021 18:43:31 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id r26sm196982ejd.85.2021.09.07.18.43.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 18:43:31 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id q26so728662wrc.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 18:43:31 -0700 (PDT)
X-Received: by 2002:a2e:b53a:: with SMTP id z26mr781467ljm.95.1631064966392;
 Tue, 07 Sep 2021 18:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtFvJdtBknaDKR54HHMf4XsXKD4UD3qXkQ1KhgY19n3tw@mail.gmail.com>
 <CAHk-=wisUqoX5Njrnnpp0pDx+bxSAJdPxfgEUv82tZkvUqoN1w@mail.gmail.com>
 <CAHk-=whF9F89vsfH8E9TGc0tZA-yhzi2Di8wOtquNB5vRkFX5w@mail.gmail.com>
 <92c20b62-c4a7-8e63-4a94-76bdf6d9481e@kernel.org> <CAHk-=wiynwuneR4EbUNtd2_yNT_DR0VQhUF1QOZ352D-NOncjQ@mail.gmail.com>
 <a2c18c6b-ff13-a887-dd52-4f0aeeb25c27@kernel.org>
In-Reply-To: <a2c18c6b-ff13-a887-dd52-4f0aeeb25c27@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Sep 2021 18:35:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=whcFKGyJOgmwJtWwDCP7VFPydnTtsvjPL6ZP6d6gTyPDQ@mail.gmail.com>
Message-ID: <CAHk-=whcFKGyJOgmwJtWwDCP7VFPydnTtsvjPL6ZP6d6gTyPDQ@mail.gmail.com>
Subject: Re: ipv4/tcp.c:4234:1: error: the frame size of 1152 bytes is larger
 than 1024 bytes [-Werror=frame-larger-than=]
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Ariel Elior <aelior@marvell.com>,
        GR-everest-linux-l2@marvell.com, Wei Liu <wei.liu@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 5:15 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Ah, okay, that is an x86-only limitation so I missed it. I do not think
> there is any bug with that Kconfig logic but it is only used on x86.

Yeah. I think other architectures are basically just buggy, but nobody
has ever cared or noticed, because the hardware basically doesn't
exist.

People hopefully don't actually configure for the kernel theoretical
maximum outside of x86. Even there it's a bit ridiculous, but the
hardware with lots and lots of cores at least _has_ existed.

> Indeed. Grepping around the tree, I see that arc, arm64, ia64, powerpc,
> and sparc64 all support NR_CPUS up to 4096 (8192 for PPC) but none of
> them select CPUMASK_OFFSTACK

I think this one says it all:

   arch/arc/Kconfig: range 2 4096

yeah. ARC allows you to configure 4k CPU's.

I think a lot of them have just copied the x86 code (it was 4k long
ago), without actually understanding all the details.

That is indeed a strong argument for getting rid of the current
much-too-subtle CPUMASK_OFFSTACK situation.

But as the hyperv code shows, even on x86 the "we never allocate a
full cpumask on the stack" has gotten lost a bit since the days that
Rusty and others actually implemented this all.

           Linus
