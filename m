Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 149194191F7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 12:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbhI0KI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 06:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbhI0KIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 06:08:25 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA34C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 03:06:48 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id s75so812712pgs.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 03:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5YhTp9o9JkfPH/hlsQsVVH+v3cNN50Tw/ave2QwHMBE=;
        b=K98uRMrNQbZaBFVhQQJIKdUPPZeCBqB5/CnxSBE6leeUOyIB1o1HihtpqFAMwXBg3E
         6//Ump8ZdmejvwmuWUiTUddPuDF8rob0TolGDyxok6vtigsDl7ahqL6ORkPdxJ0JrtJA
         /zA+5hq7GpcWnS0zpVrc7PSGN/mh7EsHWwBNm6Ote+GtDvS1VtlJq0Uov+29JuiiN0K7
         yEUCMmPng1hl/RRmcf0Y90/MDMT1vo7Fb3YQVXj+KJdgjgMu0uzCN8mPIJDAxMu1ZG/N
         qsvAeTJZBx54Vq93kVgdXhiJA1yq3jhnmwncbHBRtgJjIddednrzUlL/qoM1IwTq7vGO
         qmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5YhTp9o9JkfPH/hlsQsVVH+v3cNN50Tw/ave2QwHMBE=;
        b=lfJRYDBHPXqdxZXlnC7vWNYNWnugcfENZ3tQStMRkyKeyBWaQE69eDzH/MXs5sA3+0
         DJmjv1DbOUYzTnbcbrno/46Nsvok1iwYXW8cTuLw0mslj40HU+GpmFyh3bIuqXy8uzTO
         cK8/ebmfz1spWY1eL+JK618mhOXqmwzqaZ2bAjuMRMqdfPvBh1MbgjLiLi3O5o6Dobuy
         qPgUlfCzre6Ft1OzC5bN2UEyj1sXFjZfCNL3AIqckaHVUQI75z6bbXRe1I89YWPd3yoS
         AeGSvCTK/frnJzO4iA75z+HFGaWSCIxfTsatKvfN3tYhhhn1IVp1tcHHcb9iTIzk+Fia
         CWtg==
X-Gm-Message-State: AOAM531c9ivUy5G8FtdHzZrSqUsMbOS+ZAr8ZHbpQAOJWTGV85beWZWK
        uz28RXz1CjBE1RUJzEusSgnjGGgz0gezHMNph5M=
X-Google-Smtp-Source: ABdhPJxCa4PJd3Vfy54kJokV+/hpaWG6GcDKIJZNJhfApHmvkZbfB8RqBZaxMxs+Me6fax7hDrRu/EuanRzFBNI7X7c=
X-Received: by 2002:a63:551a:: with SMTP id j26mr16234236pgb.142.1632737207479;
 Mon, 27 Sep 2021 03:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210926055817.24352-1-rdunlap@infradead.org>
In-Reply-To: <20210926055817.24352-1-rdunlap@infradead.org>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Mon, 27 Sep 2021 18:06:11 +0800
Message-ID: <CAEbi=3dmw4nTkU1cF4atXDE6Go-tujqseRKjdX7rmPaid_3D3w@mail.gmail.com>
Subject: Re: [PATCH] NDS32: perf_event_cpu: fix 2 build errors
To:     Randy Dunlap <rdunlap@infradead.org>,
        Alan Kao <alankao@andestech.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nickhu <nickhu@andestech.com>,
        Vincent Chen <deanbo422@gmail.com>, kclin@andestech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> =E6=96=BC 2021=E5=B9=B49=E6=9C=8826=E6=
=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8B=E5=8D=881:58=E5=AF=AB=E9=81=93=EF=BC=9A
>
> ../arch/nds32/kernel/perf_event_cpu.c: In function 'unwind_frame_kernel':
> ../arch/nds32/include/asm/current.h:10:13: error: '$r25' undeclared (firs=
t use in this function)
>    10 | #define tsk $r25
> ../arch/nds32/kernel/perf_event_cpu.c:1255:50: note: in expansion of macr=
o 'tsk'
>  1255 |                                                 (tsk, &graph, fra=
me->lp, NULL);
>
> ../arch/nds32/kernel/perf_event_cpu.c:1257:27: error: assignment to 'long=
 unsigned int' from 'long unsigned int *' makes integer from pointer withou=
t a cast [-Werror=3Dint-conversion]
>  1257 |                 frame->sp =3D ((unsigned long *)frame->sp) + 1;
>
> For $r25, use the register function for current() instead.
>
> Fixes: c8b34461705e ("nds32: Add perf call-graph support.")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Nickhu <nickhu@andestech.com>
> Cc: Greentime Hu <green.hu@gmail.com>
> Cc: Vincent Chen <deanbo422@gmail.com>
> ---
> Please check the frame->sp cast/arithmetic.
>
>  arch/nds32/kernel/perf_event_cpu.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> --- linux-next-20210917.orig/arch/nds32/kernel/perf_event_cpu.c
> +++ linux-next-20210917/arch/nds32/kernel/perf_event_cpu.c
> @@ -1252,9 +1252,9 @@ static int unwind_frame_kernel(struct st
>                  */
>                 if (__kernel_text_address(frame->lp))
>                         frame->lp =3D ftrace_graph_ret_addr
> -                                               (tsk, &graph, frame->lp, =
NULL);
> +                                       (current, &graph, frame->lp, NULL=
);
>
> -               frame->sp =3D ((unsigned long *)frame->sp) + 1;
> +               frame->sp =3D (unsigned long)(((unsigned long *)frame->sp=
)) + 1;
>
>                 return 0;
>         } else {

Loop in Alan and KC.
