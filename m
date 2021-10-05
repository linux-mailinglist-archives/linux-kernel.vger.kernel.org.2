Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5503F421B49
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 02:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbhJEAqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 20:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhJEAqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 20:46:02 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E9DC061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 17:44:13 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id d207so877591qkg.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 17:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=16IcdSOxcBh6DEpjzkVUrqCTRutW8qnhNK7AMnDkfC0=;
        b=Y8ugXx6ss6S2pGsqfR3fopT9LGKpxSpRMnJtxadewE2hirekKxFfMruKFR0f6cQ3ZS
         p1qcoYfSz7UZ1NUOWC1VNjw4QZoFzSbiZehMk4Ru1yOwbb15TYf2XYN8x8KK/z+TSrp4
         aTvKH9XMoV6ijKQzVi0em9sUOzy4sNinDbfgvY3Cl1fpwBoMz/0vrcmyRzui5YjMyICV
         hKg/icggYvxuG2MwrzGC13Xo+eBAmqAq/TVEXp3IoEV3rZ7rQCNHjrLPpmceSqvQNuYN
         33Ue8haepxkjwg2x4rfWUU94Sd8j07CYkw2U6xQLDAVB2RREwdd5qcZVBWBNd7RFFAVF
         MsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=16IcdSOxcBh6DEpjzkVUrqCTRutW8qnhNK7AMnDkfC0=;
        b=j3rhigRemtFp1PlIUuxxxAQgcpVp4wDNmgfjkZziJZwISRKa2/NRtMQuN+QkDSbZcK
         bJNWwbgb0T1VQToxVPSeSG1juATmcMHYsmLCAlFBSeC9N4iv/caRwm1xq1J8L06/C5Bz
         vVPSLqsAEooFpbNLW3AeuoWMGEiGfwB6pAVCN4HP4z5ZqffwBeoc9ZJ/Sa7fSfz9/EUt
         l501Eg6zsaU3DO9MIos/vA29Q5csDOpRv7l/IjB1TJNsVoFLv+UanYBc8vrs0psHt5y9
         1m2DkQdz35LoU7HFrXMaKCtQAf5hucPeU54w7tSwg96LZZP6xaAmmWmZgHUqQF9TjWFr
         q++A==
X-Gm-Message-State: AOAM5339ldzZfUMyX15qTQmL8GOf5xhOLebR9BysHSIoZTD3DCp3oX4/
        3IE0AyL/KHv1jTvGzR9oBo/11Q==
X-Google-Smtp-Source: ABdhPJyhaCxDJl76BY6kZzfLTIzH3Oawas2fT3w/o7nBdAPs855xWVCUDMCvDU3l1jvDzqZAPl5cuQ==
X-Received: by 2002:a37:b686:: with SMTP id g128mr12834062qkf.68.1633394652077;
        Mon, 04 Oct 2021 17:44:12 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id a17sm9783333qtn.86.2021.10.04.17.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 17:44:11 -0700 (PDT)
