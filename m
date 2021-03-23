Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECDD1346AB1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbhCWVCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:02:36 -0400
Received: from mail-ej1-f52.google.com ([209.85.218.52]:41594 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbhCWVCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:02:10 -0400
Received: by mail-ej1-f52.google.com with SMTP id u5so29378167ejn.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 14:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=piHhFa85E0Z3Zzr7hilVx8SqiHOmrEsubdVllNbeaBA=;
        b=KGPT9DNoqn4YLVsfyY7YSiXA8VfnpmLlRxLS3oXy7rMSq76c/8pgUJQqtPFI14WIbZ
         eF0OLOP2n7qctpAdNIkfKH4RfSX0xW51IeHcI2zMwK2ExK8x3JDBTqgjF3zBt+x5i3pT
         PWUKxnzsthcxa0Yr4SsUTD6yBfHRQ1KMwQUBnSb8sGb6zVYdUJrQgnYW/raW6WfuMN4t
         Z1AML0hwg7tW+Q4+soRlZ64tEvyjGOsvLVn1PeKkis6ndsB2Ry2IM7kAzduTmdOh4bDx
         T9IXW1b+MEo4+sX6RV9HegGfWxKpup7R+XeVuvBvD/5uJFcngpj0eFnXfD8FYlBpzUYw
         ahCw==
X-Gm-Message-State: AOAM532YNQ++9VXx/Ewukhqhr1CJvzVvccc4idDLbXudjcqAVX9AT2nA
        nmV9kg0A8ANVukqpwx6x46Kl/4J3ftSyScEzrvk=
X-Google-Smtp-Source: ABdhPJx2bwST4v/J9Mt5/AUPh8ItMB7D1mIZ9dp+GaBqZS3BYP3o0NQx4i3QgDhom/jkaMyBoZNMimGdmZa09F0fK1s=
X-Received: by 2002:a17:907:761c:: with SMTP id jx28mr95779ejc.417.1616533329256;
 Tue, 23 Mar 2021 14:02:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210221185637.19281-1-chang.seok.bae@intel.com>
 <20210221185637.19281-15-chang.seok.bae@intel.com> <87o8fda2ye.fsf@nanos.tec.linutronix.de>
 <CALCETrVaCmG4jzLCSuy7WYP2K7r-MVZntfugWa8HiVxQ7LpF_A@mail.gmail.com>
In-Reply-To: <CALCETrVaCmG4jzLCSuy7WYP2K7r-MVZntfugWa8HiVxQ7LpF_A@mail.gmail.com>
From:   Len Brown <lenb@kernel.org>
Date:   Tue, 23 Mar 2021 17:01:58 -0400
Message-ID: <CAJvTdKmz7aePcpi4i+d3vnqLuNAJEuJCjpGDv5WTYcSUfuxoDg@mail.gmail.com>
Subject: Re: [PATCH v4 14/22] x86/fpu/xstate: Expand the xstate buffer on the
 first use of dynamic user state
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I have an obnoxious question: do we really want to use the XFD mechanism?

Obnoxious questions are often the most valuable! :-)

> Right now, glibc, and hence most user space code, blindly uses
> whatever random CPU features are present for no particularly good
> reason, which means that all these features get stuck in the XINUSE=1
> state, even if there is no code whatsoever in the process that
> benefits.  AVX512 is bad enough as we're seeing right now.  AMX will
> be much worse if this happens.
>
> We *could* instead use XCR0 and require an actual syscall to enable
> it.  We could even then play games like requiring whomever enables the
> feature to allocate memory for the state save area for signals, and
> signal delivery could save the state and disable the feature, this
> preventing the signal frame from blowing up to 8 or 12 or who knows
> how many kB.

This approach would have some challenges.

Enumeration today is two parts.
1. CPUID tells you if the feature exists in the HW
2. xgetbv/XCR0 tells you if the OS supports that feature

Since #2 would be missing, you are right, there would need to be
a new API enabling the user to request the OS to enable support
for that task.

If that new API is not invoked before the user touches the feature,
they die with a #UD.

And so there would need to be some assurance that the API is successfully
called before any library might use the feature.  Is there a practical way
to guarantee that, given that the feature may be used (or not) only by
a dynamically
linked library?

If a library spawns threads and queries the size of XSAVE before the API
is called, it may be confused when that size changes after the API is called.

So a simple question, "who calls the API, and when?" isn't so simple.

Finally, note that XCR0 updates cause a VMEXIT,
while XFD updates do not.

So context switching XCR0 is possible, but is problematic.

The other combination is XFD + API rather than XCR0 + API.
With XFD, the context switching is faster, and the faulting (#NM and
the new MSR with #NM cause) is viable.
We have the bit set in XCR0, so no state size advantage.
Still have issues with API logistics.
So we didn't see that the API adds any value, only pain,
over transparent 1st use enabling with XFD and no API.

cheers,
Len Brown, Intel Open Source Technology Center

ps. I agree that un-necessary XINUSE=1 is possible.
Notwithstanding the issues initially deploying AVX512, I am skeptical
that it is common today.  IMO, the problem with AVX512 state
is that we guaranteed it will be zero for XINUSE=0.
That means we have to write 0's on saves.  It would be better
to be able to skip the write -- even if we can't save the space
we can save the data transfer.  (This is what we did for AMX).

pps. your idea of requiring the user to allocate their own signal stack
is interesting.   It isn't really about allocating the stack, though --
the stack of the task that uses the feature is generally fine already.
The opportunity is to allow tasks that do *not* use the new feature to
get away with minimal data transfer and stack size.  As we don't
have the 0's guarantee for AMX, we bought the important part
of that back.
