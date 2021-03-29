Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B108834DCA7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 01:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbhC2Xxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 19:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhC2XxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 19:53:14 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907CCC061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 16:53:13 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4F8Tsy0BpZz9sWT;
        Tue, 30 Mar 2021 10:53:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1617061990;
        bh=atwz3EHv6rEgEaj2Uf4g75AKqWwldtzskq+PtppoRk0=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=fH44ZpLz1ZSBgqC6vUkM9wzfwFMAe9XwYlRNUX5WbJD4svjr2aGOe4jT1wj1yHvLw
         u1DXIeqBoTXoRU9J3zqpKU8THojbChbDoD1rFlTWJjRqjZufiiCDlckF8WRcXUKrW4
         C8k9qkCN3ShIx7atVor3cHCbJKca3KzxmExeNRTXGvOb1Y2hdZbIITAStVC7B3i6Cl
         0n+1N0mTkO4vufAGxuAVPB5fbicv18C80E/viXcbInpvrJKAxtBwo1UZUp+QvXUXtW
         tl04ncW2+dCpIhwmWJaNjpCIRmaRbGQIhx9sx96KOvrMFNJvHRfjkaavQPCPcJZsWw
         v3IwWIopMGEwg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        kasan-dev@googlegroups.com, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Subject: Re: [PATCH v11 0/6] KASAN for powerpc64 radix
In-Reply-To: <a5e1d7c5-3ebc-283c-2c9d-55d36d03cf48@csgroup.eu>
References: <20210319144058.772525-1-dja@axtens.net>
 <5a3b5952-b31f-42bf-eaf4-ea24444f8df6@csgroup.eu>
 <87ft0mbr6r.fsf@dja-thinkpad.axtens.net>
 <a5e1d7c5-3ebc-283c-2c9d-55d36d03cf48@csgroup.eu>
Date:   Tue, 30 Mar 2021 10:53:05 +1100
Message-ID: <87wntpfrfi.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 23/03/2021 =C3=A0 02:21, Daniel Axtens a =C3=A9crit=C2=A0:
>> Hi Christophe,
>>=20
>>> In the discussion we had long time ago,
>>> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20190806233827.=
16454-5-dja@axtens.net/#2321067
>>> , I challenged you on why it was not possible to implement things the s=
ame way as other
>>> architectures, in extenso with an early mapping.
>>>
>>> Your first answer was that too many things were done in real mode at st=
artup. After some discussion
>>> you said that finally there was not that much things at startup but the=
 issue was KVM.
>>>
>>> Now you say that instrumentation on KVM is fully disabled.
>>>
>>> So my question is, if KVM is not a problem anymore, why not go the stan=
dard way with an early shadow
>>> ? Then you could also support inline instrumentation.
>>=20
>> Fair enough, I've had some trouble both understanding the problem myself
>> and clearly articulating it. Let me try again.
>>=20
>> We need translations on to access the shadow area.
>>=20
>> We reach setup_64.c::early_setup() with translations off. At this point
>> we don't know what MMU we're running under, or our CPU features.
>
> What do you need to know ? Whether it is Hash or Radix, or
> more/different details ?

Yes, as well as some other details like SLB size, supported segment &
page sizes, possibly the CPU version for workarounds, various other
device tree things.

You also need to know if you're bare metal or in a guest, or on a PS3 ...

> IIUC, today we only support KASAN on Radix. Would it make sense to say th=
at a kernel built with=20
> KASAN can only run on processors having Radix capacility ? Then select CO=
NFIG_PPC_RADIX_MMU_DEFAULT=20
> when KASAN is set, and accept that the kernel crashes if Radix is not ava=
ilable ?

I would rather not. We already have some options like that
(EARLY_DEBUG), and they have caused people to waste time debugging
crashes over the years that turned out to just due to the wrong CONFIG
selected.

>> To determine our MMU and CPU features, early_setup() calls functions
>> (dt_cpu_ftrs_init, early_init_devtree) that call out to generic code
>> like of_scan_flat_dt. We need to do this before we turn on translations
>> because we can't set up the MMU until we know what MMU we have.
>>=20
>> So this puts us in a bind:
>>=20
>>   - We can't set up an early shadow until we have translations on, which
>>     requires that the MMU is set up.
>>=20
>>   - We can't set up an MMU until we call out to generic code for FDT
>>     parsing.
>>=20
>> So there will be calls to generic FDT parsing code that happen before the
>> early shadow is set up.
>
> I see some logic in kernel/prom_init.c for detecting MMU. Can we get the =
information from there in=20
> order to setup the MMU ?

You could find some of the information, but you'd need to stash it
somewhere (like the flat device tree :P) because you can't turn the MMU
on until we shutdown open firmware.

That also doesn't help you on bare metal where we don't use prom_init.

>> The setup code also prints a bunch of information about the platform
>> with printk() while translations are off, so it wouldn't even be enough
>> to disable instrumentation for bits of the generic DT code on ppc64.
>
> I'm sure the printk() stuff can be avoided or delayed without much proble=
ms, I guess the main=20
> problem is the DT code, isn't it ?

We spent many years making printk() work for early boot messages,
because it has the nice property of being persisted in dmesg.

But possibly we could come up with some workaround for that.

Disabling KASAN for the flat DT code seems like it wouldn't be a huge
loss, most (all?) of that code should only run at boot anyway.

But we also have code spread out in various files that would need to be
built without KASAN. See eg. everything called by of_scan_flat_dt(),
mmu_early_init_devtree(), pseries_probe_fw_features()
pkey_early_init_devtree() etc.

Because we can only disable KASAN per-file that would require quite a
bit of code movement and related churn.

> As far as I can see the code only use udbg_printf() before MMU is on, and=
 this could be simply=20
> skipped when KASAN is selected, I see no situation where you need early p=
rintk together with KASAN.

We definitely use printk() before the MMU is on.

>> Does that make sense? If you can figure out how to 'square the circle'
>> here I'm all ears.
>
> Yes it is a lot more clear now, thanks you. Gave a few ideas above,
> does it help ?

A little? :)

It's possible we could do slightly less of the current boot sequence
before turning the MMU on. But we would still need to scan the flat
device tree, so all that code would be implicated either way.

We could also rearrange the early boot code to put bits in separate
files so they can be built without KASAN, but like I said above that
would be a lot of churn.

I don't see a way to fix printk() though, other than not using it during
early boot. Maybe that's OK but it feels like a bit of a backward step.

There's also other issues, like if we WARN during early boot that causes
a program check and that runs all sorts of code, some of which would
have KASAN enabled.

So I don't see an easy path to enabling inline instrumentation. It's
obviously possible, but I don't think it's something we can get done in
any reasonable time frame.

cheers
