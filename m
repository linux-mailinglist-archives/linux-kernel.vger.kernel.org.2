Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22BC32D1D8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 12:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238263AbhCDLcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 06:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238873AbhCDLcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 06:32:20 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D7AC061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 03:31:40 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id d20so29701037oiw.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 03:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j0Anx46LrA/DH7upo2qHDfKBBW2EhpUPPJfiwAkE4e4=;
        b=FvLMEup3DhFI/E25fGKPvQa9fJ15dCqSKwz1YCyGtCJd9f16CUVmdAuligKBm/GEGh
         DtNpee5+c7ufCbWgz9LKV/SphHORc73KeXacqtr48nQFHlQuG073Um2uzMKYxsx3p9zW
         i8nLLZoanU6vBUBfpjYjGzcRNJ8r7y6pYCwO9tT4skeFF6VfuxCXKc3YDUmTrSEPUXyY
         kj9sY9uuq04Z9yfEiAN/XJwyOOWHpSdBe974Rjk6aBGwHhJ76aU0satfHRwX2OlGBNPj
         aB5Vac2b2ThLa1sgD0QCOIWaZJDLkfJTxqiWVzNVdM9a5wlJZLI4S9ZIL8GdENpcn9yC
         s+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j0Anx46LrA/DH7upo2qHDfKBBW2EhpUPPJfiwAkE4e4=;
        b=KvysjBuT89zNJ6njp77p7aPKeZ8HVT8j3BS9JCujYmGCGtfBv/jXZNTdo0/8as3NKo
         oGSB/mmKRvxrB3dk5zjbbL8uWlFJlKK02CW/AR+gN3R3Wan4ZX9uTi2+yy8SEm7bsXZZ
         ZYb+CYSS0eX27aPLFR2t4kq72HpWvHHfg8m39w7k2p/feCrO6snOTT+3qcWcKSpZUad0
         OeYtUUYob9Q0V+9yXhTEpAohV+0QzoUmfdJxHc2X1D5ArMaS1XiIOhvbYiDhtljI5qmF
         MFpsy09+5xVcXiXhGyFVaWZxCDhkHMEzoTo1GxCkpgPqbhbVI0SB56B1X9Yqjfsvo0zP
         DxPQ==
X-Gm-Message-State: AOAM533kyLMDO+HHNY/yqsJbwBtS/Nq9PmDgjxbfXOsfDkYbQoZtd1m5
        B93+to4T4zpiTjCY84jj3AjwAmWywZMvWZ+ZbA29nw==
X-Google-Smtp-Source: ABdhPJyC3mvSeSseP10oItrCI9EeNvVQ57SVpuXq2xWvCMPDxzJTIVcB8XRko5MVy0EC4y2PZJW9zDxDvIzyF/S294w=
X-Received: by 2002:a05:6808:10d3:: with SMTP id s19mr2682857ois.70.1614857499889;
 Thu, 04 Mar 2021 03:31:39 -0800 (PST)
MIME-Version: 1.0
References: <51c397a23631d8bb2e2a6515c63440d88bf74afd.1614674144.git.christophe.leroy@csgroup.eu>
 <CANpmjNPOJfL_qsSZYRbwMUrxnXxtF5L3k9hursZZ7k9H1jLEuA@mail.gmail.com>
 <b9dc8d35-a3b0-261a-b1a4-5f4d33406095@csgroup.eu> <CAG_fn=WFffkVzqC9b6pyNuweFhFswZfa8RRio2nL9-Wq10nBbw@mail.gmail.com>
 <f806de26-daf9-9317-fdaa-a0f7a32d8fe0@csgroup.eu> <CANpmjNPGj4C2rr2FbSD+FC-GnWUvJrtdLyX5TYpJE_Um8CGu1Q@mail.gmail.com>
 <08a96c5d-4ae7-03b4-208f-956226dee6bb@csgroup.eu> <CANpmjNPYEmLtQEu5G=zJLUzOBaGoqNKwLyipDCxvytdKDKb7mg@mail.gmail.com>
 <ad61cb3a-2b4a-3754-5761-832a1dd0c34e@csgroup.eu> <CANpmjNOnVzei7frKcMzMHxaDXh5NvTA-Wpa29C2YC1GUxyKfhQ@mail.gmail.com>
 <f036c53d-7e81-763c-47f4-6024c6c5f058@csgroup.eu>
