Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7EAF44B032
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 16:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238808AbhKIPWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 10:22:14 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:33126
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236189AbhKIPWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 10:22:13 -0500
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0D31140772
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 15:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1636471166;
        bh=y9pgiCV7zyEmy4K4qEsg0V4Uk9a686jGv7LQXoBRsjk=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=QR4RUxwUW3I7lAHFHeJSzZJFxwsZXT6xJYSCwnIasIFffblxGSYhYlVjr/qKpGfzT
         Zo2tKW/srbUZ6MbOOWYN7Vi++3BCxQG2aYjZ2oRUgcswzRcxk0kg1MFKU7xptYUxhD
         +mewmIqDPrNKK3f2WOiu7SEvLMyY4D5bBhbIsDMVvktus7bisQyHIZbRJ1RpMoL43W
         RMHyuD00fe0lcVBXy/xXhN3E9LXZel2Q7NTVqzjRx154F6w4UQp5jbwTNkfNmduZXh
         uR20q2Boj4BYRe6ziRZuuY9Uu71HO/FevKVbiFkTsu3cdwt44LLCxUNzYxj4zsEUwp
         +/9+QHRxVjBnQ==
Received: by mail-wr1-f70.google.com with SMTP id v18-20020a5d5912000000b001815910d2c0so4879822wrd.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 07:19:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=y9pgiCV7zyEmy4K4qEsg0V4Uk9a686jGv7LQXoBRsjk=;
        b=BbN7gz7xHww5t5pWJ7enMCWL0BGVetUWYNPEnF3rGhHsEK2MOOEI9GmF9M7QgpYlJV
         dsbhad27G+Wza2VNtDC3+PifPcoVHKSP7jCZWySOr1zHT/6kKYbtTS9gYlMTu4LKSm9V
         tMkg5x4TJ/4gne7K1U2+zPc2Zq0W/UaKiZVePlWagXPwuFQHEMJmdVRt0fkirxS3x6qF
         VQpLZg2+siFLz9gB/WHOI6grYpVPnD5UCnldvEEJ5q8YUljV2K/xhi39wDV7jGxtYyqK
         xABwos16UdcryjVpWPqjEzeQdrPVbvTpCcu2uKj49d8h2cf0SiD2BFKz9KWhcLImMQsZ
         x8mg==
X-Gm-Message-State: AOAM530Ae7qBqM8zwnh6xYPe9iiNSxj3cnYjDOx3vUaGlsNewj0wBGRF
        9/skl1K0YLDmK/gMkvBCsyJQbqI40C8+ci1PUZ41KTVJClHy1rcjDVhVyugxW44dAiHpX07HhG8
        rjc0yg5umakMEVV+kQKcFBfdIszS2PgtU4QXE4B/Egg==
X-Received: by 2002:a5d:4a85:: with SMTP id o5mr10656251wrq.109.1636471164317;
        Tue, 09 Nov 2021 07:19:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzCNJeD7i4a5vx04KG8bWS/I2OrJ+x2Tsf+9WrdJJqRb81MbzZ2SSzENTJZ7Z8eoKS6RtsSOw==
X-Received: by 2002:a5d:4a85:: with SMTP id o5mr10656188wrq.109.1636471163864;
        Tue, 09 Nov 2021 07:19:23 -0800 (PST)
Received: from [192.168.123.55] (ip-88-152-144-157.hsi03.unitymediagroup.de. [88.152.144.157])
        by smtp.gmail.com with ESMTPSA id d15sm19453600wri.50.2021.11.09.07.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 07:19:23 -0800 (PST)
Message-ID: <b3cc6176-60b0-119c-ba1d-1fdc015bd081@canonical.com>
Date:   Tue, 9 Nov 2021 16:19:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v7 1/1] RISC-V: Use SBI SRST extension when available
Content-Language: en-US
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <Anup.Patel@wdc.com>
Cc:     Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Philipp Tomsich <ptomsich@ventanamicro.com>,
        Greg Favor <gfavor@ventanamicro.com>,
        Kumar Sankaran <ksankaran@ventanamicro.com>,
        Mark Himelstein <markhimelstein@riscv.org>,
        Atish Patra <atishp@atishpatra.org>
References: <mhng-6c25dda6-4c85-447c-ad9c-7641f2858b10@palmerdabbelt-glaptop>
 <mhng-40d64bc7-5a95-4a16-af45-1d7fd7c6167e@palmerdabbelt-glaptop>
 <CAOnJCUJpLSWJ1VsJuUwfrG8vn0+hCkg2RgdOhNLTEq8C7Mo88w@mail.gmail.com>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAOnJCUJpLSWJ1VsJuUwfrG8vn0+hCkg2RgdOhNLTEq8C7Mo88w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/21 08:10, Atish Patra wrote:
