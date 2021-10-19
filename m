Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100AB432CF9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 07:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbhJSFC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 01:02:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229649AbhJSFC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 01:02:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 741436128B;
        Tue, 19 Oct 2021 05:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634619616;
        bh=voRGktYMNQgpL0Ez2VaMsZ61v2/99fKFy6JwkF43BuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lhT3gce+PssaynVzLp51Fbg9+vc3qfHg+krAHyCNMtVoY/xTZj1dyRjA9/erB3w+P
         2TI1Xd3vK5RVIApkUV2UadAmGQ0hFTqCHv1u1GXQA/8EuKfDExT2/20QyNFvLQrmof
         RYxi0aqy7fpct2eEjA9dMxnm8DMF2WyJnw1PEcRLkCT6Fd0MRTL1IshYZ2iMfs4Ko8
         ZQtScEe6ERxQjArK19pYhuzDpA783hdVPrYT+gkAJNRzfID7CTOIlief+kjE2m6uwg
         /CAtp5O0mieOdcRSL9DLzbVWFIfqOen+iBvYjj/JXdo4ci5i9twOuzRITlT6gvfyL/
         zaKRX1zPHlXQw==
Date:   Mon, 18 Oct 2021 22:00:11 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Tor Vic <torvic9@mailbox.org>
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Fix bitwise vs. logical
 warning
Message-ID: <YW5Q253s0Y+zYxdi@archlinux-ax161>
References: <20211018182537.2316800-1-nathan@kernel.org>
 <CAKwvOdn4_DrgaZoAo-v7CbYurNUpfAK5tnzT023=WCDzkmYQVg@mail.gmail.com>
 <CAHk-=wi7hUsTTcmPfZCkUEw51Y3ayq3JJxzFsNgodsxxDyk9Ww@mail.gmail.com>
 <CAKwvOd=wGjd_L1703Y9Kngcr9-_wTvcRLToiydXYkR=S_9xWDw@mail.gmail.com>
 <CAHk-=wjwOnrHXDSqnmhiKujk=5XieJFvfnQwc2WKOKFwzcqvaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjwOnrHXDSqnmhiKujk=5XieJFvfnQwc2WKOKFwzcqvaA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 05:38:09PM -1000, Linus Torvalds wrote:
> On Mon, Oct 18, 2021 at 10:14 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > Right, the patch that added the warning explicitly checks for side effects.
> 
> Well, it's a bit questionable. The "side effects" are things like any
> pointer dereference, because it could fault, but if you know that
> isn't an issue, then clang basically ends up complaining about code
> that is perfectly fine. Maybe it was written that way on purpose, like
> the kvm code.
> 
> Now, it's probably not worth keeping that "bitops of booleans" logic -
> if it is a noticeable optimization, it's generally something that the
> compiler should do for us, but basically clang is warning about
> perfectly valid code.
> 
> And what I find absolutely disgusting is the suggested "fix" that
> clang gives you.
> 
> If the warning said "maybe you meant to use a logical or (||)", then
> that would be one thing. But what clang suggests as the "fix" for the
> warning is just bad coding practice.

For what it's worth, the suggested fix is the '||' underneath the
warning text:

In file included from arch/x86/kvm/mmu/tdp_iter.c:5:
arch/x86/kvm/mmu/spte.h:318:9: error: use of bitwise '|' with boolean operands [-Werror,-Wbitwise-instead-of-logical]
        return __is_bad_mt_xwr(rsvd_check, spte) |
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                                 ||
arch/x86/kvm/mmu/spte.h:318:9: note: cast one or both operands to int to silence this warning
1 error generated.

Perhaps that hint should also be added to the warning text, like:

In file included from arch/x86/kvm/mmu/tdp_iter.c:5:
arch/x86/kvm/mmu/spte.h:318:9: error: use of bitwise '|' with boolean operands; did you mean logical '||'? [-Werror,-Wbitwise-instead-of-logical]
        return __is_bad_mt_xwr(rsvd_check, spte) |
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                                 ||
arch/x86/kvm/mmu/spte.h:318:9: note: cast one or both operands to int to silence this warning
1 error generated.

It is late for me but I can push that change to the clang developers and
see what they think tomorrow if that would help?

Cheers,
Nathan