In-Reply-To: <f036c53d-7e81-763c-47f4-6024c6c5f058@csgroup.eu>
From:   Marco Elver <elver@google.com>
Date:   Thu, 4 Mar 2021 12:31:27 +0100
Message-ID: <CANpmjNMn_CUrgeSqBgiKx4+J8a+XcxkaLPWoDMUvUEXk8+-jxg@mail.gmail.com>
Subject: Re: [RFC PATCH v1] powerpc: Enable KFENCE for PPC32
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Alexander Potapenko <glider@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Mar 2021 at 12:23, Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> Le 03/03/2021 =C3=A0 11:56, Marco Elver a =C3=A9crit :
> >
> > Somewhat tangentially, I also note that e.g. show_regs(regs) (which
> > was printed along the KFENCE report above) didn't include the top
> > frame in the "Call Trace", so this assumption is definitely not
> > isolated to KFENCE.
> >
>
> Now, I have tested PPC64 (with the patch I sent yesterday to modify save_=
stack_trace_regs()
> applied), and I get many failures. Any idea ?
>
> [   17.653751][   T58] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   17.654379][   T58] BUG: KFENCE: invalid free in .kfence_guarded_free+=
0x2e4/0x530
> [   17.654379][   T58]
> [   17.654831][   T58] Invalid free of 0xc00000003c9c0000 (in kfence-#77)=
:
> [   17.655358][   T58]  .kfence_guarded_free+0x2e4/0x530
> [   17.655775][   T58]  .__slab_free+0x320/0x5a0
> [   17.656039][   T58]  .test_double_free+0xe0/0x198
> [   17.656308][   T58]  .kunit_try_run_case+0x80/0x110
> [   17.656523][   T58]  .kunit_generic_run_threadfn_adapter+0x38/0x50
> [   17.657161][   T58]  .kthread+0x18c/0x1a0
> [   17.659148][   T58]  .ret_from_kernel_thread+0x58/0x70
> [   17.659869][   T58]
> [   17.663954][   T58] kfence-#77 [0xc00000003c9c0000-0xc00000003c9c001f,=
 size=3D32, cache=3Dkmalloc-32]
> allocated by task 58:
> [   17.666113][   T58]  .__kfence_alloc+0x1bc/0x510
> [   17.667069][   T58]  .__kmalloc+0x280/0x4f0
> [   17.667452][   T58]  .test_alloc+0x19c/0x430
> [   17.667732][   T58]  .test_double_free+0x88/0x198
> [   17.667971][   T58]  .kunit_try_run_case+0x80/0x110
> [   17.668283][   T58]  .kunit_generic_run_threadfn_adapter+0x38/0x50
> [   17.668553][   T58]  .kthread+0x18c/0x1a0
> [   17.669315][   T58]  .ret_from_kernel_thread+0x58/0x70
> [   17.669711][   T58]
> [   17.669711][   T58] freed by task 58:
> [   17.670116][   T58]  .kfence_guarded_free+0x3d0/0x530
> [   17.670421][   T58]  .__slab_free+0x320/0x5a0
> [   17.670603][   T58]  .test_double_free+0xb4/0x198
> [   17.670827][   T58]  .kunit_try_run_case+0x80/0x110
> [   17.671073][   T58]  .kunit_generic_run_threadfn_adapter+0x38/0x50
> [   17.671410][   T58]  .kthread+0x18c/0x1a0
> [   17.671618][   T58]  .ret_from_kernel_thread+0x58/0x70
> [   17.671972][   T58]
> [   17.672638][   T58] CPU: 0 PID: 58 Comm: kunit_try_catch Tainted: G   =
 B
> 5.12.0-rc1-01540-g0783285cc1b8-dirty #4685
> [   17.673768][   T58] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   17.677031][   T58]     # test_double_free: EXPECTATION FAILED at mm/k=
fence/kfence_test.c:380
> [   17.677031][   T58]     Expected report_matches(&expect) to be true, b=
ut is false
> [   17.684397][    T1]     not ok 7 - test_double_free
> [   17.686463][   T59]     # test_double_free-memcache: setup_test_cache:=
 size=3D32, ctor=3D0x0
> [   17.688403][   T59]     # test_double_free-memcache: test_alloc: size=
=3D32, gfp=3Dcc0, policy=3Dany,
> cache=3D1

Looks like something is prepending '.' to function names. We expect
the function name to appear as-is, e.g. "kfence_guarded_free",
"test_double_free", etc.

Is there something special on ppc64, where the '.' is some convention?

Thanks,
-- Marco
