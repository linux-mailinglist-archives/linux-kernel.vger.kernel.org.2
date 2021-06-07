Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52F439DE5A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 16:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhFGOKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 10:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbhFGOKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 10:10:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB763C061787
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 07:08:45 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623074922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AuQ9EP9vP1aMzOrAkT0RHCOfBg5YJvgEV+4gSQnHRE4=;
        b=itY2EYq4oU0QzzOoeNPlmqaS+fMqbnFDUN5I25PsjQKfH0Cvh0bq02lJh/dUcWND4VjqJL
        h970Klr36FwNEqv0RPx938+WSIzGGfUiX//kbc7TzAxaFtRapqgQuygStlFmX9EHsMzUS7
        EQu9hcUvI+etDSvpg8ZGUu4dRjPbe45yhCSl2qmUc9AdGXoY5h927k+cN59G3UkcIUOE34
        zQn7gjqBMzJwtJAxuF9gy3JsMIuO/jb06k8MDgVn7jkgqcdu7wEbdNKt0SkqwPZsyhPkpc
        1fet8bXeSbIF00QPb+IzpAOnFGi8xu457MZp1p/fxDoEJiqit1oyh7tCkuDGnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623074922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AuQ9EP9vP1aMzOrAkT0RHCOfBg5YJvgEV+4gSQnHRE4=;
        b=jf0KWuhBMl9/ogfTMEVA9kxISGVHFp5dGULf0s5DFbL1G9jXIUVlv2BVRvs5NM9rVDJGXg
        WTEzrsKN7HH12CCQ==
To:     Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch V2 00/14] x86/fpu: Mop up XSAVES and related damage
In-Reply-To: <eca0add1-849e-6a1a-8ea6-f6b72650c9c8@intel.com>
References: <20210605234742.712464974@linutronix.de> <87h7i9zv3r.ffs@nanos.tec.linutronix.de> <eca0add1-849e-6a1a-8ea6-f6b72650c9c8@intel.com>
Date:   Mon, 07 Jun 2021 16:08:42 +0200
Message-ID: <87eeddzs0l.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07 2021 at 06:36, Dave Hansen wrote:
> On 6/7/21 6:02 AM, Thomas Gleixner wrote:
>> On exec() the kernel sets PKRU to the default value which is as
>> restrictive as possible.
>> 
>> But on sigrestore PKRU when the init optimization is used PKRU is reset
>> to the hardware default (0), which is as permissive as possible:
>> 
>>   1) On XRSTOR from user and the signal handler cleared the PKRU feature
>>      bit in xsave.header.xfeatures. That's true for the fast and the
>>      slow path.
>> 
>>   2) For the fx_only case which loads the init_fpstate (with my fixes
>>      applied that's not longer the case)
>> 
>> So that's inconsistent at best.
>> 
>> As the kernel defines the "init" behaviour of PKRU as non-permissive
>> on exec() it should do so consequently in sigrestore as well.
>
> Agreed.  The kernel has essentially picked its own init value for PKRU,
> separate from the hardware init value.  It should be applied consistently.
>
> By the way, are you talking specifically about the _error_ paths where
> the kernel is unable to XRSTOR the signal XSAVE buffer for some reason,
> and tries to apply either init_fpu or the hardware init state instead?

1) Successful XRSTOR from user if the PKRU feature bit in the
   sigframe xsave.header.xfeatures is cleared. Both fast and slow path.

2) Successful XRSTOR from user if the PKRU feature bit is cleared in
   fx_sw_user.xfeatures as that loads init_fpstate which is busted in
   mainline. Both fast and slow path. Patch 4/14 of this series fixes this.

3) fx_only both in the fast and slow path are broken without 4/14

4) The error handling path (failed restore) is actually doing the right
   thing.

The slow path and the fx_only/fx_sw_user.xfeaturers cases are trivial
to fix.

The fast path not so much because XRSTOR operates directly on the
sigframe and there is no information about the header.xfeatures
content. So to fix this, we need to get header.xfeatures from user
before the XRSTOR and then handle the case then the PKRU bit is clear.

Thanks

        tglx
  





   
