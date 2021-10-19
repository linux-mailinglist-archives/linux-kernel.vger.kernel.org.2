Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92911432C55
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 05:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbhJSDkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 23:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbhJSDkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 23:40:42 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DFCC061745
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 20:38:29 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id p16so4362107lfa.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 20:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8/Vo8naa2pVOSCfV4UFA2BJ46wmQrSEVSsBZouXgR8Q=;
        b=TBqUPv05LF6J1Ap/h7Pz9XJiHiK0IslnX+9wn7xlIvHPKYKx/hZE2OdYd8/tUHUJiY
         5A0XsyYfcM8kS3aHiGgfpEG+nkoekDVqu2WkEHgchyxUgt84AkSR1/G59wXD3IbW6RJ1
         4qij4MWM98pZd9rp8BkYS9iuIRoGDWcJuG/YE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8/Vo8naa2pVOSCfV4UFA2BJ46wmQrSEVSsBZouXgR8Q=;
        b=VlV49Xq7kFIpeyj27m0r9q2a+41MRMKphotS/h8o8m942XUF+UAxKBaXe8NoX2UzrW
         amMu87AB6KLtzAgnvqn57vuTpsEWQhU4N3ZowX7JK5Pg0N4TFolgp4OYCx3PrNUMfHfU
         ut7R3TGnCOVitw+rWodrjNpl3UKt4P/J+S7HrnI+hGzklYuVZZV5CaHWT26oBtZB912t
         kBxsOMACnLLd8BLv1mBuF31ChL2SlDfuNduK1yKjuVzl6u/w/SVyc4flObTRNMBZw+z5
         p9VNlJqf0iyzc0GwEja6qYUHKbPMfv2RmY4fnPnh73OueHKbV21hZelFTdSaH4HF6YLm
         DkcQ==
X-Gm-Message-State: AOAM530AIVHjzrQ7DZCdU/l8qywh//q4evVgVNFH5Q4gplZVdET+I6qR
        /SK1QkYRJ2S0U+I+xmxbxepXr0xdmD8hCO0p
X-Google-Smtp-Source: ABdhPJyZGXgOm7H/KhiuRR47FBSDwNlYAX3iyA2kr0I08Sx8kxPc2V3ePar++nJx/dZsiMAF74uluQ==
X-Received: by 2002:a05:6512:128b:: with SMTP id u11mr3681831lfs.528.1634614707539;
        Mon, 18 Oct 2021 20:38:27 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id l26sm1551284lfh.247.2021.10.18.20.38.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 20:38:26 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id y15so4302787lfk.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 20:38:25 -0700 (PDT)
X-Received: by 2002:a05:6512:12d4:: with SMTP id p20mr3786322lfg.280.1634614705218;
 Mon, 18 Oct 2021 20:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211018182537.2316800-1-nathan@kernel.org> <CAKwvOdn4_DrgaZoAo-v7CbYurNUpfAK5tnzT023=WCDzkmYQVg@mail.gmail.com>
 <CAHk-=wi7hUsTTcmPfZCkUEw51Y3ayq3JJxzFsNgodsxxDyk9Ww@mail.gmail.com> <CAKwvOd=wGjd_L1703Y9Kngcr9-_wTvcRLToiydXYkR=S_9xWDw@mail.gmail.com>
In-Reply-To: <CAKwvOd=wGjd_L1703Y9Kngcr9-_wTvcRLToiydXYkR=S_9xWDw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Oct 2021 17:38:09 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjwOnrHXDSqnmhiKujk=5XieJFvfnQwc2WKOKFwzcqvaA@mail.gmail.com>
Message-ID: <CAHk-=wjwOnrHXDSqnmhiKujk=5XieJFvfnQwc2WKOKFwzcqvaA@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Fix bitwise vs. logical warning
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Tor Vic <torvic9@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 10:14 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Right, the patch that added the warning explicitly checks for side effects.

Well, it's a bit questionable. The "side effects" are things like any
pointer dereference, because it could fault, but if you know that
isn't an issue, then clang basically ends up complaining about code
that is perfectly fine. Maybe it was written that way on purpose, like
the kvm code.

Now, it's probably not worth keeping that "bitops of booleans" logic -
if it is a noticeable optimization, it's generally something that the
compiler should do for us, but basically clang is warning about
perfectly valid code.

And what I find absolutely disgusting is the suggested "fix" that
clang gives you.

If the warning said "maybe you meant to use a logical or (||)", then
that would be one thing. But what clang suggests as the "fix" for the
warning is just bad coding practice.

If a warning fix involves making the code uglier, then the warning fix is wrong.

This is not the first time we've had compilers suggesting garbage. Gcc
used to suggest (perhaps still does) the "extra parenthesis" for
"assignment used as a truth value" situation. Which is - once again -
disgusting garbage.

Writing code like

        if (a = b) ..

is bad and error prone. But the suggestion to "fix" the warning with

        if ((a = b)) ..

is just completely unacceptably stupid, and is just BAD CODE.

The proper fix might be to write it like

        if ((a = b) != 0) ...

which at least makes the truth value part explicit - in ways that a
silly double parenthesis does not. Or, better yet, write it as

        a = b;
        if (a) ..

instead, which is legible and fine.

The clang suggestion to add a cast to 'int' to avoid the warning is
the same kind of "write bad code" suggestion. Just don't do it.

             Linus
