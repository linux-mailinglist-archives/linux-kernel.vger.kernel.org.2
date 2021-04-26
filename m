Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A017236B6C9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbhDZQ3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbhDZQ3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:29:39 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB89C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 09:28:57 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id e8-20020a17090a7288b029014e51f5a6baso5513400pjg.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 09:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Vqfos0q3OrVsLgjD6hi47kyeAtTtXeJRmi2eSfO7cU=;
        b=a2RqPI2EwgiiaTtEZPoxWu3KeEd7qKTnpbjPDuP2b/yrWI4wksRspjhhICAeAvigdZ
         zkSyERxRiRHmKtt1N2+PYiS7thMZLn92hgnUSVTYN/tl6O/SNBeDgEPScxRmpaVTA5NK
         rDLG9eenOCOU51rkcwA2jE+vmTClrjCbUY+9CsQgRkZw6P4IVtvNYt0xHpMqcZdYspjJ
         L7WKum6vpdBuUExn7KHKQSKioQx4YXbOr1kbwc5ennnGMrR+FcU6Mhdk0WBjG8cFM0ID
         7awKY/sAKBKixygn3PHwOk2vcC2V6Zh8y4OBgA/DqIGt3/i9smGobZOUvfjNpH3yRnG/
         tC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Vqfos0q3OrVsLgjD6hi47kyeAtTtXeJRmi2eSfO7cU=;
        b=if2qn3i9SJCFX0Se+pdjswqgY7cS7xcCewTJTyGS2oy8S4iBTaRwbRRfcPIezEktPY
         Ubt5MqjsRSlCg3GcGaLrL9HRvRuMHo9WljkZS3bqhW2vLUMQw5NZV9Czg8/bAFGxFK84
         kZoiNQ41/LdRdQJ6C2itUNndTsaYUJqrva1jZQxRUMRQidaqnL8fwQhNsolxTbQZB+Of
         5WizCYUOygzpMmRBkpmWkJjxEGybLpddy8eIA1GwbuvYxUzK9EerthcFhxpGER+YJ/F1
         +nS0Qv550nizCnIVv+/UtWoCdVjD/ubPTaY7Sg2nKIdzgOe5JYhHiazfbOkwsyfNC2MR
         CIQA==
X-Gm-Message-State: AOAM531wvREPXauSz0+HQoYybnUByxo2osSUOpzlKRixOi3Cgg2FxIN4
        KCEDpuUYKvkdYDbvYtFJHU13bB1ULPJyt9gKxoJf45QmLMjdXF5L
X-Google-Smtp-Source: ABdhPJzWchgVLcHAYHYIFGFW01tYuh96hhmaZdNgveX9kEWQx4LzmB3gMpbY2dM9lD2kPPNDGEYk8caWxyBiqKheYRo=
X-Received: by 2002:a17:90b:46d7:: with SMTP id jx23mr21758603pjb.168.1619454536858;
 Mon, 26 Apr 2021 09:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210422171013.50207-1-rsaripal@amd.com> <20210422171013.50207-2-rsaripal@amd.com>
In-Reply-To: <20210422171013.50207-2-rsaripal@amd.com>
From:   Reiji Watanabe <reijiw@google.com>
Date:   Mon, 26 Apr 2021 09:28:40 -0700
Message-ID: <CAAeT=Fzji_=m45ycm_rS6dFcp1M3yWLQAY01-s=WG-gj4znOog@mail.gmail.com>
Subject: Re: [v2 1/1] x86/cpufeatures: Implement Predictive Store Forwarding control.
To:     Ramakrishna Saripalli <rsaripal@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        Jonathan Corbet <corbet@lwn.net>, bsd@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -1170,3 +1170,22 @@ void set_dr_addr_mask(unsigned long mask, int dr)
>                 break;
>         }
>  }
> +
> +static int __init psf_cmdline(char *str)
> +{
> +       if (!boot_cpu_has(X86_FEATURE_PSFD))
> +               return 0;
> +
> +       if (!str)
> +               return -EINVAL;
> +
> +       if (!strcmp(str, "off")) {
> +               x86_spec_ctrl_base |= SPEC_CTRL_PSFD;
> +               wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
> +               setup_clear_cpu_cap(X86_FEATURE_PSFD);

Shouldn't X86_FEATURE_MSR_SPEC_CTRL be set if the CPU supports PSF ?
x86_spec_ctrl_setup_ap(), which is called on non-boot CPUs, doesn't
update MSR_IA32_SPEC_CTRL with x86_spec_ctrl_base not having
X86_FEATURE_MSR_SPEC_CTRL (i.e. if a CPU supports PSF but no other
existing feature that makes the kernel set X86_FEATURE_MSR_SPEC_CTRL).

Also, since check_bugs() reads the SPEC_CTRL MSR to account for reserved
bits which may have unknown bits to set x86_spec_ctrl_base
(if X86_FEATURE_MSR_SPEC_CTRL is set),
I'm wondering if psf_cmdline(), which is called earlier
than check_bugs(), should do the same instead of overwriting
it with x86_spec_ctrl_base | SPEC_CTRL_PSFD.


Thanks,
Reiji
