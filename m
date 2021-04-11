Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADB435B63E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 18:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbhDKQ5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 12:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbhDKQ5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 12:57:38 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23450C061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 09:57:22 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id c17so7621264pfn.6
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 09:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=SijJqZ5EqSxizfZ+1rajM+6jINBOobyy+KI6KXX4/IQ=;
        b=gk8wFRtZrKTFaG200r2SZPxyKdvmPdjhP3AhbhPxY11DJfaBbVOya7bkOSrTDNLJ0m
         XQctnrzqO2AVCogR5lIKFs/Lx98yAW05yo0Cau2AvrIkmMb29lj9XCUFLuN6vR8Sk1Ib
         P2VOv08r6pJbVoaHsVwLM1KDgZ7lhBC5hXnVO1qK3wHhYdhe8dmomwLSFGC34Oe2C/QK
         kQOZEjhaOXYtJ3ZSRvRdpLXNIjqXRGjhdRUITaNmen1jxmZEXRJdwBtT3nGzDkIcH6fv
         EFXm/s/Sv3i5yH9E4har5kYj+9sWuXXDrv56ZlNCBEKrkNuuat2Fek8Xcn1u36aIVsb7
         Ccrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=SijJqZ5EqSxizfZ+1rajM+6jINBOobyy+KI6KXX4/IQ=;
        b=YU2H8rnnCXnrFZ8wVFBcudlJtn9VhcfFkb48VqmNB3tES0i81Y/Zl5UgEQslkn77j5
         SrzuKZ+sP51Qw914T6FmuHUEbcWOAydyzqF65kjN/hH383LV7Hh4a/yAPabgUdBosEmv
         f4br19NrGobFXJyaql56wpZMCruh00TjphkQV8tJKXxZNcwW/eVrj7St5PL3U9Ml1S5G
         DHkJHFoCg9jK32QaIRMM3LTTBFo+Wts43NYFREWqYleJhHwBp/3yyUz66F9LmNUgh7H0
         Lfn6WrbEh0diJMv/wm/mr1Bo9W5nyk7TMgmz5ORXfMzc3pxPiFlowLyrNmlTXzgtcX9q
         VIcg==
X-Gm-Message-State: AOAM531OKEtSgQ03+tkYnMOvSx5FGNqw+hYMI83D7naDED4l52ikgSit
        Kle8Gy6L5zxJBC3FEIXExoD9LTTySBWMteM1
X-Google-Smtp-Source: ABdhPJzwZLGRq8AyHKQoaaJ0jr16lmZwPkkTBKOb5RS6SwMMChPL4mmBTVHfPU7WOP26EYgQf1CWXA==
X-Received: by 2002:a62:e70e:0:b029:245:3a00:5720 with SMTP id s14-20020a62e70e0000b02902453a005720mr15962206pfh.0.1618160241499;
        Sun, 11 Apr 2021 09:57:21 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:590d:de8e:40a2:50b9? ([2601:646:c200:1ef2:590d:de8e:40a2:50b9])
        by smtp.gmail.com with ESMTPSA id kk6sm8438580pjb.51.2021.04.11.09.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Apr 2021 09:57:20 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86/msr: Block writes to certain MSRs unconditionally
Date:   Sun, 11 Apr 2021 09:57:20 -0700
Message-Id: <C7F7BE8D-562B-4BC3-A209-8EDD7DAF0AAA@amacapital.net>
References: <20210411164342.GL3762101@tassilo.jf.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Feng Tang <feng.tang@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Len Brown <len.brown@intel.com>
In-Reply-To: <20210411164342.GL3762101@tassilo.jf.intel.com>
To:     Andi Kleen <ak@linux.intel.com>
X-Mailer: iPhone Mail (18D70)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> On Apr 11, 2021, at 9:43 AM, Andi Kleen <ak@linux.intel.com> wrote:
>=20
> =EF=BB=BF
>>=20
>> I have actually seen real user programs poke MSR_SYSCALL_MASK.
>=20
> Hmm, what was the use case?
>=20
>=20

Working around a kernel bug.  The workaround only worked on AMD systems.  Th=
e correct solution was to fix the kernel bug, not poke MSRs.=
