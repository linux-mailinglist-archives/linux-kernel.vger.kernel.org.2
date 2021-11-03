Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7434449CE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 21:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhKCU7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 16:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbhKCU7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 16:59:22 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E592AC061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 13:56:45 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id u33so3647210pfg.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 13:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h+/m5FzVtHBR9VP8NJ/Plklb48WU4M8fldCyXQCwALg=;
        b=lBZKAlRIQ1/0Z48/UBiBd9E+XQqBgraPFoh1kz9iCCeafQ/N0LI6hUN8Uj+IUQZXvA
         GuccUvoi/RU8+Hanj3GmjoxJg2cxJdE0G3EBMy3P9/mto5sfny25r/prSa4ketDtrol4
         xBYYklK1XY3jaroE8mPezHidxhvoAJDS3BCTQtvdI+UShH0SR+Mi4iHAD0N8RR3+jmVI
         fXAOuuXkjqlkkzWmudKLY8z+i6uLY3zM40CkSLbOCyLXZB8GH6UpUFxdHwP7+vg72YWy
         ThhKRdHCOWxTy1WrKw/2lrJn5ktkFZEVk4Mo04dO7wuyE/S+RSwKRsyIjb4BG0VnGigk
         fLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h+/m5FzVtHBR9VP8NJ/Plklb48WU4M8fldCyXQCwALg=;
        b=VG2iVJDSI6MSuWUYgM/Onu0YSOqcQWO1FJatv7ijTGOvxkACdofX8JbqCdZeCKhe72
         xL+5f1VP2b0WF8rJXEVzQhgxYd/NCNA8PChBHZJ0S/cGyjlVQW2DKHlTbXTVhqyGGUJq
         iuGi8VWReDV3H2cl072TB0L+PcBP5flo3mMTEKKRt6u/7nHJg6Wf2gGug5pOX87NvNWd
         KlRMgcjUfI8qbsVb3OvpYwN6mLg2Lz3WDodNczDjAHnsHy6IqZwHeJZ7VhHFl5cXy9pl
         Cv4kPsdwwpqmbzSREnEA+OFD/ZF4DRL8+pNOoQvDYu/eIn3ZBpcun4j8lH5RMusfKfj+
         kGVw==
X-Gm-Message-State: AOAM531FIrnwHyJqCJhAocLtSlQbzB9/iJivAGxVxn84w7DhROGeUNed
        giBb+ZcCjnbhXaVrcy8yYv4qiB5CmfLfUahocq0=
X-Google-Smtp-Source: ABdhPJwjCrG0dvNwTkm3RE2Ji4P0FKCIIZoxrttyVwcbGvKE83UU3kaZ1OOsZTeHTdcLAG1bCWx2Mre/wmlv2DodZcI=
X-Received: by 2002:a63:e15:: with SMTP id d21mr29031307pgl.152.1635973005512;
 Wed, 03 Nov 2021 13:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210920053951.4093668-1-goldstein.w.n@gmail.com>
 <20211027162615.1989004-1-goldstein.w.n@gmail.com> <20211027162615.1989004-2-goldstein.w.n@gmail.com>
 <YXmIP2EPg12N7foP@zn.tnic> <CAFUsyf+Y76TxLnxMSfHiNqY3OOZPtBR4m_EbTcow=N65nvGdKA@mail.gmail.com>
 <YXmQSG7BYCcZ6jqZ@zn.tnic> <CAFUsyfKVistpw8eL9L6qwypac7JL9ecAL2W4reZtAMOq7xL+2g@mail.gmail.com>
 <CAFUsyfLp6hqc1KOupFKLMoFHhDmEOQDZsMxEBF7BFABRYmH9-Q@mail.gmail.com> <YYL1nyfbjXCMvw+7@zn.tnic>
In-Reply-To: <YYL1nyfbjXCMvw+7@zn.tnic>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Wed, 3 Nov 2021 15:56:34 -0500
Message-ID: <CAFUsyfKQFQqP8ooY8UyJ3TXaZr9TxVOYV78a02-n5c-i22B5Jw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] x86/xstate: Make AVX512 status tracking more accurate
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, X86 ML <x86@kernel.org>,
        hpa@zytor.com, Andy Lutomirski <luto@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 3, 2021 at 3:48 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Nov 03, 2021 at 03:22:38PM -0500, Noah Goldstein wrote:
> > Ping.
>
> Dear Noah,
>
> in case you don't know, we have a merge window now. See below for a
> lenghty explanation what that means about new patches.
>
> Also, there's no need to constantly ping people - your patch has landed
> on my TODO list and will be dealt with when its time comes.


Sorry. Don't mean to pressure. Just didn't know the state it had landed.

Thank you for taking care of it :)

>
> If it is a serious bug fix, it will be handled with a higher priority
> but that is not the case, as far as I see it.
>
> So please sit back and be patient - it'll happen.
>
> Thx.
>
> "Merge window
> ^^^^^^^^^^^^
>
> Please do not expect large patch series to be handled during the merge
> window or even during the week before.  Such patches should be submitted in
> mergeable state *at* *least* a week before the merge window opens.
> Exceptions are made for bug fixes and *sometimes* for small standalone
> drivers for new hardware or minimally invasive patches for hardware
> enablement.
>
> During the merge window, the maintainers instead focus on following the
> upstream changes, fixing merge window fallout, collecting bug fixes, and
> allowing themselves a breath. Please respect that.
>
> The release candidate -rc1 is the starting point for new patches to be
> applied which are targeted for the next merge window."
>
> from Documentation/process/maintainer-tip.rst
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
