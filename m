Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC5741AFDC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 15:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240893AbhI1NU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 09:20:58 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:52483 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240579AbhI1NU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 09:20:56 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 18SDJFBi099516
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 16:19:16 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1632835150; x=1635427150;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vgtOTbyRSvtHqgOJzpEHttghZ3hnA3y56xOmeIfocLA=;
        b=nVEsxJW9sXEw2+R4lQgiO6A6JscUaFCChyx8zTgXqjTTW1EQ7+ryCBm+VCeApJoG
        8rExfD+WJ+jwA4ZfEbophui0v8nmlXHlAWv8MYv81LYevdIGvzB2U1g8M0MlCqQT
        cW74vywpFvibLDPnkpmfuReQv+L4uUskiybS3FjPyShDax3QQKIszmGoulMubr9V
        j6KDWmOlXtIo4kAj+5La8iD6x0ROQOG1eHyPSvUo20Y81cBJ2b4pA4ysuoOA9Ujb
        gGhQ3RRTNtACj066TG+gIvaloCkHJmuXreNHmICAft/i0RHFMkOPE3qfXpcHNL9W
        w6hmRCTehbY42K8iGigkLA==;
X-AuditID: 8b5b014d-ba8f670000005d46-cb-6153164eb68b
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id AC.84.23878.E4613516; Tue, 28 Sep 2021 16:19:10 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user: mick at ics.forth.gr
Subject: Re: [PATCH V2 1/2] riscv: Add RISC-V svpbmt extension
To:     Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>
Cc:     Guo Ren <guoren@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        =?UTF-8?Q?Christoph_M=c3=bcllner?= <christoph.muellner@vrull.eu>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Christoph Hellwig <hch@lst.de>,
        liush <liush@allwinnertech.com>, wefu@redhat.com,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        taiten.peng@canonical.com,
        Aniket Ponkshe <aniket.ponkshe@canonical.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Gordan Markus <gordan.markus@canonical.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Lustig <dlustig@nvidia.com>,
        Greg Favor <gfavor@ventanamicro.com>,
        Andrea Mondelli <andrea.mondelli@huawei.com>,
        Jonathan Behrens <behrensj@mit.edu>,
        Xinhaoqu <xinhaoqu@huawei.com>,
        Bill Huffman <huffman@cadence.com>,
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>
References: <20210923172107.1117604-1-guoren@kernel.org>
 <CAOnJCUJWnDB+uRxDh=YSbGW4bf5RQvke03iCTYMYHPsw3cwnHQ@mail.gmail.com>
 <CAOnJCULrE595ex3gBTnu4GnPazO4mg8Tkrtbv6j8iLWe+sKJSA@mail.gmail.com>
 <0790abcfa1174e0e9b5e7b185f87ced9@mailhost.ics.forth.gr>
 <CAAhSdy2-y4xpM9PCrS0vgCN9ngFiBygeDOWcbgsX6Myb4XjDQg@mail.gmail.com>
 <CAOnJCULg36kNiDV6ymTSRff8yYZvFKpxm5uh=cAicQT44OcLYw@mail.gmail.com>
From:   Nick Kossifidis <mick@ics.forth.gr>
Message-ID: <ad40c335-ee8f-9ff3-4c34-f8fa5ef49e8b@ics.forth.gr>
Date:   Tue, 28 Sep 2021 16:19:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAOnJCULg36kNiDV6ymTSRff8yYZvFKpxm5uh=cAicQT44OcLYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: el-GR
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA03Sf1DTdRzH8ft8v59994XY9YVQPolFoP0gbZZ51xvlrLsKPmVoZkcxucPv
        5WAUiX0HRrMSdRkCKpIMGRwaJ+CADOHmHG5kC6akOIIL8RRTJBWI5QJu2mZ2g7rjv+fd6/34
        782zYQWyeXzmphy1tEnMiuGCcdH68gXPrZ67TnzeVrUEhh1fc2A47ZDDVyWnMAzf2c+B/o5b
        BvdLnXKoOerFUHAhAY5YI8E2apNDz85iBFeP1snh1L4qDBaXl4Pb9u0Yzgy1YTA1djLQs/2S
        HPoaDzFw62cnB72T/Rj62qo4ODGh58B0zMnCwbv/IBjpK2bBfPwYgiLTVuhqPo2gqbYMgf6H
        AxjuOVwMfDtWLX8lmo7uuslQ39+liPYXHMfU7atDtMx3HtOm3WMMNebv4eiVCy6ONg81yugf
        IyOYPnCYMLUaB+X0cEsu1XeMy2hLw26OWq/Hvf2oKjh+ozorc4taWrJyQ7DG6f9489gzed9c
        KUP5yPdEIQriibCM3LT9hgpRMB8mdCIyNTqEZoY40vrXCA70I8JKUl9tZgoRz4cLb5ADrvTA
        PSs0PUQMVydlM3gfSyyD9mnACbHkUO+POAAUwsukqPylQGLhSVI9kRq4mCOkkB1nzVygFUIo
        6aoYnpZBwlrS294w3azwNPFX97IzHUE6XL7/OorsNFeyJUgwzuLGWcQ4ixhnkcMINyBB3PKi
        MvMDrTI9W8rRKDOkFjT9LCjpJLrcOq50IIZHDkR4NiZcEX3vHTFMsVH8TKeWstOk3Cy11oEi
        eRwToVAoS9LChAwxR/2RWr1ZLf2/MnzQvHxmkadn6ZQqh7d1TtrOlvcnRywq97yWseBTYsNL
        Q9/b2xVfT+nQwhs9NbH3/U5d8VvWN7806iy6gbRUvHzrq9dCxkKSE07y55LH83bN3+Y94olm
        K+zEsGOvrJ79HGW/n/TY+bhPuv2FcHF+22WPY3G3Vm/yX5rrKf4zXKlKda5I132vEu7WJNU+
        FWpY/mHKbfSue/3jeaFR8RPuDqXGnV4p3bKs6161J/d1+0G3qs5VscysqcQPa7xR4sJfV8UP
        29tXtP8khU9qHlSs+aU5rvv3a9qLiQMi94Wh3ptYutZXO0Bat8UmWK7LpmoTUwZbFfLv9t84
        l3gmNpLLZqxBIYoYrNWILzzLSlrxX6AOS/ubAwAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/21 7:26 AM, Atish Patra wrote:
