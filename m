Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0918839E9CB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 00:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhFGWxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 18:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhFGWxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 18:53:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7542BC061574
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 15:51:57 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623106314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W+8HBkwXUWfaFKpTzso1FY801jIhgYorVwNTnXLAV3E=;
        b=Tmj9s2iMl0le/X3DsXCKKBdrGrCDU0kV4ejfQ4OxU+OvxZl3K8jJkXhH6P4goH9sn65zTo
        BTZ0t9XGQnCG3tuRO2Es5sqLXZgYNmfKRSUIXGL2k0j++TvK1vAJfPslgDB5scTY5voiXG
        5EdQt2onj9d63IpFBI1L+oznHwVl+gVW7PY3UGoylsmmiQV93xMGIo0oW4Myt+1BV/LXmW
        r6huiUfHkGuMEKZV6IhRl8sMIaxukd0pO1KeiW85BXAuCDfGCDG7Gfum746eaTBCF+t3Mu
        yD+wBqXOUh1OBV1RjXIsk2QBZLf/DKaFviQxYs2EfFYSYECwCBKLpLPd77v9rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623106314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W+8HBkwXUWfaFKpTzso1FY801jIhgYorVwNTnXLAV3E=;
        b=CFdZCbmooEGfEe73dNd2jYublkOyyD1BP7iawQK5xYIroGVVmoL+V+dNLXeEmqFoAmJVlS
        WcnNfwb086nOEPCw==
To:     Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch V2 00/14] x86/fpu: Mop up XSAVES and related damage
In-Reply-To: <37df631f-9d3d-3035-6eeb-85ef33e580d5@intel.com>
References: <20210605234742.712464974@linutronix.de> <87h7i9zv3r.ffs@nanos.tec.linutronix.de> <eca0add1-849e-6a1a-8ea6-f6b72650c9c8@intel.com> <87eeddzs0l.ffs@nanos.tec.linutronix.de> <37df631f-9d3d-3035-6eeb-85ef33e580d5@intel.com>
Date:   Tue, 08 Jun 2021 00:51:54 +0200
Message-ID: <87bl8hz3sl.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07 2021 at 09:38, Dave Hansen wrote:
> On 6/7/21 7:08 AM, Thomas Gleixner wrote:
>>> By the way, are you talking specifically about the _error_ paths where
>>> the kernel is unable to XRSTOR the signal XSAVE buffer for some reason,
>>> and tries to apply either init_fpu or the hardware init state instead?
>>=20
>> 1) Successful XRSTOR from user if the PKRU feature bit in the
>>    sigframe xsave.header.xfeatures is cleared. Both fast and slow path.
>
> It seems like the suggestion here is to inject 'init_pkru_value' in all
> cases where the kernel would be injecting the hardware init value.  I
> don't think we should go that far.
>
> If a signal handler sets xsave.header.xfeatures[PKRU]=3D0, I can't imagine
> any other intent than wanting the hardware init value.
>
> The error cases don't have intent and the kernel is pretty free to
> inject whatever sanity it deems fit to make forward progress.
>
>> 2) Successful XRSTOR from user if the PKRU feature bit is cleared in
>>    fx_sw_user.xfeatures as that loads init_fpstate which is busted in
>>    mainline. Both fast and slow path. Patch 4/14 of this series fixes th=
is.
>
> This comes down to what happens when "xsave.header.xfeatures !=3D
> fx_sw_user.xfeatures".  I honestly don't have the foggiest idea, and
> seriously doubt anyone cares.  I'm fine with where 4/14 lands.
>
>> 3) fx_only both in the fast and slow path are broken without 4/14
>
> fx_only to me means that XSAVE doesn't work, either because the hardware
> doesn't support it, or userspace mucked with the buffer enough so XSAVE
> doesn't work.  That's pretty close to the error case, and I'm fine with
> the kernel doing what it wants.
>
> BTW, we currently zap X86_FEATURE_PKU if XSAVE is disabled.  That gets
> rid of at least a few of the nasty fx_only cases.

So as we further discussed on IRC:

