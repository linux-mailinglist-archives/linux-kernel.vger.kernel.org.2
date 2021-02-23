Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1E3322D99
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 16:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbhBWPed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 10:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbhBWPea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 10:34:30 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E97C061786
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 07:33:49 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id s16so10032025plr.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 07:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=S1+694tF7E6JOAf32EqgTXj/ubixpJ18hXdr8aPWDgI=;
        b=ngI0rU01hqa40qg2u4VlRUqm7wgIOZH9Lo+aTRNgzkK1of1tdZYDsLDeM3bnImibnp
         1i/0USARwUi98V6w1t1REkAkyscY8CtbG6D13TkF4Aq1YoRYzalAzBe/6tuySpb41ZBZ
         MArEOMogQRMgVIgfD7EPHqJVo1YMTyltkKXMlnpRhSzfa10s2YM2AlxIiM3OvMzTKFT3
         UU3ROBZ/1pWcAKZhdK4AeN7Ubo6z4W/hqW+tMs1XEzLk+l8XoTglqEbFaVV3FvPXYeTM
         QHo4xkQfOZ0k2ZXsVFH6cU2hSf2YovEtg5Nz7y4mIqvz3T/09pUhzL30+00ayJcHXwKA
         35hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=S1+694tF7E6JOAf32EqgTXj/ubixpJ18hXdr8aPWDgI=;
        b=Qk1fOj74tBxCchmxcSXBBhNGpObni7lOCRrucY6EWA6UWfm7S7aQrKUvLZcH9lyZqS
         Cbtwsj/UFuiUWZw/9FnLY/aeqAvs6ss/YFcLdWq1RtY8FMq4o/2+gZUvSnYbukKBphhq
         UCGpAg5eXx52FN/fPIk19I2URVtp44e4blFGLHT4bSnHK+Zl2nJdcjx8q2Q/69SEJgvu
         56KQSO9DZ2o2cCt0plQEHOfRZ3cieoxc7xQY60mhdZ0F9EylQkZE94GwrD6r00qLEtxK
         kPZ8fwLUVel8g9Ge+2cLTUcW2o6NxSiupWrdQej1hG8hnjYKn6UDv7LKyDMFyFQWq/Ke
         b1vQ==
X-Gm-Message-State: AOAM533r2IuEtUymDJHZuvHcxp6p/NiK9TnH/kxYYOGz8HAFP/HY5Vda
        pu/iKDzHoDhMui4O2oFUZV1UwQ==
X-Google-Smtp-Source: ABdhPJzoRKhmfzQGuTbH5ITlI5Le0B+bcvxH1DrTPvM8crTJxrwekIakZjx/PditZmlrkpz5AeZJVQ==
X-Received: by 2002:a17:90a:b292:: with SMTP id c18mr29248288pjr.134.1614094428836;
        Tue, 23 Feb 2021 07:33:48 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:2488:1c5a:27b:935? ([2601:646:c200:1ef2:2488:1c5a:27b:935])
        by smtp.gmail.com with ESMTPSA id 3sm21357516pfd.45.2021.02.23.07.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Feb 2021 07:33:47 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3] x86/fault: Send a SIGBUS to user process always for hwpoison page access.
Date:   Tue, 23 Feb 2021 07:33:46 -0800
Message-Id: <788DFBA0-903F-4548-9C2F-B1A1543EE770@amacapital.net>
References: <20210223204436.1df73153@alex-virtual-machine>
Cc:     =?utf-8?Q?
         "HORIGUCHI_NAOYA=28=E5=A0=80=E5=8F=A3=E3=80=80=E7=9B=B4?=
        =?utf-8?Q?=E4=B9=9F=29" ?= <naoya.horiguchi@nec.com>,
        tony.luck@intel.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        yangfeng1@kingsoft.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210223204436.1df73153@alex-virtual-machine>
To:     Aili Yao <yaoaili@kingsoft.com>
X-Mailer: iPhone Mail (18D52)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Feb 23, 2021, at 4:44 AM, Aili Yao <yaoaili@kingsoft.com> wrote:
>=20
> =EF=BB=BFOn Fri, 5 Feb 2021 17:01:35 +0800
> Aili Yao <yaoaili@kingsoft.com> wrote:
>=20
>> When one page is already hwpoisoned by MCE AO action, processes may not
>> be killed, processes mapping this page may make a syscall include this
>> page and result to trigger a VM_FAULT_HWPOISON fault, as it's in kernel
>> mode it may be fixed by fixup_exception, current code will just return
>> error code to user code.
>>=20
>> This is not sufficient, we should send a SIGBUS to the process and log
>> the info to console, as we can't trust the process will handle the error
>> correctly.
>>=20
>> Suggested-by: Feng Yang <yangfeng1@kingsoft.com>
>> Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
>> ---
>> arch/x86/mm/fault.c | 62 +++++++++++++++++++++++++++++----------------
>> 1 file changed, 40 insertions(+), 22 deletions(-)
>>=20
> Hi luto;
>  Is there any feedback?

At the very least, this needs a clear explanation of why your proposed behav=
ior is better than the existing behavior.

>=20
> Thanks
> Aili Yao
