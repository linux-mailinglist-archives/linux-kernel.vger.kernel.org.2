Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89BD53A4A2C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 22:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhFKUfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 16:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhFKUfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 16:35:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2286BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 13:33:22 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623443600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ahpVLmDUlFikGExgkNFOG0zVXR+svUsVeLAIbivpA4=;
        b=FGV1qv5WJdmFYoZ0QEEKPi22NGtmDvpYCocpjZ2vSCVD04xQ4ydA9JU6cPWTLjtWjiVokC
        9iWZ0Bn9hxAEgM3Pacd+XAEUyVg3BCAt2wY5irNCzk92aLGqNq6nLwFFy9vdBEcJZ5ZEMP
        ursxQhZssm81z2CahnSSlj7NAILwBNbLEgBKOuyRZ9qkZaTo760gylwxKDrjAt/kozWKgc
        M50tqI1CYZd5I6WAFIBe3xspLnqqM0grC5qoLv9JRfSNGhw7JTqAOijU4uA3v4v1Dd/wj7
        rFyJovZhcPbyhPVyrWFw/RHzVH/15bKsWNTgyZ4G2Fy5SafEvtw5Vl33bqchdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623443600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ahpVLmDUlFikGExgkNFOG0zVXR+svUsVeLAIbivpA4=;
        b=lnFJHwAsBInfsX/LlSvqX1U9+83EXzdxpeK5DMB1NuPMuP9vWJmBUcbU2ayQgl6dW045jr
        BrBb6/r/w5Ede9AA==
To:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [patch 08/41] x86/fpu: Restrict fpstate sanitizing to legacy components
In-Reply-To: <b81a0fe0-1aca-c0de-eb9e-895ac98c0c86@kernel.org>
References: <20210611161523.508908024@linutronix.de> <20210611163111.820639606@linutronix.de> <2be2ef6c-fcb8-46cf-976c-2b3a9537b660@kernel.org> <b81a0fe0-1aca-c0de-eb9e-895ac98c0c86@kernel.org>
Date:   Fri, 11 Jun 2021 22:33:20 +0200
Message-ID: <87eed8w38v.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11 2021 at 12:18, Andy Lutomirski wrote:
> On 6/11/21 12:03 PM, Andy Lutomirski wrote:
>> On 6/11/21 9:15 AM, Thomas Gleixner wrote:
>> Does this result in the mxcsr_mask and mxcsr fields being correct?
>> There is a silly number of special cases there.

Let me stare at that.

> The SDM says, in a footnote in XRSTOR:
>
> There is an exception if RFBM[1] =3D 0 and RFBM[2] =3D 1. In this case, t=
he
> standard form of XRSTOR will load MXCSR from memory, even though MXCSR
> is part of state component 1 =E2=80=94 SSE. The compacted form of XRSTOR =
does
> not make this exception.
>
> which makes me think that this code has a bug.  Also, the code is
> manifest nonsense for a different reason:
>
> if (!FP)
>   memset(the whole damn thing, 0);
>
> if (!SSE)
>   memset(just part of it, 0);
>
> which means that, if the FP bit is clear but the SSE bit is set, this
> thing will clobber the SSE state.
>
> This code is garbage.  So is the architecture that gave rise to this code.

No argument about that :)
