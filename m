Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE004305A7B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbhA0L5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237114AbhA0Lym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:54:42 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80831C061574
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 03:54:02 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id x21so1536054iog.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 03:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ai5NdOowrSBakZKJ8eQ5sKDACTNsnhQctY19yYzSJYY=;
        b=JLI+ILDcY8CgzNx4U5ERNajaQdOSeMWvZ3Fekwavyt5PBFiZjd4jSLQvX08E9G/T5A
         G30O/ccGCl0WUZRYNM8hk/7y9FEs8wWuyvJcsLEg5Yn2TSIKy0zTL+vxQ3Yxto8t5pxq
         2ZLkLOXd/E3cMLbrIKP2PO0DHPFBZpTumcsDp1Z4vKIN1/+sM7ktwYmTfB4fUGFl3aWc
         oOpD7tkk8A2NS5jyL2YvRG5BZ8aK72/DbwcJTagcKHTew4Sc+6IOGlMLd99pDql6fWHP
         mEATkHZIAGkoby8daAlC5eXxeqQEZb9Oywv3f77Lc/ZQsNYws4qZjVgCUza+speEwiYT
         2bmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ai5NdOowrSBakZKJ8eQ5sKDACTNsnhQctY19yYzSJYY=;
        b=hqKGfYliphZKHESSmta1GaRw9hS8LIAmlC92QXw6VVjjhml52kW/EPGkEsZXNsRspT
         j4KHgBVyKui1sVlpjq5Y45TwkoZaTDMgvXhlxl46buzV5WRzczRUAbFdlzgRptfeiZBP
         lV9+8UO2QEpfAGBmNIW4myOvpX2f4boXX5rjj3oFtssTZkyQ2nn3Oh9GpapZ2XgsXk+C
         2bbpQUG39M9IeZ/SowcfJ8WwNOJjGJ6UEOyqXv17XPTuWZZxndEQI5SdhBvI+RtVGO4j
         RXTCe8p4cQThFYV4LzIZaT/Ap3Z0/XY1AiaWYHNT7MIOSARbm5I3EpozISD+dS5hnLQW
         kldA==
X-Gm-Message-State: AOAM533pw1an0W/2pEcMLVKBImRJus/Nxt4StL2iD91Xo6kPGXxXy+sW
        Ou6GBZ0zNpmBAaiJFGZAOEtNx+n+e3Zd/yBnoZgT7A==
X-Google-Smtp-Source: ABdhPJwhqeLobpvZThrOu+EozN9Ak3JpftpHLK+maCkBfDhICQTfqYMmPN+T7aGmSvO9sads/+l/nDEHdUzoyBMITtE=
X-Received: by 2002:a05:6638:13c6:: with SMTP id i6mr8628625jaj.141.1611748441673;
 Wed, 27 Jan 2021 03:54:01 -0800 (PST)
MIME-Version: 1.0
References: <20210127022507.23674-1-dong.menglong@zte.com.cn>
In-Reply-To: <20210127022507.23674-1-dong.menglong@zte.com.cn>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Wed, 27 Jan 2021 12:53:50 +0100
Message-ID: <CA+i-1C2sWYB-3b=TT0Sta8TsUJToMUhziUBA7HfwMT9XuBcpnw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: change 'BPF_ADD' to 'BPF_AND' in print_bpf_insn()
To:     menglong8.dong@gmail.com
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, kafai@fb.com,
        songliubraving@fb.com, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, netdev@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Menglong Dong <dong.menglong@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks!

On Wed, 27 Jan 2021 at 03:25, <menglong8.dong@gmail.com> wrote:
>
> From: Menglong Dong <dong.menglong@zte.com.cn>
>
> This 'BPF_ADD' is duplicated, and I belive it should be 'BPF_AND'.
>
> Fixes: 981f94c3e921 ("bpf: Add bitwise atomic instructions")
> Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>

Acked-by: Brendan Jackman <jackmanb@google.com>

> ---
>  kernel/bpf/disasm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
> index 19ff8fed7f4b..3acc7e0b6916 100644
> --- a/kernel/bpf/disasm.c
> +++ b/kernel/bpf/disasm.c
> @@ -161,7 +161,7 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
>                                 insn->dst_reg,
>                                 insn->off, insn->src_reg);
>                 else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
> -                        (insn->imm == BPF_ADD || insn->imm == BPF_ADD ||
> +                        (insn->imm == BPF_ADD || insn->imm == BPF_AND ||
>                           insn->imm == BPF_OR || insn->imm == BPF_XOR)) {
>                         verbose(cbs->private_data, "(%02x) lock *(%s *)(r%d %+d) %s r%d\n",
>                                 insn->code,
> --
> 2.25.1
>
