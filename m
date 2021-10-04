Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7621B420AF2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 14:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbhJDMhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 08:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhJDMhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 08:37:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2930C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 05:35:20 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633350919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5vLixdfDE0S5zHZr8cD6szxBdMNIIaIc2M+ATobHZdI=;
        b=o8sGjw9UUpIPLZUOzbgCh63dWmFvuhWekxFKrnZkiiqipuW0ZPSi2pC/oeEgiGF1Ka9Wav
        bh17hvhP6ZmNhkxRuCrR0qHA75k8mRNG87j98sm6QuRWTA0TKeTksCdlR/2r11u9kKAdFk
        6/KoiV7Y7kvT6qrjq+KtYlMKlw05gtL/cIJ6Yz/7bcdeZcJNDGwrsRklC8C7Q0ChE9dNHQ
        TyvaqlCaPqSb+tC7ZPGyS6MO2L8jdFK0Ug1I9s6PwCnEIx/vG4yrpaln0QNa3MiEGLSeJN
        f62pQlpv6a9CCYKMQ/Og8Hr76DxFWie8HsfmaqTjWIaIO5hx85Ww3rp31awaUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633350919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5vLixdfDE0S5zHZr8cD6szxBdMNIIaIc2M+ATobHZdI=;
        b=Jux+IFsAh0/0WHKPrecjVRV8bLUb01mZG0w2QLVdsFeR92PWRpQNGu95o6fVl5GYL7ebnm
        wvAnJOAFg9L0KUDQ==
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     "bp@suse.de" <bp@suse.de>, "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 13/28] x86/fpu/xstate: Use feature disable (XFD) to
 protect dynamic user state
In-Reply-To: <E5C66E6E-8AB8-4258-814D-C8E94446E2C4@intel.com>
References: <20210825155413.19673-1-chang.seok.bae@intel.com>
 <20210825155413.19673-14-chang.seok.bae@intel.com> <871r546b52.ffs@tglx>
 <87wnmw4w80.ffs@tglx> <E5C66E6E-8AB8-4258-814D-C8E94446E2C4@intel.com>
Date:   Mon, 04 Oct 2021 14:35:18 +0200
Message-ID: <87bl45ge7t.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 03 2021 at 22:38, Chang Seok Bae wrote:
> On Oct 1, 2021, at 08:10, Thomas Gleixner <tglx@linutronix.de> wrote:
>> 	local_irq_enable();
>
> v1 had some similar ones (not the same though) [1]. FWIW, I think Andy=E2=
=80=99s point
> is worth to be noted here:
>
>     First, you can't just enable IRQs here. If IRQs are off, they're off =
for a
>     reason. Secondly, if they're *on*, you just forgot that fact.

The #NM comes from user space where interrupts are always enabled. So we
can enable interrupts _after_ doing the sanity checks.

Also we reenable interrupts in various other trap handlers when the trap
comes from user space as well. That's perfectly fine and required. How
would e.g. fault handling or single stepping ever work otherwise?

I have no idea where you had places the local_irq_enable(), but the code
I outlined is correct.

Thanks,

        tglx

