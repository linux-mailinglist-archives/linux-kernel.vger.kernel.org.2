Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA203DF716
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 23:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhHCVtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 17:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhHCVtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 17:49:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EC8C061757;
        Tue,  3 Aug 2021 14:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=nylKBfKJ8dD/OzgOpJIt5TOaQTcYQ2HiRYJZ04qvB98=; b=hsy43JUcZIEkkkUKqn6G2ORK03
        tu6pZY5Ykzu+SYrijRhwM+jh5XseO4CzfreS7DCkaMcv37zxNUlb9OoQTUkhTdDiVdz2eXE1FoHMp
        UMu8oQUvQI+1IVtgW97/TppC25OsPAjBMZF9T1GcQDYxj9vweAIdUzYv/pnZVtIxiFpUZ4K0kDxq9
        hgh9qkaDRkbRDul/D0lgP+A0rq6UD0mkxzP8JnrL433cBghHAhkpk+02fQ+UbgB5we7H/rEoYyJ/L
        xODuGdgyEwUEY3/tY+BEqgXdAAqRginZ/y6cN0GaBHvOrS00wHHC+TC3FrqkNt+dIwVeWUfq+uJ8X
        Yry0BY4Q==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mB2Hi-005YGP-Sd; Tue, 03 Aug 2021 21:49:15 +0000
Subject: Re: [PATCH 0/9] Kconfig symbol clean-up on ./arch/x86/
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Lubomir Rintel <lkundrak@v3.sk>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee.jones@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        platform-driver-x86@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210803113531.30720-1-lukas.bulwahn@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d693d351-7c93-693f-4bf5-3ccd5db46e60@infradead.org>
Date:   Tue, 3 Aug 2021 14:49:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210803113531.30720-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/21 4:35 AM, Lukas Bulwahn wrote:
> Dear x86 maintainers,
> 
> 
> Randy Dunlap pointed out that ./scripts/checkkconfigsymbols.py warns on
> invalid references to Kconfig symbols (often, minor typos, name confusions
> or outdated references): see Link below.
> 
> This is a first patch series addressing the issues reported by
> ./scripts/checkkconfigsymbols.py in the ./arch/x86/ directories, quickly
> filtered down with:
> 
>    ./scripts/checkkconfigsymbols.py | grep "arch/x86" -B 1 -A 2
> 
> It addresses some issues I considered to be "true positives";
> so, issues that should be addressed and cleaned up.
> 
...

for the series:
Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.


> 
> Lukas Bulwahn (9):
>    x86/entry: correct reference to intended CONFIG_64_BIT
>    x86, olpc: correct condition to intended CONFIG_OLPC_XO15_SCI
>    x86/Kconfig: correct reference to MWINCHIP3D
>    x86/Kconfig: remove reference to obsolete MFD_INTEL_MSIC config
>    x86/Kconfig: remove reference to obsolete APB_TIMER config
>    x86/irq: fix slightly wrong reference in comment
>    x86/uaccess: adjust comment for endif of CONFIG_CC_HAS_ASM_GOTO_OUTPUT
>    x86: page_32.h: adjust comment for endif of CONFIG_X86_USE_3DNOW
>    x86: ia32.h: adjust comment for endif of CONFIG_IA32_EMULATION
> 
>   arch/x86/Kconfig                    | 4 +---
>   arch/x86/include/asm/entry-common.h | 2 +-
>   arch/x86/include/asm/ia32.h         | 2 +-
>   arch/x86/include/asm/irq_stack.h    | 2 +-
>   arch/x86/include/asm/page_32.h      | 2 +-
>   arch/x86/include/asm/uaccess.h      | 2 +-
>   arch/x86/platform/olpc/olpc.c       | 2 +-
>   7 files changed, 7 insertions(+), 9 deletions(-)
> 


-- 
~Randy

