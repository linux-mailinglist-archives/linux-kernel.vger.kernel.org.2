Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3CAF3FF4D0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 22:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345935AbhIBUWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 16:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbhIBUV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 16:21:57 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A51C061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 13:20:57 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id y6so5865653lje.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 13:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hreAElmr17ZL4OZVVbHmIMZ79i4fbz6kVkns1rTJnHc=;
        b=HCYGedbiW5sxO0PtzzBBe+DYAD81uoV3SwQYKClx0kwNbPRA5ElojhCrT3jnR4uhRd
         HLxyprxHi7xQasx3DFgNlTj/yg1d0j46tzGDI1S8+hIdpRX9R1nPqC6KPQ5zirF2eLrV
         WDmNqiVxfeaWTlBG45m02oSkp/x9Yu4g+rjx1xUpK1aFOMOU+I3ajhe5cEWguOx0iCHh
         kR/QtkZR4ZQBYPsR2sA6DjayNC4N6XiTfe9La6Wm0Kty9kskkGxLF3OHRbvTyhVxtEWe
         2lKIWZNF4S+geRas9yuWGFUU1fQPftnpoScaFM9gHMr2ZkBjj551yoTkTj+7+Hdr7gsE
         zz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hreAElmr17ZL4OZVVbHmIMZ79i4fbz6kVkns1rTJnHc=;
        b=Q3XML5GS85WhbRTAwlRs+B3Gf5HmxQ1dlSg3ce2OlPq0i81ZdWzXLNE0GhD+M5DzJf
         khfsr0kgy7M28NuxSJc4kl7Tdyd81ZhGJV6N6hvdvvIvEvx4UEpfmVK7GJ5CgSASATGs
         rkoB+vCqI8fhiB6MFmOg4o3e452o1SCmsCG82zuVsBrYRVdawladgoMSFuPbpZXHeVQx
         0OEgfk6i01a8mOLjVxqe6AR1lb0dDoLas4TsBwoC6rWtpYrPvvrxevBeNO5f4QumkQ2Z
         gWimMDgEFJpSYY2P6yLBLabqy9B+hf8yl6Zqo+XFFRDwNPYszqOWTtG82rdRQuxWhK7/
         Fmug==
X-Gm-Message-State: AOAM533nHDyxKs7dNXJq9ZSajYQeNHqur8Wl27DnBrf1PsfHuZHyZsOy
        A8Nyweqxh76qorQmzbsrsMJ5OuZSGW14syrzPXCe/g==
X-Google-Smtp-Source: ABdhPJxtMphhWy4wchNGwPu9Zb74KqIJd30juhzzc4H9TTlbKYRgu/wGvWW5BjAXM4aFpOFXzfBrOucRHxro2nUvpiU=
X-Received: by 2002:a05:651c:33b:: with SMTP id b27mr65586ljp.314.1630614055208;
 Thu, 02 Sep 2021 13:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210901211412.4171835-1-rananta@google.com> <20210901211412.4171835-6-rananta@google.com>
In-Reply-To: <20210901211412.4171835-6-rananta@google.com>
From:   Oliver Upton <oupton@google.com>
Date:   Thu, 2 Sep 2021 13:20:31 -0700
Message-ID: <CAOQ_Qsg1VPf+YBG4fvM2ddWMp82h7QRzdzO-iWNF7d6-EsJ4VA@mail.gmail.com>
Subject: Re: [PATCH v3 05/12] KVM: arm64: selftests: Add basic support to
 generate delays
To:     Raghavendra Rao Ananta <rananta@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <Alexandru.Elisei@arm.com>,
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

On Wed, Sep 1, 2021 at 2:14 PM Raghavendra Rao Ananta
<rananta@google.com> wrote:
>
> Add udelay() support to generate a delay in the guest.
>
> The routines are derived and simplified from kernel's
> arch/arm64/lib/delay.c.
>
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> ---
>  .../selftests/kvm/include/aarch64/delay.h     | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/include/aarch64/delay.h
>

Reviewed-by: Oliver Upton <oupton@google.com>
