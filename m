Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A1D40A906
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 10:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbhINITZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 04:19:25 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52130 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229661AbhINITN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 04:19:13 -0400
Received: from zn.tnic (p200300ec2f1048004bf380b26d2cf776.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:4800:4bf3:80b2:6d2c:f776])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CB68D1EC0464;
        Tue, 14 Sep 2021 10:17:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631607468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=eMT4q2YHM8DSMwfGYTfM+wuFb+6GqN7tGcTDXZ4NOWM=;
        b=Q2JKvRNbYt6VyNdwlhzXAFZj/4Xd8d7rnlsk9wKhrFwAEJpchLbnzDKP6tVXzSJm46NPFp
        4qEO1GmFMrVcKsXtyfPolb1SwsOh82NW6wP1gp+FNgh2Xut2yMDEMZGg9XilQdsa32lW4G
        1RewJM0tOKV169GEuJGvh3Jp80qZn7I=
Date:   Tue, 14 Sep 2021 10:17:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH 25/24] x86/traps: Rewrite native_load_gs_index in C code
Message-ID: <YUBalsPFstzwKT0b@zn.tnic>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
 <20210902105052.2842-1-jiangshanlai@gmail.com>
 <bfeb0b12-5b95-46c9-8ea3-6a4a5bf59076@www.fastmail.com>
 <4ecf191a-6642-6d59-cf10-6fe51e261b28@linux.alibaba.com>
 <YUBZ3J4Jy3x0VDkX@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUBZ3J4Jy3x0VDkX@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 10:14:20AM +0200, Peter Zijlstra wrote:
> I really do think you've got some very good things here. Please work on
> it. I will try and review :-)

IOW, what he's saying is, you should handle your patchset the usual way.
And if you're unsure how, feel free to skim over:

Documentation/process/submitting-patches.rst

it is all explained there. :-)

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
