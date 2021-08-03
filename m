Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C173DEB2F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 12:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbhHCKoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 06:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235442AbhHCKoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 06:44:20 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A312C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 03:44:08 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id o20so27604894oiw.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 03:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yaNx5vDzglyO/0OfjHwfgJ9vhfDLVyx661pK/MAUsA8=;
        b=dVh6ktfKl/CmGwenXxBiuBj7rQKh2aljyeA1exgKoGSGKNgNYgcjYdawdaDKHH8nzn
         /BQL/xwjCvvlTq7RvVWJnDnlIVV/aZr4pzV3RLA9NNynINGSSKLWu6uARzGcwM3coHR8
         Varoz0BHPMjUE80DcbiIsdcwPxx1SMgyWTYpagPD/PJZAyQGJt0zEz3y3EiIkg/el/ES
         oaCCFlt4a4J+tNoj6nFdSnwvLkeB/OAhLAhy7O4WdZn6S7DTXExr0zVWdaaB3hCP7pBW
         v5Yi/QTAA6jM5SPjTcOnBBlfX2vUWu1YZTjOOooTLlLd24h7plROwT2vsyroHVMAvuCo
         MzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yaNx5vDzglyO/0OfjHwfgJ9vhfDLVyx661pK/MAUsA8=;
        b=RvOmhVHfKHR09xGN2znknzp86KwCq4DUHnY/vn5t0TnMHTRjEfnOCq8O8cDwqHVRWT
         MPpxDWNKSlsJvEmmC9xKWpiok3wmWE1tu0Wcf4oneI3v5u1VvzEPIx4m/YYwvM6vaY6A
         4NVaX9xmVGqclrdXyPWku7MFZglVxgV0yt751KctBVGvfb6Z698gKTJj4f/kuvNPRJ9C
         FYGad+EOcnICmT9hC0KfD+N4BMdzJKL+sMaLMX0nUctNLW1OYnTssc8pQOahgLv0qBrl
         6BBhLH6Ro0Xy6ycuQ9EWq6CQjKYuhOm1YcSczIasj0zCgBJdC/AO5Y2yZy21IeqkRe3i
         D+YQ==
X-Gm-Message-State: AOAM532Lb9t1SL+YWhsUHUVrsgqFDS3EsnxLB/KP5xmTTvNYqfZPPbCX
        Yu22RlSRBolk6Wg9AmXGElXj63qOtzyewXUmuXOBP65u3ntFB0K1
X-Google-Smtp-Source: ABdhPJwYzCSdWjyi0pYSnKyyrs+IptK4BCpyosUrou0C9GbEJeZ1RjMGqStuxXt0pVyzMJHXXFxwuoId3kQv0IvjGUQ=
X-Received: by 2002:aca:2102:: with SMTP id 2mr2456621oiz.67.1627987447441;
 Tue, 03 Aug 2021 03:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210729132818.4091769-1-qperret@google.com> <20210729132818.4091769-11-qperret@google.com>
 <CA+EHjTxCvqQ=jmBPJ1N6ShBf=f4J5cjT4pt9akfnqNjQUoqzWw@mail.gmail.com> <YQkWuCVkKWJX81en@google.com>
In-Reply-To: <YQkWuCVkKWJX81en@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Tue, 3 Aug 2021 12:43:30 +0200
Message-ID: <CA+EHjTwamSQ+msUUnuCi6c_hw5TzDy-7dSxLxEnGmA4T4uhw_Q@mail.gmail.com>
Subject: Re: [PATCH v3 10/21] KVM: arm64: Enable forcing page-level stage-2 mappings
To:     Quentin Perret <qperret@google.com>
Cc:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        dbrazdil@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

> > > +static bool stage2_block_mapping_allowed(u64 addr, u64 end, u32 level,
> > > +                                        struct stage2_map_data *data)
> > > +{
> > > +       if (data->force_pte && (level < (KVM_PGTABLE_MAX_LEVELS - 1)))
> > > +               return false;
> >
> > I'm not sure I understand why checking the level is necessary. Can
> > there be block mapping at the last possible level?
>
> That's probably just a matter of naming, but this function is in fact
> called at every level, just like kvm_block_mapping_supported() was
> before. And we rely on it returning true at the last level, so I need to
> do that check here.
>
> Maybe renaming this stage2_leaf_mapping_allowed() would clarify?

Yes it would.

Thanks,
/fuad
