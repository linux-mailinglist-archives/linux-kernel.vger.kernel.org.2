Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A02373375
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 03:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbhEEBMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 21:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbhEEBMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 21:12:31 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFE4C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 18:11:35 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id n16so243292plf.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 18:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=ZTESUAJHff3rHiE1iQkDnV/NFjY5nd2nPE1FAwGRmjQ=;
        b=l/zgfqAGkgB7vlL0PDLMPEZIJlENnIokEpGmg2KornzaXhgFm1wB11bLrk55TNitNh
         UdLfrjHeYshWzFmYK7lwXFTqsDraVgaoAuZDsbpZPJ8vP2nSRuRK2YdvAl43ACphfMsi
         /ZnWjOdKj2g85eeUuH8v2mcD6SHtDSpV0iYJiGAZPd/BTSMeofqRNRxsWPlpdq/SLAFR
         X9V5wZHwKucLyaaqigIledcoHEJ+Ry2G8wS27JwZ/Sj59Vw1f7NtcG34wvs2Cskame9W
         /Y92W/vQN47vX2GeWzFEYdkaCEYRyBK4/RfndWLKhokzj9WkoW7SnoLBOgXa/FroZVpg
         8uAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=ZTESUAJHff3rHiE1iQkDnV/NFjY5nd2nPE1FAwGRmjQ=;
        b=XCRhpOuxQ0/rQG4/1zaVKkCTd4uM8DBmiib4UTMJib0hJ5Z5ncIjoDVIeosgPQ+ZOx
         9qo9Eg4jnT/2U/eN1BUfZt0pFiB5IsfHEJqc2TIEdzoDhEbUOx2SQopaFWv0sosx/311
         oSfEeqYmy7ceReUKppu+DVBm2Qe+4MZZuYLo3oBxNkiOFE/4AmeZbx87Aky6suFIE79c
         LAVu4UMCoauTNcoYigkN5AFGcP2MDZN4QDX0VOTJgxn9VZWSRIYAZHUn8dJ+kEu2mVGN
         xKPURlYoEhXKkXEtEV156KuIAPgxH2he0Bz73NN8OlLsPFcZLOLa63dZ0ofDzck9hi8k
         ubIw==
X-Gm-Message-State: AOAM533qJo1zzx+UXVg87S2x1U5Ut5ddKAel0G9xTincXK46EwkmyboO
        QgvWsiHPDa7kGtCDBDCkerlCUg==
X-Google-Smtp-Source: ABdhPJxtP+upQelD5pdYH1pqguazacLMttp75xuFKWERCXHxVZKQ/Z9WbGbDKWq6tGCtVlAi6UG3nQ==
X-Received: by 2002:a17:902:9002:b029:e6:c95f:2a1d with SMTP id a2-20020a1709029002b02900e6c95f2a1dmr28821032plp.79.1620177094861;
        Tue, 04 May 2021 18:11:34 -0700 (PDT)
Received: from smtpclient.apple ([2601:646:c200:1ef2:cd99:8d1d:1c8b:22c9])
        by smtp.gmail.com with ESMTPSA id a190sm13964079pfd.118.2021.05.04.18.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 18:11:34 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] KVM/VMX: Invoke NMI non-IST entry instead of IST entry
Date:   Tue, 4 May 2021 18:11:33 -0700
Message-Id: <2FB0C052-A998-4510-8BBA-6B48AC86E4C8@amacapital.net>
References: <CAJhGHyDsTVyDX9fkYAyVkVQFWqkyTAVCY4enJqdG4bzOuOSn+w@mail.gmail.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Uros Bizjak <ubizjak@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Juergen Gross <JGross@suse.com>,
        Joerg Roedel <jroedel@suse.de>, Jian Cai <caij2003@gmail.com>
In-Reply-To: <CAJhGHyDsTVyDX9fkYAyVkVQFWqkyTAVCY4enJqdG4bzOuOSn+w@mail.gmail.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
X-Mailer: iPhone Mail (18E199)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 4, 2021, at 6:08 PM, Lai Jiangshan <jiangshanlai@gmail.com> wrote:
>=20
> =EF=BB=BFOn Wed, May 5, 2021 at 5:23 AM Andy Lutomirski <luto@amacapital.n=
et> wrote:
>>=20
>>=20
>>>> On May 4, 2021, at 2:21 PM, Sean Christopherson <seanjc@google.com> wro=
te:
>>>=20
>>> =EF=BB=BFOn Tue, May 04, 2021, Paolo Bonzini wrote:
>>>>> On 04/05/21 23:05, Maxim Levitsky wrote:
>>>>> Does this mean that we still rely on hardware NMI masking to be activa=
ted?
>>>>=20
>>>> No, the NMI code already handles reentrancy at both the assembly and C
>>>> levels.
>>>>=20
>>>>> Or in other words, that is we still can't have an IRET between VM exit=
 and
>>>>> the entry to the NMI handler?
>>>>=20
>>>> No, because NMIs are not masked on VM exit.  This in fact makes things
>>>> potentially messy; unlike with AMD's CLGI/STGI, only MSRs and other thi=
ngs
>>>> that Intel thought can be restored atomically with the VM exit.
>>>=20
>>> FWIW, NMIs are masked if the VM-Exit was due to an NMI.
>>=20
>> Then this whole change is busted, since nothing will unmask NMIs. Revert i=
t?
>=20
> There is some instructable code between VMEXIT and
> handle_exception_nmi_irqoff().
>=20
> The possible #DB #BP can happen in this gap and the IRET
> of the handler of #DB #BP will unmask NMI.
>=20
> Another way to fix is to change the VMX code to call the NMI handler
> immediately after VMEXIT before leaving "nostr" section.
>=20
> Reverting it can't fix the problem.

I was indeed wrong, and the helper properly unmasks NMIs. So all should be w=
ell.

I will contemplate how this all interacts with FRED.=
