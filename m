Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCF74400F6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 19:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhJ2RLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 13:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhJ2RLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 13:11:39 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26FEC061714
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 10:09:10 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id f9so13249996ioo.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 10:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h3YTNCK7UytUbo7c2/sSDHv06VTVUuG5mVx6fLu0ANg=;
        b=dUmGVmyABnaSqOTbbuKNLggRSkDNQ1gdqkgoLFaFmVZY6ow9uAwg9KkKVgv3Z4Wlt3
         +YOYFnws30IMCAD+quZnzghKZWaK3UlOhdx5n/dBvcgv03foLoGaLTD9cAWPK6Z95l/b
         CxvlQYThZWNv6MSZBl5PyY3t2gg079tw3gsYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h3YTNCK7UytUbo7c2/sSDHv06VTVUuG5mVx6fLu0ANg=;
        b=Nlz4ek3xkNkREnLEnVGWpfkc4Y8ilvww4iPg2Tnk3YCCx/SNtlwEV3I+qrYGaUcU1E
         zfh633Ve3aLUs8/ff1+5h6jV+GF46HlxmY0368xiOKdVd6E18pBFo5Sn+FME0Fyti1yv
         8eI5F9VFngDAt8R8Bjj6hBTy/nGX/tJZPh+ZRMLDj8MqJVNd0kHlyai1IhpbV0HMrIhg
         vBSNwNQpPnvkAuNjZf0StGgaunPqJTLLcwB7VKgXoUKfh8HwieKXww97WHmHjEUrjouO
         cr0jWgpZlLA0df6puT2kINlkbMeO0roxdqCc2GZuYTTm4A1kngOiwlcT+cd5s4I9I5N8
         IDBg==
X-Gm-Message-State: AOAM53203E4TQjSAWEQnw1PvPxtz2ZvRkk2f7kosoAN4WWcnbUL6sRu2
        N0q/8JJ7AwbKaUQ5+b2xIIyFfw37SI/4PPLxeztR/A==
X-Google-Smtp-Source: ABdhPJwynwYAcGRettY3BGY/Q/Jf7JI99GbdakDcb3TOGJKzE8Cmd3gkFBuLrM/DCdHsR49Om2rIYQ+FiCXNI7yeIgw=
X-Received: by 2002:a5d:8719:: with SMTP id u25mr9078165iom.140.1635527350173;
 Fri, 29 Oct 2021 10:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <20211028164357.1439102-1-revest@chromium.org> <20211028224653.qhuwkp75fridkzpw@kafai-mbp.dhcp.thefacebook.com>
 <10a745cc-5942-70ff-483f-a5c77a9776a2@gmail.com>
In-Reply-To: <10a745cc-5942-70ff-483f-a5c77a9776a2@gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Fri, 29 Oct 2021 19:08:59 +0200
Message-ID: <CABRcYmJV6CQOXVx-9orS7twdmDuF8_daQ+h8Ldc=wVXVybs-dw@mail.gmail.com>
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

On Fri, Oct 29, 2021 at 5:17 PM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
>
>
> On 10/29/21 6:46 AM, Martin KaFai Lau wrote:
> > On Thu, Oct 28, 2021 at 06:43:57PM +0200, Florent Revest wrote:
> >> Allow the helper to be called from the perf_event_mmap hook. This is
> >> convenient to lookup vma->vm_file and implement a similar logic as
> >> perf_event_mmap_event in BPF.
> > From struct vm_area_struct:
> >       struct file * vm_file;          /* File we map to (can be NULL). */
> >
> > Under perf_event_mmap, vm_file won't be NULL or bpf_d_path can handle it?
> >
>
> Hmm, is perf_event_mmap a proper tracing target ?
> It does not appear in /sys/kernel/debug/tracing/available_filter_functions.
>
> I tried using kprobe/fentry to attach to it, both failed.

Good observation! :) In the bpf-next tree, perf_event_mmap is still
not exposed to tracing because the kernel/events/Makefile specifically
removes CC_FLAGS_FTRACE for core.c.
However, Song sent a patch to expose the functions of
kernel/events/core.c to tracing:
https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/kernel/events/Makefile?id=79df45731da68772d2285265864a52c900b8c65f

That patch is going through Peter Zijlstra's tree so it should
percolate down to Linus tree probably at ~the same time as this patch
(if it gets in :)). I tested this on bpf-next with Song's patch
cherry-picked.
