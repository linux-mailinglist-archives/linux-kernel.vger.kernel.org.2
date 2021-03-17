Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3F633FAAA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 22:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhCQVwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 17:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbhCQVvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 17:51:51 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9090AC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 14:51:50 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id c17so2985217ilj.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 14:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cmS5VTdpjB7aIZbCdxUlC1inIiI2M7dpyhvt0mW8CFA=;
        b=t1qvOW6Sdnm6F5t6MN6isTbErnV9e4RXgxsB+XA0Xf+q0woj9+8+dRBGiwvNYkTBm+
         nzfKQJFtSZz4UFyoGYCYhwIexwumX065v3jcoQKHp51fHsPs/lLwvimi7Pa88aWbE3ng
         U3q7YILGfh7LzADYk7oAM2ovFYogcmXiRmRZMFVO2O0/vQx8snK9S1oBx5GwK81AIVdR
         TAfB8jYF4tnHPftyeJ8fQSbxnq9ANtrgH5LhZY/ZwuBig1ULVcZf8lPyX+yiuUAS1b/a
         kTvfIuhoQ583myMslUhqBTrkWui2R400/mvcVXqrP5PxqAbOGqT8g9J+jzfjolIS5Inm
         qxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cmS5VTdpjB7aIZbCdxUlC1inIiI2M7dpyhvt0mW8CFA=;
        b=X8rRQDGoipJRoC8DnPFfbZQhzSJkEClLdqkFKZ6a/EnoiANBrGb0Rc1zMTSwjuv1xB
         iETVWfXRd1twW7px1n9xtM6/SHk1Q6vkE6Kc5wbBNLufz3/taYPGgYssV1kPLLGRgCOu
         LafW76niKzHPoEkRfZN7CYP9jJdmRgiYeXZ7g9bKxJSSoqW8DKZIoVVWVaa4jyn5WI3l
         Sxc5opVQDQuRCiMNSbwH0UVG12c+UmeEZI1bXf1VU/KxmbEhJ/fH5zIStHlTCzTyiPG8
         Qo3Akt3SokRPdegAO42kveGn8Uq3ryF8bydbHdjJEXMxtOCsb0hhmtc0CyHusMWoOLn1
         /JtA==
X-Gm-Message-State: AOAM533ZCeMlhTzNSoTuLIJ3/Vqtn0dC8lK9eXL2kXfbXN6d0fNeu9y9
        I6Wjw5gVyfafNPVX1eW0cFL+vU8glaYhQWYNSG48aA==
X-Google-Smtp-Source: ABdhPJzDdpvOTCpLCR5MSfOKKIMYJZEXVpXveigA2mdX2CAIO/adsdEURbfOHA0T8xEy4lRONEV7OpRWVrAMDP+jtDk=
X-Received: by 2002:a92:5404:: with SMTP id i4mr8322524ilb.193.1616017909699;
 Wed, 17 Mar 2021 14:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210317183243.2904919-1-seanjc@google.com> <20210317191132.GD25069@zn.tnic>
 <YFJbzIrGLXu2UsFv@google.com> <YFJyX/MludiiS+dN@google.com>
In-Reply-To: <YFJyX/MludiiS+dN@google.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Wed, 17 Mar 2021 15:51:37 -0600
Message-ID: <CAMkAt6oLT6-fCYG_t22ZO5K61QjS07HPwgey88p=isbL_ZAMPA@mail.gmail.com>
Subject: Re: [PATCH] x86/cpu/AMD: Adjust x86_phys_bits to account for reduced
 PA in SEV-* guests
To:     Sean Christopherson <seanjc@google.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 3:19 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Wed, Mar 17, 2021, Sean Christopherson wrote:
> > On Wed, Mar 17, 2021, Borislav Petkov wrote:
> > > IOW, you have c_bit so your valid address space is [0 .. c_bit-1] no?
> >
> > I haven't found anything in the GHCB that dictates that MAXPHYADDR == C_BIT-1,
> > or more specifically that MAXPHYADDR == C_BIT - PhysAddrReduction.  E.g. AFAICT,
> > a VMM could do C_BIT=47, MAXPHYADDR=36, PhysAddrReduction=0, and that would be
> > allowed by the GHCB.
> >
> > Forcing "c->x86_phys_bits = c_bit - 1" doesn't seem like it would break anything,
> > but it's also technically wrong.
>
> On the other hand, "C_BIT=47, MAXPHYADDR=36, PhysAddrReduction=0" would mean the
> C-bit is an illegal PA bit from the guest's perspective.  That's rather
> nonsensical, but also not technically disallowed by the APM or GHCB specs.

The C-bit location on Rome is 47 but it's 51 on Milan. So we already
have a C-bit that is an illegal PA bit.
