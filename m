Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E2645F4FF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 20:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbhKZTHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 14:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhKZTFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 14:05:54 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7F3C08EAE0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 10:27:19 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v11so20394649wrw.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 10:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bEdmFaJ1LdkBlcJ8ExSvzEd5k9oTy182V+ctNy3yUV0=;
        b=ccv29rgetrRb8F/+HByzZuboYJNhjjDCdO5Ma5xj29UHe3JyqdvBWlsgPNrcKBDGQd
         LbDas6J4bJAhzFoEj+amPBzyl5kwckjJpTcHGdqr1eyhrcuZebrJ7ZtCxOXKslz2X2+s
         zgiZmjlRK34SUxbtOVnjyOVbt/L4KXjRzOhbUEKycygB5iS91fHobnaC5ML3HZeuu4uf
         7+Huws6FQlSFACwoDjjEJWcPxPelDOnEZYWi0/jf8zR1DnRmTZTrvrCm3WSPaYNTwCyJ
         GHPkltjuKlUXdEQ3FShKP5JljPu77FUSxEC6nsWXIQv+CXamGWhQ8K3O0q+ZZS3c1IMc
         kKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bEdmFaJ1LdkBlcJ8ExSvzEd5k9oTy182V+ctNy3yUV0=;
        b=6RL9US2NByHxfvcB6l6dnk3o+4pxQpBUv50ZE4rAM501cll4OwWIOuLkOIkaYlrNA7
         kr55aYBYi9o8ajnihJV7RbNKDOSte3EPJ4Z0Pr3wY30Wyp/e1HBXgC5Z41lOFPp9n3sL
         U/79yZXzRIqNL1dHnsXxp3Cs4o0q/GnelKbkQp7Kv34twySY+2b/qzcgiSp9N3jdBw70
         YYmIYP5/z7B4Y2NGQGxBLs+hobQGHS68jHGtZ8z1I5Z2iS8w8pE3WXFVyuyU9NewL7Oc
         Rl9IZo5FRA+DefA626Pc9TNVNeS+nwUsgrJIIV4uo07Bl+im176nGXDFHMaqpDofMCyC
         qbFA==
X-Gm-Message-State: AOAM530a3QAIby/NJPBOI0bC1BQuyjL5zK2hEGWSxpDAnbrmKCEB1CgR
        DasB+Yp2XR5n2g41DNUDgzygstVrr4H0SmaRUgJWYg==
X-Google-Smtp-Source: ABdhPJzkapDl3mJ7aOTvQJVbeAxT2512UGxnQgv4bf76bFnL4Omq2r0x7xJ3Tma3HprCZy2J9CD0ed4Qhcws4VSAfro=
X-Received: by 2002:adf:f0c5:: with SMTP id x5mr14934180wro.484.1637951237799;
 Fri, 26 Nov 2021 10:27:17 -0800 (PST)
MIME-Version: 1.0
References: <20211125193852.3617-1-goldstein.w.n@gmail.com>
 <CANn89iLnH5B11CtzZ14nMFP7b--7aOfnQqgmsER+NYNzvnVurQ@mail.gmail.com>
 <CAFUsyfK-znRWJN7FTMdJaDTd45DgtBQ9ckKGyh8qYqn0eFMMFA@mail.gmail.com>
 <CANn89iJA1JOevgLSK019VYXKkLJsMjV-u9ZHvrgZ+XUypRWwfQ@mail.gmail.com> <CAFUsyfLeVGW8etXHuSGvYy_RoS3RGaA1L+NLKnpc7EsSMVORBg@mail.gmail.com>
In-Reply-To: <CAFUsyfLeVGW8etXHuSGvYy_RoS3RGaA1L+NLKnpc7EsSMVORBg@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 26 Nov 2021 10:27:06 -0800
Message-ID: <CANn89iJxMhGfp364rPu6p_ZLrKnM1qWF_NWrw4_oL_KG+piByg@mail.gmail.com>
Subject: Re: [PATCH v1] x86/lib: Optimize 8x loop and memory clobbers in csum_partial.c
To:     Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com,
        Borislav Petkov <bp@alien8.de>, dave.hansen@linux.intel.com,
        X86 ML <x86@kernel.org>, hpa@zytor.com, peterz@infradead.org,
        alexanderduyck@fb.com, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 10:17 AM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
>

>
> Makes sense. Although if you inline I think you definitely will want a more
> conservative clobber than just "memory". Also I think with 40 you also will
> get some value from two counters.
>
> Did you see the number/question I posted about two accumulators for 32
> byte case?
> Its a judgement call about latency vs throughput that I don't really have an
> answer for.
>

The thing I do not know is if using more units would slow down the
hyper thread ?

Would using ADCX/ADOX would be better in this respect ?
