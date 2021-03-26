Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C870234B283
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 00:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhCZXNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 19:13:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229986AbhCZXMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 19:12:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E84661A2A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 23:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616800358;
        bh=24pKDfbjgMO5cT0vfldX3nEeWd0DAVSbgu1Cx1/p6+c=;
        h=From:Date:Subject:To:From;
        b=nmJCEwg3z7vwEKwXCg+382LcBoOge1tCbAyZOF0O5vqNS9m+ctxDm9mV1CwHhPR6f
         khUA76Xb9FO+wVPjhsNeMexMy5HKAA6+wenhy/H/VpZTRbJTNCqH2a5UX9FhPg6nrf
         GwtA28uOGitHOr6EQOri7RIURqrMoOw1m+6pIAPCVd286ItOfNDm39MxyjGevbcqHA
         aVv1H4aUPdaSYhJBtfYytY6oNnHgAEN1cYXtMZAb0WqieuEtcUr2yih05LE56intAf
         Ot5piD+MUwuLJoM8Bz5x7BfB70jKim3/KK5AI2IQ8Wj4tyAjI1ORLyv1yiP6NXjPe1
         MQsG21q4l82xA==
Received: by mail-ed1-f45.google.com with SMTP id y6so8092698eds.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 16:12:37 -0700 (PDT)
X-Gm-Message-State: AOAM531aBoep+v94ZS7ZXs029i2RPfpxVDFalxdavYj0W8RinpOhavg/
        XebdpJ/ikb/fkVfDGu/gytjyhSEfSR4F+aIOl0ETjA==
X-Google-Smtp-Source: ABdhPJyJHhr3Jeg/rskbL19tHEX1mN80b9QAR/1FBTRRwNpcItd4rIVGCIhhNN6fjGOUHstbVG8DnDdsj9GaEzSpMFY=
X-Received: by 2002:a50:fa92:: with SMTP id w18mr17525282edr.172.1616800356579;
 Fri, 26 Mar 2021 16:12:36 -0700 (PDT)
MIME-Version: 1.0
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 26 Mar 2021 16:12:25 -0700
X-Gmail-Original-Message-ID: <CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ@mail.gmail.com>
Message-ID: <CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ@mail.gmail.com>
Subject: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-abi@vger.kernel.org,
        libc-alpha <libc-alpha@sourceware.org>,
        Florian Weimer <fweimer@redhat.com>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all-

After some discussion on IRC, I have a proposal for a Linux ABI for
using Intel AMX and other similar features.  It works like this:

First, we make XCR0 dynamic.  This looks a lot like Keno's patch but
with a different API, outlined below.  Different tasks can have
different XCR0 values.  The default XCR0 for new tasks does not
include big features like AMX.  XMM and YMM are still there.  The AVX2
states are debatable -- see below.

To detect features and control XCR0, we add some new arch_prctls:

arch_prctl(ARCH_GET_XCR0_SUPPORT, 0, ...);

returns the set of XCR0 bits supported on the current kernel.

arch_prctl(ARCH_GET_XCR0_LAZY_SUPPORT, 0, ...);

returns 0.  See below.

arch_prctl(ARCH_SET_XCR0, xcr0, lazy_states, sigsave_states,
sigclear_states, 0);

Sets xcr0.  All states are preallocated except that states in
lazy_states may be unallocated in the kernel until used.  (Not
supported at all in v1.  lazy_states & ~xcr0 != 0 is illegal.)  States
in sigsave_states are saved in the signal frame.  States in
sigclear_states are reset to the init state on signal delivery.
States in sigsave_states are restored by sigreturn, and states not in
sigsave_states are left alone by sigreturn.

Optionally we do not support PKRU at all in XCR0 -- it doesn't make
that much sense as an XSAVE feature, and I'm not convinced that trying
to correctly context switch XINUSE[PKRU] is worthwhile.  I doubt we
get it right today.

Optionally we come up with a new format for new features in the signal
frame, since the current format is showing its age.  Taking 8kB for a
signal with AMX is one thing.  Taking another 8kB for a nested signal
if AMX is not in use is worse.

Optionally we make AVX-512 also default off, which fixes what is
arguably a serious ABI break with AVX-512: lots of programs, following
POSIX (!), seem to think that they know much much space to allocate
for sigaltstack().   AVX-512 is too big.

Thoughts?

--Andy
