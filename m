Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2D334839B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 22:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbhCXV1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 17:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbhCXV0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 17:26:40 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18E5C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 14:26:40 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y200so18423964pfb.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 14:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=zO+XfNdX3v/+PmfnluHP2E/c5Q62HLHyb9yG1IFvFJ4=;
        b=NOibUNwHRBkC1k9KJ3G7tCxnTnZvwLUhozcsEHKd199C6vA3TiMhEJKTH9DfCrZ1CJ
         mLpr+Z4Dr2tgNNcccFf6HD4iLTuOTFhtcSBdyyvLC3jUMkubX1pTWO3QWfXlWxbJDPZL
         UhMJx+uzHhNiezob4Df96Ub0FFUJWX4ktgy6ecQ1N33FPnEZd0m7CJ9zB2atNV7p9cD2
         vCcIsjXqNhvv8To8iwRxACtzhY2alisHVzvgDlhMEe+2SPIGbiWZABSG3cqnwmqL1kVf
         XFbLVQTh5LlRmeP2a0/kI5k/8PpyidDkwFhRvlHq1Us4cwFX6zhIWuXbxEDK4Js5tXXS
         uf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=zO+XfNdX3v/+PmfnluHP2E/c5Q62HLHyb9yG1IFvFJ4=;
        b=fi3nU9BuknYQgJ+GCkhLY/5YIaPVVTIGK1BahVn3M2QSRAOmYwvZ/k+X2d516eW151
         F1mZ4x6H2sh3TGnuIZayDhqvKU5kyaAddPcNCz/4+tJgWO4vwlgVgY22mKkluDY3NsEd
         xtGCvhfEJxDTFaUFT574EsTA7Qcm2BbHO17BNH7lQD55noX3vR6FqBT3eWr/22kdmX90
         ErN0W9qbCMzomXJKzoqJklMKsAi+Mxp1b5y9NbvUCR2ZqQHbgP0IUytGLtWTZUz09PmP
         EcHwTuNcbMCf+0qIyDzZjWOUnnfDKRKp0BmKig9TkAnFdZo1cZyilrYEl+oUqSrs9b5a
         5m7Q==
X-Gm-Message-State: AOAM530X3gvBPjtXc8LDxaB9hMwRn9PHn3CiJxFwdX4TPfwTej0SssGy
        Ku18UIjDlsiptuuQnPPpuwwZMQ==
X-Google-Smtp-Source: ABdhPJyaJbizpVHq5AV+qVNCg11PCwsLrwynDNqHBShPUp/SE4Rpp46ccxRzekPySq/0iNUZ+X4x5w==
X-Received: by 2002:a17:902:8217:b029:e6:2875:b1d9 with SMTP id x23-20020a1709028217b02900e62875b1d9mr5450994pln.70.1616621200316;
        Wed, 24 Mar 2021 14:26:40 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:b9f9:ef01:c08a:fb13? ([2601:646:c200:1ef2:b9f9:ef01:c08a:fb13])
        by smtp.gmail.com with ESMTPSA id o76sm2400729pfg.217.2021.03.24.14.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 14:26:39 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 14/22] x86/fpu/xstate: Expand the xstate buffer on the first use of dynamic user state
Date:   Wed, 24 Mar 2021 14:26:38 -0700
Message-Id: <DEF855E6-185F-4E23-91F0-A4544F62EE50@amacapital.net>
References: <CAJvTdKm_uP-RqoprWWatg725WZOm3T-BHZU8S08dpWe2=1apGw@mail.gmail.com>
Cc:     "Liu, Jing2" <jing2.liu@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        X86 ML <x86@kernel.org>, Len Brown <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>
In-Reply-To: <CAJvTdKm_uP-RqoprWWatg725WZOm3T-BHZU8S08dpWe2=1apGw@mail.gmail.com>
To:     Len Brown <lenb@kernel.org>
X-Mailer: iPhone Mail (18D61)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> On Mar 24, 2021, at 2:09 PM, Len Brown <lenb@kernel.org> wrote:
>=20
> =EF=BB=BFOn Tue, Mar 23, 2021 at 11:15 PM Liu, Jing2 <jing2.liu@linux.inte=
l.com> wrote:
>=20
>>> IMO, the problem with AVX512 state
>>> is that we guaranteed it will be zero for XINUSE=3D0.
>>> That means we have to write 0's on saves.
>=20
>> why "we have to write 0's on saves" when XINUSE=3D0.
>>=20
>> Since due to SDM, if XINUSE=3D0, the XSAVES will *not* save the data and
>> xstate_bv bit is 0; if use XSAVE, it need save the state but
>> xstate_bv bit is also 0.
>>>  It would be better
>>> to be able to skip the write -- even if we can't save the space
>>> we can save the data transfer.  (This is what we did for AMX).
>> With XFD feature that XFD=3D1, XSAVE command still has to save INIT state=

>> to the area. So it seems with XINUSE=3D0 and XFD=3D1, the XSAVE(S) comman=
ds
>> do the same that both can help save the data transfer.
>=20
> Hi Jing, Good observation!
>=20
> There are 3 cases.
>=20
> 1. Task context switch save into the context switch buffer.
> Here we use XSAVES, and as you point out, XSAVES includes
> the compaction optimization feature tracked by XINUSE.
> So when AMX is enabled, but clean, XSAVES doesn't write zeros.
> Further, it omits the buffer space for AMX in the destination altogether!
> However, since XINUSE=3D1 is possible, we have to *allocate* a buffer
> large enough to handle the dirty data for when XSAVES can not
> employ that optimization.
>=20
> 2. Entry into user signal handler saves into the user space sigframe.
> Here we use XSAVE, and so the hardware will write zeros for XINUSE=3D0,
> and for AVX512, we save neither time or space.
>=20
> My understanding that for application compatibility, we can *not* compact
> the destination buffer that user-space sees.  This is because existing cod=
e
> may have adopted fixed size offsets.  (which is unfortunate).
>=20
> And so, for AVX512, we both reserve the space, and we write zeros
> for clean AVX512 state.
>=20
> For AMX, we must still reserve the space, but we are not going to write ze=
ros
> for clean state.  We so this in software by checking XINUSE=3D0, and clear=
ing
> the xstate_bf for the XSAVE.  As a result, for XINUSE=3D0, we can skip
> writing the zeros, even though we can't compress the space.

Why?

>=20
> 3. user space always uses fully uncompacted XSAVE buffers.
>=20

There is no reason we have to do this for new states. Arguably we shouldn=E2=
=80=99t for AMX to avoid yet another altstack explosion.=
