Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82283342703
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 21:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhCSUgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 16:36:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39434 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbhCSUfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 16:35:51 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616186140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yss2YXw2wGJKESGQdQhkczjLdCge31FEG/iKiin8T0c=;
        b=jpiq+sd5czy5w52Hnt5YAFBCPbITmsxpmtKyE8EH4f6VIWi3ZkAxvNALV/BHNYMvJ+iet8
        gFJEePDy5dZpSLa7whWfFqgivML7xZ0meA1jTQcvuJbo8WdxVyzrD1eEJssaf/glrmvia0
        4wcm5i7UgR/VLpSMmjGz2JvHU60zEcj8uMiFiZIsIwYHLnZwru6Gzvz+ln/pFHl8cJI4OO
        6ZON6zYNcQ1nSl5C0UvTWKhOWy8SmR7pv9xVS3kjb0Sxr3Mg8rD0CJ2qUjnjTON+dOotq8
        yuvM1OpCTNSxBZv2dvSaId26QtImj+Xpzo7kHJ5cOL2brIsKUKym7ctKoy7aZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616186140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yss2YXw2wGJKESGQdQhkczjLdCge31FEG/iKiin8T0c=;
        b=T5ghH2wnsmQPMxuKQV/BZSacXkoZcuCtK4RJBPuKd/NsXxGl9Dehbu76XCz8tFoIMoEIIB
        GgvbF4bCkmRJ3VBw==
To:     Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v5 1/3] x86/cpufeatures: Enumerate #DB for bus lock detection
In-Reply-To: <20210313054910.2503968-2-fenghua.yu@intel.com>
References: <20210313054910.2503968-1-fenghua.yu@intel.com> <20210313054910.2503968-2-fenghua.yu@intel.com>
Date:   Fri, 19 Mar 2021 21:35:39 +0100
Message-ID: <877dm26fvo.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13 2021 at 05:49, Fenghua Yu wrote:
> A bus lock is acquired though either split locked access to

s/though/through/
either a 

> writeback (WB) memory or any locked access to non-WB memory. This is
> typically >1000 cycles slower than an atomic operation within a cache
> line. It also disrupts performance on other cores.
>
> Some CPUs have ability to notify the kernel by an #DB trap after a user

the ability

> instruction acquires a bus lock and is executed. This allows the kernel
> to enforce user application throttling or mitigations. Both breakpoint
> and bus lock can trigger the #DB trap in the same instruction and the
> ordering of handling them is the kernel #DB handler's choice.

Thanks,

        tglx
