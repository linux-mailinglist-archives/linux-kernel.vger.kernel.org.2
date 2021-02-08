Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362E2313E63
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 20:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbhBHTDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 14:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234863AbhBHRcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 12:32:32 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BD2C061793
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 09:31:51 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id l12so19414058edt.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 09:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=150RTcQf9BfKKICDDXV9LKFJabVH26+mj9gc5y6fe7Y=;
        b=hyAFs0fKGKFRmcciR03ZZ+YgXacp92jIDmnU50sMK4A9BRuJZf1z7VY29bDmosfHTb
         1WxxFJmX4Gx2fA5LbII7eG20wFGqZn2bS948AI6OJ6Alo0QsDcr/UWtsoB9PEoSSrQs6
         Sgp9ku+9stH6xnurZ6pYqxXLqFor2p8XQ8xdOHBcBbW6DZ9qjJXHVcwNrJ9g2FJfHgrr
         nJ7wG+20YbrL/0Rdm7sCRiO2XEvUYsLQR+ZhObZcRDg0iMfiwvTqtzC1QFMWLyLnPeZW
         eyTK7lotvYRoGNA1ptcR3iRB9VOCPrva6py9K0rLj2MnNZz0HANq9733DQWdvkSShO8W
         u1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=150RTcQf9BfKKICDDXV9LKFJabVH26+mj9gc5y6fe7Y=;
        b=dB9S0bUTcxR5cmCGycrgCKFrTceFAf+YaO353UTPjFaNl5NMQxdKZlYI6btikQkR6w
         64GrwyYAhjOye3Cx7ldqxJdiPPOkbXiA5V2N4iJ7rsTHp1YjK5QuZpGoHDukryqMePhR
         6AAK8VpZRuYXrgfr29ZUq5Non6zMz5sh0zooY0wegvGFi6YwGvUi4pG7RaJnzdlyPW9g
         IqwVnMt72Q+tq+zX5W3gzt35mDdPxGhoZr5uJ8DmVH/txOaZbJ0gRzUeMLCri5DbNpwM
         GQ6oQ4uTdPTpUh+zvle4xXDSERRq7ClSfrJHqtrM7EsIfTgBNg6lZYdpZQ/vkPbGPuCi
         /uUw==
X-Gm-Message-State: AOAM533NByYUpUIYwW0NeF1zEATwth26DLG8ilemForSV29Ugt6P1BiJ
        zpv+5ia1v8CbnEnkCAJx7BmCy6lcueFn+9iaVxOVv7Vw2Bw=
X-Google-Smtp-Source: ABdhPJyfU7DR5l4b18tnpHL187lOP8zLT1R2zc8ro9MwTmAB+zuO7xlpf0gqcrlNJL178r53Bg3pYOpuitw0w/ezOBI=
X-Received: by 2002:a50:e80d:: with SMTP id e13mr17842705edn.251.1612805510357;
 Mon, 08 Feb 2021 09:31:50 -0800 (PST)
MIME-Version: 1.0
References: <20210205135803.48321-1-steven.price@arm.com> <20210205135803.48321-6-steven.price@arm.com>
In-Reply-To: <20210205135803.48321-6-steven.price@arm.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Mon, 8 Feb 2021 17:31:39 +0000
Message-ID: <CAFEAcA99kV_d6ev9wC4ySiyoD7Cp=HCD0v2bBhGSOU-KrzkqaQ@mail.gmail.com>
Subject: Re: [RFC PATCH v8 5/5] KVM: arm64: ioctl to fetch/store tags in a guest
To:     Steven Price <steven.price@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Juan Quintela <quintela@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Haibo Xu <Haibo.Xu@arm.com>, Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Feb 2021 at 13:58, Steven Price <steven.price@arm.com> wrote:
>
> The VMM may not wish to have it's own mapping of guest memory mapped
> with PROT_MTE because this causes problems if the VMM has tag checking
> enabled (the guest controls the tags in physical RAM and it's unlikely
> the tags are correct for the VMM).
>
> Instead add a new ioctl which allows the VMM to easily read/write the
> tags from guest memory, allowing the VMM's mapping to be non-PROT_MTE
> while the VMM can still read/write the tags for the purpose of
> migration.
>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  arch/arm64/include/uapi/asm/kvm.h | 13 +++++++
>  arch/arm64/kvm/arm.c              | 57 +++++++++++++++++++++++++++++++
>  include/uapi/linux/kvm.h          |  1 +
>  3 files changed, 71 insertions(+)

Missing the update to the docs in Documentation/virtual/kvm/api.txt :-)

thanks
-- PMM
