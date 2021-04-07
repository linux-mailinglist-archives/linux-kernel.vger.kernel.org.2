Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7AA35747B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 20:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355383AbhDGSn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 14:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbhDGSnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 14:43:25 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D764C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 11:43:14 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id y2so14516211qtw.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 11:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cilium-io.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lwseBhtjiF9OLa/jt/21tHXtZHL6eXnMpFccp0D93oY=;
        b=uoMiJ2FEhGCc7gKHBuuZ8Lu3bgwTY9u5HJf2rqcNzrQRKfWvOYRaBsgCgYY5Df4qFm
         arboEx9wv/v+Kccpy0SCr+AnEhg3JuAmS3Sr8yOXei9b13OuBNK0oEcEKzUb6/6uMyqc
         VZLVOvQNk+P/VuJgSsN9RgJYn6YjdvmDTeISgIB4AVBhZkS2IpJJ7h4udOxe+vopBnqd
         fblwQvTGkM+kGkq0PD83o05gaIl7Fjyve3bttBIj/wSFiHK0Q6Hy6fdQ+5ZcjccBu8x7
         mWQ05BMG/SxhZXf0TQpYkHfOIQjM272nLSnDhTQA/pC/bXmLC7U6oKHHJ7l2yE75Fbvl
         MZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lwseBhtjiF9OLa/jt/21tHXtZHL6eXnMpFccp0D93oY=;
        b=c7NalwWeACEZhxDheUOE7b4RLtqZj4RBXOq1eAD6mTH3DL8gr7V/kHDvTxwq97/sif
         HnvzR+TjQ8FukNNNtrfK4ISfBO3cCHvAIqqtbYr0i/ZoWGNm7zETdUYw87MvuJyP+vDZ
         WcTALJrExE5V6m5yz25V0cYXz/MB5iYGgg7vg/55BWvqiX8d3Exgg5AIMuaFwjxHEd4L
         ORQm+Ks+SbpK8DpBcMkLFvYmKA/OQHjyR5OByoyMCGEJ+T7bcoAoaU+sX+MNv/OQN7Ag
         8QAwzjcfe46rwBhVp1wFcQvvKtcj0bK1A/k7qap2C4kD96G7wGrBG0Dc2iVfedyJ+9na
         LxEw==
X-Gm-Message-State: AOAM532lHfY2p0H/pKC3htBMs9bQKIl5T6rMKuOi5DsVRUhTciXt8QOL
        EiNBh5c4IDO/MSSy0EHqLK9t+iHDmsfdjxMnM5E=
X-Google-Smtp-Source: ABdhPJzPUnxUh0Y3OTUxakdfQh5qa9BFLglLXJ1PfQIGwLP6bz3NPGfGbbi0iwj/kBP+pGi1mNxQrw==
X-Received: by 2002:ac8:4d8b:: with SMTP id a11mr3958359qtw.302.1617820993800;
        Wed, 07 Apr 2021 11:43:13 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id o125sm18807190qkf.87.2021.04.07.11.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 11:43:12 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id l9so6874343ybm.0;
        Wed, 07 Apr 2021 11:43:12 -0700 (PDT)
X-Received: by 2002:a25:2e4d:: with SMTP id b13mr5948575ybn.199.1617820992048;
 Wed, 07 Apr 2021 11:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210406185806.377576-1-pctammela@mojatatu.com>
In-Reply-To: <20210406185806.377576-1-pctammela@mojatatu.com>
From:   Joe Stringer <joe@cilium.io>
Date:   Wed, 7 Apr 2021 11:42:33 -0700
X-Gmail-Original-Message-ID: <CAOftzPgmZSB7oWDLLoO-NEDq3s8LdLxSXdhoaB2feScuTP-JSA@mail.gmail.com>
Message-ID: <CAOftzPgmZSB7oWDLLoO-NEDq3s8LdLxSXdhoaB2feScuTP-JSA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: clarify flags in ringbuf helpers
To:     Pedro Tammela <pctammela@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        "open list:BPF (Safe dynamic programs and tools)" 
        <netdev@vger.kernel.org>,
        "open list:BPF (Safe dynamic programs and tools)" 
        <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
        Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pedro,

On Tue, Apr 6, 2021 at 11:58 AM Pedro Tammela <pctammela@gmail.com> wrote:
>
> In 'bpf_ringbuf_reserve()' we require the flag to '0' at the moment.
>
> For 'bpf_ringbuf_{discard,submit,output}' a flag of '0' might send a
> notification to the process if needed.
>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> ---
>  include/uapi/linux/bpf.h       | 7 +++++++
>  tools/include/uapi/linux/bpf.h | 7 +++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 49371eba98ba..8c5c7a893b87 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -4061,12 +4061,15 @@ union bpf_attr {
>   *             of new data availability is sent.
>   *             If **BPF_RB_FORCE_WAKEUP** is specified in *flags*, notification
>   *             of new data availability is sent unconditionally.
> + *             If **0** is specified in *flags*, notification
> + *             of new data availability is sent if needed.

Maybe a trivial question, but what does "if needed" mean? Does that
mean "when the buffer is full"?
