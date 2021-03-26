Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAEB34B135
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 22:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhCZVVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 17:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhCZVVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 17:21:07 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC36DC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 14:21:07 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id t20so1534830plr.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 14:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=m2miwIO/u/sYwYpBdb5shG1C8hzzjvjQQh0IO27dehU=;
        b=AIvUJFpRVWe1n4j/fb8FJ2I9EdzdGmlDPQh7pK4XVOy4ddGl6yz0ZLqFE8/Pjb20kA
         Dq8hP472PqEDlb7kNx6YHi6Vt6ldPV/NVyQgNrfqOTogf2iFTY+U39peo9/sYzWGrXYi
         uBSNuxdJD1nkTtaHVylnyh7N2Dd2du+O1O9m3i9Ee4HLIp/RoJtR0PcytdfUGHY23yP6
         zS7Hu5MaQOWVH2onH73m9gqRoJrZme6uWiGkfTcobgMzuVmUFW3dF+fUA20oDp2rERpI
         jfBuMNnPh/V7SgxG50YXA2DWmsZj7r3qIJ10bRfYDBGWRudoU53plSEXvqWKk/QfhtZk
         GUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=m2miwIO/u/sYwYpBdb5shG1C8hzzjvjQQh0IO27dehU=;
        b=I4YUFgsCPcZAM9XJ8YQwqcJ9md4JLwXmTajxz0axB7Vf+X6MKdSxBgrymw2j5QA61w
         0HdAOiogAPlqWcmns02AMFq/IxXXPbV9lQFvmzNsEJBy0cMj9GT6mgYtD8B0JlBmY9CC
         MyMgatAn6uvuU0ZTrtoPQ3OOcRyflVzFGXtreURviVFxkHYvOz20jKHSQJVvbVzutxpL
         LwHovF09J0XC0FfuR/dckHdlI/yZwRk1N6R0jVkTpJv2mpdKuo9Pa8GMrGMi18ZEU0Ta
         dEWruyu835sAlltL92ezO4PTR8JTBZe5gdb3EFDe+6+bEguk9hi+slH4B3Jd2nc+RSkE
         3kAw==
X-Gm-Message-State: AOAM532yHHwLEfmK8u6o9N/qygEGcJHdiSI3BdydBIWU5XRklUTp3oZY
        lr4IVDT0lloPWq4yff1Qyh9kZg==
X-Google-Smtp-Source: ABdhPJzu3YvDiQ+YFH46fm+031Ix2HT2UX27Wa9xogrIJhAGl5B1yLVcTz9TgNOfljmjPaB0ajujgQ==
X-Received: by 2002:a17:90b:e87:: with SMTP id fv7mr7563556pjb.27.1616793667148;
        Fri, 26 Mar 2021 14:21:07 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:c0b1:cb30:1baf:4666? ([2601:646:c200:1ef2:c0b1:cb30:1baf:4666])
        by smtp.gmail.com with ESMTPSA id v11sm9988434pgg.68.2021.03.26.14.21.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 14:21:06 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: Why does glibc use AVX-512?
Date:   Fri, 26 Mar 2021 14:21:05 -0700
Message-Id: <C624A1B5-45EE-491C-B43B-5605D48273E9@amacapital.net>
References: <87pmzlboxj.fsf@mid.deneb.enyo.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "H. J. Lu" <hjl.tools@gmail.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Carlos O'Donell <carlos@redhat.com>,
        Rich Felker <dalias@libc.org>,
        libc-alpha <libc-alpha@sourceware.org>
In-Reply-To: <87pmzlboxj.fsf@mid.deneb.enyo.de>
To:     Florian Weimer <fw@deneb.enyo.de>
X-Mailer: iPhone Mail (18D61)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 26, 2021, at 2:11 PM, Florian Weimer <fw@deneb.enyo.de> wrote:
>=20
> =EF=BB=BF* Andy Lutomirski:
>=20
>>> On Fri, Mar 26, 2021 at 1:35 PM Florian Weimer <fw@deneb.enyo.de> wrote:=

>>>=20
>>> I mean the immense slowdown you get if you use %xmm registers after
> their %ymm counterparts (doesn't have to be %zmm, that issue is
> present starting with AVX) and you have not issued VZEROALL or
> VZEROUPPER between the two uses.

It turns out that it=E2=80=99s not necessary to access the registers in ques=
tion to trigger this behavior. You just need to make the CPU think it should=
 penalize you. For example, LDMXCSR appears to be a legacy SSE insn for this=
 purpose, and VLDMXCSR is an AVX insn for this purpose. I wouldn=E2=80=99t t=
rust that using ymm9 would avoid the penalty just because common sense says i=
t should.

>> What kind of system has that problem?
>=20
> It's a standard laptop after a suspend/resume cycle.  It's either a
> kernel or firmware bug.

What kernel version?  I think fixing the kernel makes more sense than fixing=
 glibc.

