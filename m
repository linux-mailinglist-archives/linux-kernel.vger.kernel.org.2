Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A73A3574C2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 21:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355550AbhDGTDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 15:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355544AbhDGTDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 15:03:40 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB1EC061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 12:03:30 -0700 (PDT)
Received: from zn.tnic (p200300ec2f08fb0068bab63ea534f357.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:fb00:68ba:b63e:a534:f357])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1A0E11EC027D;
        Wed,  7 Apr 2021 21:03:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1617822208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JUOYRsoSNtxMpZveLJ6dY4PyEUlazbU0SkSDty5Zntg=;
        b=SX+Ta7aY7OoQKmk+/6iAH5iiPBmVuHU5k5NQf0B27AX5iXwtcFXHbOn96kakmdXydwk+JZ
        i4GelD6ZGHPtUD+5dLGv6YrayKCV/lusYTyu/E7hKNWr7xv0uwlQB+SkND8njXqaWJWIbl
        6PF6qk1+Kr69fXl9znMbSQIfba3GXyw=
Date:   Wed, 7 Apr 2021 21:03:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Yang Li <yang.lee@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH] x86/kernel: remove unneeded dead-store initialization
Message-ID: <20210407190328.GM25319@zn.tnic>
References: <1617177624-24670-1-git-send-email-yang.lee@linux.alibaba.com>
 <20210407120239.GD25319@zn.tnic>
 <CAKwvOdnuKazNhqXAM9Qj7DgCW=PqVHkyyfYWytmkyBzv0QeYsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdnuKazNhqXAM9Qj7DgCW=PqVHkyyfYWytmkyBzv0QeYsw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 10:41:26AM -0700, Nick Desaulniers wrote:
> You do have clang-tidy installed right? `which clang-tidy`?

Yah, installed that and was able to repro:

arch/x86/kernel/cpu/cacheinfo.c:880:24: warning: Value stored to 'this_cpu_ci' during its initialization is never read [clang-analyzer-deadcode.DeadStores]
        struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
arch/x86/kernel/cpu/cacheinfo.c:880:24: note: Value stored to 'this_cpu_ci' during its initialization is never read

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
