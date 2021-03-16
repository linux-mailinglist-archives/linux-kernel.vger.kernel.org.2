Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257E333CFD6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 09:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbhCPI13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 04:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234784AbhCPI1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 04:27:11 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E49C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 01:27:11 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0a1000e85ec692d6311902.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:1000:e85e:c692:d631:1902])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DC92D1EC0253;
        Tue, 16 Mar 2021 09:27:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1615883230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nM+iF1guv/PSwIVXcDDo0A/XUPIZEJsXfp+MFPvrb2E=;
        b=Nik1xsG2tymTxLllckPTOOoaKkUsB6OLKhIOw/A7X6uF92Z2KHozFe8Ppq/WEqx2gEl+Tm
        14J8pHJLmjPSphijxABO+kluB5L9U19uglwPQLU0VZLNISP5j3WTUZJXYq+K31xwoiE3lt
        NXQ6gr8JQWhs0F/ylJCtD+2OhuO32go=
Date:   Tue, 16 Mar 2021 09:27:03 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [tip:x86/cpu 2/3] arch/x86/kernel/alternative.c:96:10: warning:
 Undefined behaviour, pointer arithmetic 'x86nops+10' is out of bounds.
Message-ID: <20210316082703.GA18003@zn.tnic>
References: <202103160701.3uXlWiWM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202103160701.3uXlWiWM-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yet another useless report!

On Tue, Mar 16, 2021 at 07:50:10AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
> head:   301cddc21a157a3072d789a3097857202e550a24
> commit: a89dfde3dc3c2dbf56910af75e2d8b11ec5308f6 [2/3] x86: Remove dynamic NOP selection
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

What's cppcheck?

That?

Description-en: tool for static C/C++ code analysis (CLI)
 Cppcheck is a command-line tool that tries to detect bugs that your


> >> arch/x86/kernel/alternative.c:96:10: warning: Undefined behaviour, pointer arithmetic 'x86nops+10' is out of bounds. [pointerOutOfBounds]
>     x86nops + 1 + 2 + 3 + 4,
>             ^
>    arch/x86/kernel/alternative.c:97:10: warning: Undefined behaviour, pointer arithmetic 'x86nops+15' is out of bounds. [pointerOutOfBounds]
>     x86nops + 1 + 2 + 3 + 4 + 5,
>             ^
>    arch/x86/kernel/alternative.c:98:10: warning: Undefined behaviour, pointer arithmetic 'x86nops+21' is out of bounds. [pointerOutOfBounds]
>     x86nops + 1 + 2 + 3 + 4 + 5 + 6,
>             ^
>    arch/x86/kernel/alternative.c:99:10: warning: Undefined behaviour, pointer arithmetic 'x86nops+28' is out of bounds. [pointerOutOfBounds]
>     x86nops + 1 + 2 + 3 + 4 + 5 + 6 + 7,
>             ^
> >> arch/x86/kernel/ftrace.c:304:7: warning: union member 'ftrace_op_code_union::code' is never used. [unusedStructMember]
>     char code[OP_REF_SIZE];
>          ^

How do you trigger this?

/me ignores it until there's some info on how those things can be
reproduced.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
