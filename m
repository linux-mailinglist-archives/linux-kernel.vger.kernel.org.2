Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1433F699A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 21:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbhHXTMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 15:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbhHXTMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 15:12:52 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA42C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 12:12:07 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id g13so47618987lfj.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 12:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ML8yvEkHn2MMk7DHTb7xofUolC2C3CbamkHF2ym8ns=;
        b=CCvgl77rDwn5Xdz1iPvHjiRdu483Ntev3TcN1slHj28zjY6a9duK7ML3JIaywIunKM
         w7nES36Axak0acr4X5y4QNLO1kuG+eou5mTFd146IBmALhGfdMfGMEKtTm/ogAFSulo2
         ZaDnOTkeFwweTIBsmOW50zL/o3x7KoH0lX+B4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ML8yvEkHn2MMk7DHTb7xofUolC2C3CbamkHF2ym8ns=;
        b=gS8A+ppb70ULbThQ8cuI99KQ93FLjrCguFaUNZK43SRzjU+oV2u/g+6PzH20ANxZPk
         ZAEpu/gu6CXB+jAqeJ55krl6ksyUsXkPxnWMG+AxT2CGy2cD98XxpzzxUCq6+4TlfUDN
         Dm2O2gcQ+vDUuhZ++58JqYVchlGSxgQC4DlcLlLxcanSGrH8UAs+5Q0s6wRVAKwC5Zaz
         sQ8UIDbiubpcifwvtFSUbzP38iPwznzE5TN7qLKAquaPP4nu51/t8Z1YHGDeSs0nwFVb
         f0CMnxBXnnsOzGkeQVShWnL2JttFRxkYZwS2f1IIDO05/K79RWN0402jCCBOy7znXnrv
         DHIQ==
X-Gm-Message-State: AOAM532Wz2EGX29YGHF7I1JihOE0sDmjW4lbu64/9H8Z/O1pkCN5Lze/
        7ZlFrv4Ajiun/fVeupMGo6tl0t9PFFTsaVE9
X-Google-Smtp-Source: ABdhPJxSCaoCEKTqlE1HjW+JBwjOH0rJRlp2gPDOc17bwzNLVoheuGMyltfFloc89ZiDgrs1EyiJ5A==
X-Received: by 2002:a05:6512:1689:: with SMTP id bu9mr30970797lfb.147.1629832326073;
        Tue, 24 Aug 2021 12:12:06 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id r22sm65502lfm.7.2021.08.24.12.12.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 12:12:05 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id l18so31882794lji.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 12:12:05 -0700 (PDT)
X-Received: by 2002:a2e:7d0e:: with SMTP id y14mr32903544ljc.251.1629832325371;
 Tue, 24 Aug 2021 12:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjD8i2zJVQ9SfF2t=_0Fkgy-i5Z=mQjCw36AHvbBTGXyg@mail.gmail.com>
 <YSPwmNNuuQhXNToQ@casper.infradead.org> <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <1957060.1629820467@warthog.procyon.org.uk> <YSUy2WwO9cuokkW0@casper.infradead.org>
 <CAHk-=wip=366HxkJvTfABuPUxwjGsFK4YYMgXNY9VSkJNp=-XA@mail.gmail.com> <YSVCAJDYShQke6Sy@casper.infradead.org>
In-Reply-To: <YSVCAJDYShQke6Sy@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Aug 2021 12:11:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wisF580D_g+wFt0B_uijSX+mCgz6tRRT5KADnO7Y97t-g@mail.gmail.com>
Message-ID: <CAHk-=wisF580D_g+wFt0B_uijSX+mCgz6tRRT5KADnO7Y97t-g@mail.gmail.com>
Subject: Re: [GIT PULL] Memory folios for v5.15
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 12:02 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> Choosing short words at random from /usr/share/dict/words:

I don't think you're getting my point.

In fact, you're just making it WORSE.

"short" and "greppable" is not the main issue here.

"understandable" and "follows other conventions" is.

And those "other conventions" are not "book binders in the 17th
century". They are about operating system design.

So when you mention "slab" as a name example, that's not the argument
you think it is. That's a real honest-to-goodness operating system
convention name that doesn't exactly predate Linux, but is most
certainly not new.

In fact, "slab" is a bad example for another reason: we don't actually
really use it outside of the internal implementation of the slab
cache. The name we actually *use* tends to be "kmalloc()" or similar,
which most definitely has a CS history that goes back even further and
is not at all confusing to anybody.

So no. This email just convinces me that you have ENTIRELY the wrong
approach to naming and is just making me more convinced that "folio"
came from the wrong kind of thinking.

Because "random short words" is absolutely the last thing you should look at.

             Linus
