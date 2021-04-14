Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32C535F1C6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 12:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbhDNK5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 06:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbhDNK5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 06:57:18 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A50C061756
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 03:56:57 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id v26so20211656iox.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 03:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xJdZSbHTyMBCsVp7BAaTCxdXi6B0tpl9od8+wlQ9J+g=;
        b=TEAgfFBFUB3b0fB+QOyjxFBwYw0U5RxeWNc26RxJa8ik23iALaiCaRngy5LMzw9L8o
         ngDCjNrtS7pw5RNK5LCLafOfxKX5DMh1H3zLWoCqWVa9aaP7xk6xhD22vEEhdjO/3zMq
         4tbPUaynT31cZgfRtXvFhfpcpcSWqp//AzYq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xJdZSbHTyMBCsVp7BAaTCxdXi6B0tpl9od8+wlQ9J+g=;
        b=GdpzSmCInUpHcOlfWsV+yX15iCq0gSaEu6PJmLyCrrB+ic4jk/8cPKHH5pFuBSFN0z
         RkbewqzwkUIF3DrW6YqHwmU9+PMB04M9Df9YEbpSTbpRgd2myxAVgztEwIYn3lTxkGK1
         0/Tt40mgjLxWC+3rxzvlo0oWcvtTnYPyRc+kl+NNrsUMilKBlfIkOtvQWE9pp+TELRQA
         EvKQDuduwqdgbK5nEnTim7TsvgryVkHYaM0NqM7Qc12nrMvmG5l6EPuSKd9RQl8b63P7
         7pL0J5eLKN1sLeMGGlkJ4Rccf/0yuM4cvEseaYlkSY5VAd4dQcNMBykTV207wQHIMO8T
         tm7A==
X-Gm-Message-State: AOAM532vD9pqRz875H7r7h2jZwhLEKvTrd8WMjAnygC4P9FHE/BvZUJx
        Jj+TzuOWi4tjX0DsBk0fzNba9TmQBnvcc1LbXdSrBulU3Lc=
X-Google-Smtp-Source: ABdhPJzbOpygaeq8A7GMJvLn+Om67N8hLLaO1CKhbeDgYPkDMIxrniuJJUuaib3hhaIExfwv2HbHOYjtPypZ2p0Mt3M=
X-Received: by 2002:a02:b197:: with SMTP id t23mr37906352jah.125.1618397816954;
 Wed, 14 Apr 2021 03:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210412153754.235500-1-revest@chromium.org> <20210412153754.235500-2-revest@chromium.org>
 <CAEf4BzaUeE7EPObUuS=NPw9qmssxJ=i6+M1v6A3=wvLVGOKkXg@mail.gmail.com> <CABRcYmKjcZD4px3QwjqMZozOJDTXV+fWvf+w2R=ssPyBOJmMTg@mail.gmail.com>
In-Reply-To: <CABRcYmKjcZD4px3QwjqMZozOJDTXV+fWvf+w2R=ssPyBOJmMTg@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 14 Apr 2021 12:56:46 +0200
Message-ID: <CABRcYmJz_yGqJx_suu8JN8SkHZm10RaSS5xx=f7QDZFFNS9twg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/6] bpf: Factorize bpf_trace_printk and bpf_seq_printf
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 11:56 AM Florent Revest <revest@chromium.org> wrote:
> On Wed, Apr 14, 2021 at 1:01 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Mon, Apr 12, 2021 at 8:38 AM Florent Revest <revest@chromium.org> wrote:
> > > +       err = 0;
> > > +out:
> > > +       put_fmt_tmp_buf();
> >
> > so you are putting tmp_buf unconditionally, even when there was no
> > error. That seems wrong? Should this be:
> >
> > if (err)
> >     put_fmt_tmp_buf()
> >
> > ?
>
> Yeah the naming is unfortunate, as discussed in the other patch, I
> will rename that to bpf_pintf_cleanup instead. It's not clear from the
> name that it only "puts" if the buffer was already gotten.

Ah, sorry I see what you meant! Indeed, my mistake. :|
