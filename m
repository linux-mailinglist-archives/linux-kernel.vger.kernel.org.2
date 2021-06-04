Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4D039BA8F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 16:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhFDOHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 10:07:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53630 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFDOHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 10:07:05 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622815518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C5eIsiJlxyk0DwSBkEKL9HvfeOM1s2obSITu2soWjvk=;
        b=2xrMlxlRf1LYZqq/Lm2bsl8PILtKhK8JLQJH1GtWDRabS0h9O6c6/cMHBIfG7aMttxx8OA
        Q5vM9HOrAGKiShAkXaRjKZv3H4HTvDfQPXohIEafN6xtKSw2qikyd/SF2BJ4IjDe0gpjV4
        2K5gXB66Bdjnan7qmcF08yD95m0XfnBkGr7jYaSypedrFKyx2zgI1Rs7862SafTDyiGNSZ
        MZpyxjtnSCu4GILHd3Zcdtf2o+kIidey2Al2WiROqq9rhZWkmgkuTn6FPPMwBlQUL2Ktln
        n2KN7/mcTc0sEqlvM8hsECFqkEVU3qF5KkPKG+tiAoRW2lysoIqcqDpM19apSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622815518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C5eIsiJlxyk0DwSBkEKL9HvfeOM1s2obSITu2soWjvk=;
        b=RIh0WZnJrQbNk66O/hQDq0oncebDWJ30XMhRBIbHOtQgZ2NFJ8QVk0C2oYy1+LsxnvhCk1
        ARzBfzxSlCGJo5Aw==
To:     "Yu\, Yu-cheng" <yu-cheng.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [patch 0/8] x86/fpu: Mop up XSAVES and related damage
In-Reply-To: <9c5c90bf-fbf6-7e45-4668-2f40f11e8b36@intel.com>
References: <20210602095543.149814064@linutronix.de> <9c5c90bf-fbf6-7e45-4668-2f40f11e8b36@intel.com>
Date:   Fri, 04 Jun 2021 16:05:18 +0200
Message-ID: <87h7idzpwh.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02 2021 at 14:28, Yu-cheng Yu wrote:
> On 6/2/2021 2:55 AM, Thomas Gleixner wrote:
>
> With the series applied, glibc pkey test fails sometimes.  I will try to 
> find out the cause.

That fails not sometimes. It fails always due to patch 7/8. The reason
is that before that patch fpu__clear_all() reinitialized the hardware
which includes writing the initial PKRU value.

But fpu__initialize() does not store the initial PKRU value in the
task's xstate which breaks PKRU. As that patch is not urgent we can
postpone it for not.

But looking at the above, it's not clear to me why that PKRU stuff works
at all (upstream), but I'll figure it out eventually. I'm quite sure
that it does work by pure chance not by design.

Thanks,

        tglx
