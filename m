Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 185683A4A2D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 22:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhFKUgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 16:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbhFKUgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 16:36:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B2EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 13:34:45 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623443683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=atIT0RG+Bd3ZEMuwvwGozKDLhSW7XoFNglmJfcgkpfM=;
        b=eETIfLGVu0FdmZobR1tCuN8srt3sdtbT7UdWzRj/N87twnwoVztIECYTaDLRaxkIPbHRbI
        CCGLlOUl2jk2vlWulBMitkwO/ZtKfB0vMk3wvRzjflsprFSChHNKdx/Zwjxo92tIuCKKFk
        JROxWmC8p0M7omPrMqEnVerq7PsaAdSDeo6YleIlzoea1Kjnw0C0/oyuNE9AsudDqILLDa
        yC9tOPNSNWq3GTWPn+VbdU2JotMVDcM8r3iWLT7kUsB8CpA96m6eyRWIYhoxlwIz64uEiB
        UVyuxLsxQmqtvNSylRlyuOenMEwiN2rHotMfES6MYrUHz4mpLMyd+GmNXA/eZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623443683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=atIT0RG+Bd3ZEMuwvwGozKDLhSW7XoFNglmJfcgkpfM=;
        b=4vZbu7P8szbQ5Js1D0p72S1eZuUZueTesFrHGys0bfrwhswTgNoG3TzzNnB7R6CnU+0HTL
        lvxpp0OLCbqr35BA==
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
In-Reply-To: <87eed8w38v.ffs@nanos.tec.linutronix.de>
References: <20210611161523.508908024@linutronix.de> <20210611163111.820639606@linutronix.de> <2be2ef6c-fcb8-46cf-976c-2b3a9537b660@kernel.org> <b81a0fe0-1aca-c0de-eb9e-895ac98c0c86@kernel.org> <87eed8w38v.ffs@nanos.tec.linutronix.de>
Date:   Fri, 11 Jun 2021 22:34:43 +0200
Message-ID: <87bl8cw36k.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11 2021 at 22:33, Thomas Gleixner wrote:

> On Fri, Jun 11 2021 at 12:18, Andy Lutomirski wrote:
>> On 6/11/21 12:03 PM, Andy Lutomirski wrote:
>>> On 6/11/21 9:15 AM, Thomas Gleixner wrote:
>>> Does this result in the mxcsr_mask and mxcsr fields being correct?
>>> There is a silly number of special cases there.
>
> Let me stare at that.
>
>> The SDM says, in a footnote in XRSTOR:
>>
>> There is an exception if RFBM[1] =3D 0 and RFBM[2] =3D 1. In this case, =
the
>> standard form of XRSTOR will load MXCSR from memory, even though MXCSR
>> is part of state component 1 =E2=80=94 SSE. The compacted form of XRSTOR=
 does
>> not make this exception.
>>
>> which makes me think that this code has a bug.  Also, the code is
>> manifest nonsense for a different reason:
>>
>> if (!FP)
>>   memset(the whole damn thing, 0);

That's actually my bug. The code I replaced was different. Lemme stare
at it and fix it.

>> if (!SSE)
>>   memset(just part of it, 0);
>>
>> which means that, if the FP bit is clear but the SSE bit is set, this
>> thing will clobber the SSE state.
>>
>> This code is garbage.  So is the architecture that gave rise to this cod=
e.
>
> No argument about that :)
