Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4423DAA23
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 19:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhG2R2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 13:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhG2R2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 13:28:51 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BA4C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:28:48 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id f6so2316266ioc.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3FtzGKwABQo72/dMQleZZDertRJDDXn2wvynHfmBqH8=;
        b=YzPmZW5EZSwHZDq92FKwxPy69FMJ+2vDI4hnu59VWRFvOaa3lNGNbNgT+IyKNgor4g
         YuFsHIuTnutoXdkfl9dzUEYBWK78CV7QVbLzWbxajuDW324SdTapaHIpxUc51060I2Q5
         z1y1UhU2h7Z6oRZ1u2DHd+Uexq5xVre4jISJnvr0Qzp62Km0hIczN2r+0R9bOqN/kA0u
         5VyhURGkV3umzSqPV8SotzGVVstK7AqlWhd90kjOMJDlPllUOSrEzCuAen/5FgQbYvbW
         JPQOAlRZLxfxbdyO1Gw/FmNrTc0Z8tSl00ZMrDomLjUQJpUOrDAV+FLF2trTXRsYIG8K
         rCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3FtzGKwABQo72/dMQleZZDertRJDDXn2wvynHfmBqH8=;
        b=eqwk9FkC1sXXkcJwF6fpsB9A0MNZ9sMfBM9pUluWXDwuDP+B5NJZMzAzHxTzMiL//a
         tQYxn88aostu6TfYdgz6gWy4xfBQjGiMypekDvJxIe/u28tdlM4DInX1sY+IUVdCElxN
         7IAwEllcsfkrQCfRu7R4FqWi2F0bFtx7ZP1McTLJSQaFfzj2loVs+TVOeecyfNvia/h1
         wP6A8dPaDzR2yuX4KPa9BDipIR/IvQQ5aEorfs83RxBk5q8Me1MqGB0si+obDeJ/eh6X
         7hrjGrpXxWepqp2qhllRMpUbiZ9R89iGijZ/j0mYjKYqD+IaYS6HoHTLQfIiq32hP9Oy
         jU8w==
X-Gm-Message-State: AOAM530BIKf93dljmtLY3DdSTLhJCvysSRn9IDDN2lU88R/SeWaAN6C9
        YHV5kfCpqdMK0h6TpsH/b+MZJC9SsfRHaNh/8lQ7NA==
X-Google-Smtp-Source: ABdhPJwfYweaYZvTqmLoiQYvOqERUYEe8DE+aZWTwo/E3l/mFh8dV39ZuZUZ/gGUmFu6jGbTlSHuHO37HIaWI5xKqzk=
X-Received: by 2002:a05:6638:3a12:: with SMTP id j18mr5500606jaj.75.1627579726879;
 Thu, 29 Jul 2021 10:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210729092841.38175-1-ligang.bdlg@bytedance.com>
In-Reply-To: <20210729092841.38175-1-ligang.bdlg@bytedance.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 29 Jul 2021 10:28:11 -0700
Message-ID: <CAJHvVcjou-AvG4VJ1zeiCUg-WWsNTVA6ni2U1OGOUnjJ24x8vQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: mmap_lock: use DECLARE_EVENT_CLASS and DEFINE_EVENT_FN
To:     Gang Li <ligang.bdlg@bytedance.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>

On Thu, Jul 29, 2021 at 2:28 AM Gang Li <ligang.bdlg@bytedance.com> wrote:
>
> By using DECLARE_EVENT_CLASS and TRACE_EVENT_FN, we can save a lot
> of space from duplicate code.
>
> Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
> ---
>  include/trace/events/mmap_lock.h | 44 +++++++++-----------------------
>  1 file changed, 12 insertions(+), 32 deletions(-)
>
> diff --git a/include/trace/events/mmap_lock.h b/include/trace/events/mmap_lock.h
> index 5f980c92e3e9..b9dd66f9c226 100644
> --- a/include/trace/events/mmap_lock.h
> +++ b/include/trace/events/mmap_lock.h
> @@ -13,7 +13,7 @@ struct mm_struct;
>  extern int trace_mmap_lock_reg(void);
>  extern void trace_mmap_lock_unreg(void);
>
> -TRACE_EVENT_FN(mmap_lock_start_locking,
> +DECLARE_EVENT_CLASS(mmap_lock,
>
>         TP_PROTO(struct mm_struct *mm, const char *memcg_path, bool write),
>
> @@ -36,11 +36,19 @@ TRACE_EVENT_FN(mmap_lock_start_locking,
>                 __entry->mm,
>                 __get_str(memcg_path),
>                 __entry->write ? "true" : "false"
> -       ),
> -
> -       trace_mmap_lock_reg, trace_mmap_lock_unreg
> +   )
>  );
>
> +#define DEFINE_MMAP_LOCK_EVENT(name)                                    \
> +       DEFINE_EVENT_FN(mmap_lock, name,                                \
> +               TP_PROTO(struct mm_struct *mm, const char *memcg_path,  \
> +                       bool write),                                    \
> +               TP_ARGS(mm, memcg_path, write),                         \
> +               trace_mmap_lock_reg, trace_mmap_lock_unreg)
> +
> +DEFINE_MMAP_LOCK_EVENT(mmap_lock_start_locking);
> +DEFINE_MMAP_LOCK_EVENT(mmap_lock_released);
> +
>  TRACE_EVENT_FN(mmap_lock_acquire_returned,
>
>         TP_PROTO(struct mm_struct *mm, const char *memcg_path, bool write,
> @@ -73,34 +81,6 @@ TRACE_EVENT_FN(mmap_lock_acquire_returned,
>         trace_mmap_lock_reg, trace_mmap_lock_unreg
>  );
>
> -TRACE_EVENT_FN(mmap_lock_released,
> -
> -       TP_PROTO(struct mm_struct *mm, const char *memcg_path, bool write),
> -
> -       TP_ARGS(mm, memcg_path, write),
> -
> -       TP_STRUCT__entry(
> -               __field(struct mm_struct *, mm)
> -               __string(memcg_path, memcg_path)
> -               __field(bool, write)
> -       ),
> -
> -       TP_fast_assign(
> -               __entry->mm = mm;
> -               __assign_str(memcg_path, memcg_path);
> -               __entry->write = write;
> -       ),
> -
> -       TP_printk(
> -               "mm=%p memcg_path=%s write=%s",
> -               __entry->mm,
> -               __get_str(memcg_path),
> -               __entry->write ? "true" : "false"
> -       ),
> -
> -       trace_mmap_lock_reg, trace_mmap_lock_unreg
> -);
> -
>  #endif /* _TRACE_MMAP_LOCK_H */
>
>  /* This part must be outside protection */
> --
> 2.20.1
>
