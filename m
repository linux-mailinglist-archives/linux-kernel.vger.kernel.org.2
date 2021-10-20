Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7363043544C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 22:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhJTUH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 16:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbhJTUH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 16:07:56 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267B6C061749
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 13:05:41 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 145so14572626ljj.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 13:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0++TUycna+bE6Avhciu0oSb+ZwvvTLsg8M+asM8i1ao=;
        b=Ve/C0XG/xw8UyPAGxVwRPbpQH9RyAGe6NPgj4p4E7sLNs6ru46yKyU2Mo273jTGvAu
         Ig7Avg3/BtfJKmUHIBielU5BzXWEcSOvdhLp9P7itwhTM7l8nMLuKAqf9Prw682q73aZ
         2789HkXDUuVPBMBPyD6YLSKnDn2dksoJJlRsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0++TUycna+bE6Avhciu0oSb+ZwvvTLsg8M+asM8i1ao=;
        b=dYJcpgF/eaUIgC2r99h9rpaywES6xpXqbbkzTNZ3OTU4Fp0ymtZWnK0WiYC/qK/Vwr
         nP6rVgvUW6CeKrzghIJuf8Rb0fWBB+yXakRy3KnPB8NHF6oTu94Jd9hpiCbZ4YZMDWbb
         tMrw3Bs47P0FiXpke8LJ1Kqzr8jqWXG4tlCGKjcZkHinZP5/6nT/dfYqfZ3vb0AtYXk1
         TvCFyFkc3Ohp4L6CEt76Ycp5dxDHWVB8BO5kOn0o5+k3xVrRH6p57Ec5Rv/J2BZlEIyF
         PulSeSD3YiMtJgoSoWH8pYYOQKj/9bT9pME1b1m4m6XD9FtmRSHE90QUGNCWDMOedCNm
         fiyA==
X-Gm-Message-State: AOAM530eK15ibTFzPSaPgCXh1JRt4x6NbupIILNn+XRGdQSzDKJ3roaj
        ZUEL1lQ4c7uIcUz9lH+ijvoUM0ZbQQu7k9su
X-Google-Smtp-Source: ABdhPJzkGPF8yLYsHdvtMWrQhnvik1fe4Iv0zn5s49kmDp+bOj3fiQsSh8nmCc87E9EhD+vb9gsg3w==
X-Received: by 2002:a2e:9a56:: with SMTP id k22mr1263359ljj.32.1634760338111;
        Wed, 20 Oct 2021 13:05:38 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id br39sm21527lfb.306.2021.10.20.13.05.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 13:05:37 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id u5so741113ljo.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 13:05:37 -0700 (PDT)
X-Received: by 2002:a2e:a407:: with SMTP id p7mr1286007ljn.68.1634760337033;
 Wed, 20 Oct 2021 13:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <87y26nmwkb.fsf@disp2133> <20211020174406.17889-13-ebiederm@xmission.com>
In-Reply-To: <20211020174406.17889-13-ebiederm@xmission.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Oct 2021 10:05:21 -1000
X-Gmail-Original-Message-ID: <CAHk-=whe-ixeDp_OgSOsC4H+dWTLDSuNDU2a0sE3p8DapNeCuQ@mail.gmail.com>
Message-ID: <CAHk-=whe-ixeDp_OgSOsC4H+dWTLDSuNDU2a0sE3p8DapNeCuQ@mail.gmail.com>
Subject: Re: [PATCH 13/20] signal: Implement force_fatal_sig
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 7:45 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Add a simple helper force_fatal_sig that causes a signal to be
> delivered to a process as if the signal handler was set to SIG_DFL.
>
> Reimplement force_sigsegv based upon this new helper.

Can you just make the old force_sigsegv() go away? The odd special
casing of SIGSEGV was odd to begin with, I think everybody really just
wanted this new "force_fatal_sig()" and allow any signal - not making
SIGSEGV special.

Also, I think it should set SIGKILL in p->pending.signal or something
like that - because we want this to trigger fatal_signal_pending(),
don't we?

Right now fatal_signal_pending() is only true for SIGKILL, I think.

               Linus
