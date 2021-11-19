Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5EB456B37
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 09:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbhKSIDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 03:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhKSIDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 03:03:48 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82344C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 00:00:47 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id p23so11738018iod.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 00:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s4nj/6566dyvMfjGMcSjd4UtQrsv0ENgMqq4sN6ZNg0=;
        b=SX3gknsdAHk/6PTy5mLzxXu/d7RCdazzLSUX40F3TwekmHQ8tRChSokuwW0KcLSHwU
         NSxLqfsnGj44rt6FL2Ae1LnMSBWyaj3xaYqA6ZdeYZMB/Ei7d3ZsHsc+IQS5mHwmDJAq
         7oq0R3mF7Q38mtLv/HQmDrx35X6+dpLKZgU13QLuHzc7A9A1oLarCK4FmjM1ekn6y9S9
         Nm8Wfz4/Av5wjb0+Ev3McG4QGjLxvJQgMjb1hdXmDz1esMGktZmsm1GQU30nuQlxFZ4d
         YLEn1f03pALjPANtRIG+5Ij5RsHzodPizfuBGTwEp56PyyCz7GO+OA1IPPJmoO7MISl5
         Q9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s4nj/6566dyvMfjGMcSjd4UtQrsv0ENgMqq4sN6ZNg0=;
        b=PmtgdtyMayjuJpjReMpuZo9qYynrARpsKQMGm4k8bPh+umFe3LEID4ePVPWV2m0CjH
         yajNVNyXJyBk8FigWXZ7LkdcQ0Nog9rIrs4M8crmriokvsXWniXqz9FdnHTz6bevxnAc
         nVICbj6y+RUIim3Xsam9aUdLX5peHQaNMDq9VMTXpxJuZyxaKIY5DuluonyshCFatECZ
         kf6LYbdsbrdKq8OTbdI0wUubG5yohlYZ2Cps7U8rJkbvYnwEYoWEKMB3VbiAqMRwMKeh
         whI3We51paY1Dsi+sIbF3qt/0WiTU2ryQ6HvISOY15GfoxRA3LSqa6F590NMu0QxT358
         nyEQ==
X-Gm-Message-State: AOAM533oGYDcbi0PR6inFMYOmv/m4khV4vOVxR8VftOIk5bTnnbty2XP
        TzbREivn+TMcO8Wt6dFooHKKW3IiOSOdcI92IRo=
X-Google-Smtp-Source: ABdhPJzBu0aRW0ZZlE7Og+UuzT8/juI0lIoprDQaAi/Wwp3fMUg4bA9yxkcvbEHQbuYKTslu9Ip2bZUAkfEnjuYehn8=
X-Received: by 2002:a05:6638:144f:: with SMTP id l15mr25620895jad.21.1637308846269;
 Fri, 19 Nov 2021 00:00:46 -0800 (PST)
MIME-Version: 1.0
References: <20211110100102.250793167@infradead.org> <20211110101325.186049322@infradead.org>
In-Reply-To: <20211110101325.186049322@infradead.org>
From:   Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Date:   Fri, 19 Nov 2021 16:00:34 +0800
Message-ID: <CAJhGHyCG05CxdnFmMU=UkOEZ-bkS8FMdMDaZfbhagbx7vsfd6g@mail.gmail.com>
Subject: Re: [PATCH v2 05/23] x86,entry_64: Remove .fixup usage
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, mbenes@suse.cz
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 6:19 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Place the anonymous .fixup code at the tail of the regular functions.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>

> ---
>  arch/x86/entry/entry_64.S |   13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -735,13 +735,9 @@ SYM_FUNC_START(asm_load_gs_index)
>         swapgs
>         FRAME_END
>         ret
> -SYM_FUNC_END(asm_load_gs_index)
> -EXPORT_SYMBOL(asm_load_gs_index)
>
> -       _ASM_EXTABLE(.Lgs_change, .Lbad_gs)
> -       .section .fixup, "ax"
>         /* running with kernelgs */
> -SYM_CODE_START_LOCAL_NOALIGN(.Lbad_gs)
> +.Lbad_gs:
>         swapgs                                  /* switch back to user gs */
>  .macro ZAP_GS
>         /* This can't be a string because the preprocessor needs to see it. */
> @@ -752,8 +748,11 @@ SYM_CODE_START_LOCAL_NOALIGN(.Lbad_gs)
>         xorl    %eax, %eax
>         movl    %eax, %gs
>         jmp     2b
> -SYM_CODE_END(.Lbad_gs)
> -       .previous
> +
> +       _ASM_EXTABLE(.Lgs_change, .Lbad_gs)
> +
> +SYM_FUNC_END(asm_load_gs_index)
> +EXPORT_SYMBOL(asm_load_gs_index)
>
>  #ifdef CONFIG_XEN_PV
>  /*
>
>
