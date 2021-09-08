Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F01403A81
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 15:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349346AbhIHNWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 09:22:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50876 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349315AbhIHNWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 09:22:33 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631107284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=33Nk/vdkZ6k9Oes7z0H/ATHMundijj8Fk0qr9QwfkIk=;
        b=zq8PtbrLT33AbqbVp/pDo9T/VRoSiAQ4ImF4KWpx0oa70emvJxn2d6NAXJYUO9Dke7NJK4
        Yw/Dif6A8p4eNTo4StYbViHqn0RXCd8HlPWCPpOzjWnTW+g9osr/T5F57XPuMH3/SgtcjE
        FNATaPVwqn4VIgkJQHqtirHxLDucnafZKhmhHhd0D8r5qn+kgIH06+UE+fKzdaz+fkACgb
        Cy1ATJYBugIYprujDF7jT4feIEbkaHjPrhmrm7DXZ9BlesVVcujb5r4paKlr/Ye5w5em3l
        vsNOMSayPFdc55WCNskgaMGLL3LesUvVWSfWvca7aqta/UcGdPNH+SC69ptt9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631107284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=33Nk/vdkZ6k9Oes7z0H/ATHMundijj8Fk0qr9QwfkIk=;
        b=MUkFNyP+EjH6OwlIQwLhzqgITP8n1CENwsKGu8y34Ib0UDMCwWrMCp+K1qcEk3F8TrF/7R
        yNNVveBQ6fRyqPBw==
To:     "Luck, Tony" <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Ziljstra <peterz@infradead.org>
Subject: RE: [patch V2 00/20] x86/fpu: Clean up exception fixups and error
 handling in sigframe related code
In-Reply-To: <87pmtj8x7z.ffs@tglx>
References: <20210907195612.321345EED@xen13.tec.linutronix.de>
 <874kaw9mpo.ffs@tglx> <e190b62e3f954cc1804a41149a842641@intel.com>
 <871r609m2i.ffs@tglx> <a883fe85b6b941b9bff44bc4b268bba1@intel.com>
 <87v93c82zn.ffs@tglx> <87sfyg8118.ffs@tglx>
 <cf9a841219904c048983fe2aee578761@intel.com> <87pmtj8x7z.ffs@tglx>
Date:   Wed, 08 Sep 2021 15:21:23 +0200
Message-ID: <878s078ap8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08 2021 at 07:14, Thomas Gleixner wrote:
> On Wed, Sep 08 2021 at 04:06, Tony Luck wrote:
>
>>>> Huch? That tree is based on 0bcfe68b876 and it just has those 20 patches
>>>> on top which should not at all interfere with your root filesystem
>>>> device. Let me verify.
>>>
>>> I lost connection to my test machines. Will continue tomorrow morning.
>>
>> To save you some time I ran a bisect. It says the wheels fall off the bus at
>> patch 13/2
>
> Yes, but that's not the real culprit. That's just the messenger.

This patch triggers it because it has the left over #PF check from
V1. But then I removed the MCE safe fixup from the *SAVE functions, got
distracted and tested a stale kernel... I'll send a V3 in a minute

Thanks,

        tglx
