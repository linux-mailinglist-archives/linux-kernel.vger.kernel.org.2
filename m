Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1FA36EEF1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 19:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240975AbhD2Rc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 13:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbhD2Rc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 13:32:56 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAF1C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 10:32:08 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id z23so30908822lji.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 10:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7np8PxEBIfKzo8X9ratNgnW7KInhe0xQPLjwvvGhK/M=;
        b=Z5Oqj8fBP0FUm8FD8BuwdL3QlTYDqairdidocmEP1pkj4o/zaNbZCO9NkV8mozsQl+
         xY/rLp/EYZ2z1BKJ2gWrHVUR4vyEx1VIoE6LW7JzruSj8bQoqiujGxoMbyqogYiOFVsm
         E9FmKPsFWzgpBF0XTfkFRQQAGP2vA5dWOQ3so=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7np8PxEBIfKzo8X9ratNgnW7KInhe0xQPLjwvvGhK/M=;
        b=ZyVbU/wB235GCpqo/vieVll0x0eaHtDxW4Ci+bcKdTTPhOYhOYMPKcNWTKy2Brslba
         x+Zmh4x5jPjsrc8mIDYC8RNVWGdyBaMxIn6Ez3ysWtNJ+Hy0A/MiwCk39bvlLNY/ADxM
         DBIrHJg+t8XVOfTH35wwOspDIpO3KzR5InbWSdwaR9xtQFaoj71peSHMF5iL7OU4lODk
         3zEHlJerrFeoUHfVi1kTjJ2bUKGSvtUemqk72QJyKqUa9l8EzqTO53megNErz0VUHB4V
         gmrXJ6huyOMiEyh9vHiqRbqKzqDmuAM3rH1s7W7+Vu2/oj36yzz4cMCG2soaaLK54Fbq
         Ztwg==
X-Gm-Message-State: AOAM530wPB3uCsQ7RQsBQzO62yjfzVjJC/9DKrktOfazmGRffJTSW0cf
        mDM9Mr54LZkq8sNznIjKUIHnvp+K94Ssd1pA
X-Google-Smtp-Source: ABdhPJxRJ3NekHS/XFpS5L8b1maKgFZsIGoCDTde3/fhVQLydhpDS9mvj/+CZVZ/ichizl1Sd8EdIA==
X-Received: by 2002:a2e:bf03:: with SMTP id c3mr605565ljr.184.1619717526271;
        Thu, 29 Apr 2021 10:32:06 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id j9sm38281lfu.85.2021.04.29.10.32.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 10:32:05 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id n138so106208753lfa.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 10:32:05 -0700 (PDT)
X-Received: by 2002:a19:c30b:: with SMTP id t11mr409242lff.421.1619717524788;
 Thu, 29 Apr 2021 10:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210423063227.GA17429@xsang-OptiPlex-9020> <CAHk-=wg8iAG6bBB+zdoZvZx1XYmyAXrWL0gPs_eTrTt+tXN0Tw@mail.gmail.com>
 <20210425014816.GB5251@xsang-OptiPlex-9020> <CAHk-=wiW7xdHZTBgVOpVFM_7bek0HGvioQvCCyDXCbRa2fWdXQ@mail.gmail.com>
 <20210429075300.GA31265@xsang-OptiPlex-9020>
In-Reply-To: <20210429075300.GA31265@xsang-OptiPlex-9020>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Apr 2021 10:31:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh62h6XXgKqhHnb=LTrmbMcVsV8GhXJvEoceTyHKtdBJA@mail.gmail.com>
Message-ID: <CAHk-=wh62h6XXgKqhHnb=LTrmbMcVsV8GhXJvEoceTyHKtdBJA@mail.gmail.com>
Subject: Re: [mm/vunmap] e47110e905: WARNING:at_mm/vmalloc.c:#__vunmap
To:     Oliver Sang <oliver.sang@intel.com>, Jessica Yu <jeyu@kernel.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Harish Sriram <harish@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Backgroudn for Jessica:

    https://lore.kernel.org/lkml/20210423063227.GA17429@xsang-OptiPlex-9020/

  with some more emails in this thread ]

On Thu, Apr 29, 2021 at 12:36 AM Oliver Sang <oliver.sang@intel.com> wrote:
> >
> > Oh, that's interesting. So only 12 out of 74 runs saw that __vunmap
> > warning, but if I understand your table correctly, there were some
> > _other_ issues in there?
>
> yes, there are.

Yeah, so it really does look like the commit you bisected to changes
timing - and thus just exposes an existing problem.

And it's likely a race condition, and it exposes the existing problem
not just in a new place, but much *MORE*.

The fact that you see something like

    Trying to vfree() bad address (0000000070935066)

means that clearly something has corrupted the the module data in
'struct module *'. Because that should have been a core_layout.base
pointer that was allocated with moodule_alloc(), which is just a
vmalloc wrapper on x86-64.

The allocations in the module handling are somewhat odd (putting it
mildly), with that 'struct module *' actually being a pointer *into*
the module allocation itself, so I suspect there's some race with
del_module() or something, and the reason you bisect to that commit
e47110e90584a22e9980510b00d0dfad3a83354e is that the added
cond_schedule() in the vfree path now exposes exactly that race of two
things trying to free the same module at the same time.

This all *should* be serialized by various subtle things

 - MODULE_STATE_UNFORMED means that modules are bypassed

 - the actual allocation/freeing functions use module_mutex to serialize

 - some lookup functions use RCU to look up a module but should then
only look at things like the symbol arrays etc.

but if somehow del_module() can race with do_init_module() creating a
module halfway and then doing free_module() (or perhaps multiple
module loads of the same module racing and aborting), then I can see
one freeing the underlying module data, and the other one seeing
corrupt 'struct module *' as a result.

I suspect the other oopses are different symptoms of the same bug, and
I wonder if they woudl give more hints about what the "other side" of
the thing is. Like that BUG:unable_to_handle_page_fault_for_address /
canonical_address one that you have multiple hits for on both side of
that commit you bisected to?

Jessica, have you seen any particular problematic module loading
reports that could give other hints about what goes wrong?

             Linus
