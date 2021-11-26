Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4254345E429
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 02:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357528AbhKZBz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 20:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357463AbhKZBx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 20:53:57 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9946AC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 17:50:45 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id c4so15219740wrd.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 17:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ue+ydJFjsfN5rd8y2Zo0UmtI3oU+9VqtaCaChqusUO4=;
        b=kXAsc3mjmWv9rUz4lB+vUNHm0Sr0p32DgP+/S8zwaD/EafvX9STH5ZFNz7Cgh3lW4f
         erOfieBjkr/PBxp6CarPf6AXnjI4FbFALtNhHzW6AALWGJV42SLdsNV42t+q39ODeDWw
         Jxi1O4tiftDa3Z2MxeWcSKVCsG+/1+iJIaLsUOe8ALMK3mNw/ifu4354yplVI6gIYJDY
         bNYHjS5H5tl4EP64yis7lWB//URbVQGDIdQIUq6pBSqRUgD3WLcuzFGP+uQMVJGBT5kw
         G5u+w2T/rnLXlgNeurUZSWqiXonlLWjbQo0zffYplthvFhKNmZBzlvGzZDYRW1OnIELg
         CWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ue+ydJFjsfN5rd8y2Zo0UmtI3oU+9VqtaCaChqusUO4=;
        b=FX4WvWPy9Plfob9oH2y7DB1rkdpDpCrZSnqC1mOLEMKsAKunTQdjnupQ29JapjO428
         UJPdMaPsxZjYvllrYLtdETkLWIBPWFe1rHoLTnO9Z0Pu7/sMCZ3PuLbHJpQf5diyAoSN
         Q37tVBcH+vOWY+MvkJKt3IVMWF3Yb0TeJ1Y5Sjxml0299yc4SMJq9dyMfAJgW2bBFkIq
         pyqxnxu2+Gp9J+BIQf8ghZKCp2oa+uLbuXNX5mEqcP/zppt+oSUoHWwGA2rjavgssLt/
         YJhkb5Ops4OfjPGDnDI5Bmi6rhaU0lcKVLE38zA0uoLaXNuasLOo5ylDj7LQKeukPffC
         +qxQ==
X-Gm-Message-State: AOAM530F7945EvZFd1M0cPmsR2cHVQkgI49KaoG26mxVZLU/OffI8xka
        PlUd/SYxu7PRXyIA5MSX3BYivJUGM94Ugxfw/qQT2Q==
X-Google-Smtp-Source: ABdhPJw5/dBmybdmG22b7pw2fTf20H2BZ4oTSKV8OjjQssoabMfKGjg9VlqDquLgR+HMtMGgAxStqcMOVJrjyY/Cc90=
X-Received: by 2002:adf:ef4f:: with SMTP id c15mr11584812wrp.226.1637891443685;
 Thu, 25 Nov 2021 17:50:43 -0800 (PST)
MIME-Version: 1.0
References: <20211125193852.3617-1-goldstein.w.n@gmail.com>
In-Reply-To: <20211125193852.3617-1-goldstein.w.n@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 25 Nov 2021 17:50:31 -0800
Message-ID: <CANn89iLnH5B11CtzZ14nMFP7b--7aOfnQqgmsER+NYNzvnVurQ@mail.gmail.com>
Subject: Re: [PATCH v1] x86/lib: Optimize 8x loop and memory clobbers in csum_partial.c
To:     Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        peterz@infradead.org, alexanderduyck@fb.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 11:38 AM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
>
> Modify the 8x loop to that it uses two independent
> accumulators. Despite adding more instructions the latency and
> throughput of the loop is improved because the `adc` chains can now
> take advantage of multiple execution units.

Nice !

Note that I get better results if I do a different split, because the
second chain gets shorter.

First chain adds 5*8 bytes from the buffer, but first bytes are a mere
load, so that is really 4+1 additions.

Second chain adds 3*8 bytes from the buffer, plus the result coming
from the first chain, also 4+1 additions.

asm("movq 0*8(%[src]),%[res_tmp]\n\t"
    "addq 1*8(%[src]),%[res_tmp]\n\t"
    "adcq 2*8(%[src]),%[res_tmp]\n\t"
    "adcq 3*8(%[src]),%[res_tmp]\n\t"
    "adcq 4*8(%[src]),%[res_tmp]\n\t"
    "adcq $0,%[res_tmp]\n\t"
    "addq 5*8(%[src]),%[res]\n\t"
    "adcq 6*8(%[src]),%[res]\n\t"
    "adcq 7*8(%[src]),%[res]\n\t"
    "adcq %[res_tmp],%[res]\n\t"
    "adcq $0,%[res]"
    : [res] "+r" (temp64), [res_tmp] "=&r"(temp_accum)
    : [src] "r" (buff)
    : "memory");


>
> Make the memory clobbers more precise. 'buff' is read only and we know
> the exact usage range. There is no reason to write-clobber all memory.

Not sure if that matters in this function ? Or do we expect it being inlined ?

Personally, I find the "memory" constraint to be more readable than these casts
"m"(*(const char(*)[64])buff));

>
> Relative performance changes on Tigerlake:
>
> Time Unit: Ref Cycles
> Size Unit: Bytes
>
> size,   lat old,    lat new,    tput old,   tput new
>    0,     4.972,      5.054,       4.864,      4.870

Really what matters in modern networking is the case for 40 bytes, and
eventually 8 bytes.

Can you add these two cases in this nice table ?

We hardly have to checksum anything with NIC that are not decades old.

Apparently making the 64byte loop slightly longer incentives  gcc to
move it away (our intent with the unlikely() hint).

Anyway I am thinking of providing a specialized inline version for
IPv6 header checksums (40 + x*8 bytes, x being 0  pretty much all the
time),
so we will likely not use csum_partial() anymore.

Thanks !