> On Wed, Jul 28, 2021 at 9:30 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> On Sun, 11 Jul 2021 11:59:33 PDT (-0700), Palmer Dabbelt wrote:
>>> On Fri, 09 Jul 2021 22:01:02 PDT (-0700), Anup Patel wrote:
>>>>
>>>>
>>>> ﻿On 08/07/21, 9:22 AM, "Anup Patel" <anup@brainfault.org> wrote:
>>>>
>>>>      On Wed, Jul 7, 2021 at 1:57 AM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>>>>      >
>>>>      > On Mon, 21 Jun 2021 21:46:46 PDT (-0700), anup@brainfault.org wrote:
>>>>      > > Hi Palmer,
>>>>      > >
>>>>      > > On Wed, Jun 9, 2021 at 5:43 PM Anup Patel <anup.patel@wdc.com> wrote:
>>>>      > >>
>>>>      > >> The SBI SRST extension provides a standard way to poweroff and
>>>>      > >> reboot the system irrespective to whether Linux RISC-V S-mode
>>>>      > >> is running natively (HS-mode) or inside Guest/VM (VS-mode).
>>>>      > >>
>>>>      > >> The SBI SRST extension is available in the SBI v0.3 specification.
>>>>      > >> (Refer, https://github.com/riscv/riscv-sbi-doc/releases/tag/v0.3.0-rc1)
>>>>      > >
>>>>      > > Can you please consider this patch for Linux-5.14-rc1 ?
>>>>      > >
>>>>      > > The SBI v0.3 spec is already frozen and this patch has been
>>>>      > > floating on LKML for quite a few months now.
>>>>      >
>>>>      > I didn't realize that SBI-0.3 had been frozed.  That link is to a RC,
>>>>      > the cooresponding v0.3.0 tag isn't in that repo.  Can you give me a
>>>>      > pointer to the frozen spec?
>>>>
>>>>      Here's the link to SBI v0.3.0 tag:
>>>>      https://github.com/riscv/riscv-sbi-doc/releases/tag/v0.3.0
>>>>
>>>>      We treat RC tags as frozen in SBI spec because no functional
>>>>      changes are done in SBI spec after it is tagged as RC. We only
>>>>      do typo fixes and clarifications on SBI spec RC release.
>>>
>>> Treating the 0.3.0-rc1 as frozen as soon as it's released is a
>>> terrifying policy: some of the fixes I sent in after I saw rc1 released
>>> change the actual meaning of the text, even if they were meant to change
>>> them to what I thought the intended meaning was supposed to be.  That
>>> means the actual text of 0.3.0-rc1 and 0.3.0 conflict with each other.
>>> Given that frozen comes with a guarntee of backwards compatibility, does
>>> that mean that the behavior allowed by 0.3.0-rc1 is compliant with the
>>> SBI, even if it was likely just allowed by a wording mistake?
>>>
>>> If you're going to freeze things at rc1 then you really need to be quite
>>> explicit about that, as generally the point of RCs is to elicit
>>> review/testing.  Looks like I was the only person to have provided any
>>> review, so I guess I was the only one who assumed "We don't expect any
>>> significant functional changes. We will wait for any further feedback
>>> and release the official v0.3 in a month or so." actually meant "this is
>>> frozen".
>>>
>>>> Can you take this patch for Linux-5.14 ??
>>>
>>> No, sorry, it's way too late for that.  Please be specific about when
>>> you freeze specifications in the future, so we can all stay on the same
>>> page.
>>
>> I went and talked to Krste, and he says that there's a whole process for
>> freezing extensions that this hasn't gone through.  They don't have
>> anything written down that I can point to, but can you guys please just
>> get on the same page about this?  It seems like every time I talk to
> 
> Absolutely. The freezing extensions process is documented right now[1]
> but that is only meant
> for ISA/hardware/platform specifications. There is no process defined
> for a SBI specification which is purely
> a software specification because SBI specification release
> processes(v0.1 and v0.2) predate these documented processes.
> The SBI specification is owned by the Platform HSC which falls under
> the purview of software HC.
> You can see a detailed chart of the RVI organization at [2]. All the
> aspects of SBI specification are discussed
> in platform meetings[3] and frozen only after public review[4] and
> approval from the platform working group
> and the software HC. The official SBI specification(v0.3) will also be
> available along with all other RISC-V specifications
> once they figure out how to structure non-ISA specifications.
> 
> I have cc'd Kumar (chair of the Platform HSC) and Philip (chair of the
> software HC) in case they want to add anything.
> I was not aware of the fact that Krste/Andrew are not aware of the
> progress of the SBI specification.
> I will raise this topic during the next meeting and make sure they are
> in the loop as well.
> 
>> someone from the RISC-V foundation I get a conflicting description of
>> what's going on, and I'm entirely out of patience when it comes to
>> getting blamed for all the chaos over there.
>>
> I agree the RVI process has not been very clear in the past. However,
> that has changed a lot in recent times thanks to Mark and
> other working group chairs. I don't think anybody is blaming you for
> the delay in ratification of the RVI specifications.
> There is a clear path for all the specifications to be ratified e.g.
> the AIA and H extensions are planned to be frozen by the end of this
> year.
> Let me know if you want to see the timeline of each specification and
> I can point you to the correct sheet.
> 
> [1] https://docs.google.com/presentation/d/1nQ5uFb39KA6gvUi5SReWfIQSiRN7hp6z7ZPfctE4mKk/edit#slide=id.ga0a994c3c8_0_6
> [2] https://docs.google.com/presentation/d/1eEVuu6lRZd9iiDnZQSZME7Q7svtTG3pGIKHPmZ79B8E/edit#slide=id.ga275a504df_0_9
> [3] https://github.com/riscv/riscv-platform-specs/wiki
> [4] https://lists.riscv.org/g/tech-unixplatformspec/message/1042

https://github.com/riscv-non-isa/riscv-sbi-doc/releases/tag/v0.3.1-rc1
has:

"This tag the release candidate of version 0.3.1 of the RISC-V SBI 
specification. It doesn't have any significant changes other than typos.
A new release is created to adapt the ratification process for non-ISA 
specifications defined by RVI recently."

Has this patch to wait until release 0.3.1 of the SBI specification is 
ratified?
What is the timeline?

Could you, please, provide a link the the non-ISA ratification process 
description.

Best regards

Heinrich
