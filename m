Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375F834DC70
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 01:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhC2X1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 19:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhC2X0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 19:26:43 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5424DC061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 16:26:43 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so8483035pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 16:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=waSXWCTE99vHc7CuELi75wqDgOVkGsht2MlSvB7uCsw=;
        b=DuUgS+zBKM+nbZVWPBjSK6kgrfP+dSo5CaVxqCbvBdZuKCm7rjYfx7CdZabeqGjkfs
         N/vkVulfy6TV4mCs7kr6AghHR/Ij4LerOXXZt2C2i7gidfWabkJwo9+9nzJnBpgpOfHM
         Fup/QUvY25HVvioGMu9nzhw9EA/xek/JLyBQ+qQoZWuhfku4EQy6qDXW0Frvyn09rDcG
         HElWcBiIlRubYPJAbr6tLigktZCEdpcQrx1Lbw8isX/a+caMRrk27dbq6g9lxhWcpF3j
         6ZnQE+nWgP/ClS/RYOSBAXs4PuEyF8MzTme3WtE52/JFjhBdRvfiBOfecHvLvrgzGMw3
         7v1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=waSXWCTE99vHc7CuELi75wqDgOVkGsht2MlSvB7uCsw=;
        b=EH7QbgSbCoh1nDSo1UrCseG0x/bQfh8aDhYX50t2AYlyJea7V0AFH0wHNLK13PGXLM
         DTICoBOlf9L+gFTBy/VfG4b7iqRlKplgzHJ0BK7M8SJ7lxRdR62+vV7/rd7oMWTD2aSd
         C+C9OF9KrvNehX7+JhJm5hUv19epDym4QukYoYCn/Z1yzkI8dqThiyJiqmITChsdyj7+
         bttABTfLcj0S7jse7K0tU/a/WY95U4UTLGqJF73DIOLYC1vW2b50R35lJms++7h1bzV3
         32Li/nSvNTYEGwiOUX8xD5A49QK367uLoDhxskvYfr+0jyL1Sc5rBqh9M06oMntG18V0
         +lnw==
X-Gm-Message-State: AOAM530tFCVBDtAt9kowVNoK0YMpMhZB5HGavkLbS63GVnBhOcf4FRIz
        9ZbY0s953PgPnBx/3WzSxrfuGA==
X-Google-Smtp-Source: ABdhPJzpEjhA4161ybufAzfHgnh/4NyykpXzaxceoi8ELiUKaqV8u0Glmo011B8oX/jdmAp5hrcc4w==
X-Received: by 2002:a17:902:f68c:b029:e5:ca30:8657 with SMTP id l12-20020a170902f68cb02900e5ca308657mr30950976plg.78.1617060402851;
        Mon, 29 Mar 2021 16:26:42 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:e17c:78f7:dc94:55dd? ([2601:646:c200:1ef2:e17c:78f7:dc94:55dd])
        by smtp.gmail.com with ESMTPSA id e3sm6214707pfm.43.2021.03.29.16.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 16:26:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: I915 CI-run with kfence enabled, issues found
Date:   Mon, 29 Mar 2021 16:26:41 -0700
Message-Id: <2F989294-F0D4-4F1C-86A6-E657F60EF2A8@amacapital.net>
References: <CANpmjNO+_4C0dYs6K8Ofy-xVSYxO8OtXSRbW6vCXBYdjJSjqbQ@mail.gmail.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Sarvela, Tomi P" <tomi.p.sarvela@intel.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <CANpmjNO+_4C0dYs6K8Ofy-xVSYxO8OtXSRbW6vCXBYdjJSjqbQ@mail.gmail.com>
To:     Marco Elver <elver@google.com>
X-Mailer: iPhone Mail (18D61)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mar 29, 2021, at 2:55 PM, Marco Elver <elver@google.com> wrote:
>=20
> =EF=BB=BFOn Mon, 29 Mar 2021 at 23:47, Andy Lutomirski <luto@amacapital.ne=
t> wrote:
>>=20
>>=20
>>>> On Mar 29, 2021, at 2:34 PM, Marco Elver <elver@google.com> wrote:
>>>=20
>>> =EF=BB=BFOn Mon, 29 Mar 2021 at 23:03, Dave Hansen <dave.hansen@intel.co=
m> wrote:
>>>>> On 3/29/21 10:45 AM, Marco Elver wrote:
>>>>>> On Mon, 29 Mar 2021 at 19:32, Dave Hansen <dave.hansen@intel.com> wro=
te:
>>>>> Doing it to all CPUs is too expensive, and we can tolerate this being
>>>>> approximate (nothing bad will happen, KFENCE might just miss a bug and=

>>>>> that's ok).
>>>> ...
>>>>>> BTW, the preempt checks in flush_tlb_one_kernel() are dependent on KP=
TI
>>>>>> being enabled.  That's probably why you don't see this everywhere.  W=
e
>>>>>> should probably have unconditional preempt checks in there.
>>>>>=20
>>>>> In which case I'll add a preempt_disable/enable() pair to
>>>>> kfence_protect_page() in arch/x86/include/asm/kfence.h.
>>>>=20
>>>> That sounds sane to me.  I'd just plead that the special situation (not=

>>>> needing deterministic TLB flushes) is obvious.  We don't want any folks=

>>>> copying this code.
>>>>=20
>>>> BTW, I know you want to avoid the cost of IPIs, but have you considered=

>>>> any other low-cost ways to get quicker TLB flushes?  For instance, you
>>>> could loop over all CPUs and set cpu_tlbstate.invalidate_other=3D1.  Th=
at
>>>> would induce a context switch at the next context switch without needin=
g
>>>> an IPI.
>>>=20
>>> This is interesting. And it seems like it would work well for our
>>> usecase. Ideally we should only flush entries related to the page we
>>> changed. But it seems invalidate_other would flush the entire TLB.
>>>=20
>>> With PTI, flush_tlb_one_kernel() already does that for the current
>>> CPU, but now we'd flush entire TLBs for all CPUs and even if PTI is
>>> off.
>>>=20
>>> Do you have an intuition for how much this would affect large
>>> multi-socket systems? I currently can't quite say, and would err on
>>> the side of caution.
>>=20
>> Flushing the kernel TLB for all addresses
>> Is rather pricy. ISTR 600 cycles on Skylake, not to mention the cost of l=
osing the TLB.  How common is this?
>=20
> AFAIK, invalidate_other resets the asid, so it's not explicit and
> perhaps cheaper?
>=20
> In any case, if we were to do this, it'd be based on the sample
> interval of KFENCE, which can be as low as 1ms. But this is a
> production debugging feature, so the target machines are not test
> machines. For those production deployments we'd be looking at every
> ~500ms. But I know of other deployments that use <100ms.
>=20
> Doesn't sound like much, but as you say, I also worry a bit about
> losing the TLB across >100 CPUs even if it's every 500ms.

On non-PTI, the only way to zap kernel mappings is to do a global flush, eit=
her via INVPCID (expensive) or CR4 (extra expensive). In PTI mode, it=E2=80=99=
s plausible that the implicit flush is good enough, and I=E2=80=99d be happy=
 to review the patch, but it=E2=80=99s a PTI only thing.  Much less expensiv=
e in PTI mode, too, because it only needs to flush kernel mappings.

If this is best-effort, it might be better to have some work in the exit to u=
sermode path or a thread or similar that periodically does targeting single-=
page zaps.
