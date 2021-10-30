Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1725F440BAA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 23:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhJ3VHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 17:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhJ3VHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 17:07:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD25AC061570
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 14:04:30 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635627868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kYHRUaGb+rhXTEMfmnyryqTuicwbjsEvds4MSkhqu/I=;
        b=AK4bvcUdadzoGlSMXgtkVdYE7KVQTzuTzvmZIu2r5HW7L1rUAKq2CUvUQG0kewX2BKiOZy
        ARbWM6BWPh/ikUpPInB+qDJ3rtkcShbCWFH4+O7UNUINhMpwgxwhEyOlFCN5zLlYKYN/Ey
        l/apEuf6ncm3aJjo2DUtHZg+3g91lfVdWEVkFJKWv0iKfPb+sH3qGXPgepRuRBxJ9It3kY
        xPPg2y/lOZyCUBTl9JUbnWx2bEBeL2BO+fWzeTX6cUQbiitnqDvMxR4aiZMEqLVD+OHisu
        SM2Bht99tsm4QM4KjooGcSCvJis9romc/ORXoU1L03nliX0pJ97fBx3qHNPK9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635627868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kYHRUaGb+rhXTEMfmnyryqTuicwbjsEvds4MSkhqu/I=;
        b=HVqGgSJQgXkQHQ5vHYkht6AH5go1Q3oyYRyyJwMrAkguYPsXjmpohwm8OacGZjJgthC3Sb
        2B1VMGhMSe+L1hAQ==
To:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/x86/iopl: Adjust to the faked iopl CLI/STI usage
In-Reply-To: <20211030083939.13073-1-bp@alien8.de>
References: <20211030083939.13073-1-bp@alien8.de>
Date:   Sat, 30 Oct 2021 23:04:27 +0200
Message-ID: <87a6iqfcmc.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30 2021 at 10:39, Borislav Petkov wrote:

> From: Borislav Petkov <bp@suse.de>
>
> Commit in Fixes changed the iopl emulation to not #GP on CLI and STI
> because it would break some insane luserspace tools which would toggle
> interrupts.
>
> The corresponding selftest would rely on the fact that executing CLI/STI
> would trigger a #GP and thus detect it this way but since that #GP is
> not happening anymore, the detection is now wrong too.
>
> Extend the test to actually look at the IF flag and whether executing
> those insns had any effect on it. The STI detection needs to have the
> fact that interrupts were previously disabled, passed in so do that from
> the previous CLI test, i.e., STI test needs to follow a previous CLI one
> for it to make sense.
>
> Fixes: b968e84b509d ("x86/iopl: Fake iopl(3) CLI/STI usage")
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Borislav Petkov <bp@suse.de>

Acked-by: Thomas Gleixner <tglx@linutronix.de>

