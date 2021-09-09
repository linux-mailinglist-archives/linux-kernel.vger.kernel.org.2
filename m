Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32006405DDD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 22:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245175AbhIIUHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 16:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhIIUHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 16:07:53 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B02C061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 13:06:44 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id v10so6308809ybq.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 13:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tO7FQvr77frYJi3nZmu6+pwHGzzGpRLOFUZlxjTtI1U=;
        b=Oy8ce1O5/wmCpWya7nBN8qiLzyBclFRFa2r5eAlAZU84jaC9rRJqZj+6BkGTdfIpgW
         Xo43sUbTTRgBrpwz5atoMw8WujebQDagPIFYaWoWcjBinCeRRovpaAoErPviwwGktYxP
         2IzfCacZM2oMqC39Ot+/X5X/Dm9DDMIjRuU6S0+QBgx2AmPIUXBsbIFrNplp1T8lCRh8
         yi+d82k1py9m7Zw1jRBRnzaBMTHpxNDk1JlsO3SBLSBfCH36zQGB1BjjhcxRxp10WXKe
         5KDRIbkrpMER8mwxPbVPhljAg1QG2K6yLR41eqOBWjdb0KAOLc1agFTWxfHGFr2zJmrQ
         svJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tO7FQvr77frYJi3nZmu6+pwHGzzGpRLOFUZlxjTtI1U=;
        b=i+NdqcfqQ2nhP6sfkCF6KoOFFI/ieIOMwtNp7nwZEmE/npPrK8V1aiDPmP/4SlTvje
         ifzAZGaqQthhGxga5cNoQlS8e9ZADdej1TywGUVOuH5tVAKP0EnJcdQDyg2SaZYPA2Rv
         P/cniYhCZhgkLnjyHvKkvTGfZxG+ewD+E3GbeXrGgCCvEQVADB75QLC8dtvSJbiLKN8C
         fXE98lX/cct9gYjzjCm9U+OgrSsqmuHnWrrPARAn5Dl46GDAu8DvWKHSP1ZdwGvpWmEJ
         N4sNrwxRV+FuPpEmKXXu7d4vRWeaOOvv9H2q6NFg5N1zKAeynaQ4fJ9tUO/dT77Vz8eT
         VT4Q==
X-Gm-Message-State: AOAM531b2v6uQ70Sw4ZqUEPRWWwl4L19KS4qIXlCNAWDQLrzLJH835X/
        ejaA5AS1lySvErbOu9UU+wv7p/tkKit8lT9eiYQaDg==
X-Google-Smtp-Source: ABdhPJy5AGrEZidGvl3dQRB0sKLB1qGhBQdOWzBR63cYYp97lf+k7MCv+e5P0N+q7y2PLgyyxkEQheVKlXRUYFUqZyY=
X-Received: by 2002:a25:8093:: with SMTP id n19mr6441809ybk.414.1631218003111;
 Thu, 09 Sep 2021 13:06:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210909013818.1191270-1-rananta@google.com> <20210909013818.1191270-3-rananta@google.com>
 <20210909171755.GF5176@sirena.org.uk>
In-Reply-To: <20210909171755.GF5176@sirena.org.uk>
From:   Raghavendra Rao Ananta <rananta@google.com>
Date:   Thu, 9 Sep 2021 13:06:31 -0700
Message-ID: <CAJHc60yJ6621=TezncgsMR+DdYxzXY1oF-QLeARwq8HowH6sVQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/18] KVM: arm64: selftests: Add sysreg.h
To:     Mark Brown <broonie@kernel.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 9, 2021 at 10:18 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Sep 09, 2021 at 01:38:02AM +0000, Raghavendra Rao Ananta wrote:
> > Bring-in the kernel's arch/arm64/include/asm/sysreg.h
> > into selftests to make use of all the standard
> > register definitions in consistence with the kernel.
>
> > Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> > ---
> >  .../selftests/kvm/include/aarch64/sysreg.h    | 1278 +++++++++++++++++
> >  1 file changed, 1278 insertions(+)
> >  create mode 100644 tools/testing/selftests/kvm/include/aarch64/sysreg.h
>
> Can we arrange to copy this at build time rather than having a duplicate
> copy we need to keep in sync?  We have some stuff to do this for uapi
> headers already.

That's a great idea actually (I wasn't aware of it). But, probably
should've mentioned it earlier, I had a hard time compiling the header
as is so I modified it a little bit and made the definitions of
[write|read]_sysreg_s() similar to the ones in kvm-unit-tests.
I'll try my best to get the original format working and try to
implement your idea if it works.

Regards,
Raghavendra
