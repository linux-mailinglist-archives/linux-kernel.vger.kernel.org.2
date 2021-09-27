Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98BA441A38D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 01:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238012AbhI0XHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 19:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhI0XHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 19:07:37 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F89C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 16:05:59 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id z5so27595025ybj.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 16:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=te3ufbbhdLYzLpKReFSUnhdYPCC2UOLB8sm0ImQvwSg=;
        b=tNVc7cvyLru14b2J2DjRw5M7+f0Vzr9bnjoC8qr9Yj/j57ncp7ve6/9lPPOqy7Go6u
         hJd0SUmECBMfaKUTi51ak+Ha0jxqIFJx59rUJpFe0QEpvJKAwAnc5gbjxmcXfS93crs0
         jg0ho6LXbTNK6AaR4dp3FkJfB5XtEKDN7ObrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=te3ufbbhdLYzLpKReFSUnhdYPCC2UOLB8sm0ImQvwSg=;
        b=HwHWmAwc0KzLnmDmPCcAd/t2uJFdXL6WI7rH3PAvfh7Bf4G2GN68SUGRJaa310RH9U
         WrzkKSxOEwFgSBMngV3z7FTGrnyqPLRAaUR25CBh5sIxOfY8F/+NBVzRJTnykq3HxQWj
         XoNYegoePoaSGYjzm/AR2DcrSl6m+gL/HtNJcDS9AQOKiTSoLJwc17P5axq3ARxIYbHu
         nsa7JwthEKe/S7R07WaF3BrWy6kawGepI6F6DV1osjFyx6N/Htot7Q3NzJxkapEuS+gU
         RzgIPKdLUYdDG7/euOF+FCjmZ3MAmKqTH7JpquAx0vMwEQ6jTyw/3FBPKCXaLLQSFO8e
         OZEA==
X-Gm-Message-State: AOAM531ktU1+85eDzfrrX9TI8Bboo01+o7B1sd9mXw4Bxo7kYaLzamvs
        8ubV8Rpr0jMt6/L8+If5+njZ8r9NpPiK4qaXaWbL
X-Google-Smtp-Source: ABdhPJznvZBPCpgBv8Jgcg/OQuqyDWj+Q8Gey0hZLrv3MRRacKbPCtHWdja625jSae5btgDes2J7CcmXcNdir+qyoQM=
X-Received: by 2002:a25:7ec4:: with SMTP id z187mr2751056ybc.35.1632783958580;
 Mon, 27 Sep 2021 16:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210923172107.1117604-1-guoren@kernel.org> <CAOnJCUJWnDB+uRxDh=YSbGW4bf5RQvke03iCTYMYHPsw3cwnHQ@mail.gmail.com>
 <CAOnJCULrE595ex3gBTnu4GnPazO4mg8Tkrtbv6j8iLWe+sKJSA@mail.gmail.com> <CA+Qh7T=kud8AM-6JjuWNwJY0r_gkmnP6SmzVXqeE2VYxViLUoQ@mail.gmail.com>
In-Reply-To: <CA+Qh7T=kud8AM-6JjuWNwJY0r_gkmnP6SmzVXqeE2VYxViLUoQ@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 27 Sep 2021 16:05:47 -0700
Message-ID: <CAOnJCUJp9UatyReA8-Jq=WGY_QgV4CbL4Qs2F9rXJzOHsXeW5Q@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] riscv: Add RISC-V svpbmt extension
To:     Greg Favor <gfavor@ventanamicro.com>
Cc:     Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Guo Ren <guoren@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
        Christoph Hellwig <hch@lst.de>,
        liush <liush@allwinnertech.com>, wefu@redhat.com,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        taiten.peng@canonical.com, aniket.ponkshe@canonical.com,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        gordan.markus@canonical.com, Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Lustig <dlustig@nvidia.com>,
        Andrea Mondelli <andrea.mondelli@huawei.com>,
        Jonathan Behrens <behrensj@mit.edu>,
        Xinhaoqu <xinhaoqu@huawei.com>,
        Bill Huffman <huffman@cadence.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 1:53 PM Greg Favor <gfavor@ventanamicro.com> wrote:
>
> With the big caveat that I haven't been in the middle of this discussion,=
 it seems like Allwinner D1's changes represent a custom (and nonconforming=
) extension.

As per the v1.12 privilege specification, bit 63 is reserved for
Svnapot extension while bit 60=E2=80=9354 are reserved for future standard
use.
D1's implementation uses both 60 and 63 bit for their custom "PBMT"
extension in addition to bit 61 & 62 [1].

> Isn't this just a matter of the patch needing to be treated as for a RISC=
-V custom extension per the recently clarified policy for handling upstream=
ing/etc. of custom extensions?  (Philipp can > speak to this clarified poli=
cy.)  Or what am I missing?

Linux kernel upstream policy is yet to adopt that clarification as it
was recently discussed at RVI meetings. Is there a written definition
of non-conforming/custom/incompatible ?
Moreover, as per the platform specification[2],

A non-conforming extension that conflicts with a supported standard
extensions must satisfy at least one of the following:
  --- It must be disabled by default.
  --- The supported standard extension must be declared as unsupported
in all feature discovery structures used by software.
      This option is allowed only if the standard extension is not required=
.

In this case, the custom non-conforming implementation can not be
disabled or marked unsupported as it is critical for all the necessary
I/O devices (usb, mmc, ethernet).
Without this custom implementation support in upstream, we can not
really use the mainline kernel for Allwinner D1.

[1] https://linuxplumbersconf.org/event/11/contributions/1100/attachments/8=
41/1607/What%E2%80%99s%20the%20problem%20with%20D1%20Linux%20upstream-.pdf
[2] https://github.com/riscv/riscv-platform-specs/blob/main/riscv-platform-=
spec.adoc#2112-general

>
> Greg
>
> On Mon, Sep 27, 2021 at 1:14 PM Atish Patra <atishp@atishpatra.org> wrote=
:
>>
>> > @Palmer Dabbelt @Guo Ren
>> >
>> > Can we first decide what to do with D1's upstreaming plan ? I had a sl=
ide[1] to discuss that during RISC-V BoF.
>> > But we ran out of time. Let's continue the discussion here.
>> >
>> > We all agree that Allwinner D1 has incompatible changes with privilege=
 specification because it uses two reserved bits even after Svpbmt is merge=
d.
>> > Let's not argue on the reasoning behind this change. The silicon is al=
ready out and the specification just got frozen.
>> > Unfortunately, we don't have a time stone to change the past ;).
>> >
>> > We need to decide whether we should support the upstream kernel for D1=
. Few things to consider.
>> > =E2=80=93 Can it be considered as an errata ?
>> > =E2=80=93 Does it set a bad precedent and open can of worms in future =
?
>> > =E2=80=93 Can we just ignore D1 given the mass volume ?
>> >
>> > One solution I can think of is that we allow this as an exception to t=
he patch acceptance policy.
>> > We need to explicitly specify this board as an exception because the p=
olicy was not in place during the design phase of the hardware.
>> > At least, it protects us from accepting the incompatible changes in th=
e future. Any other ideas ?
>> >
>> > [1] https://linuxplumbersconf.org/event/11/contributions/1128/attachme=
nts/846/1757/RISC-V%20Bof.pdf



--=20
Regards,
Atish
