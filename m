Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB4F401E16
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 18:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243858AbhIFQNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 12:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238452AbhIFQNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 12:13:36 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B926C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 09:12:31 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id s12so12159703ljg.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 09:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hYS9+nltkRVvqUm5CmdhVmH+ALslv6xme21bOkTYocQ=;
        b=VYGGPZPNBbWCuSJ1UEVbkPjJq2Lyfd/u0WtP0VF5Pl5b8+dBnFmHXlVDSNRplBiDAH
         KszTYCunx4zsrA5cbC8iwV4WCjXhIgyPbwlQd18riW8k/UhlgyxmltKZiWdU5Ar0uzF8
         ORkGrm6zw2qvK+d6Sm9faG2fYVydaGxRmVf5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hYS9+nltkRVvqUm5CmdhVmH+ALslv6xme21bOkTYocQ=;
        b=sivGapfvS9C5eZsbADasfnwxQy33VJ3G9/mCfhSO2loi2DVY0RBdBFyAVlFv5KvAoj
         EYEZEgzoWdWREC+WIeyd4Ny4mz+lDhgT5NOLhcOQLi8fgxgM0xebzcVq8r+8XRP0HpDd
         QSGb0e2C6RIAQ5Q28dQ5JKlY/Ju1/gE1Gy3k4UtkrIEEqAzxjWvc8aEwZoBZZWaaoVsQ
         ASsUS/gFBWg81Mj3b5bYugD8tvqz8fHiPFOFc8QqUcG2wjZjrsCUbwLh24IJoAw1J9v+
         tbhIS5bv/WwoFwjCdJp2ITQoDVCuMqPgxJJUjtfEDw4m66tU5h/9V1nmb+ITTxTv/ZSB
         86Ew==
X-Gm-Message-State: AOAM533l5xvfn7nM2zq0BpAhmgpikq+UNJU42rDn8AcxBOM2H9Gl4Me8
        Npthr5wNyMfn9SApRcpinlhz9I5+3use4iewnzk=
X-Google-Smtp-Source: ABdhPJwXC1bFLxOUiW5cN4u3NZr4NmyojwXnjZCTO/1gPsAErOH+XeXNYPTN3ZCZ9+fxR1/2CjCyvw==
X-Received: by 2002:a2e:22c1:: with SMTP id i184mr11563602lji.89.1630944749155;
        Mon, 06 Sep 2021 09:12:29 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id a13sm1111390ljn.120.2021.09.06.09.12.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 09:12:28 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id y34so14275879lfa.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 09:12:28 -0700 (PDT)
X-Received: by 2002:a05:6512:114c:: with SMTP id m12mr9963367lfg.150.1630944748158;
 Mon, 06 Sep 2021 09:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210906142615.GA1917503@roeck-us.net>
In-Reply-To: <20210906142615.GA1917503@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Sep 2021 09:12:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
Message-ID: <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 6, 2021 at 7:26 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Build results:
>         total: 153 pass: 89 fail: 64

Well, that sadly proves the point of that patch. x86-64 may be clean,
because I have required it manually. Others not necessarily so much..

I've got at least one sparc64 fix in my inbox. It _might_ fix some
other cases too (syscall checking), but I suspect it's one of those
"death by a thousand cuts" situations, not just one or two issues that
show up.

Do you end up exposing the errors anywhere where I can take a look?

If some of them are just because of bad tooling on certain
architectures (ie fundamentally "this is unfixable, because we use
gcc-XYZ that just always causes warnings") then those we could/should
just disable -Werror for those and forget about them.

But hopefully most cases are just "people haven't cared enough" and
easily fixed.

              Linus
