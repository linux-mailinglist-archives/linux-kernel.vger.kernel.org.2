Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDAF23316E5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 20:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhCHTAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 14:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbhCHTAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 14:00:32 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F0DC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 11:00:32 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id ba1so5335854plb.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 11:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=V4Tigkzpq26eOM6aEUwWM7QVcYVGsExzXqZiJfAmSJA=;
        b=Fv5HjlR4uYDG9QwkkKU0YgiyZx5kdn3v+zk31IL31g8+S9QsDdcYDdnR9S2kzgwnXH
         8t/woWK17zbr68ALkZpU03jiNnoP3rKuCHDURjwFsEGM0oU9VGDCvZJg2HIem1kIC+35
         yvS1Lk9w1Kq8Uuh4+4iDwixPLNuJO2C+JN0/zcPbedHxkId0VUcHdhiJpquAvtsvV8Fw
         l882PhdylzpYGNbszEXY+GPQFLq9KfaQp1Et8IZBU6QUxj9Ql/zgGuOxVyYEVzQiSSTX
         V7JXjANENDFrIfMQaL3HrMkhgguTiW4c1Ll024aB6rcQDKhb4TWgsi5jplw/uEsiIaYV
         qmtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=V4Tigkzpq26eOM6aEUwWM7QVcYVGsExzXqZiJfAmSJA=;
        b=hhbR/AEAeSJsHqO8Mvhp29o/X2zszPs/0xamcOHfOtAM+awYZLRkD6asNd3vMq28cq
         b2k+6RwFKjMto7SQjOq5AjgophgowBG+o8zLQU+M/F2f/JO1hXX+CvCog0W5KY3VHKO4
         yul9qEP5SQ9XKSmP8v/AddUE8vZMYujemNAe35eO4Y3s/Jkke2tew7tN8NKnHiY1m39w
         LrYGxxYGEYc14hqJL1ZPSyg0eWpV5iLIgD13ZGNbJyS8l833ZhDwFkSNuceFQWaxQqkh
         83RXOg0dKRvobNhS8Ut0NB2PJ+yVFrmeX9Q4/9WR93WXFMmQg6uR5c5eqEsdGzngLjl7
         Yl1w==
X-Gm-Message-State: AOAM532ftP5Wrk+jiODtAZpHwHMV8g2qlokvACodd41nsGFoaJtg6ld3
        gbdBZrYXb/kX/GlkxU+SpeSIgw==
X-Google-Smtp-Source: ABdhPJz54C43bjkl/a4EQx6b84Qr2rOfZobOcxYnp5hbEnyIPfshP90RN+Bz4Ag2gcvmMuyHUtPGRQ==
X-Received: by 2002:a17:90a:ba8b:: with SMTP id t11mr288602pjr.177.1615230031904;
        Mon, 08 Mar 2021 11:00:31 -0800 (PST)
Received: from ?IPv6:2600:1010:b069:668b:f917:6da4:65d8:f711? ([2600:1010:b069:668b:f917:6da4:65d8:f711])
        by smtp.gmail.com with ESMTPSA id gg22sm125432pjb.20.2021.03.08.11.00.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 11:00:31 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3] x86/fault: Send a SIGBUS to user process always for hwpoison page access.
Date:   Mon, 8 Mar 2021 11:00:28 -0800
Message-Id: <047D5B49-FDBB-494C-81E9-DA811476747D@amacapital.net>
References: <4fc1b4e8f1fb4c8c81f280db09178797@intel.com>
Cc:     Aili Yao <yaoaili@kingsoft.com>, Andy Lutomirski <luto@kernel.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        yangfeng1@kingsoft.com, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <4fc1b4e8f1fb4c8c81f280db09178797@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux API <linux-api@vger.kernel.org>
X-Mailer: iPhone Mail (18D52)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 8, 2021, at 10:31 AM, Luck, Tony <tony.luck@intel.com> wrote:
>=20
> =EF=BB=BF
>>=20
>> Can you point me at that SIGBUS code in a current kernel?
>=20
> It is in kill_me_maybe().  mce_vaddr is setup when we disassemble whatever=
 get_user()
> or copy from user variant was in use in the kernel when the poison memory w=
as consumed.
>=20
>        if (p->mce_vaddr !=3D (void __user *)-1l) {
>                force_sig_mceerr(BUS_MCEERR_AR, p->mce_vaddr, PAGE_SHIFT);

Hmm. On the one hand, no one has complained yet. On the other hand, hardware=
 that supports this isn=E2=80=99t exactly common.

We may need some actual ABI design here. We also need to make sure that thin=
gs like io_uring accesses or, more generally, anything using the use_mm / us=
e_temporary_mm ends up either sending no signal or sending a signal to the r=
ight target.

>=20
> Would it be any better if we used the BUS_MCEERR_AO code that goes into si=
ginfo?

Dunno.

>=20
> That would make it match up better with what happens when poison is found
> asynchronously by the patrol scrubber. I.e. the semantics are:
>=20
> AR: You just touched poison at this address and need to do something about=
 that.
> AO: Just letting you know that you have some poison at the address in sigi=
nfo.
>=20
> -Tony
