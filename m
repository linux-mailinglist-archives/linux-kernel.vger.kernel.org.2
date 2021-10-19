Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1C3432E49
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 08:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbhJSG3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 02:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234190AbhJSG3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 02:29:34 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FF0C061745
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 23:27:22 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id j21so5219766lfe.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 23:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Hz18V9cmevixb6yPJp+xhm9+FmsVtQxvQp4KWS9Xn0=;
        b=MaQGIQasM+dLV7KwlcsE5Cl9HFetE/vzwFHktseUxeQcmw5PdeCbgreOiQxEbNmFt4
         dnLQIc2SvagaUe91R1lrfZl+mhDwAH/5cNO7uFEDcK1cxss/qgvbSTzqirsdRKsLf/ix
         x+1OQif8898d3tVTgUGcnvsSybigNO3qRv1Cs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Hz18V9cmevixb6yPJp+xhm9+FmsVtQxvQp4KWS9Xn0=;
        b=tpHommDd5xgAghsGcE/Tx/lBtTfZwyemAQmPMgNyiJG7RIj7O1vF5bC2f3CFAppX/w
         fO2keJWhMsjPL/J9AcnPMrAMzw/yMzpbxGpIwXPUObFd+EbUGvn4BS5yNSnzXkeOZO3c
         3K6/mS7YiwuLYMV9awOupYX4shH55Hc7V3cRTdYahpPR+v93g7Euo0VGTxDJxSo3Yqo3
         yC7B0fuEqB6Qknp7JgHx7T97c3H729L5oIGrxUucjcpZYRgPsi/Nd6PSmVKkKjtIRPIz
         acUJkBPp74Am4NgHyQpIH7rqTK2ELwIOLUpV/Ebcfi06LllPIUf76KzGS+ycfoEdx+Gx
         1nZQ==
X-Gm-Message-State: AOAM531IxmRDxAiq2AATxDpL7YOC7mHA/3NDCJvqgFVxUkBcYWVuAjak
        gp3IKW8PLiW8Kzna3K+SBYzpRB1s8OLeHg==
X-Google-Smtp-Source: ABdhPJzjhbW28gjjL5tYM854CFEfjwcVIgo1IG6vX6nwbulhUMIYXC7ADVui6nlrw8NeP6MpKkAwFA==
X-Received: by 2002:a19:c3c8:: with SMTP id t191mr4179610lff.525.1634624840086;
        Mon, 18 Oct 2021 23:27:20 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id p21sm1575383lfg.18.2021.10.18.23.27.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 23:27:19 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id n7so4134764ljp.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 23:27:18 -0700 (PDT)
X-Received: by 2002:a2e:1510:: with SMTP id s16mr4766664ljd.56.1634624838613;
 Mon, 18 Oct 2021 23:27:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211018182537.2316800-1-nathan@kernel.org> <CAKwvOdn4_DrgaZoAo-v7CbYurNUpfAK5tnzT023=WCDzkmYQVg@mail.gmail.com>
 <CAHk-=wi7hUsTTcmPfZCkUEw51Y3ayq3JJxzFsNgodsxxDyk9Ww@mail.gmail.com>
 <CAKwvOd=wGjd_L1703Y9Kngcr9-_wTvcRLToiydXYkR=S_9xWDw@mail.gmail.com>
 <CAHk-=wjwOnrHXDSqnmhiKujk=5XieJFvfnQwc2WKOKFwzcqvaA@mail.gmail.com> <YW5Q253s0Y+zYxdi@archlinux-ax161>
In-Reply-To: <YW5Q253s0Y+zYxdi@archlinux-ax161>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Oct 2021 20:27:02 -1000
X-Gmail-Original-Message-ID: <CAHk-=wi-UJAGo6uwYx8XKydSEsnQ33mW4t+kUnb+CNY+Oxobjg@mail.gmail.com>
Message-ID: <CAHk-=wi-UJAGo6uwYx8XKydSEsnQ33mW4t+kUnb+CNY+Oxobjg@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Fix bitwise vs. logical warning
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
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

On Mon, Oct 18, 2021 at 7:00 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> For what it's worth, the suggested fix is the '||' underneath the
> warning text:
>
> In file included from arch/x86/kvm/mmu/tdp_iter.c:5:
> arch/x86/kvm/mmu/spte.h:318:9: error: use of bitwise '|' with boolean operands [-Werror,-Wbitwise-instead-of-logical]
>         return __is_bad_mt_xwr(rsvd_check, spte) |
>                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                                                  ||
> arch/x86/kvm/mmu/spte.h:318:9: note: cast one or both operands to int to silence this warning
> 1 error generated.

Hmm. That's not at all obvious.

The *much* bigger part is that

   note: cast one or both operands to int to silence this warning

which is what I'm complaining about. That note should die. It should
say "maybe you meant to use a logical or" or something like that.

> Perhaps that hint should also be added to the warning text, like:
>
> In file included from arch/x86/kvm/mmu/tdp_iter.c:5:
> arch/x86/kvm/mmu/spte.h:318:9: error: use of bitwise '|' with boolean operands; did you mean logical '||'? [-Werror,-Wbitwise-instead-of-logical]
>         return __is_bad_mt_xwr(rsvd_check, spte) |
>                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                                                  ||
> arch/x86/kvm/mmu/spte.h:318:9: note: cast one or both operands to int to silence this warning

I don't understand why you seem to continue to ignore the "note"
message, which makes a completely crazy suggestion.

                 Linus
