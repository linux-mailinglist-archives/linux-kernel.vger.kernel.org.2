Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0564265D2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 10:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbhJHIXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 04:23:09 -0400
Received: from mail-vs1-f46.google.com ([209.85.217.46]:41506 "EHLO
        mail-vs1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbhJHIXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 04:23:07 -0400
Received: by mail-vs1-f46.google.com with SMTP id g10so9645641vsb.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 01:21:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZIU2hEBrWy04O/6quAlEqQ6iWBtsadQriVwbmeAJBtA=;
        b=zEQb8NUTnmkvrrMunBvEsHhNKw49e4u3g9qMHzSrHny/mGl6bd314ejKrjALHM4z4W
         egIp3b2OJxppDdkdhPsabUnsC3wRAHAPkAInOSuQ73lvUMKPZvUwLu50dXUT6JafPfWK
         hY33lIvRyeRtwvk9Fb4oU25S1tRD0C1vnBlJFvIShLkXLgXe4GyEtzDznpWDw5Rrw1p1
         rRsjgLUNVcjKAsUkbZT0+wwmlSbhY53O2aE6q1Ywg6DI8NWl8fG5HNShgBNQCDi6rUBE
         AuVE0LPrI2aK4RGMi5oyXbBjeqPdtPhIuaQvLDn+CZQprrnatdpKejXbgiG9MmF+Y+3q
         UMzw==
X-Gm-Message-State: AOAM532ABYo9AMAxkFrRsM/2vtsEtzqz84mP6B4ApRN8CMVZHMgdx9ex
        h4UpZgbY/367SdrlAwaWYqBKzEWoEA9kdGfas7I=
X-Google-Smtp-Source: ABdhPJzDL/QWKRtPp3CyYzPJ8qtOafqR2yCXNGdBjWTg61pglR75eGfmgCJFvJ6P1GLFYI22DeMthm9Y3I8Y+9/A4qY=
X-Received: by 2002:a67:d111:: with SMTP id u17mr8113141vsi.37.1633681272542;
 Fri, 08 Oct 2021 01:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211007214448.6282-1-michael.christie@oracle.com> <20211007214448.6282-3-michael.christie@oracle.com>
In-Reply-To: <20211007214448.6282-3-michael.christie@oracle.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 8 Oct 2021 10:21:01 +0200
Message-ID: <CAMuHMdXy1-jCSTNw8A7ZyvNja5P31kXp=uV2cN-CHrKaaQgCag@mail.gmail.com>
Subject: Re: [PATCH V4 2/8] fork: move PF_IO_WORKER's kernel frame setup to
 new flag
To:     Mike Christie <michael.christie@oracle.com>
Cc:     vverma@digitalocean.com, hdanton@sina.com,
        Christoph Hellwig <hch@infradead.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Stefano Garzarella --cc virtualization @ lists . linux-foundation . org" 
        <sgarzare@redhat.com>, virtualization@lists.linux-foundation.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 7, 2021 at 11:45 PM Mike Christie
<michael.christie@oracle.com> wrote:
> The vhost worker threads need the same frame setup as io_uring's worker
> threads, but handle signals differently and do not need the same
> scheduling behavior. This patch separate's the frame setup parts of
> PF_IO_WORKER into a new PF flag PF_USER_WORKER.
>
> Signed-off-by: Mike Christie <michael.christie@oracle.com>

>  arch/m68k/kernel/process.c       | 2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