> On Mon, Sep 27, 2021 at 8:50 PM Anup Patel <anup@brainfault.org> wrote:
>>
>> On Tue, Sep 28, 2021 at 6:32 AM Nick Kossifidis <mick@ics.forth.gr> wrote:
>>>
>>> Στις 2021-09-27 23:13, Atish Patra έγραψε:
>>>>> We need to decide whether we should support the upstream kernel for
>>>>> D1. Few things to consider.
>>>>> – Can it be considered as an errata ?
>>>
>>> It's one thing to follow the spec and have an error in the
>>> implementation, and another to not follow the spec.
>>>
>>>>> – Does it set a bad precedent and open can of worms in future ?
>>>
>>> IMHO yes, I'm thinking of Kendryte 210 devs for example coming up and
>>> asking for MMU support, they 've also shipped many chips already. I can
>>> also imagine other vendors in the future coming up with implementations
>>> that violate the spec in which case handling the standard stuff will
>>> become messy and complex, and hurt performance/security. We'll end up
>>> filling the code with exceptions and tweaks all over the place. We need
>>> to be strict about what is "riscv" and what's "draft riscv" or "riscv
>>> inspired", and what we are willing to support upstream. I can understand
>>> supporting vendor extensions upstream but they need to fit within the
>>> standard spec, we can't have for example extensions that use encoding
>>> space/csrs/fields etc reserved for standard use, they may only use
>>> what's reserved for custom/vendor use. At least let's agree on that.
>>
>> Totally agree with Nick here. It's a slippery slope.
>>
>> Including D1 PTE bits (or Kendryte K210 MMU) part of the Linux RISC-V
>> means future hardware which intentionally violates specs will also have to
>> be merged and the RISC-V patch acceptance policy will have no significance.
>>
>>>
>>>>> – Can we just ignore D1 given the mass volume ?
>>>>>
>>>
>>> IMHO no, we need to find a way to support it upstream but I believe
>>> there is another question to answer:
>>>
>>> Do we also guarantee "one image to rule them all" approach, required by
>>> binary distros, for implementations that violate the spec ? Are we ok
>>> for example to support Allwinner D1 upstream but require a custom
>>> configuration/build instead of supporting it with the "generic" image ?
>>> In one case we need to handle the violation at runtime and introduce
>>> overhead for everyone (like looking up __riscv_svpbmt every time we set
>>> a PTE in this case), in the other it's an #ifdef.
>>
>> At least, we should not have hardware violating specs as part of the
>> unified kernel image instead have these intentional deviations/violations
>> under separate kconfig which will not be enabled by default. This means
>> vendors (of such hardware) and distros will have to explicitly enable
>> support for such violations/deviations.
>>
> 
> If we merge the code and are not enabled by default, it would be a
> maintenance nightmare in future.
> These part of the kernel will not be regularly tested but we have to
> carry the changes for a long time.

I don't see a difference between having these features as part of the
generic image vs having them as custom configs/builds. The code will get
executed only on boards that support the custom/non-compliant
implementation anyway. To the contrary we'll have more code to test if
we are doing things at runtime vs at compile time.

> Similar changes will only grow over time causing a lot of custom
> configs that are not enabled by default.
> 

We'll have a lot of custom configs that will only get used on boards
that use them, vs runtime code that will run for no reason on every
board and choose the default/standard-compliant implementation most of
the time. In the end the code will only get tested on specific hardware
anyway.

> IMHO, if we want to support this board in upstream, we should just
> clearly state that it is one time special exception
> for this board only because of the following reasons
> 
> 1. The board design predates the patch acceptance policy.
> 2. We don't have enough affordable Linux compatible platforms today.
> 3. Allowing running an upstream kernel on D1 helps the RISC-V software
> ecosystem to grow.
> 

The same can be said for Kendryte as well, are we willing to also
support their MMU implementation on the generic image if a patch comes
in ? To be clear I'm not saying we shouldn't support D1 or Kendryte
upstream, I'm just saying that we shouldn't sacrifice the compleity and
performance of the code path for standard-compliant implementations, to
support non-compliant implementations, and instead support non-compliant
implementations with custom kernel builds using compile time options. It
still counts as upstream support, they won't have to maintain their own
forks. It'll also allow custom implementations to have more flexibility
on what they can do since they will be able to use completely
different/custom code paths, instead of trying to fit in the standard
code path (which will become a mess over time). I think this approach is
much more flexible and will allow more customizations to be supported
upstream in the future.
