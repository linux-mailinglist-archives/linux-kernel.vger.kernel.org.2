Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68A9392D53
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 13:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbhE0L6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 07:58:38 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56776 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234393AbhE0L6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 07:58:35 -0400
Received: from zn.tnic (p200300ec2f0f02008ae29220a5f6f448.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:200:8ae2:9220:a5f6:f448])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 861A71EC01DF;
        Thu, 27 May 2021 13:57:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622116621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SAOBNM/TdWmKVJtnca/J3NIttsNpU6/kPggS1hONNPM=;
        b=GsE0NG9O3hlWuFbsWHM/CwAt4dnpyz2PFFcBKTeq7CqvKMbQeUTY+v1qFEbNpbGTRRdEod
        MWAUBleTu3okjBk+5hSi2XkUrnzX4PEXZbxajJ7k5eyaBXrAusPeZ71pAeYeNkGk5xw5O9
        mrjU1eBI12dis2KgeEhc8QCVJL3SyyE=
Date:   Thu, 27 May 2021 13:56:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     James Feeney <james@nurealm.net>, linux-smp@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        lkml <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        x86-ml <x86@kernel.org>
Subject: Re: [PATCH] x86/thermal: Fix LVT thermal setup for SMI delivery mode
Message-ID: <YK+JC9qjkEuz/aaz@zn.tnic>
References: <YKYqABhSTTUG8cgV@zn.tnic>
 <a264eaef-1c94-77e1-dfbf-e436a41588be@nurealm.net>
 <YKjJfu4kRDflQS5e@zn.tnic>
 <373464e3-b8a0-0fe0-b890-41df0eecf090@nurealm.net>
 <YKqLSqIM7Gi5x+IA@zn.tnic>
 <b550a241-2097-cf4b-cc41-e4d0a45cda72@nurealm.net>
 <YKtbBXZGpVZS1M4R@zn.tnic>
 <1f6c70f4-6680-d6ea-465a-548dc7698317@nurealm.net>
 <YK905sC/2cVOYo6I@zn.tnic>
 <87h7io8kh5.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h7io8kh5.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 01:49:42PM +0200, Thomas Gleixner wrote:
> That works, but TBH, it's a hack....

Yeah, it restores to the previous behavior.

> What I really fail to understand is how disabling that LVT entry makes
> the machine lock up.

The observation is is that on James' box, *sometimes* - not always - it
would softlockup on CPU0 without this early LVT thermal read.

I can try to reproduce on the box I have here, lemme see...

> Also if disabling this entry is causing the BIOS/SMM gunk to go south, then
> disabling CONFIG_X86_THERMAL_VECTOR should have the same effect.
> 
> Which made me look at other places like lapic_suspend/resume which does
> the save/restore Kconfig conditional as well.

The fact that it doesn't reproduce always shows that there's something
else at play too. As I said in the commit message: "Those soft lockups
are not 100% reproducible and the reason for that can only be speculated
as no one tells you what SMM does."

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
