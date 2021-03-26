Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0141134AF4E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 20:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhCZTXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 15:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhCZTWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 15:22:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191C5C0613AA;
        Fri, 26 Mar 2021 12:22:52 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616786569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HOwEOhqJnXGxxll46m6ZslgjM0eNhem33zGhp699AZI=;
        b=GKLi8e/27BXLUR1JpxhP7JIL6b14TOiG5IMO3eePGGq3Kngm32tm5jIcOLRFdkaf+VPkgb
        06YJFKkYQ21lBgGCWXjiVQfLhK3xgMXijbBnANAgsfAjJIXmSnKDA5Y87WxKE8I3RPwRb2
        2nkIIMHx5E2ElJ/m7nTmxmlMEBBruDSf/vlwUDUHTa3hY5V6e+Z9DvNqtGmsV4MtRe+WB1
        xD36kvWyas47LlxqSSp/kHTuR8PHCTD/td6V5RjiEytuFs9WpUqT+ny7U/N9slwPcQM3eI
        I9Bj15txjh8GeD2CQP2jB6e+IfFv/Vqo0jWceyp8FV286+7bYprvwigkAD3kGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616786569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HOwEOhqJnXGxxll46m6ZslgjM0eNhem33zGhp699AZI=;
        b=OPbN9pptPVmjGKcs5UaqBX2Qj78kt+fQsNGoUpDzCafJTa6HAIIDAFol8Ih8L5anKfiV/b
        x3Uh/QjFXkM16pAQ==
To:     Len Brown <lenb@kernel.org>, Dave Hansen <dave.hansen@intel.com>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown\, Len" <len.brown@intel.com>,
        "Liu\, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v4 22/22] x86/fpu/xstate: Introduce boot-parameters to control state component support
In-Reply-To: <CAJvTdKk-d2rpsAYiPg7iJNZ=sEyhjBnGrT3Hy8Mt5G1TkEJRDw@mail.gmail.com>
References: <20210221185637.19281-1-chang.seok.bae@intel.com> <20210221185637.19281-23-chang.seok.bae@intel.com> <871rc9bl3v.fsf@nanos.tec.linutronix.de> <CAJvTdKkOKOgnmvAiPS6mWVoyAggbOB6hBOqb_tcHYDe8+-X+FQ@mail.gmail.com> <b1a8f92d-fd82-6e86-93ff-4ac200080d8c@intel.com> <CAJvTdKk-d2rpsAYiPg7iJNZ=sEyhjBnGrT3Hy8Mt5G1TkEJRDw@mail.gmail.com>
Date:   Fri, 26 Mar 2021 20:22:49 +0100
Message-ID: <87eeg1en3q.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Len,

On Fri, Mar 26 2021 at 11:27, Len Brown wrote:
> On Thu, Mar 25, 2021 at 7:10 PM Dave Hansen <dave.hansen@intel.com> wrote:
>> From some IRC chats with Thomaas and Andy, I think it's safe to say that
>> they're not comfortable blindly enabling even our "simple features".  I
>> think we're going to need at least some additional architecture to get
>> us to a point where everyone will be comfortable.
>
> There is no code in this patch series, including patch 22, that enables
> an unvalidated feature by default.
>
> Yes, I fully accept that patch 22 allows a user to enable something
> that a distro didn't validate.

That's not the point. And neither Andy nor myself asked for distros to
validate and approve anything.

> If there is a new requirement that the kernel cmdline not allow anything
> that a distro didn't explicitly validate, then about 99.9% of the kernel cmdline
> options that exist today would need to be removed.
>
> Does such a requirement exist, or does it not?

Nobody said that, but patches to remove command line options are always
welcome. Can we start with the most horrible of all we have today, i.e
"clearcpuid=", please?

Thanks,

        tglx
