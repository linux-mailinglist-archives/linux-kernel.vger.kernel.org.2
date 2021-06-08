Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED0039FE16
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbhFHRsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 13:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbhFHRsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 13:48:41 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94C4C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 10:46:47 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id w21so25442676edv.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 10:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bkqv7MfLVoeFg0KvtzkZioAgbKIJlREdEU5n+r8Z5g4=;
        b=H8BX10Ld3oDqbkA+qU7coef/BEYjOIDEYGA48ZryVnVlBuHQxqhBH5MBE2sZ6iXUx4
         K78OoRgsTWWTT7fI/TCszaZg6GuR6Ccs6qKYUcP1Hm089CR4zKLtXP0vFu7g4/8OaEVF
         dTOZrXemsrLzBz/tARFAhF+eGtL+JCzwzWcjRJjxjyS2nCOoppOkjvxELjnuymr/Y11s
         R5lj1T9ffKVwwIXjhDIoc4TLN6LfjcNeqpigUEs+/Ed8iIVJnLaRSiUjQRQxkWPYHO6S
         qZsGvICVagULAIvdVQFcEj9sWhkTXg9MH8GtMne0sW6qfoBboXDBsTz2/jnQW4oYIuBV
         wKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bkqv7MfLVoeFg0KvtzkZioAgbKIJlREdEU5n+r8Z5g4=;
        b=ljP+YjhPPsIE0qksHjx6Ub/MsLRpRT/FobpNN4Xk1MOApyWX9UwCOZT1x840SdwmiT
         4DF+7frY967iEdEm86GRnoOazXNBVOVDQ+OX+9JWKC2pAQydwvQnyZJ8TsR3MDsqIe4t
         F9nnaa2CH3IT6QtRfj9lhaG0n7dftYG5ufeJUO2Qk6WhNlu0N7QzXwwhRBwFt3Xl9Qd7
         RFDWo++QYjOOekGe/jXSGFofYsizfrepVrAPwwhEYGTtBcbWT7P8P84NF6/2uM6Bqo16
         4wUzXJEVFRAPPzD30SVWmlVWAdwfz4bFn1VJZwsqi4qGWcFNV9hZ0ma8IPdajdYO3WSD
         ACgg==
X-Gm-Message-State: AOAM531ScPik0XsIzUiiQM9MAKkmTSlbM1d6yVTOLFpiDFeJ38p0ffyF
        MDMQec/ZO103D9RbMJmkhFnqiSxzBnJ9eaEOQqL0Dw==
X-Google-Smtp-Source: ABdhPJzSqe4nnlCsavCCS5DfyHoif/XjHKGNN2/Q+bK8RYCr5eRm08qgonEPfhSLxF3zAYe+Y2qohJq1c8H1v0cvQ00=
X-Received: by 2002:aa7:c654:: with SMTP id z20mr26596243edr.26.1623174406231;
 Tue, 08 Jun 2021 10:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210527150526.271941-1-pasha.tatashin@soleen.com>
 <20210527150526.271941-4-pasha.tatashin@soleen.com> <87sg28rx3c.wl-maz@kernel.org>
 <CA+CK2bDvsFX_s-G5tRcE1GreNW_xLTognosUFbPPgaUK7-cafQ@mail.gmail.com>
 <87r1hl22qm.wl-maz@kernel.org> <CA+CK2bBwd2+QB6qCWYQdC5x_Vkf7-64pr8UWJFoUkQgtfaAsHQ@mail.gmail.com>
In-Reply-To: <CA+CK2bBwd2+QB6qCWYQdC5x_Vkf7-64pr8UWJFoUkQgtfaAsHQ@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 8 Jun 2021 13:46:10 -0400
Message-ID: <CA+CK2bB6YOmASnDJevgibdu_noDhEuBj1=5qhZ3uCdUjN_qrSg@mail.gmail.com>
Subject: Re: [PATCH 03/18] arm64: hyp-stub: Move elx_sync into the vectors
To:     Marc Zyngier <maz@kernel.org>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com,
        rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Selin Dag <selindag@gmail.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        madvenka@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 1, 2021 at 9:18 PM Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
>
> > > It cannot call mutate_to_vhe because #HVC_VHE_RESTART is not used
> > > here. But, if it had to it would not work as we cannot return to the
> > > old kernel text after relocation.
> >
> > OK, so you are happy with having a dangling branch pointing to
> > nowhere? Something in me screams that it isn't a good idea, in
> > general.
> >
> > If HVC_SOFT_RESTART is all you need, I'd rather you have a small stub
> > that implements exactly that and nothing else. Feel free to extract it
> > as a reusable macro if you want.

Using macro won't help here to save kernel text. Optimally, we would
want to use only one vector table to reduce kernel text memory usage.
I could do that by overwriting sync entries in
trans_pgd_copy_el2_vectors(). But, that would be ugly, as I would need
to have some specific assumptions about what entries need to be
overwritten. Therefore, I decided to move the vector table that we
currently have in hibernate code, and make it common between kexec and
hibernate; trans_pgd_copy_el2_vectors() will use that table's body to
create copies.

Thanks,
Pasha
