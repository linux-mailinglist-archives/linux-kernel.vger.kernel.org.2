Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E0D30AABD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 16:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhBAPOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 10:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbhBAPB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 10:01:29 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AE8C06178A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 07:01:18 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id q2so4468024edi.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 07:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hZ3xD2/2lcYcAhtu708AbjR6mIFxqFO7i7RlxJAZ5ZU=;
        b=vgNYmiNTNpQzx2jV86jycjLWMXZ6nJ4tSwFTGE5x9SuV+VLEyH6rZomNo5oqBVo48Z
         DsUNK+cQyv8QkSJJyXCZV4tv7cR0lGYCjwpm+TwjNSzGMAIRQxs9GEmw8ufWoEShxBYa
         GurBr5HHFFkdq90UWzoaiYGIUkN3QyDzID/0qAL8SuJUtIPCsK6PqLwuBRW7lZ+fqOpE
         JjjRgi3SE94pzzb3u1PKCrV1lkLEtli/cajzD6YV9W7lzHADaLkPi5/ewt2oaZw4uKdu
         tgk1m8Lrv1Qvlu+q7sAxQ2juiqAdpdQe2746+17+ZmPEo8rXHJ5J2rZ6cKbFzR+uOsZh
         Rltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hZ3xD2/2lcYcAhtu708AbjR6mIFxqFO7i7RlxJAZ5ZU=;
        b=P/deG/nGIk5WS66MU+RXJ3OCyqstaOQZo4rVCJorgr9RkhsahcLmpll5yWI2yDdutI
         BbiuoKQG+hul03UIwLyBBg68EfCWxkDEbXA6WhKfHKK/GoXd7rqpuSwEwrImq65Vi6zH
         WZd8LePIOj+1eGz1DPpep2PtRMnfouLFxhj7UrBMgbZK3kGOYdzTpnFhOkihpw30Rpz6
         RFkRczdnvBbQWUl9vUAuv/y5YLDQ0kcucwDODfyJPSOlZXB3tCeM6E8bINoNHm2SiLzS
         4JHRePbtUa4xTFuP36re2fGtss242tY8C6TuRB10z+9zX/yh1uyV40iJwmY/2dq5sN0K
         BWMA==
X-Gm-Message-State: AOAM530Lk6inc9eYnD7b31Fx9fz1iZ16QPRQqi8367JokZwvoFIBg0Yg
        O6yigs/dXAcS8NN6josF6Jyc8hAWWL12jxyN+AO0UA==
X-Google-Smtp-Source: ABdhPJyUKDJgotj2iV/EZDBBDNQh6SKgJOObpqGbdfNKm6jwpeZr7z46WvIqVVcQo2wc5dGjzyguHOPwSCGKOdVqhQ8=
X-Received: by 2002:a05:6402:26c9:: with SMTP id x9mr19192479edd.365.1612191676837;
 Mon, 01 Feb 2021 07:01:16 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYvzh5GEssPJHM=r2TVUKOhsFJ8jqrY+pP4t7+jF8ctz9A@mail.gmail.com>
 <5f072f84c7c9b03ded810e56687935b2@kernel.org>
In-Reply-To: <5f072f84c7c9b03ded810e56687935b2@kernel.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 1 Feb 2021 20:31:05 +0530
Message-ID: <CA+G9fYs4u=E+jMxTds8A-gYWchC4OSdx26cCw7079+w3_bUiZQ@mail.gmail.com>
Subject: Re: arm64: gen-hyprel.c:40:10: fatal error: generated/autoconf.h: No
 such file or directory
To:     Marc Zyngier <maz@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>, lkft-triage@lists.linaro.org,
        kvmarm@lists.cs.columbia.edu,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        James Morse <james.morse@arm.com>,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Feb 2021 at 19:15, Marc Zyngier <maz@kernel.org> wrote:
>
> On 2021-02-01 13:38, Naresh Kamboju wrote:
> > Linux next 20210201 tag arm64 builds failed.
> > kernel config attached to this email.
> >
> > BAD:    next-20210201
> > GOOD: next-20210129
> >
> > make --silent --keep-going --jobs=8
> > O=/home/tuxbuild/.cache/tuxmake/builds/1/tmp ARCH=arm64
> > CROSS_COMPILE=aarch64-linux-gnu- 'CC=sccache aarch64-linux-gnu-gcc'
> > 'HOSTCC=sccache gcc'
> > arch/arm64/kvm/hyp/nvhe/gen-hyprel.c:40:10: fatal error:
> > generated/autoconf.h: No such file or directory
> >    40 | #include <generated/autoconf.h>
> >       |          ^~~~~~~~~~~~~~~~~~~~~~
> > compilation terminated.
> >
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>
> Could you please check with the fix suggested at [1]?

Here is the change I have applied and the arm64 builds successful now.

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 09d04dd50eb8..ed10fcf1b345 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -7,7 +7,7 @@ asflags-y := -D__KVM_NVHE_HYPERVISOR__
 ccflags-y := -D__KVM_NVHE_HYPERVISOR__

 hostprogs := gen-hyprel
-HOST_EXTRACFLAGS += -I$(srctree)/include
+HOST_EXTRACFLAGS += -I$(objtree)/include

 obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o \
         hyp-main.o hyp-smp.o psci-relay.o


> [1] https://lore.kernel.org/r/20210201104251.5foc64qq3ewgnhuz@google.com


- Naresh
