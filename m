Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82C5405B0C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 18:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237415AbhIIQmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 12:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbhIIQmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 12:42:23 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AB5C061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 09:41:13 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id y16so5138608ybm.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 09:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rkaCWrw71p3Bwx6Ujv9uVMcrBmBnNtWcMasEZoICUtg=;
        b=dk7XG+iTfUp9mJk61u0tbmxR8do9bhReeJEjxKWTkr7mk6yTeOo7oOAKTzW88D5oFt
         xB3/uaxC9EeaQ6xD311r2INEWMUDkeiAuOB+xS8kTK3BZlL9vZg+qv11MC8fIYro0Y4+
         WfNT0EiCYoxOUvMMnieVkaTDR7VLJRWw+bB15aRVuHemdxOCnanUy2kYvJuB9NIKfh4o
         yda8xdXzMwYTPZic6D+AD0ISZbeH/iymz9UQLkkpW2qaQZb1K7fQEC6ak7TXPknEKug/
         3XeamAAIRYw/SneBt3ifDaLJvdeuAZPpwlrp1gEJMOdbHBkld1bFwMCm5ZjFc+k35XgZ
         1W6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rkaCWrw71p3Bwx6Ujv9uVMcrBmBnNtWcMasEZoICUtg=;
        b=fsRwX95My/khwQ3tEIas4HFGffLJap1O7s73s0MDwzui8xIJa2agUJm+sJgrvX+uNc
         5R/GcJzmQ5fhjf/sWYrk683Jpaq07gYrHnRe9jidRSw7WA1R9PUWipNXpdPSvSimSvbF
         S4p6AHmq7yQ4dsEa2pZhJT640VdUfTxO5R0sH15Er3ezzkBVGihtWYqR6NqSonvmyh8w
         0ZpJErolcHwLnpL0hrLPkYZphbP+MPzPaaxix/B54/oZB/qHmCwwtzibtgsm0JdT6tUg
         WJ6h75kw9QqydnpGS2ra4x1AlWNCi++Fa1HP0FJsM8FUTY4iLa0zGfL8Acp0ToA7a+1q
         cGXg==
X-Gm-Message-State: AOAM53274qc+tYcM3NNIGBGl6jdL8ZKX7+Jv9UPtNEmh6fLObkiQIeIg
        oSdP1RVEUAIZ6IVsZ7RMnDk5+GPU3dzj/2bdSIeesw==
X-Google-Smtp-Source: ABdhPJxOb0z3ulldpbOkQOCns5TrLa7bWBtK5lyZgAwd9CnftUY48Lnurh5DsoueF+EhVX32OlwRpYEDMSkKxKNuJeE=
X-Received: by 2002:a25:8093:: with SMTP id n19mr5184637ybk.414.1631205672615;
 Thu, 09 Sep 2021 09:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210909013818.1191270-1-rananta@google.com> <20210909013818.1191270-19-rananta@google.com>
 <YTmdUEcbvf/7mkOw@google.com>
In-Reply-To: <YTmdUEcbvf/7mkOw@google.com>
From:   Raghavendra Rao Ananta <rananta@google.com>
Date:   Thu, 9 Sep 2021 09:41:00 -0700
Message-ID: <CAJHc60yi8Dk8d67Gd=_UJRz+71vz0LZZC_TrCE5=kqyRTwBKoA@mail.gmail.com>
Subject: Re: [PATCH v4 18/18] KVM: selftests: vgic_init: Pull
 REDIST_REGION_ATTR_ADDR from vgic.h
To:     Oliver Upton <oupton@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 8, 2021 at 10:36 PM Oliver Upton <oupton@google.com> wrote:
>
> On Thu, Sep 09, 2021 at 01:38:18AM +0000, Raghavendra Rao Ananta wrote:
> > Pull the definition of REDIST_REGION_ATTR_ADDR from vgic.h.
> >
> > Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> > ---
> >  tools/testing/selftests/kvm/aarch64/vgic_init.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
>
> Just squash this into the commit where you hoist it into vgic.h. It is
> fine to glob it together with the other vgic changes since you're
> dropping it into a completely new header file.
>
Sure, I'll squash it.

Regards,
Raghavendra
> --
> Thanks,
> Oliver
