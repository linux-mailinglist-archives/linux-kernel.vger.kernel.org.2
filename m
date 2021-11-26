Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8871345ECCE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 12:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347713AbhKZLnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 06:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344575AbhKZLla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 06:41:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC408C0619EB
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 03:03:03 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637924581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g4btdXn6LCRAN615sbfvmy4KHaxdnAQkd+iKSwrlwvo=;
        b=CirGF0lR9c+ZnkqzgiLiS/rhoR3NJVYyvCNXk6cOsd92JMu3OPQAIyDf7M6U0bYoI12qjo
        RIK4vELWm+OcdAOd5bAnszkMhNU+zCU8hugZCGkraktNyDlneBMWKL2FKGty74V4XShDgA
        qKTxV5ZGhPmFJ1fVMGIFvUG5YNJUOKpNamajvTmiOFpYKDQO/6XeoU45hwHgNtZtX/6x/J
        SFIzuRWWgOeDDF7sz2nxiRNeIRbIfEK/2UeNzkAOvimmuZe+6cW7YFSvfQ1UiULlgIymtc
        sZ2+1PgmliPJSPQhhWoLSg/UkrAY7oKSF4j8jWut3oDVel212OkvzvNVhuHTNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637924581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g4btdXn6LCRAN615sbfvmy4KHaxdnAQkd+iKSwrlwvo=;
        b=HHWyui7ciCWdpgjGKLwWJUFL0e52YgYQOd4ClF84HmbCDkKNguSV9k+NvMMbGI+Fx+NkLJ
        3SJldidIVzzsgTDg==
To:     ira.weiny@intel.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-mm@kvack.org
Subject: Re: [PATCH V7 05/18] x86/pks: Add PKS setup code
In-Reply-To: <87ilwgl10a.ffs@tglx>
References: <20210804043231.2655537-1-ira.weiny@intel.com>
 <20210804043231.2655537-6-ira.weiny@intel.com> <87ilwgl10a.ffs@tglx>
Date:   Fri, 26 Nov 2021 12:03:01 +0100
Message-ID: <87o867gowq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25 2021 at 16:15, Thomas Gleixner wrote:
> On Tue, Aug 03 2021 at 21:32, ira weiny wrote:
> Aside of that, the function which set's up the init value is really
> bogus. As you explained in the cover letter a kernel user has to:
>
>    1) Claim an index in the enum
>    2) Add a default value to the array in that function
>
> Seriously? How is that any better than doing:
>
> #define PKS_KEY0_DEFAULT	PKR_RW_ENABLE
> #define PKS_KEY1_DEFAULT	PKR_ACCESS_DISABLE
> ...
> #define PKS_KEY15_DEFAULT	PKR_ACCESS_DISABLE
>
> and let the compiler construct pkrs_init_value?
>
> TBH, it's not and this function has to be ripped out in case that you
> need a dynamic allocation of keys some day. So what is this buying us
> aside of horrible to read and utterly pointless code?

And as Taoyi confirmed its broken.

It surely takes a reviewer to spot that and an external engineer to run
rdmsr -a to validate that this is not working as expected, right?

Sigh...
