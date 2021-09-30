Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E3B41D184
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 04:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347873AbhI3Cje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 22:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347849AbhI3Cjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 22:39:33 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8995EC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 19:37:51 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id o124so5508261vsc.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 19:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FsYqypxg/dr8c8wkXcAf7I6Hd0FSlf0rtrIdWKourdU=;
        b=SaeqEH6gjhtWTbbPlvjvhTi0o4fUIWYNq0JW65SJw7siu39S0ZbRgRH0GVO3MAIXDX
         OVCLvjIO2Thku8+ZEgx/nJpEi+FylTNXWvk4enKtDlDFZ6qMQ9GYYwXYkR1ih/5e8FN9
         Mlzhb4qYw8Dt2N0Rl4u5aI7rN5QLi4x7+S8u9q0UpRZX0sxEZO6KrqlbYVNoCeePZ96G
         VJoqkdMuAhk3ztVa5+SoPpgzXF8orXYDa+WtJTYv7v7xCQx/36rBM63ga2sdP71uUeI6
         rROgxmQy5/Obuo1dWAE9XmrMaZbu0QedLkwAKDzDGke+ctKx60fE5mRVMtVl5vCdrKfT
         5lkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FsYqypxg/dr8c8wkXcAf7I6Hd0FSlf0rtrIdWKourdU=;
        b=bIPX8Rd1mU5BIYVE6Ea2l3xkPE6gL1xFMwfvZ6W6nydQj/kHTFKjKsJjeXv/CgVZ3U
         rRgzgHRXl/oiWQeJcFxJS7/x3i7/T/07OUaAc6OSgrzSLyuqA+3JK+NwhtWd5xirgj21
         hWcUVSeJPlH6nBJRb8zabQ3ShAt6NllRprFvxG38nvR7J1cUxJJTw/htSE1WCXMETVyS
         RmUoV+V3rcek3+RkjjOerQt1ci+I5zwFOwe6b4nUeAtmbYEPCoTDKkSHvhIVbvxrfayy
         GF26eVoDmsaztgEVpbZ7aEJVxHPFDcF+hoPNiwHO2CHGBn1k0ZTIhrQwcYCqAOXTyktB
         +FYA==
X-Gm-Message-State: AOAM532GheDSTi0Xzwul4C/3M2Z/6XGQIMkAbmegV5JQNqh7vcKN32vh
        PiMSdJwhWtIqLwqM5zHO4CSQIbm94rC6eZvJJScUqe2WRbyOyA==
X-Google-Smtp-Source: ABdhPJyL/1fwFO+VYZjrC4XLhQoSFULZrxT2hJ7vv0nhIyQq1/A3zN0JWW/oay21otY+mUGk75mzScSuK2rdFkxrolE=
X-Received: by 2002:a67:f251:: with SMTP id y17mr2073492vsm.22.1632969470752;
 Wed, 29 Sep 2021 19:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631121222.git.greentime.hu@sifive.com> <82fe07af09d223b33c8d4b8986939bcc0d7180a1.1631121222.git.greentime.hu@sifive.com>
In-Reply-To: <82fe07af09d223b33c8d4b8986939bcc0d7180a1.1631121222.git.greentime.hu@sifive.com>
From:   Ley Foon Tan <lftan.linux@gmail.com>
Date:   Thu, 30 Sep 2021 10:37:39 +0800
Message-ID: <CAFiDJ5_Lp8ejFiNpZw=YvneyEFRj-PD9667Jv_hHy_-7xGf+FQ@mail.gmail.com>
Subject: Re: [RFC PATCH v8 11/21] riscv: Add sigcontext save/restore for vector
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        aou@eecs.berkeley.edu, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        vincent.chen@sifive.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 9, 2021 at 1:49 AM Greentime Hu <greentime.hu@sifive.com> wrote:
>
> This patch adds sigcontext save/restore for vector. The vector registers
> will be saved in datap pointer. The datap pointer will be allocated
> dynamically when the task needs in kernel space. The datap pointer will
> be set right after the __riscv_v_state data structure to save all the
> vector registers in the signal handler stack.
>
> Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> ---
>  arch/riscv/include/uapi/asm/sigcontext.h |  24 ++++
>  arch/riscv/kernel/asm-offsets.c          |   2 +
>  arch/riscv/kernel/setup.c                |   4 +
>  arch/riscv/kernel/signal.c               | 164 ++++++++++++++++++++++-
>  4 files changed, 190 insertions(+), 4 deletions(-)
>

[....]


> +
> +static size_t cal_rt_frame_size(void)
> +{
> +       struct rt_sigframe __user *frame;
> +       static size_t frame_size;
> +       size_t total_context_size = 0;
> +       size_t sc_reserved_size = sizeof(frame->uc.uc_mcontext.__reserved);
> +
> +       if (frame_size)
> +               goto done;
> +
> +       frame_size = sizeof(*frame);
> +
> +       if (has_vector)
> +               total_context_size += rvv_sc_size;
> +       /* Preserved a __riscv_ctx_hdr for END signal context header. */
> +       total_context_size += sizeof(struct __riscv_ctx_hdr);
> +
> +       if (total_context_size > sc_reserved_size)
> +               frame_size += (total_context_size - sc_reserved_size);
> +
> +done:
> +       return round_up(frame_size, 16);

Hi Greentime,

frame_size is static variable here, so it will preserve the value for
the next calling to cal_rt_frame_size().

I think we need update frame_size before return, example:

frame_size =  round_up(frame_size, 16);
return frame_size;


Regards
Ley Foon
