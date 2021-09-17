Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9775940FA3F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 16:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243036AbhIQOgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 10:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241700AbhIQOga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 10:36:30 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7CEC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 07:35:08 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id n27so14308061oij.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 07:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ID+EROtCIq5uKg/d863vFLkQbbXUtaQHcxjVUWZxmJg=;
        b=ECs95L59V1c5niovkF76nE4YKmQuTv0PTD62kQiRhRclIIj9933G+G+bOItYg/s0la
         jz7c0oYfnP3h8WI0SvWXb4FiTSfIJgX40XIazB+wIWjOqAFGiPyFdKxfW/AnQCRzboIN
         arXL2T9x1efYsHEDkaC+3YgdqYdBXQOUoZP1BDIBQK2oLt2RzyRgAoosktEsFFs8bG4A
         dSr0LUITSxD3KX95IPvzDjVmVm9aKRlxRHpRpHqug0Ury4sP8UxL054Lk1H27GXI+rKV
         vavOyBlyHbl3ZY40Wfl8PPaDFsAwVHfozfLrUkOFddKFFmHX9an6HBN1Xq58uB3veLsF
         iqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ID+EROtCIq5uKg/d863vFLkQbbXUtaQHcxjVUWZxmJg=;
        b=CufkaK+YVGB6a5W69iydG6fkkCiRt3E4SzGy4F6InHtnXA7PP2HmHUYDJPVyHAcM+j
         0ows9zOFuWZv+8LDdK5nVEZPBDb9oobPD9hky+BL7siFiLH7qxQ6uSrvp2L5RQhqEMXD
         PInWaoq2xeJ0ARp/DY7sWyPHY4tRGedceKL9j1ZpwASdd+SJ5akSPQNd2FxXVgkwiXR0
         G2gBWcpYFmQ5MyCfjvL4u34TS+v7ukgDJUGApKYNWBeb+w+v2wmNeVKj7k3vsoHFH5NZ
         yGwgbO4Bl4vriVFsYnc49ZYu3Q1CPXdtaRgSQ/3wqAZuv04G/coEIn3GsbonnVTrLY/r
         atyA==
X-Gm-Message-State: AOAM530h4OZEGygPXScG6T+6Ylr4MEYoAd4WVSJ6JRbHfWQrdZzKxg0P
        kcmaNjpt8iXSGiC/jB9OlPoW3HP3WznocUpnFb8L9A==
X-Google-Smtp-Source: ABdhPJyzOOqSe7lVIn0OaDHquEuIIjZa0Fydfcr55etLrv+vuG7Rywx1ezWPSoSkP+9GaW/U1K3v21OJ5L20N11b8P8=
X-Received: by 2002:aca:f189:: with SMTP id p131mr13881383oih.128.1631889307519;
 Fri, 17 Sep 2021 07:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210830172627.267989-1-bigeasy@linutronix.de> <20210830172627.267989-2-bigeasy@linutronix.de>
In-Reply-To: <20210830172627.267989-2-bigeasy@linutronix.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 17 Sep 2021 16:34:56 +0200
Message-ID: <CACT4Y+aj3UkhEBq+ROyM=Ns138xpEfCNXSvGRLAXTFyOVkFA8A@mail.gmail.com>
Subject: Re: [PATCH 1/5] Documentation/kcov: Include types.h in the example.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marco Elver <elver@google.com>,
        Clark Williams <williams@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Aug 2021 at 19:26, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> The first example code has includes at the top, the following two
> example share that part. The last example (remote coverage collection)
> requires the linux/types.h header file due its __aligned_u64 usage.
>
> Add the linux/types.h to the top most example and a comment that the
> header files from above are required as it is done in the second
> example.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Dmitry Vyukov <dvyukov@google.com>


> ---
>  Documentation/dev-tools/kcov.rst | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/dev-tools/kcov.rst b/Documentation/dev-tools/kcov.rst
> index d2c4c27e1702d..347f3b6de8d40 100644
> --- a/Documentation/dev-tools/kcov.rst
> +++ b/Documentation/dev-tools/kcov.rst
> @@ -50,6 +50,7 @@ The following program demonstrates coverage collection from within a test
>      #include <sys/mman.h>
>      #include <unistd.h>
>      #include <fcntl.h>
> +    #include <linux/types.h>
>
>      #define KCOV_INIT_TRACE                    _IOR('c', 1, unsigned long)
>      #define KCOV_ENABLE                        _IO('c', 100)
> @@ -251,6 +252,8 @@ selectively from different subsystems.
>
>  .. code-block:: c
>
> +    /* Same includes and defines as above. */
> +
>      struct kcov_remote_arg {
>         __u32           trace_mode;
>         __u32           area_size;
> --
> 2.33.0
>
