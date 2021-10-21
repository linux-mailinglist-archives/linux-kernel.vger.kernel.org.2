Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34180435AD8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 08:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhJUG3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 02:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhJUG3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 02:29:41 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B3BC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 23:27:25 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id q16so400302ljg.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 23:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rJpQfkMo0q0LBGoauyzzkpiMDtQa3RitH2cjnNtLs94=;
        b=RUO+hd8TBKKv+KfOMFpkrXcDn367z6mGTEVuEyE5K66rswyjAcj/+WdyIbhOZyucbs
         s63SS9MEql93qP3U+72s/CxzHT4tGCDf2txvdTcvIPUVPTCnGmFNTYmmzHH2D+FLvxeV
         tbf/qlqU5T8PetQ5rsrK0Chd2XPcvxoT05qzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rJpQfkMo0q0LBGoauyzzkpiMDtQa3RitH2cjnNtLs94=;
        b=UPqjBlNUGabTzWbnlywu7ZV4oCgG+TJ/I1828t0tp+zurfN98k0YZKzhkdYNu5bwW6
         bPmAynBJJblF+diPD1L2y7qVzgGjFTUg/9RAdehZGWS33C2n3p3rgd9aFROvkXQSUpkK
         Iiy2UwlZ1qgJVRpqVOjr8t3rEisGVavHwh53Pi7yTxQGbD3r7sNbCL78edkQeCTlg3//
         nb+zbxtTIeaxK6r2N3ALA4qFfi04UREz4gwHQ4z4Q8t035f0DTwCxBDICQFro+AD+Kb/
         yW3ndlPwYCcQecwiQmCty81OWSEzYAgERjke5lx8Yfvly7UpgD+TRpb9ea6OKj94CUMw
         sKEg==
X-Gm-Message-State: AOAM531dPfIcias9ZgrgaJw2Sl/hWi736aj3ZVoRxCpLK4HCEVpoT2nL
        TFoTcn0I/K4kiXcQaiK8tmwGPaHZLc3E6rDI
X-Google-Smtp-Source: ABdhPJwsqWdmJDcalxDWcBYn5veedZLVWsH5P6hZslOYTXcrcc/UurKb8nMlHarl4xkHeAMaXadewA==
X-Received: by 2002:a2e:a7c7:: with SMTP id x7mr3876771ljp.8.1634797643792;
        Wed, 20 Oct 2021 23:27:23 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id o9sm482154ljh.9.2021.10.20.23.27.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 23:27:23 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id g8so819218ljn.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 23:27:23 -0700 (PDT)
X-Received: by 2002:a2e:a41b:: with SMTP id p27mr3817331ljn.31.1634797642976;
 Wed, 20 Oct 2021 23:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <20211019091344.65629198@gandalf.local.home> <CAHk-=wjvGRtwMHDJ9VR8197+_rVveqE73Uv-MMFbvuUEbWKNtQ@mail.gmail.com>
 <20211020121727.57f46a15@gandalf.local.home> <CAHk-=whr2M-jzyv9B8Co0V0TMvCpnH24fWYwxXrN9YeGKicoVw@mail.gmail.com>
 <20211020181241.0e6a2b47@gandalf.local.home> <20211020184101.25b7e583@gandalf.local.home>
 <CAHk-=wgBhyLhQLPem1vybKNt7BKP+=qF=veBgc7VirZaXn4FUw@mail.gmail.com> <6ce0c8301cadef76fd45f38ace1e20408f6e52e9.camel@perches.com>
In-Reply-To: <6ce0c8301cadef76fd45f38ace1e20408f6e52e9.camel@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Oct 2021 20:27:07 -1000
X-Gmail-Original-Message-ID: <CAHk-=wicuM=0iMeRCrbG=MMLZRdwihpZ64rWxDqidEjMa-YDsA@mail.gmail.com>
Message-ID: <CAHk-=wicuM=0iMeRCrbG=MMLZRdwihpZ64rWxDqidEjMa-YDsA@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Fix to recursion protection for 5.15
To:     Joe Perches <joe@perches.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 8:16 PM Joe Perches <joe@perches.com> wrote:
>
> Generally, a tool like b4 should be able to create a list of any
> email addresses in a thread linked commit.

I really think Cc lines are very useful.

That said, they are *more* useful when they are thought about, than
when they are automated.

IOW, the "these people are relevant to this patch" is simply very
useful information, and no, neither "get_maintainer" nor some set
gathered automatically from a patch submission is a replacement for
actual _thought_ behind it.

I will, for example, strive to put the people who _participated_ in
some discussion as the "Cc" list - they may not have acked a patch, or
reviewed it, but they might have piped up in the discussion, and that
probably merits them then knowing about any problems it causes.

And honestly, the "b4" information you mention is almost useless. Why?
Because people who do the "Link:" and "Cc:" information based on the
automation they picked up the patch from often don't look at the part
that is _really_ relevant, namely the discussion that _caused_ the
patch. IOW, the original report, possibly earlier versions of the
patch etc etc.

Mindless "take the cc list from the emailed submission of the patch"
is still somewhat useful in that it avoids having to look it up later
when something happens, but really, a bit of human mindful editing is
probably called for.

                 Linus
