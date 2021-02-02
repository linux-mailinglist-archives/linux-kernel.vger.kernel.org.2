Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B4F30CDFC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 22:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhBBVgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 16:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhBBVg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 16:36:26 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A0DC061788
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 13:35:41 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id m12so3111602pjs.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 13:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FoA422evUbddlF75nQqEp1016LqOY8Nux/3DycG907Y=;
        b=KFi96diUBtHsM9QjTLOU/LYSXKZJ0HTUHilQzhM2H9rN7GHzNuqM6WUTNStZg1yvj4
         KJRzyCsVm0T0IhcXrtMQXmpKpkqaC4zzt2rdNJulrse8lsfS08hLDWA0WWV+ffTb+0k0
         gSfrLUp3v2xao9XYqMU/AIzvqaaW6004lwc9/AJ5z8/CF/LymuN3jOvMJxf1cyDkZF2F
         sw27/OtWBiUueWsn/ElrkrYSVGx/piNWTCmkSvUrREnbG3e9XJteSQAE1mBuZ57L3alV
         9pxu6LQm0rhzEfMLwyh6+uZbb64g8Y/yOtH/VwDNEngd8byUzVVK00sTOAeRnlhazN9C
         Tp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FoA422evUbddlF75nQqEp1016LqOY8Nux/3DycG907Y=;
        b=piejqYFw0vVtdZLgUYDGcI2/e+e0DYKJAxyRJT+NusZ+pYu9LDrmNm41KA1ToBrg0L
         POX+TssRJU/yvMPUrFtPZuw4zsXQhB2k9gKRWgTuf5ajiqCgs9bvMA6D+4mNEMfnwfZr
         aoJT6XklQq31abejl2KR2Ba2OO2skINjaQ8ZFEp+GQYB8E3vhYFNCBnhXd8QHcn+dve7
         Uv+IR6xz1gt751P0Smitw8XQ8CFn02E8Dg5BgcmaZDS7Dp1NDglC5WzmgSndSAI9hOfm
         ZzXAvSZjgvdvkWJzUa9JoCgrH5QvkxUuCw8IU2OGXnAqlaEQxE+mqdcInRbM0M3zi/LG
         6/Jg==
X-Gm-Message-State: AOAM532umm7PVu9xxfx5L3bdRvkX6WG59rI2NlSsrY5AbQe5Qp9Abe6z
        HUMTUJFjXrlUJ109IiXmyYc=
X-Google-Smtp-Source: ABdhPJxC7dnN1/A6L3fkfdNBAFGq503bH5flKJ3/GWe+kvTYfnaVSueYyGTs7ACApbhmTZiKxoyZhg==
X-Received: by 2002:a17:90a:588d:: with SMTP id j13mr6445635pji.50.1612301741037;
        Tue, 02 Feb 2021 13:35:41 -0800 (PST)
Received: from [192.168.88.245] (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id 21sm22259802pfu.136.2021.02.02.13.35.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Feb 2021 13:35:40 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [RFC 01/20] mm/tlb: fix fullmm semantics
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <YBkwyEL2FKxlsgZ5@hirez.programming.kicks-ass.net>
Date:   Tue, 2 Feb 2021 13:35:38 -0800
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, X86 ML <x86@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5E9B0429-7E72-4E86-B91B-4718C4134B0F@gmail.com>
References: <20210131001132.3368247-1-namit@vmware.com>
 <20210131001132.3368247-2-namit@vmware.com>
 <YBfntzMgNlMDOP9s@hirez.programming.kicks-ass.net>
 <52673507-2C30-4AC6-8EBC-B5A313827FB0@gmail.com>
 <YBkwyEL2FKxlsgZ5@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Feb 2, 2021, at 3:00 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Tue, Feb 02, 2021 at 01:32:36AM -0800, Nadav Amit wrote:
>>> On Feb 1, 2021, at 3:36 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>>>=20
>>>=20
>>> https://lkml.kernel.org/r/20210127235347.1402-1-will@kernel.org
>>=20
>> I have seen this series, and applied my patches on it.
>>=20
>> Despite Will=E2=80=99s patches, there were still inconsistencies =
between fullmm
>> and need_flush_all.
>>=20
>> Am I missing something?
>=20
> I wasn't aware you were on top. I'll look again.

Looking on arm64=E2=80=99s tlb_flush() makes me think that there is =
currently a bug
that this patch fixes. Arm64=E2=80=99s tlb_flush() does:

       /*
        * If we're tearing down the address space then we only care =
about
        * invalidating the walk-cache, since the ASID allocator won't
        * reallocate our ASID without invalidating the entire TLB.
        */
       if (tlb->fullmm) {
               if (!last_level)
                       flush_tlb_mm(tlb->mm);
               return;
       }=20

But currently tlb_mmu_finish() can mistakenly set fullmm incorrectly (if
mm_tlb_flush_nested() is true), which might skip the TLB flush.

Lucky for us, arm64 flushes each VMA separately (which as we discussed
separately may not be necessary), so the only PTEs that might not be =
flushed
are PTEs that are updated concurrently by another thread that also defer
their flushes. It therefore seems that the implications are more on the
correctness of certain syscalls (e.g., madvise(DONT_NEED)) without
implications on security or memory corruptions.

Let me know if you want me to send this patch separately with an updated
commit log for faster inclusion.=
