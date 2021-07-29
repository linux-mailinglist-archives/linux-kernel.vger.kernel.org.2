Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213E93DAA11
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 19:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbhG2R0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 13:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhG2RZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 13:25:56 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37827C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:25:53 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id c3so6695309ilh.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1TJn11KWxh6Ms0mK4tEBNoyeY+OXDD+P+VEKQkQD+NY=;
        b=gArWMxjXXqu1OGyaMxDZQLC7i3MHPcCwF64UUfAPXyDJCorXxfzg5a5vysUeCi0oTs
         7wFR6iAl9vrkIiIim8d796MbceV1SQt3ohDK1ASDKT6JrvVjxpWxD8wEaGlV/tnO57t3
         RmC0xlJtZW/UDFxt5uAXeyNkypjdqlbCYCZn4FR/6qqp4gdTPuPWTE8T6vE1kiYtNXZv
         UZfE+jUng3gWHY8JQ1PLBmsioi9bcfuEB7t/MyPzXlGUYCT8EjD1ypK1T7hGkc5P3te4
         4YwtB2Au81Hle8YpONuLo35dtXRlJUYybfoeR6F2rTFIP6zhpArk30NC+p/P0VeWvg2P
         ejaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1TJn11KWxh6Ms0mK4tEBNoyeY+OXDD+P+VEKQkQD+NY=;
        b=BXQK+ZoTwDpbyt/hLucmTnFFwof3z9H21iFEN4x0qEcdo8AVA+rysDc+6MO7EGk8mj
         cjKICk6Qkh/pJYGowOAR6gQn0X7OWmvTanvAWWmdzYOMObFnGt6utn6NCwW6HxCjVVog
         AwWmE+6VCDLCYmnwqc3Jf5HAc+ZqsolSCGuyY6Y+iurUHcMM02rLFbJ70+Rmxf49bKyC
         h/22lr+BOjXgBGh+v0lD/kM38AlsDaASxVBJLukjx11P+Qa0oNxn1ePS2XDZdDNDPxFc
         vsyS3i8YdYdBFoPpzv9m7F1xFM0CZTvjZ7vd3/L1p0uY9aY4LCb15MHOHj1DG9PHiu1g
         kkSA==
X-Gm-Message-State: AOAM530YrgY/YYxBhjJYYPcBYTGVS9XzE116YEikbTikZI3VLnR+8hf/
        A6QxwXnqxvt4q2a/DxSUgczH3NkFs4oiCdenhIpyNQ==
X-Google-Smtp-Source: ABdhPJxBgdfROfnlNJH7EqhAkcAqMv7RaO3xL0u4dbECwCJh6xgg0R0BASRody0t0fg1QO6ecx070wnnTrtihecu8Do=
X-Received: by 2002:a92:6503:: with SMTP id z3mr4427664ilb.258.1627579552466;
 Thu, 29 Jul 2021 10:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210729092831.38106-1-ligang.bdlg@bytedance.com>
In-Reply-To: <20210729092831.38106-1-ligang.bdlg@bytedance.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 29 Jul 2021 10:25:16 -0700
Message-ID: <CAJHvVchhhUXyi2YbaqMW53y=bT50kmOBjjbApaMG8QZPQ=h1OQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: mmap_lock: remove redundant "\n" in TP_printk
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
> Ftrace core will add "\n" automatically on print. "\n" in TP_printk
> will create blank line, so remove it.
>
> Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
> ---
>  include/trace/events/mmap_lock.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/trace/events/mmap_lock.h b/include/trace/events/mmap_lock.h
> index 0abff67b96f0..5f980c92e3e9 100644
> --- a/include/trace/events/mmap_lock.h
> +++ b/include/trace/events/mmap_lock.h
> @@ -32,7 +32,7 @@ TRACE_EVENT_FN(mmap_lock_start_locking,
>         ),
>
>         TP_printk(
> -               "mm=%p memcg_path=%s write=%s\n",
> +               "mm=%p memcg_path=%s write=%s",
>                 __entry->mm,
>                 __get_str(memcg_path),
>                 __entry->write ? "true" : "false"
> @@ -63,7 +63,7 @@ TRACE_EVENT_FN(mmap_lock_acquire_returned,
>         ),
>
>         TP_printk(
> -               "mm=%p memcg_path=%s write=%s success=%s\n",
> +               "mm=%p memcg_path=%s write=%s success=%s",
>                 __entry->mm,
>                 __get_str(memcg_path),
>                 __entry->write ? "true" : "false",
> @@ -92,7 +92,7 @@ TRACE_EVENT_FN(mmap_lock_released,
>         ),
>
>         TP_printk(
> -               "mm=%p memcg_path=%s write=%s\n",
> +               "mm=%p memcg_path=%s write=%s",
>                 __entry->mm,
>                 __get_str(memcg_path),
>                 __entry->write ? "true" : "false"
> --
> 2.20.1
>
