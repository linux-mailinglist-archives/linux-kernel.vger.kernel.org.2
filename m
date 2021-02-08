Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE59314149
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbhBHVHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 16:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbhBHUBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 15:01:13 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6137AC061788
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 12:00:23 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id p12so2668288qvv.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 12:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ncVBkcoC/VI+DZNzSSUnx3SJhRiGGcMMVcmdGZHYKZ0=;
        b=Za6tUJWtTDsmOMGXHsCFlyfX7YFzx3IcnYLDKdTItpYk1mk5qAxupu0rCQTWPkxRp2
         puvyeILzfho54F5wH8zwRFkCR2cjFmkCxjh7xLQBLK7EGoDN9bQeadkOQjOc0ilapu9X
         g47nP6LCdr27pWFQVj4h6XqEAcszdIddAOHYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ncVBkcoC/VI+DZNzSSUnx3SJhRiGGcMMVcmdGZHYKZ0=;
        b=lW1PREVXa79gNQsSnRjSyxE6X9+E9sb7reRj6MOc17aW9WRvQEFZWO07R7uoHr9YUz
         yJfRz+JwT9QIGqH58onpweOUJzpOFzPJActKmWmAqQ4dhTkpRUfPb/mfyvBUt9842D5L
         sJSku0+58pGzs2NKG4WP4S9Eugw3C+Zs0g1bobPGyZCgo5Rg+PUuzpEte4BHHc6thRXd
         /CzczcwHS86bHZ1k34SlOZ5v1CHbmvnkbDphNL1OLmKl0AScWuTf7lq5DLrDCfpuBElS
         B+HHIfANfro+feIGGHXHjV0eAiNJUSdDcuQjbjEEOeCDrSmGw5WR5Jec9aYwwO3fYyBI
         M7nA==
X-Gm-Message-State: AOAM531scxNalS07gOFecVqSn6kNFi5yHKC33u239B6P/52VDBU3Ze2Y
        f0R9gptZDwfxTxGkVRDLGS5KtGt/uYLRvPncaDc1QbZKWjdeTg==
X-Google-Smtp-Source: ABdhPJwzXBL6MMPfNNMvMliIkTIsFicNdf44ZeUAQHcRnb57YpTuCvzYrCYwYYbd7R7jSSXQSukNdNOfFQk/7qCMXhM=
X-Received: by 2002:ad4:47a2:: with SMTP id a2mr8571620qvz.16.1612814422594;
 Mon, 08 Feb 2021 12:00:22 -0800 (PST)
MIME-Version: 1.0
References: <cover.1612534649.git.jpoimboe@redhat.com> <06d02c4bbb220bd31668db579278b0352538efbb.1612534649.git.jpoimboe@redhat.com>
 <20210208195618.3gngafmybdircj46@treble>
In-Reply-To: <20210208195618.3gngafmybdircj46@treble>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Mon, 8 Feb 2021 12:00:11 -0800
Message-ID: <CABWYdi2hcg6_MYNAWcVPv1aA1NvysXa_w9ghgukc6gTU3a84jw@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/unwind/orc: Silence warnings caused by missing
 ORC data
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 8, 2021 at 11:56 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Fri, Feb 05, 2021 at 08:24:03AM -0600, Josh Poimboeuf wrote:
> > The ORC unwinder attempts to fall back to frame pointers when ORC data
> > is missing for a given instruction.  It sets state->error, but then
> > tries to keep going as a best-effort type of thing.  That may result in
> > further warnings if the unwinder gets lost.
> >
> > Until we have some way to register generated code with the unwinder,
> > missing ORC will be expected, and occasionally going off the rails will
> > also be expected.  So don't warn about it.
> >
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
>
> Cc: stable@vger.kernel.org

I was the one who asked for this to be backported, since it solved the
warnings for me.

Tested-by: Ivan Babrou <ivan@cloudflare.com>
