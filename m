Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5443F32C186
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350689AbhCCTGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 14:06:34 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50394 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239663AbhCCSj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 13:39:28 -0500
Received: from zn.tnic (p200300ec2f086d00c42804c7137f86b4.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:6d00:c428:4c7:137f:86b4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CCBF61EC03EA;
        Wed,  3 Mar 2021 19:38:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614796710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=g2TK9il/mPmdUOfRXJuApFscWhYfoxDG/y4lpE2NquI=;
        b=kTqMkzuzKiHqmKiP5VwxqdpSeveegkpfyjhI61iKE1hM/7JI054S+Q0+lhwX9Svatzl5n0
        X8BpYd7WIv9tmdIGom9cVM+D4d72eL4PBGNIFCv2nWPwUN5/srkEncIVVZR0K2SJOkErfo
        bH38QcVQ4xoDzkBqoE/vQ+c7Bhj6t6c=
Date:   Wed, 3 Mar 2021 19:38:30 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Cleanup and fixups for vmemmap handling
Message-ID: <20210303183830.GH22305@zn.tnic>
References: <20210301083230.30924-1-osalvador@suse.de>
 <20210302160935.eb91809c253d1caa7d0e896d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210302160935.eb91809c253d1caa7d0e896d@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 04:09:35PM -0800, Andrew Morton wrote:
> >  arch/x86/mm/init_64.c | 189 +++++++++++++++++++++++++++++++-------------------
> 
> Perhaps a better route would be via an x86 tree.

I assumed you took mm stuff, even if arch-specific. I can still take
them through tip if you prefer...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
