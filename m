Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470F94400E1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 19:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhJ2REy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 13:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhJ2REx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 13:04:53 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75828C061714
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 10:02:24 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id w10so11278267ilc.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 10:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PJvarO8L5W2e7uLHhloQuMwGrgNW5hY97FRnmyvhwnM=;
        b=XrghPzUtutSQMfL7zTS5TE9yze/ZX1oFMPQFFt36/PBYRO6dW9IbwkKETsuu87E/6x
         LgoSXTNNA7T8QRRgNVdTAEuucZoTDkoNTrS5FUNPMB85rtLjrdpELCuHP6WjvX+SPVk9
         SZVC43nEy+FhT9Hl4JLvWDzhOO9469yVS7AvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PJvarO8L5W2e7uLHhloQuMwGrgNW5hY97FRnmyvhwnM=;
        b=7HgVgHnjtNox4WVn6fx3HkNgVaOZmuqYmRgkwPS0TubHgvE85t2Mq6pAgpisXD34nE
         FxCCOjzoT2nnyPWa/Ur7JpcQqDqG4zQTkQp293S5RwT9QjqrBAaAkohAvm46Ekc6DSj7
         8yu9GzIJ7oVlhaz8fDOBtH1Q9mZk/DD6BO4gXGVb4jnZw5lSDss1aydDgZcvnRes+6Fc
         k98UlnffknpdTi60zy4f7ar10rZWjn3PmQrW8SFYXy1EBX+kCHpZnBoASomzqtFjyFtU
         7cgijKQLpPdag0bFzJhV0Xql7CEnwDdrukZMoZ2VN3QSDvkGLs5e3A9a8/KHlw5kyMEX
         n95A==
X-Gm-Message-State: AOAM530Rtooc6uaYF/yAhB46q/99YWjt0JFxmB53NbZc+uwYyihLdU4/
        mvLkqYv5rXyuCLprI0jy5aytNQ7ii3MaD9a4KSfhVw==
X-Google-Smtp-Source: ABdhPJym0YJFatUvwp30E3R57zpL6u5GgzHHF/djLyeGUVvMlQalgoxf4b8ZyBt6ZB7bZIjf67NTU0IjUscniU+zoxw=
X-Received: by 2002:a92:c26f:: with SMTP id h15mr2887252ild.83.1635526943894;
 Fri, 29 Oct 2021 10:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <20211028164357.1439102-1-revest@chromium.org> <20211028224653.qhuwkp75fridkzpw@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20211028224653.qhuwkp75fridkzpw@kafai-mbp.dhcp.thefacebook.com>
From:   Florent Revest <revest@chromium.org>
Date:   Fri, 29 Oct 2021 19:02:13 +0200
Message-ID: <CABRcYmLWAp6kYJBA2g+DvNQcg-5NaAz7u51ucBMPfW0dGykZAg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Allow bpf_d_path in perf_event_mmap
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, jackmanb@google.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 12:47 AM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Thu, Oct 28, 2021 at 06:43:57PM +0200, Florent Revest wrote:
> > Allow the helper to be called from the perf_event_mmap hook. This is
> > convenient to lookup vma->vm_file and implement a similar logic as
> > perf_event_mmap_event in BPF.
> From struct vm_area_struct:
>         struct file * vm_file;          /* File we map to (can be NULL). */
>
> Under perf_event_mmap, vm_file won't be NULL or bpf_d_path can handle it?

Thanks Martin, this is a very good point. :) Yes, vm_file can be NULL
in perf_event_mmap.
I wonder what would happen (and what we could do about it? :|).
bpf_d_path is called on &vma->vm_file->f_path So without NULL checks
(of vm_file) in BPF, the helper wouldn't be called with a NULL pointer
but rather with an address that is offsetof(struct file, f_path).
