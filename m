Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A5534AC9A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 17:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhCZQe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 12:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhCZQen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 12:34:43 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3AEC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 09:34:43 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id y1so8057301ljm.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 09:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rr+9Nmmd9Te7QF0knbE1qBYAGxHmadtN1JXjZbkqZxk=;
        b=TE3vVFc1TEOPacZvHQoUhpJ4RFZnJn0IqpEwL6eK2EYUf4O44EU6XvJ6AbWS08goSx
         P5xMh/HVT/bm7S033DJcbue+y7VFTW/OrEofqktcL9dcVNyARonQGWf9KVlzGuHB23Cp
         +C8zocaS/guougrUBHPdafevJ0NI7KIcpMVctP5yC0RBuIkZGSGT6nrWdZc7GhLnbAY+
         zi3lSBJEEqbb8sEQo8cuqAlEDwwUrgM0hHfGFMXF92oaCXNmFEssywe6ExHY3vwcfidR
         b6KK3mYvWGLDrSWnTw2ebo4jjVVr3pABFWGe9QYlpU1EJHdcOS9ONUB7AxsM1qhxpOyV
         niNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rr+9Nmmd9Te7QF0knbE1qBYAGxHmadtN1JXjZbkqZxk=;
        b=OjRVCCZjwz+B4dj3txjvhMNfDJfEb+G95h3XuxjBluQBoUiXKtSeYg5xxAIJjeA9Md
         I6O/yi2Z6gvbg1ixfnaL357ohxafEoKa6dX+zlQAu3N3OqL05ZXRiLpa2eqd7pP6YGvA
         RmNLJ5MCzpSwtELSqS8wJNLulSvMOQn1p5mdlPWtyvodlv9vL7svQOOt/aZkpykffal9
         w3nslsC/exnzgQHqBuUsKRQBsOJZgC1UrohyFNIwS8EaLawUG1HU8704hDU+VSv4Mmv/
         RZ82MDd3yY/4V1iEpZatU4gPTuYx24QIUnj3bZyzFYKXgGoxjwnfdfLDTbelLFiNbKrM
         we9A==
X-Gm-Message-State: AOAM530Y/10EtZZfETH+EvfGBeFa70/48M7RDzIQbaWmUQmqLdWF4La7
        hUbzpF1khKV5AFqWSpRJ9nwDr0/m5QkQ/DtB1tYaKg==
X-Google-Smtp-Source: ABdhPJzcO6wP+okfrvaLtTR5/Yj3Jm6V/h77ahZBaB1e/VtsbrPfOFxXEmyszAbfvl8v3ddXrkNkS+5DSutJJqq7Zuk=
X-Received: by 2002:a2e:9bcd:: with SMTP id w13mr9378810ljj.43.1616776481296;
 Fri, 26 Mar 2021 09:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210221185637.19281-1-chang.seok.bae@intel.com> <20210221185637.19281-15-chang.seok.bae@intel.com>
In-Reply-To: <20210221185637.19281-15-chang.seok.bae@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 26 Mar 2021 17:34:14 +0100
Message-ID: <CAG48ez3hLjwirUoaanDHJ_2h73YruVxfJL88AFVoym7sy02a5w@mail.gmail.com>
Subject: Re: [PATCH v4 14/22] x86/fpu/xstate: Expand the xstate buffer on the
 first use of dynamic user state
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     Borislav Petkov <bp@suse.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, jing2.liu@intel.com,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 21, 2021 at 7:56 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
> Intel's Extended Feature Disable (XFD) feature is an extension of the XSAVE
> architecture. XFD allows the kernel to enable a feature state in XCR0 and
> to receive a #NM trap when a task uses instructions accessing that state.
> In this way, Linux can defer allocating the large XSAVE buffer until tasks
> need it.
>
> XFD introduces two MSRs: IA32_XFD to enable/disable the feature and
> IA32_XFD_ERR to assist the #NM trap handler. Both use the same
> state-component bitmap format, used by XCR0.
>
> Use this hardware capability to find the right time to expand the xstate
> buffer. Introduce two sets of helper functions for that:
>
> 1. The first set is primarily for interacting with the XFD hardware:
>         xdisable_setbits()
>         xdisable_getbits()
>         xdisable_switch()
>
> 2. The second set is for managing the first-use status and handling #NM
>    trap:
>         xfirstuse_enabled()
>         xfirstuse_not_detected()
>
> The #NM handler induces the xstate buffer expansion to save the first-used
> states.
[...]
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 7f5aec758f0e..821a7f408ad4 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
[...]
> +static __always_inline bool handle_xfirstuse_event(struct fpu *fpu)
> +{
> +       bool handled = false;
> +       u64 event_mask;
[...]
> +       if (alloc_xstate_buffer(fpu, event_mask))
> +               return handled;
[...]
> +}
> +
>  DEFINE_IDTENTRY(exc_device_not_available)
>  {
>         unsigned long cr0 = read_cr0();
>
> +       if (handle_xfirstuse_event(&current->thread.fpu))
> +               return;

What happens if handle_xfirstuse_event() fails because vmalloc()
failed in alloc_xstate_buffer()? I think that should probably kill the
task with something like force_sig() - but as far as I can tell, at
the moment, it will instead end up at die(), which should only be used
for kernel bugs.

> +
>  #ifdef CONFIG_MATH_EMULATION
>         if (!boot_cpu_has(X86_FEATURE_FPU) && (cr0 & X86_CR0_EM)) {
>                 struct math_emu_info info = { };
> --
> 2.17.1
>
>
