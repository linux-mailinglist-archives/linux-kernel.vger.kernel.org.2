Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8754331356B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 15:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbhBHOlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 09:41:49 -0500
Received: from mail.skyhub.de ([5.9.137.197]:56528 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232871AbhBHOUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 09:20:46 -0500
Received: from zn.tnic (p200300ec2f073f00628fe78cdb18e959.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:3f00:628f:e78c:db18:e959])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5DB511EC025A;
        Mon,  8 Feb 2021 15:20:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1612794000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0916GFWjobhpdtl0LxXuwelF3OucqI1KlbA66uCf0Mw=;
        b=Vcz79MheqThN2tbRzYJV3LKmCluIHsnM3xZ4QT0vyOUdmmx08Sg5OKo3FofSqA2oW5aTUy
        RmqoR8mnqjKNdVAv+JLIMf0RhKS6H1xHLPovaLrE+c7hALvTEhzWhwWT2Lz3tj2MT3WY9y
        JvVr1SL0LiiaCCoO2dckVgVyUKzz9sg=
Date:   Mon, 8 Feb 2021 15:19:57 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, kbuild-all@lists.01.org,
        x86@kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [kbuild-all] Re: [patch 06/12] x86/entry: Convert system vectors
 to irq stack macro
Message-ID: <20210208141957.GA18227@zn.tnic>
References: <20210204211154.713523041@linutronix.de>
 <202102051148.WIj5O4Ry-lkp@intel.com>
 <YB1SdvRbHMY7IRrY@hirez.programming.kicks-ass.net>
 <ad03c046-3249-8ac2-96af-03b2312454c0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ad03c046-3249-8ac2-96af-03b2312454c0@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 07, 2021 at 04:15:11PM +0800, Rong Chen wrote:
> Thanks for the advice, we'll add the check to our cluster,
> and sorry for the inconvenience.

When it comes to the tip tree, I'd say you guys are much better off not
scraping any patches from the mailing list but simply testing the tip
branches. That would be more than enough and you already do that anyway.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
