Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71FD43A80B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 01:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbhJYXS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 19:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbhJYXS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 19:18:26 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7928FC061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 16:16:03 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id n7so12575919ljp.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 16:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N57vRJe+Hp19ptzSp75ybyre1XzyfFA16SmQOsxj3tA=;
        b=UgKxLMhT870ySRwwioSjbGbqOTOBYQ47GNWCxDiXZMwTTJf9VDBTR8W+864dN8KcsO
         Z6fdPCVuLRfJK898kYlNziu6kubhhOKZSFSL88QzpLnCMRPDxMXRPb5TuftXYw1AbTu/
         dNmRTderTGCnZEoMbOtKWZ1IZbBj7mM1zoEus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N57vRJe+Hp19ptzSp75ybyre1XzyfFA16SmQOsxj3tA=;
        b=EltY2WgBoc7CgS+phSLtjZW8uKzu/mDVxiM1Ld4q4ROw2TDmQNw8LAHQpM6xyYy/TP
         3vCBW8bZQaBt5L1ZhL1NT32OFb+2VTuUtUDX63HP9bKRLsY2c5e2TGyRDKBDyFHP9oiP
         E5CAlwTp8mMsnelb81cEQYDSz2tCBK5Xs4R/fg0H9grpVadoRiSSDgkLHVpEqouAMV2x
         z8R9DCYXrSASZLS8z3PTQhTG4XlNusNlulIu22urKRCBUqOqKxwrPsjuspkxbfcqorOF
         XlzzczvLJvsP/WDbgfUZCSKVVSVBWksh3y0VCyjDIPljglE0OY1tlxJw2IW1Tbwp0tNQ
         kIvw==
X-Gm-Message-State: AOAM533T0NYXKYOHcVdDBJ5wuGPZkF7TXZ38HA1kvpb3muh07l1bJ0rs
        OVmw68T44Wmydp9BioM0GJmh1V3tGonSmR8G
X-Google-Smtp-Source: ABdhPJxdGgKjD+rFwcHycn0h6jXZxEtkCLcoSKEMDf2rRl8yTEnL9k5pTsZ74rHUvjOZAps1WVhL/Q==
X-Received: by 2002:a2e:5cc7:: with SMTP id q190mr22404442ljb.494.1635203761550;
        Mon, 25 Oct 2021 16:16:01 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id d5sm64969lfi.96.2021.10.25.16.16.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 16:16:00 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 188so2355190ljj.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 16:16:00 -0700 (PDT)
X-Received: by 2002:a2e:bc24:: with SMTP id b36mr21991313ljf.95.1635203760541;
 Mon, 25 Oct 2021 16:16:00 -0700 (PDT)
MIME-Version: 1.0
References: <87y26nmwkb.fsf@disp2133> <20211020174406.17889-13-ebiederm@xmission.com>
 <CAHk-=whe-ixeDp_OgSOsC4H+dWTLDSuNDU2a0sE3p8DapNeCuQ@mail.gmail.com> <9416e8d7-5545-4fc4-8ab0-68fddd35520b@kernel.org>
In-Reply-To: <9416e8d7-5545-4fc4-8ab0-68fddd35520b@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Oct 2021 16:15:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=whJETM0MHqWQKCVALBkJX-Th5471z5FW3gFJO5c73L6QA@mail.gmail.com>
Message-ID: <CAHk-=whJETM0MHqWQKCVALBkJX-Th5471z5FW3gFJO5c73L6QA@mail.gmail.com>
Subject: Re: [PATCH 13/20] signal: Implement force_fatal_sig
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 3:41 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> I'm rather nervous about all this, and I'm also nervous about the
> existing code.  A quick skim is finding plenty of code paths that assume
> force_sigsegv (or a do_exit that this series touches) are genuinely
> unrecoverable.

I was going to say "what are you talking about", because clearly Eric
kept it all fatal.

But then looked at that patch a bit more before I claimed you were wrong.

And yeah, Eric's force_fatal_sig() is completely broken.

It claims to force a fatal signal, but doesn't actually do that at
all, and is completely misnamed.

It just uses "force_sig_info_to_task()", which still allows user space
to catch signals - so it's not "fatal" in the least. It only punches
through SIG_IGN and blocked signals.

So yeah, that's broken.

I do still think that that could the behavior we possibly want for
that "can't write updated vm86 state back" situation, but for
something that is called "fatal", it really needs to be fatal.

            Linus
