Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF01441D09
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 16:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbhKAPDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 11:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhKAPDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 11:03:46 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E72C061764
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 08:01:13 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id w10so18705429ilc.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 08:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UeCamez7dYjsVrzr0y/VUZD6no3Hy/V9lIflaKTQhDk=;
        b=m8+uc5Hqe0SMu/zS36qgvCpi65JkbeDmRFHvstBwQ5bIVE2XCLjeJjV5cXcrb+K2t6
         IuUXrneaToxudpTgMoPzGljjZz75iTvTwwwklJ12xj78aVw99Gq6ovznhZSGex3R4JbV
         QQqZBaTyH2qJF7UMrZcm0WNRhD5kzJgz3x6YM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UeCamez7dYjsVrzr0y/VUZD6no3Hy/V9lIflaKTQhDk=;
        b=G99gOfAD4cPgOkkCcJwZ/IOJwFeGZxACBvnjZBav8qACEGy08UQlIwfwxBHkUiNgQD
         0lOxJvfhjypuSTZoYv+NclvmkSgbPL4dT5HraGGb0v74mqGwDqsdNbT7K3dXeQcHcPLT
         wwur7tVOy50JEa2XeU2y4U+TiazhvDn7JpJKcGGek40e4yAsBfJtHCEGTJvBqzhtxjnF
         0+X/XjVKqdE2oc5Xmt5rbtPj7LW9CEfe/5Xl2cUbllBosSHTmjHbPpsaGDoOLuk3qQ3S
         1nykmjxnsLaRDkvEM2gmum7/1AcWJ+SipuxTu2H9LOz51gNy2vORhCB50N6OZ/Y6al67
         mlAQ==
X-Gm-Message-State: AOAM531p2cF7mdOmp4GaMpKf6qF7SKBPrrlnR5lPbC/FS+Y8LAnniD5A
        gbHtH5HG+AdzFf8PLZYenSYUubM1z3LMGAroBDO9QA==
X-Google-Smtp-Source: ABdhPJwCzDoM1KKgXMm9p+bT5xCKWNES6qXpJKw0Z+anp4R+lQkPh2d5qolZHXfPnwqrdOJcfW59FWKOhQIaqaqH5IU=
X-Received: by 2002:a05:6e02:148b:: with SMTP id n11mr2709381ilk.83.1635778873157;
 Mon, 01 Nov 2021 08:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <20211028164357.1439102-1-revest@chromium.org> <20211028224653.qhuwkp75fridkzpw@kafai-mbp.dhcp.thefacebook.com>
 <CABRcYmLWAp6kYJBA2g+DvNQcg-5NaAz7u51ucBMPfW0dGykZAg@mail.gmail.com> <204584e8-7817-f445-1e73-b23552f54c2f@gmail.com>
In-Reply-To: <204584e8-7817-f445-1e73-b23552f54c2f@gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Mon, 1 Nov 2021 16:01:02 +0100
Message-ID: <CABRcYmJxp6-GSDRZfBQ-_7MbaJWTM_W4Ok=nSxLVEJ3+Sn7Fpw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Allow bpf_d_path in perf_event_mmap
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@kernel.org, jackmanb@google.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 1, 2021 at 2:17 PM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> Hi,
>
>
> On 2021/10/30 1:02 AM, Florent Revest wrote:
> > On Fri, Oct 29, 2021 at 12:47 AM Martin KaFai Lau <kafai@fb.com> wrote:
> >>
> >> On Thu, Oct 28, 2021 at 06:43:57PM +0200, Florent Revest wrote:
> >>> Allow the helper to be called from the perf_event_mmap hook. This is
> >>> convenient to lookup vma->vm_file and implement a similar logic as
> >>> perf_event_mmap_event in BPF.
> >> From struct vm_area_struct:
> >>         struct file * vm_file;          /* File we map to (can be NULL). */
> >>
> >> Under perf_event_mmap, vm_file won't be NULL or bpf_d_path can handle it?
> >
> > Thanks Martin, this is a very good point. :) Yes, vm_file can be NULL
> > in perf_event_mmap.
> > I wonder what would happen (and what we could do about it? :|).
> > bpf_d_path is called on &vma->vm_file->f_path So without NULL checks
> > (of vm_file) in BPF, the helper wouldn't be called with a NULL pointer
> > but rather with an address that is offsetof(struct file, f_path).
> >
>
> I tested this patch with the following BCC script:
>
>     bpf_text = '''
>     #include <linux/mm_types.h>
>
>     KFUNC_PROBE(perf_event_mmap, struct vm_area_struct *vma)
>     {
>         char path[256] = {};
>
>         bpf_d_path(&vma->vm_file->f_path, path, sizeof(path));
>         bpf_trace_printk("perf_event_mmap %s", path);
>         return 0;
>     }
>     '''
>
>     b = BPF(text=bpf_text)
>     print("BPF program loaded")
>     b.trace_print()
>
> This change causes kernel panic. I think it's because of this NULL pointer.

Thank you for the testing and repro Hengqi :)
Indeed, I was able to reproduce this panic. When vma->vm_file is NULL,
&vma->vm_file->f_path ends up being 0x18 so d_path causes a panic.
I suppose that this sort of issue must be relatively common in helpers
that take a PTR_TO_BTF_ID though ? I wonder if there is anything that
the verifier could do about this ? For example if vma->vm_file could
be PTR_TO_BTF_ID_OR_NULL and therefore vma->vm_file->f_path somehow
considered invalid ?
