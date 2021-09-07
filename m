Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F984030CB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 00:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347655AbhIGWRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 18:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbhIGWRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 18:17:32 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71B5C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 15:16:25 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id y34so725867lfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 15:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rI0WC20BXjVjzaeO3sQGxSjjHO4dQiVDCRLV5j9nGLk=;
        b=P75ZGmdgymFTaH6OHWYMs7eNE2c+mhXoEVHPp9EGFVi+KAgBuf5F4S4+vC681qLeb9
         GI81Qvv3LNNelXKtmfuR7j7Y2zB1QcDgmAnAWgRpVsoygPpZy6eTHzOY8aEX3ZL4jPGy
         Tm9dveI0XRCpGyaySxpy3h51e6LKbYY0x05Hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rI0WC20BXjVjzaeO3sQGxSjjHO4dQiVDCRLV5j9nGLk=;
        b=sv2/Zh9negRIq/IVx78sWsmzPH09Bce4NNEhMS9ahBkBBZmT2qOJ2xtcCXUy2mFaSx
         ZX/c5AOoERMl7CuL8fhoUxN3uZzLoBB3vexpZNPvLrvflAf9bFLmHPvyjattk+RJB4wt
         3oleK5QV7T7MNzC8U79sF8W/vM3ylM6CBMyXKhpPtSKzlmdORL4wCi9GA8fsZ9yNW2ir
         EzwHLQ8a7KHsreeyrqACUbF0r0piyNj2mQrq0838FwL1CTjU8vUOpYhPTZP8YDWrDm8f
         SGLJFojWn2KtyVHqanRmtBBu6WTIcRCX4Tr98NApleoZjq0o576EWSM1FmdWuh+6egrn
         P8Ng==
X-Gm-Message-State: AOAM530GXxA3JGN4w1ijgqqWTat4Yq+UKkZpNQu1eILio9OMHwE+1KTm
        NbpBFHN1a2JHf5nQjnWjz8vlSWm5GrghU+nvHls=
X-Google-Smtp-Source: ABdhPJwR5xweS6TJHSPot1PTOhJrxRgSO+2KuNL8mbz5LSsaUGxEP13xbzAy0DfL2oMqJiioYEV67g==
X-Received: by 2002:a05:6512:338f:: with SMTP id h15mr434953lfg.38.1631052983487;
        Tue, 07 Sep 2021 15:16:23 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id bi19sm20197lfb.28.2021.09.07.15.16.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 15:16:22 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id q21so90662ljj.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 15:16:21 -0700 (PDT)
X-Received: by 2002:a2e:8107:: with SMTP id d7mr371422ljg.68.1631052981640;
 Tue, 07 Sep 2021 15:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtFvJdtBknaDKR54HHMf4XsXKD4UD3qXkQ1KhgY19n3tw@mail.gmail.com>
In-Reply-To: <CA+G9fYtFvJdtBknaDKR54HHMf4XsXKD4UD3qXkQ1KhgY19n3tw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Sep 2021 15:16:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wisUqoX5Njrnnpp0pDx+bxSAJdPxfgEUv82tZkvUqoN1w@mail.gmail.com>
Message-ID: <CAHk-=wisUqoX5Njrnnpp0pDx+bxSAJdPxfgEUv82tZkvUqoN1w@mail.gmail.com>
Subject: Re: ipv4/tcp.c:4234:1: error: the frame size of 1152 bytes is larger
 than 1024 bytes [-Werror=frame-larger-than=]
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 6, 2021 at 5:27 AM Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> /builds/linux/net/ipv4/tcp.c: In function 'do_tcp_getsockopt.constprop':
> /builds/linux/net/ipv4/tcp.c:4234:1: error: the frame size of 1152

None of these seem to be new.

It looks like this is (yet another) example of some build testing that
just never cared about warnings.

Which was the exact problem that the new -Werror flag is all about.
All these build test servers that only go "ok, it built, never mind
all the warnings".

Everybody tells me that the build servers care about warnings.
Everything I actually see tells a very different story indeed.

              Linus