Date:   Mon, 04 Oct 2021 17:44:11 -0700 (PDT)
X-Google-Original-Date: Mon, 04 Oct 2021 17:44:07 PDT (-0700)
Subject:     Re: [PATCH V2 1/2] riscv: Add RISC-V svpbmt extension
In-Reply-To: <CA+zEjCuaxtD8P1CwD25kfNFGFr+nZJt7k+=P8ck5NvLNNgTttw@mail.gmail.com>
CC:     philipp.tomsich@vrull.eu, mick@ics.forth.gr, atishp@atishpatra.org,
        anup@brainfault.org, guoren@kernel.org,
        Anup Patel <Anup.Patel@wdc.com>,
        Atish Patra <Atish.Patra@wdc.com>, christoph.muellner@vrull.eu,
        Christoph Hellwig <hch@lst.de>, liush@allwinnertech.com,
        wefu@redhat.com, lazyparser@gmail.com, drew@beagleboard.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        taiten.peng@canonical.com, aniket.ponkshe@canonical.com,
        heinrich.schuchardt@canonical.com, gordan.markus@canonical.com,
        guoren@linux.alibaba.com, Arnd Bergmann <arnd@arndb.de>,
        wens@csie.org, maxime@cerno.tech,
        Daniel Lustig <dlustig@nvidia.com>, gfavor@ventanamicro.com,
        andrea.mondelli@huawei.com, behrensj@mit.edu, xinhaoqu@huawei.com,
        huffman@cadence.com, allen.baum@esperantotech.com,
        jscheid@ventanamicro.com, rtrauben@gmail.com
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     alexandre.ghiti@canonical.com
Message-ID: <mhng-36a5dea1-9499-41d3-83f2-7a725919ab6e@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sep 2021 07:58:51 PDT (-0700), alexandre.ghiti@canonical.com wrote:
> On Tue, Sep 28, 2021 at 3:48 PM Philipp Tomsich
> <philipp.tomsich@vrull.eu> wrote:
>>
>> Nick,
>>
>> On Tue, 28 Sept 2021 at 15:19, Nick Kossifidis <mick@ics.forth.gr> wrote:
>> >
>> > On 9/28/21 7:26 AM, Atish Patra wrote:
>> > > On Mon, Sep 27, 2021 at 8:50 PM Anup Patel <anup@brainfault.org> wrote:
>> > >>
>> > >> On Tue, Sep 28, 2021 at 6:32 AM Nick Kossifidis <mick@ics.forth.gr> wrote:
>> > >>>
>> > >>> Στις 2021-09-27 23:13, Atish Patra έγραψε:
>> > >>>>> We need to decide whether we should support the upstream kernel for
>> > >>>>> D1. Few things to consider.
>> > >>>>> – Can it be considered as an errata ?
>> > >>>
>> > >>> It's one thing to follow the spec and have an error in the
>> > >>> implementation, and another to not follow the spec.
>> > >>>
>> > >>>>> – Does it set a bad precedent and open can of worms in future ?
>> > >>>
>> > >>> IMHO yes, I'm thinking of Kendryte 210 devs for example coming up and
>> > >>> asking for MMU support, they 've also shipped many chips already. I can
>> > >>> also imagine other vendors in the future coming up with implementations
>> > >>> that violate the spec in which case handling the standard stuff will
>> > >>> become messy and complex, and hurt performance/security. We'll end up
>> > >>> filling the code with exceptions and tweaks all over the place. We need
>> > >>> to be strict about what is "riscv" and what's "draft riscv" or "riscv
>> > >>> inspired", and what we are willing to support upstream. I can understand
>> > >>> supporting vendor extensions upstream but they need to fit within the
>> > >>> standard spec, we can't have for example extensions that use encoding
>> > >>> space/csrs/fields etc reserved for standard use, they may only use
>> > >>> what's reserved for custom/vendor use. At least let's agree on that.
>> > >>
>> > >> Totally agree with Nick here. It's a slippery slope.
>> > >>
>> > >> Including D1 PTE bits (or Kendryte K210 MMU) part of the Linux RISC-V
>> > >> means future hardware which intentionally violates specs will also have to
>> > >> be merged and the RISC-V patch acceptance policy will have no significance.
>> > >>
>> > >>>
>> > >>>>> – Can we just ignore D1 given the mass volume ?
>> > >>>>>
>> > >>>
>> > >>> IMHO no, we need to find a way to support it upstream but I believe
>> > >>> there is another question to answer:
>> > >>>
>> > >>> Do we also guarantee "one image to rule them all" approach, required by
>> > >>> binary distros, for implementations that violate the spec ? Are we ok
>> > >>> for example to support Allwinner D1 upstream but require a custom
>> > >>> configuration/build instead of supporting it with the "generic" image ?
>> > >>> In one case we need to handle the violation at runtime and introduce
>> > >>> overhead for everyone (like looking up __riscv_svpbmt every time we set
>> > >>> a PTE in this case), in the other it's an #ifdef.
>> > >>
>> > >> At least, we should not have hardware violating specs as part of the
>> > >> unified kernel image instead have these intentional deviations/violations
>> > >> under separate kconfig which will not be enabled by default. This means
>> > >> vendors (of such hardware) and distros will have to explicitly enable
>> > >> support for such violations/deviations.
>> > >>
>> > >
>> > > If we merge the code and are not enabled by default, it would be a
>> > > maintenance nightmare in future.
>> > > These part of the kernel will not be regularly tested but we have to
>> > > carry the changes for a long time.
>> >
>> > I don't see a difference between having these features as part of the
>> > generic image vs having them as custom configs/builds. The code will get
>> > executed only on boards that support the custom/non-compliant
>> > implementation anyway. To the contrary we'll have more code to test if
>> > we are doing things at runtime vs at compile time.
>> >
>> > > Similar changes will only grow over time causing a lot of custom
>> > > configs that are not enabled by default.
>> > >
>> >
>> > We'll have a lot of custom configs that will only get used on boards
>> > that use them, vs runtime code that will run for no reason on every
>> > board and choose the default/standard-compliant implementation most of
>> > the time. In the end the code will only get tested on specific hardware
>> > anyway.
>> >
>> > > IMHO, if we want to support this board in upstream, we should just
>> > > clearly state that it is one time special exception
>> > > for this board only because of the following reasons
>> > >
>> > > 1. The board design predates the patch acceptance policy.
>> > > 2. We don't have enough affordable Linux compatible platforms today.
>> > > 3. Allowing running an upstream kernel on D1 helps the RISC-V software
>> > > ecosystem to grow.
>> > >
>> >
>> > The same can be said for Kendryte as well, are we willing to also
>> > support their MMU implementation on the generic image if a patch comes
>> > in? To be clear I'm not saying we shouldn't support D1 or Kendryte
>> > upstream, I'm just saying that we shouldn't sacrifice the complexity and
>> > performance of the code path for standard-compliant implementations, to
>> > support non-compliant implementations, and instead support non-compliant
>> > implementations with custom kernel builds using compile time options. It
>>
>> For priming the pump on the software effort, having a solution that is enabled
>> on distro-builds is clearly preferable — that leads to the solution that Palmer
>> had outlined at LPC, which is to have a KCONFIG option that enables the
>> alternate code paths and can be turned off for embedded use-cases.
>>
>> > still counts as upstream support, they won't have to maintain their own
>> > forks. It'll also allow custom implementations to have more flexibility
>> > on what they can do since they will be able to use completely
>> > different/custom code paths, instead of trying to fit in the standard
>> > code path (which will become a mess over time). I think this approach is
>> > much more flexible and will allow more customizations to be supported
>> > upstream in the future.
>>
>> The important detail will be the ground rules: changes have to be sufficiently
>> quarantined that (a) they can be turned off, (b) can be reverted easily (in case
>> that vendors fail to perform their maintenance obligations),
>
> Can we really remove support once it is in and widely used?

We'll follow the standard deprecation policies for anything I have any 
say over, which in the kernel I've always heard described as 
forever-ish.  Since this is pretty coupled to a specific chip one could 
imagine deprecating it when we can convince ourselves those chips have 
all had their smoke let out, but that's a decade timescale sort of 
thing.

>> and (c) they don't
>> affect the performance and complexity of the standard code paths.
>>
>> Cheers,
>> Philipp.
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
