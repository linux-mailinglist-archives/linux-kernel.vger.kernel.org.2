Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379AF42DEA2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 17:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbhJNPvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 11:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbhJNPvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 11:51:41 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3FFC061753
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 08:49:36 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id pf6-20020a17090b1d8600b0019fa884ab85so7248704pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 08:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cdo2IY53QdZvWuodTSPVoJdmcB1S4P8LHhiW3c03rcM=;
        b=I0b88tEwj3JE/IAT78aAGXsEtfmxFvIcrfK8hf/r4ZsPEKHNmHEbPFPbqCwEqzBuW3
         PjVg4l0AXCtsMVmoEmXx/yZRrrOw1dIuWC587lxM7TsR8k+4Y6PcSIdnBhKa88PZ4cjJ
         WpsG95BSQlduoBivA2ReWeTHqtfYUZ7AI27YPoNHpdmPOqzuuXKXMFt1O/QznNp3/yKL
         9I5kd79gcS2Pcqr5FlZu2W/OROMIjaZisxj1nLTy/oKqVWB8Z8WeRJBya0cjh0ixLS2a
         zju58EM4ulcnZlTMEUWY4zOxobMXq2DtiwlCKRaHTCxg3zESsNZBxRt3IzyGHIrgPTzQ
         +CcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cdo2IY53QdZvWuodTSPVoJdmcB1S4P8LHhiW3c03rcM=;
        b=3smrikprCIOlNbybBX23vMQiWRMF4a26yFveq5IjTAOqgKdyuDKQrjswXHjSj3ZLJA
         QCCOG2eJhU9Rm7bdtB2y9nrh0p1b3qBbbLtuqb6QG6Gvpukgd2KR6nPZP55efj+ZxEDS
         vq9deMZabUEof0gywe8RvivUi4DLQbYt+Z44cCHPFgdYDDW1JcZKV4dsX8dS6p3r/jAx
         FGpPqLL0R9MwS63JZBn+LGbwIMNNvSD60V9bEF+eJeQRLxUNyAeAZA3jRXO49m/5v3Q0
         qj+VCPUVXg1IYx5gpzeD9XppXRxglC9SKMwTYtGbl/JtHxbJUudP7M4BHDLO3Sxvpx2j
         bbVw==
X-Gm-Message-State: AOAM531TS6U8pJskZcqta1BYhyi4vTB6ATQ0/s5rGuqUigusQilA1GM+
        icxJx57uhg5ZWv0sO20VQsHPQsJclCTx3UigQ6Aq1BNfe1A=
X-Google-Smtp-Source: ABdhPJxiro4aLxYXdvtsKCuJqxcXSw3e7sN2nuJINHdalZMtv5nUAIPrlhl259rx3ApMn0YwSMq50WBg7TLlCIXwXuQ=
X-Received: by 2002:a17:90a:b794:: with SMTP id m20mr7116811pjr.178.1634226576478;
 Thu, 14 Oct 2021 08:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210920053951.4093668-1-goldstein.w.n@gmail.com>
 <CAFUsyfJWXJEc1879uX_YOJg7cvie0gitv+bu83DiUXiE74uQww@mail.gmail.com>
 <CAFUsyfJQ8_=QnZjZ2zS45wwB6AaRgL4JO8_sT1a_rXUsfh_1WQ@mail.gmail.com> <YWfqEIaCKOwSWGHF@zn.tnic>
In-Reply-To: <YWfqEIaCKOwSWGHF@zn.tnic>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Thu, 14 Oct 2021 10:49:25 -0500
Message-ID: <CAFUsyfLf5a6-L7f2AjLx3j8+qbG7EU9iLPJCTA0+UoOUg3C61A@mail.gmail.com>
Subject: Re: [PATCH v1] x86/fpu: Remove opmask state from avx512_timestamp check
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, X86 ML <x86@kernel.org>,
        hpa@zytor.com, Andy Lutomirski <luto@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 3:28 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Oct 13, 2021 at 05:36:14PM -0500, Noah Goldstein wrote:
> > Ping2
>
> Why?


This left me confused and annoyed for several hours because
the avx512 usage information on my applications didn't make
sense. Figured worth a patch for posterity.

>
> The original patch which added this abomination:
>
> 2f7726f95557 ("x86/fpu: Track AVX-512 usage of tasks")
>
> says already:
>
>  the tracking mechanism is imprecise and can theoretically miss AVX-512
>  usage during context switch. But it has been measured to be precise
>  enough to be useful under real-world workloads like tensorflow and
>  linpack.
>
>  If higher precision is required, suggest user space tools to use the
>  PMU-based mechanisms in combination.

This patch isn't about higher precision / false negatives.
It's about false positives.

>
> and as you've noticed, the high 16 regs would cause a false positive
> too.
>
> So what is the actual real-life use case for this?

No big project. There is a case for avoiding the extended avx512
registers (reg16..31) for various reasons (context switches,
code size, instruction limitations) that don't apply to mask registers.

Irrelevant of the still existing flaws, it makes the output more accurate.

Is there a cost to the change I am not seeing?

If not it seems to be a tradeoff between more accurate vs less accurate.
So why not take the former?

>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
