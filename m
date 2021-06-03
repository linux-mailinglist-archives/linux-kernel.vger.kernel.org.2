Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1CE39ACD4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 23:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhFCV07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 17:26:59 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41302 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230287AbhFCV05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 17:26:57 -0400
Received: from zn.tnic (p200300ec2f138500c7e12fc0802db454.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:8500:c7e1:2fc0:802d:b454])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 198201EC03D2;
        Thu,  3 Jun 2021 23:25:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622755511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bURlLHBMfj+F4SlyMSuJ2efdSMfQ/sgu0krAwvwf87Y=;
        b=oIWSeLngAcnTKdj473RIQtWk+m1hmvZ1sPqV7RzdNqCvhF3nUDX5zB9w7vSYNv+lVjGN96
        ik6wQjvX7V7PeLXO+LV3Rw7aAeQ5QNpLsm1dlVJTxdbXGHQvLwJlx8fEh6Fm4jt+gkAluK
        yTDA+lyVcbp52LkmLplze2CVRQDOoMw=
Date:   Thu, 3 Jun 2021 23:25:05 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Borislav Petkov <bp@suse.de>,
        kernel test robot <rong.a.chen@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [tip:x86/cpu 4/4] Warning: Kernel ABI header at
 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at
 'arch/x86/include/asm/cpufeatures.h':  111< /* free                                    (
 3*32+29) */
Message-ID: <YLlIsS1brAdNyG4K@zn.tnic>
References: <20210602094153.GH1271937@shao2-debian>
 <YLdTRopUV9OyulSq@zn.tnic>
 <YLelUPtti40D7DUl@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YLelUPtti40D7DUl@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 12:35:44PM -0300, Arnaldo Carvalho de Melo wrote:
> ... 
> will build in older systems where things added to the updated copy of
> the kernel headers isn't present, so trying to update the file and then
> rebuild perf, only warning me if it doesn't build would give me an early
> warning about things that are breaking and that I should look sooner
> rather than later.
> 
> 	Doing just the diff is not that useful :-)

Lemme see if I understand this correctly: you'd like for the 0day folks
to take those perf-*src-pkg builds, put them on an *old* distro and see
if it builds. Am I close?

And do that with the headers in tools/ which do not have the new changes
and see if they still build?

Or?

Alternatively, we can always go back to keeping the headers in sync with
those in tools/ and f'get about it.

Thoughts?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
