Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C4D44238B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 23:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbhKAWrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 18:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhKAWrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 18:47:39 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95867C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 15:45:05 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bu18so22001384lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 15:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SNUbkTtYTbfw3LTnBHUuLedyMtf0R5lgICFaSOZddUo=;
        b=G/5y+m3w1Y6havoAR2aXaL2ZhhabpzEbQzZWA+38slab1Y1n//uVsvgxYimYyLbqyf
         63bF/M3I74r5mlfWH6719K2PveOr6Tbjr/ZvatJzuO/Zn0XfMjrArn0kLKId+tzYts8O
         u/PzEYr8kCq4VCV/DZRk2lsd0LoGYdFOpVWuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SNUbkTtYTbfw3LTnBHUuLedyMtf0R5lgICFaSOZddUo=;
        b=5m5MGSWuf6q9e4Z1BcK2KnCQz6V8byjcVbkvOxHJ1jaI55Jfqg03ox+QQ5t7webGOT
         f9RUgJomcOww/+CJFOe11FWuOtTBTQwViZTAHZjpWFApaXNSRaZd4hwwgTPnZsk2e6wG
         gRVqILah75X5mKQFpm5wXjO6ON7/HSw7jlQwTMlnahwHMoPDRBlgENiHtvPp024EbHh7
         3kRq3iON91rrQKXkv0k5Pw4mUra6GCzLWE1kHP1Qc5vcZaq+WuhbqRtYBqBw5uvRbGPz
         RaMhpeoSWzeegSDh2sPkzRPWhG3yaemL2ssKeFyzpi08GaCrClri6AmKzWoTRKhWYfWz
         8n5A==
X-Gm-Message-State: AOAM530tEzrsNF2bVCK1JUeLXS242UABpgJ5ZmXgG1fePJYQ3SskCTQ9
        k2ob7UJGPCRbRv8viMCJRcg+K/WGyV+XJMJm
X-Google-Smtp-Source: ABdhPJwJ2cxL4rfeeZBtW27NYXzIeDP0b8gon7xqYcxWGdBdpdW/DwBIgxzciJ9fIutp+wcx5//ZJg==
X-Received: by 2002:a05:6512:3aa:: with SMTP id v10mr18839428lfp.13.1635806703634;
        Mon, 01 Nov 2021 15:45:03 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id q6sm1646264ljh.1.2021.11.01.15.45.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 15:45:03 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id k22so10178621ljk.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 15:45:02 -0700 (PDT)
X-Received: by 2002:a05:651c:17a6:: with SMTP id bn38mr33500059ljb.56.1635806702447;
 Mon, 01 Nov 2021 15:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <YX/BhEUBTK4bkQNm@zn.tnic>
In-Reply-To: <YX/BhEUBTK4bkQNm@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Nov 2021 15:44:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wijTDq+_TQtk9NdRi7AyDpmhvtMzs5=jvPJvNT6qA3HkA@mail.gmail.com>
Message-ID: <CAHk-=wijTDq+_TQtk9NdRi7AyDpmhvtMzs5=jvPJvNT6qA3HkA@mail.gmail.com>
Subject: Re: [GIT PULL] x86/cpu for v5.16
To:     Borislav Petkov <bp@suse.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 1, 2021 at 3:29 AM Borislav Petkov <bp@suse.de> wrote:
>
> - Start checking a CPUID bit on AMD Zen3 which states that the CPU
> clears the segment base when a null selector is written. Do the explicit
> detection on older CPUs, zen2 and hygon specifically, which have the
> functionality but do not advertize the CPUID bit. Factor in the presence
> of a hypervisor underneath the kernel and avoid doing the explicit check
> there which the HV might've decided to not advertize for migration
> safety reasons, a.o.

"a.o."? Is that a common German shorthand, possibly anglicized?

I'm assuming - and rewrote it - that it stands for "or similar".

Possibly "among other" aka "inter alia"? Very occasionally shortened
"i.a.", although "e.g." is the _much_ more common form of much the
same thing.

Never seen that "a.o." thing.

               Linus
