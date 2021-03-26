Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1E9349F12
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 02:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhCZBvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 21:51:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51452 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhCZBua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 21:50:30 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616723428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qk7ofeEc58aagvDU4M/2eGpuGBknhHhtWyOKLfXRzAU=;
        b=UCI8Ff9ugAC7C5wR27Hq3NBnRG2C8pv+SQFgcxPVXYfNqG1wvbRqv3G4Z0BecuDqVIuCPb
        vYMHwSi1amkIlDiNxDK3HlJ3GOdMSI/HqD0x61sUOH/tbHc4mBZKW8gIeJe6vcN42AtgZr
        E5yF+oTY6b8yX4c3x/GKWs7Hv+d6ifgPIkwWtiX4JEA3WkJTl0RXdAf1Y10toIj9IsM5nC
        D8gOS/oHL+UxPBZCtnEXYuyVUs3Ksxry7eR+YLHXhLckw58pvqCrXiHbQ9f2tug5wGdzMQ
        Su5xWHvaKoZsdjDPSf3otIMIPW2yB5c+V8q1Ys6CTMkXduezZvMRiY3XoOvv7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616723428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qk7ofeEc58aagvDU4M/2eGpuGBknhHhtWyOKLfXRzAU=;
        b=xxTEfloyJ93iplom+6w50LbegSao7uXjQGkLRHsscZKBpyPNdsFHytTYc/sdL73xFQXAnj
        tOAs9K722wZSEeBQ==
To:     Len Brown <lenb@kernel.org>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown\, Len" <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu\, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v4 22/22] x86/fpu/xstate: Introduce boot-parameters to control state component support
In-Reply-To: <CAJvTdKkOKOgnmvAiPS6mWVoyAggbOB6hBOqb_tcHYDe8+-X+FQ@mail.gmail.com>
References: <20210221185637.19281-1-chang.seok.bae@intel.com> <20210221185637.19281-23-chang.seok.bae@intel.com> <871rc9bl3v.fsf@nanos.tec.linutronix.de> <CAJvTdKkOKOgnmvAiPS6mWVoyAggbOB6hBOqb_tcHYDe8+-X+FQ@mail.gmail.com>
Date:   Fri, 26 Mar 2021 02:50:28 +0100
Message-ID: <87v99evg2j.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Len,

On Thu, Mar 25 2021 at 18:59, Len Brown wrote:
> On Sat, Mar 20, 2021 at 4:57 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>> We won't enable features which are unknown ever. Keep that presilicon
>> test gunk where it belongs: In the Intel poison cabinet along with the
>> rest of the code which nobody ever want's to see.
>
> I agree, it would be irresponsible to enable unvalidated features by default,
> and pre-silicon "test gunk" should be kept out of the upstream kernel.

Well, that's not my experience from the past and sorry for being
paranoid about that.

> This patch series is intended solely to enable fully validated
> hardware features, with product quality kernel support.

The fact, that the function is broken as provided, definitely supports
that product quality argument.

> The reason that the actual AMX feature isn't mentioned until the 16th
> patch in this series is because all of the patches before it are
> generic state save/restore patches, that are not actually specific to
> AMX.

That's related to 22/22 in which way?

> We call AMX a "simple state feature" -- it actually requires NO KERNEL
> ENABLING above the generic state save/restore to fully support
> userspace AMX applications.

Aside of the unanswered questions vs. the impact of letting it in
initialized state along with the unsolved problem of sigaltstacks...

> While not all ISA extensions can be simple state features, we do
> expect future features to share this trait, and so we want to be sure
> that it is simple to update the kernel to turn those features on (and
> when necessary, off).

History tells me a different story.

> There will be a future CPUID attribute that will help us identify
> future simple-state features.
> For AMX, of course, we simply know.

You believe so, but do you know for sure?

I neither know for sure nor do I believe any of this at all.

Please provide the architectural document which guarantees that and does
so in a way that it can be evaluated by the kernel. Have not seen that,
so it does not exist at all.

  Future CPUID attributes are as useful as the tweet of today.

> So after the generic state management support, the kernel enabling of AMX
> is not actually required to run applications.  Just like when a new instruction
> is added that re-uses existing state -- the application or library can check
> CPUID and just use it.  It is a formality (perhaps an obsolete one), that
> we add every feature flag to /proc/cpuid for the "benefit" of
> userspace.

It's not a formality when the instruction requires kernel support and
from the history of the various incarnations of this command line option
it's just a given that this is going belly up.

Even the current incarnation is broken just from looking at it, so what
the heck are you talking about?

> The reason we propose this cmdline switch is
> 1. Ability of customers to disable a feature right away if an issue is found.
> Unlike the CPUid cmdline that works on flags, this is the ability to turn
> off a feature based on its state number.  Ie.  There could be 20 features
> that use the same state, and you can turn them all off at once this
> way.

I'm fine with that, but then the disabling has to handle all the things
related to it and not just be on a 'pray that it works' base.

> 2. Ability of customers to enable a feature that is disabled by default
> in their kernel.  Yes, this will taint their kernel (thanks Andy),
> but we have customers that want to run the new feature on day 0
> before they have got a distro update to change the default, and this
> gives them a way to do that.

You might know my opinion from previous discussions about this topic,
but let me repeat it for completeness sake:

   This is a generic kernel exposed to a gazillion of users and a
   minority of them want to have the ability to enable insane
   stuff on the command line because:

     1) Intel is not able to provide them a test kernel package

     2) Their favourite $DISTROVENDOR is not able to provide them a
        test kernel package

     3) Intel did not manage to get the support for this upstream
        on time so the $DISTROVENDOR was able to backport it into
        their Frankenkernel

   So you seriously want us to have a command line option to enable
   whatever the feature of today is because of #1-#3?

   Sure, from a Intel managerial POV that's all cool. Not so much when
   you put your community hat on and think about the consequences.

   Aside of that none of the above #1 - #3 is a technical argument.  See
   Documentation/process/* for further enlightment.

Of course none of your arguments above have shown up in the changelog of
this command line patch. And none of the potential side effects or down
sides have been mentioned.

Don't blame Chang Bae for that. That patch carries a:

      Reviewed-by: Len Brown <len.brown@intel.com>

I really have to ask whether you actually looked at the code and the
changelog or just tagged it because some internal procedure requires it.

Either way ....

> Yeah, the cmdline syntax is not a user-friendly mnemonic, and I don't know
> that making it so would be an improvement.
> Like the CPUID cmdline, it is precise, it is future-proof, and it is
> used only in special situations.

The CPUID commandline option is yet another trainwreck which is neither
precise nor future proof if you dare to take a deep technical look. It
should have never been merged and it should be ripped out rather than
proliferated. If you think otherwise then please provide a proper proof
that this commandline option is correct under all circumstances before
abusing it as an argument.

Please try again when you have

  - a reviewable and functional correct implementation

  - including the ability to evalute that via architectural CPUID

  - a changelog which provides an argument which is based on solely
    technical criteria instead of wishful managerial thinking or being
    just void of content like the current one.

Sorry for looking at this solely from the technical side and thereby
ignoring all the managerial powerpoint slide illusions.

Now putting my managerial hat on:

    Given the history of that command line option, I have no idea why
    this has even be tried to piggy pack on AMX at all. It's an
    orthogonal problem and absolutely not required to make AMX supported
    in the first place.

    Hrm, unless you expect that a lot of users will need to disable AMX
    because ... But that would be a technical reason not to enable it
    in the first place, which is not desired from a managerial/marketing
    POV, right?

Thanks,

        tglx
