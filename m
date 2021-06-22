Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810D33B100C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 00:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhFVW2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 18:28:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:6790 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229675AbhFVW17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 18:27:59 -0400
IronPort-SDR: f+izIeQpL8OuwTuCm9cvdXfVWROcweaBnWrx281vBahzaRfTzaUmVvkrdzsoyBkLrw+jNy+jFP
 sijNtUe8HiiQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="268292463"
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="268292463"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 15:25:41 -0700
IronPort-SDR: 9Vo/oWFEeuu5HZhoFInXkcDeivD8e9SylwhJZyH+7PDnYEmPFYOWmcaX3QBwlEowsZEAF5cB7h
 Az3yixY2F1YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="473922775"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga004.fm.intel.com with ESMTP; 22 Jun 2021 15:25:40 -0700
Subject: [RFC][PATCH 0/8] x86/pkeys: remove PKRU from kernel XSAVE buffer
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, luto@kernel.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Tue, 22 Jun 2021 15:24:55 -0700
Message-Id: <20210622222455.E901B5AC@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a rework of the kernel's Protection Keys Register code.  It severs
the connection between PKRU and XSAVE as thoroughly as possible without
affecting the existing ABIs.

This compiles in a few configurations and passes the pkeys selftest, but
that's about it.  It's not been pummeled enough yet for merging anywhere.

This is on top of the current:

	git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/fpu

specifically:

	3d168301c78d ("x86/fpu/signal: Let xrstor handle the features to init")

--

PKRU is currently a strange beast.  It can be XSAVE-managed and it has
space allocated in the thread 'fpstate' buffer.  However, it is
switched more eagerly than other FPU state because PKRU affects things
like copy_to/from_user().  This is because PKRU affects user *PERMISSION*
accesses, not just accesses made from user *MODE* itself.

This leaves PKRU in a very odd position.  It is stored in the kernel
XSAVE buffer but the XSAVE architecture is not used to manage it.

Move PKRU out of the 'fpstate' buffer.  Instead, allocate space in the
thread_struct for it and save/restore it in the context-switch path
separately from the XSAVE-managed features.  This removes the ambiguity
of having PKRU state in two places for each task.

 include/asm/fpu/internal.h |    2 -
 include/asm/fpu/xstate.h   |    2 -
 include/asm/pkru.h         |   10 +++--
 kernel/cpu/common.c        |   19 +++++++++-
 kernel/fpu/core.c          |    8 ++--
 kernel/fpu/signal.c        |   12 +++++-
 kernel/fpu/xstate.c        |   83 ++++++++++++++++++++++++++++++---------------
 kernel/process_64.c        |    9 ++--
 kernel/signal.c            |    1 
 kvm/x86.c                  |    8 ++--
 mm/pkeys.c                 |   21 ++---------
 11 files changed, 113 insertions(+), 62 deletions(-)

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
