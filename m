Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6698E451D4C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243745AbhKPA1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:27:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:35740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344231AbhKOUCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 15:02:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0448D61B53;
        Mon, 15 Nov 2021 19:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637006378;
        bh=e+qTl3GVa+R8yCMOOe5nLNrSRW3yOgeypx4VapamJaw=;
        h=Date:From:To:Cc:Subject:From;
        b=E0kjXBZ2D3nEypeV+7+u2PUt4hh65LNxkADWjsAI2QEfZaqdL2jHmltUHz2oMgAKj
         PcSXdH5SXvR6WEyuwhHDD63h0gHOUmHELll07AywchikUD3zCEo+/au1jcqK4mdMpa
         Aoet7TnNs9ra+C79VC5SAF52BfLrHO/LFPncel2SCo8p1u9bqyu8EPpNFXMJm5mjAC
         1vBwVBhoIZBQ5DR8VmrAUy4GuoiQr5M0WcX0AnSnz2h+ShEaktXjEKX8M3PiUPV+ND
         8lWUE+3cRyIu3xgWvkerwdgBETPW4kBIwAQ0KUtmO/c8AKWw26Iy7yizliXnSN8XEJ
         dufOxsT53TlGg==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0375427C005A;
        Mon, 15 Nov 2021 14:59:37 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute6.internal (MEProxy); Mon, 15 Nov 2021 14:59:37 -0500
X-ME-Sender: <xms:KLySYU3VLoZQfbHngCKr8g5vqWfiuv2fawJsx8PcvOzCBf1mnp15CQ>
    <xme:KLySYfEbhuZGRS-W8HxQCJBTTTIGv8xUq8z-ANL54u2j7iPvC6ySY5tPXvq7R6wLr
    0yBTrnnhuoeE7lH7xA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfedtgddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkfffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhguhicu
    nfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpeehveeglefgjefhffeuheetuefhkeefleeghfetgfeukeeggedtgeekuddv
    fffhhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedukeehieef
    vddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinhhugidrlh
    huthhordhush
X-ME-Proxy: <xmx:KLySYc7DwFsW7Dtl2RR_q-ol6A3r4R_0Lv3rW26TFX4ztctI2fBGiA>
    <xmx:KLySYd3eyaufNQZZOBSaeLvUmjrw3MeLXDzjSGabE2bZtK7_jvMlSA>
    <xmx:KLySYXE2LtkYJM8FZ1z22yrwvont3M2oI6AzM60A42tzXgUQuvdc0Q>
    <xmx:KbySYeBwOCvGVNF52OtNl4i2g3Q-h9V8qUpUigQbKuUCQc8ElARCXV30BBY>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 50B5621E006E; Mon, 15 Nov 2021 14:59:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1371-g2296cc3491-fm-20211109.003-g2296cc34
Mime-Version: 1.0
Message-Id: <0f03a9e2-4611-4b5c-962f-93a7e1d2bde8@www.fastmail.com>
Date:   Mon, 15 Nov 2021 11:59:15 -0800
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Asit K Mallick" <asit.k.mallick@intel.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Brown, Len" <len.brown@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Borislav Petkov" <bp@alien8.de>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "Arjan van de Ven" <arjan@linux.intel.com>
Cc:     "Andrew Cooper" <andrew.cooper3@citrix.com>
Subject: Revisiting XFD-based AMX and heterogenous systems
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[resend -- first try was HTML.  oops.]

Hi all-

I just learned that current Alder Lake review samples are actually heterogenous, at least physically.  The performance cores have AVX-512 and the efficiency cores don't have AVX-512.  Since no OS supports actual runtime ISA heterogeneity, this feature seems to be hidden in that one must choose, per boot, whether one wants AVX-512 or efficiency cores, but the CPU is physically heterogenous.

All the earlier discussions about Linux AMX architecture happened under the assumption that xfeature-heterogenous systems would never happen, and my grudging acceptance of the XFD model was predicated on that.  But now we have obviously heterogenous hardware that is apparently actually shipping at least to reviewers, and I think we should revisit this before we merge AMX support.

The current proposed AMX ABI on Linux has all tasks starting out with the AMX bits set in XCR0.  If the tasks want to actually use AMX, they need to issue a prctl asking for permission and, if they don't issue that prctl, they will take XFD faults and get signalled if they try to use the TILE regs.  If Intel thinks we might ever have software-visible heterogenous system, then this will be very awkward -- all tasks will start with AMX set in XCR0 even if they're on efficiency cores and even they have no intention to ever use AMX.  Once a process asks for AMX permission or perhaps after the first XFD fault, the process will be pinned to performance cores and can use AMX.  Aside from awkwardness, this requires that efficienty cores actually implement enough of AMX to do this.  And keep in mind that Alder Lake is actually heterogenous for AVX-512, and there is no such thing as AVX-512 XFD.

So I suggest that we go back and switch to the XCR0 model.  Tasks will start out with AMX clear in XCR0.  If they want AMX, they issue a prctl asking for AMX, AMX gets set in XCR0, and the tasks need to be able to tolerate the XCR0 change.  Then, if Intel ever wants to expose the full Alder Lake physical capabilities and support efficiency cores and AVX-512 on the same boot, we can have a mode in which tasks start with AVX-512 clear in XCR0 and can opt in with prctl.  This will require HPC-like apps to be recompiled or run with a special wrapper bit will otherwise expose the full HW capabilities. (Of course this assumes that Intel sets up MSRs or ucode or whatever to support this.)

What do you all think?

