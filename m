Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90B5432628
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 20:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbhJRSRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 14:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhJRSRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 14:17:37 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6821EC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 11:15:25 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id y26so1545474lfa.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 11:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ERwIJtrAxSKFmtkdla8UNA3CjrOGMlzFelchQeuneqM=;
        b=PvFPrrHqhzLoQwugLC06OkLKAETokHq2kcRDQ2GRnjTqhztE5NwcSpFrcIF1QGvRzN
         QojzqkjCeMTtNbkax3976xxSB8xyWgHS1GjolB/a485xoNKOFy1jFgjouwfTYFpKqT2N
         56iFCafGyQxy4KrnM4lYvzC1ppazomKTmc7pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ERwIJtrAxSKFmtkdla8UNA3CjrOGMlzFelchQeuneqM=;
        b=Vc7BfGeJQsaxDpIa4/NPT5LFcg6J8L4T0qmEsGMLjV2s0/LDJON4ixdJVA/xJ6fGqP
         j1JsV8XWzdGrqVlnwqZXp1Dg4gUyrVgDityZLBOK6ocngHoJovPeGAxmRKisMaj44HcU
         19dAwc0u7lBif0DL+AGcNBNw5Dz+izybG/wZEvbyDyq6IfUpY2J9JpFPU7AlzYCDp0sm
         P4v2X36ZPbzNpCOgiIBE71VTOTYuR/cCUD8wpaY4v22zxNCr2Y4yYUOa5drqrOUA1ruk
         jokJbHmsbzMyruPNQUhI87fdPVg+++FTSsBsSuU+PDXxTNJC8o35X06vVjgfj5qBT1tu
         3Mmg==
X-Gm-Message-State: AOAM5309q0uzI/RED2XR4rm9CQPjoJWnrGKQnhn283mEKoo/sXY6LK4j
        IdwKW+FhCbSRMNz/FPtry09xf+wcnSUd6tQG
X-Google-Smtp-Source: ABdhPJyw6CUd8urYhpeaQtRrSXzfWEdV+UakyPL6f2chrd4egUjfGiVGA0DJbwZ+v3ahF4a1Q+VB6w==
X-Received: by 2002:ac2:4c48:: with SMTP id o8mr1212344lfk.286.1634580923569;
        Mon, 18 Oct 2021 11:15:23 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id r22sm1450916lfe.239.2021.10.18.11.15.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 11:15:22 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id u5so1310606ljo.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 11:15:21 -0700 (PDT)
X-Received: by 2002:a2e:a407:: with SMTP id p7mr1465932ljn.68.1634580921681;
 Mon, 18 Oct 2021 11:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <20211018174137.579907-1-pbonzini@redhat.com> <CAHk-=wg0+bWDKfApDHVR70hsaRA_7bEZfG1XtN2DxZGo+np9Ug@mail.gmail.com>
 <daba6b06-66cb-6564-b7b0-26cb994a07cd@redhat.com>
In-Reply-To: <daba6b06-66cb-6564-b7b0-26cb994a07cd@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Oct 2021 08:15:05 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgScNWP7Ohh5eEKgcs3NLp9GZOoQ6Z-Kz0aByRtHoJSrw@mail.gmail.com>
Message-ID: <CAHk-=wgScNWP7Ohh5eEKgcs3NLp9GZOoQ6Z-Kz0aByRtHoJSrw@mail.gmail.com>
Subject: Re: [GIT PULL] KVM fixes for Linux 5.15-rc7
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 8:03 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The code is not wrong, there is a comment explaining it:
>
>          * Use a bitwise-OR instead of a logical-OR to aggregate the reserved
>          * bits and EPT's invalid memtype/XWR checks to avoid an extra Jcc
>          * (this is extremely unlikely to be short-circuited as true).

That makes very little sense.

It seems to be avoiding a 'jcc' and replace it with a 'setcc' and an
'or'. Which is likely both bigger and slower.

If the jcc were unpredictable, maybe that would be one thing. But at
least from a quick look, that doesn't even seem likely

 The other use of that function has a "WARN_ONCE()" on it, so
presumably it normally doesn't ever trigger either of the boolean
conditions.

Very strange code.

                    Linus
