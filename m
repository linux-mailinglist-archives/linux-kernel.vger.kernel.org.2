Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48DB35AE86
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 16:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbhDJOwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 10:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbhDJOwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 10:52:15 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B3EC06138A
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:52:01 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id b17so5995372pgh.7
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=6TuiuBmLZhDQQUKyBNjF725AcPdjJwz198tbKFYQDiE=;
        b=WH38WsTEPW5XaJfyaXe4vnml3T7wzzW9m2cMfWUvm0i0KT3rTbByeLxLfbo3kquzU5
         ZJydMeNqdyfze/7L+NiaJ2gMEjOAMazid7uOhSDr2eYGdOtWc9uDTESpkabNFVQC30d8
         +oMIVlZnp2BCDOJXnGiEKMeImNNCq7qFHRZZk5hzmnDsURpPkUdRYuaqqTfW5y1qdMBT
         aeshEygNzKjT4c1C0lDLUUa/AWMxgMxAp5WAq3y43HZ3N7GiQjHF/+3XUNID0Frch8U3
         myq4lYcin/sbzZjlr9G3ZlMsNN3sErz1Zv8MQPCZjl5qtkhM4dNsyfXA+0C5l250nNDH
         0wzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=6TuiuBmLZhDQQUKyBNjF725AcPdjJwz198tbKFYQDiE=;
        b=MvquDarSVhccQIyGZXC3IulMmjfKHjX7SMHH//uS2ppyg5CGnbtA3P8VrQzSeh4nsm
         dKJmrZhn/d0FKkjbFMHGcoXCDiGuOI/EVfBNY5odPvBTGZYHONfckajy+MHbxL69RQTN
         FUYl8Iue8K7y78hdmQjaRPG7gxA/hrbp/Msgau+o5uhoNny2d/kx7jMdHOOEhaeu9QIX
         zE5QdPleW+ARZ6jp8xlf+E1HGFA3QvOPCz+rb1yMNbHUFVH2X29Mc7yXTyD5LABTcI7F
         v5527Vbw4PizTBkTBnoEArWcUZ+zzOe1vEaKIBCqL7xbJjxkpMw36jHLimevQXi+4i/z
         a5Xw==
X-Gm-Message-State: AOAM531uuSRU5I16FoksRkGLIK0BxmiEB5TCtNvK2eWe1J0jMt+yi1Uk
        XzwaX5UIe/bTgJNJmGH30lTFpMEuMBTjhcSk
X-Google-Smtp-Source: ABdhPJz0+dIHvGEbf7AI38FCEb9h7DsXYIGekgJNwyXjhdP4SCb++aDjU84V5EjFg68nFSareWzReg==
X-Received: by 2002:a62:3246:0:b029:224:6c6f:b3f2 with SMTP id y67-20020a6232460000b02902246c6fb3f2mr16768396pfy.68.1618066320180;
        Sat, 10 Apr 2021 07:52:00 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:50f6:ed2d:56f5:2c9e? ([2601:646:c200:1ef2:50f6:ed2d:56f5:2c9e])
        by smtp.gmail.com with ESMTPSA id r127sm2045690pfr.163.2021.04.10.07.51.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Apr 2021 07:51:59 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86/msr: Block writes to certain MSRs unconditionally
Date:   Sat, 10 Apr 2021 07:51:58 -0700
Message-Id: <437BACC3-A1F7-4C65-80C7-98F6652A14E6@amacapital.net>
References: <20210410121144.GC21691@zn.tnic>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Feng Tang <feng.tang@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        andi.kleen@intel.com, dave.hansen@intel.com, len.brown@intel.com
In-Reply-To: <20210410121144.GC21691@zn.tnic>
To:     Borislav Petkov <bp@alien8.de>
X-Mailer: iPhone Mail (18D70)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 10, 2021, at 5:11 AM, Borislav Petkov <bp@alien8.de> wrote:
>=20
> =EF=BB=BFFrom: Borislav Petkov <bp@suse.de>
> Date: Sat, 10 Apr 2021 14:08:13 +0200
>=20
> There are a bunch of MSRs which luserspace has no business poking at,
> whatsoever. Add a ban list and put the TSC-related MSRs in there. Issue
> a big juicy splat to catch offenders.

Ack!

Can you add STAR, CSTAR, LSTAR, SYSENTER*, SYSCALL*, and EFER please?=20

>=20
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
> arch/x86/kernel/msr.c | 17 +++++++++++++++++
> 1 file changed, 17 insertions(+)
>=20
> diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
> index ed8ac6bcbafb..574bd2c6d4f8 100644
> --- a/arch/x86/kernel/msr.c
> +++ b/arch/x86/kernel/msr.c
> @@ -78,6 +78,13 @@ static ssize_t msr_read(struct file *file, char __user *=
buf,
>    return bytes ? bytes : err;
> }
>=20
> +static const u32 msr_ban_list[] =3D {
> +    MSR_IA32_TSC,
> +    MSR_TSC_AUX,
> +    MSR_IA32_TSC_ADJUST,
> +    MSR_IA32_TSC_DEADLINE,
> +};
> +
> static int filter_write(u32 reg)
> {
>    /*
> @@ -89,6 +96,16 @@ static int filter_write(u32 reg)
>     * avoid saturating the ring buffer.
>     */
>    static DEFINE_RATELIMIT_STATE(fw_rs, 30 * HZ, 1);
> +    int i;
> +
> +    for (i =3D 0; i < ARRAY_SIZE(msr_ban_list); i++) {
> +        if (msr_ban_list[i] !=3D reg)
> +            continue;
> +
> +        WARN_ONCE(1, "Blocked write to MSR 0x%x\n", reg);
> +
> +        return -EINVAL;
> +    }
>=20
>    switch (allow_writes) {
>    case MSR_WRITES_ON:  return 0;
> --=20
> 2.29.2
>=20
>=20
> --=20
> Regards/Gruss,
>    Boris.
>=20
> https://people.kernel.org/tglx/notes-about-netiquette