We have an hen and egg problem because the hardware init value is 0
(maximum permissive) and the kernel initial PKRU value is minimal
permissive.

Of course we cannot make this consistent ever because the hardware does
not provide a mechanism to set a default PKRU init value, e.g. via the
obviously useful MSR_PKRU_INIT.

So what ever we do, we end up being inconsistent because a user space
XRSTOR behaves different from a sigreturn restore in many ways, some of
them are historical nonsense, i.e. the completely obscure
fpx_sw_bytes.xfeatures handling.

Unless we revert acd547b29880 ("x86/pkeys: Default to a restrictive init
PKRU") there is no real consistent solution. But that revert makes no
sense either because that would put the burden on user space to come up
with some sensible default when initializing an application (think
libraries) and still would not give any meaningful values for the XRSTOR
case with the PKRU bit disabled in xfeatures.

Now a real useful way out of this is to remove PKRU from xsaves
alltogether, i.e. disable it in XCR0 as XSAVES managed state.

That solves a couple of problems:

  1) The issue that PKRU has to be context switched contrary to the rest
     of XSTATE which conflicts with the restore XSTATE only on return to
     user space approach.

  2) The signal restore would get rid of all consistency issues in one
     go.

  3) init_fpstate would become __ro_after_init and not involved in all
     of that

That opens up the opportunity to:

  1) Make the PKRU value on the signal frame independent of XSAVE init
     issues

  2) To provide a per process or task defined PKRU default value which
     can be used for e.g. the signal handling path which makes a lot of
     sense on it's own.
=20=20
But it creates a few new problems:

  1) Where to put the PKRU value in the sigframe?

     For 64bit sigframes that's easy as there is padding space, for
     32bit sigframes that's a problem because there is no space.

  2) Backward compatibility

     As much as we wish to have a time machine there is a rule not to
     break existing user space.

Now fortunately there is a way out:

  1) User space cannot rely on PKRU being XSTATE managed unless PKRU is
     enabled in XCR0. XCR0 enablement is part of the UABI so any
     complaint about missing XCR0 support is futile

  2) As documented in pkey_alloc(2):

     "pkey_alloc() is always safe to call regardless of whether or not
      the operating system supports protection keys.  It can be used in
      lieu of any other mechanism for detecting pkey support and will
      simply fail with the error ENOSPC if the operating system has no
      pkey support.

      The kernel guarantees that the contents of the hardware rights
      register (PKRU) will be preserved only for allocated protec=E2=80=90 =
tion
      keys.  Any time a key is unallocated (either before the first call
      returning that key from pkey_alloc() or after it is freed via
      pkey_free()), the kernel may make arbitrary changes to the parts
      of the rights register affecting access to that key."

Stupidly the pkeys(7) man page says:

      "This signal behavior is unusual and is due to the fact that the
       x86 PKRU register (which stores protection key access rights) is
       managed with the same hardware mechanism (XSAVE) that manages
       floating-point registers.  The signal behavior is the same as
       that of floating-point registers."

But that's not a show stopper IMO because the signal behaviour of XSTATE
managed floating point registers is documented that it only contains the
register state which is actually XSTATE managed, i.e. the corresponding
bit is set in XCR0 which user space can retrieve via XEGTBV and which is
fortunately part of the *kinda* documented ABI.

So the proposed solution is to:

   A) Exclude PKRU from XSTATE managed state, i.e. do not set the PKRU
      bit in XCR0

   B) Exclude 32bit applications on 64bit kernels from using PKEYS by
      returning an error code from pkey_alloc(). That's fine because the
      man page requires them to handle the fail which they need to do
      anyway because 32bit kernel do not support PKEYS and never will.

   C) Replace the current context switch mechanism which is partially
      XSAVE based by a software managed one.

   D) Store the PKRU value in one of the reserved slots of the 64bit
      signal frame which is possible because of #B so that a signal
      handler has the chance to override the interrupted task's PKRU
      setting.

Thoughts?

Thanks,

        tglx


=20=20=20=20=20=20
