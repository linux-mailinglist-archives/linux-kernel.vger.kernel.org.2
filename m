Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963844222EA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 11:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbhJEJ7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 05:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbhJEJ72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 05:59:28 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D77C061764
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 02:57:35 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id d8so7364162edx.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 02:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mcUx6mFpPjRWb+s/DSiH7CSR1lxitUSgQfuJXwjrEzM=;
        b=XxjVUrlzLpLKzpxmT+9cuXU4t7FWXSQ+5JK+kHlkVE+zALIUo6EP0uLi69A7WEhfcs
         Hd630y3z8QG+bgU5PGoV0r4iklRHOhbpy7us9MKQUczYD1lH0yUmu3c7Sw1PX/iwJzLi
         Lf2iDxuAAMZHS9Utm25mtNWFCxVXjd1+hIa7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mcUx6mFpPjRWb+s/DSiH7CSR1lxitUSgQfuJXwjrEzM=;
        b=qCpWViYvR2lXPhDTlUw4CtO/vv/rPnpFJzRNyr4e2SxJ89Ke/fa8xf84oYK/cknJDf
         lQfHJuGXl1bl9UywSVE2F7tK0BwI7raHjyAEcmLkSHGrJS9Ak57RZBvRseoGMUBwMzbA
         qY7fd/GMg0MHQxaLCWk0U4/UB8hutnhyhyXBBZMPBXOUIXarvHthHCy2G8YfsN7SbhHH
         8oeG8sShwqXTWKniEuAyB8m2V4bSFnToViVNCeNAer1uVtVnDJxk1K2puyH8wCx6lmPm
         FgWI7mfQjHDRSe6aPMYqpHb/7Z8jmpphG7yKTx/Wfq2IYpmfCFxktaqt2FzWU/3izYlR
         Z8yw==
X-Gm-Message-State: AOAM533yn+LdbBs6pY2IDF8uQ4WqYJqCalxwUlWnXpJ9fcJniBZSejEl
        evC4eIJh8DO/nsNrp34J6a79c3pj1SZDRQ==
X-Google-Smtp-Source: ABdhPJxHX/xYstw8iwzFrVUO85q6vhfUwNhpKCLHMwe/0UFT06z1RgEiaiHXG5YJskrVgXE4z6nIRg==
X-Received: by 2002:a50:d511:: with SMTP id u17mr23708050edi.105.1633427853027;
        Tue, 05 Oct 2021 02:57:33 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id jt24sm7704740ejb.59.2021.10.05.02.57.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 02:57:32 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id v25so25566591wra.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 02:57:32 -0700 (PDT)
X-Received: by 2002:adf:a184:: with SMTP id u4mr20543894wru.69.1633427851714;
 Tue, 05 Oct 2021 02:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210928034634.333785-1-senozhatsky@chromium.org>
In-Reply-To: <20210928034634.333785-1-senozhatsky@chromium.org>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 5 Oct 2021 18:57:20 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DLiW23a0U_JjnpvoYmpcbiKbStq7=w=7KvbDP7zLvBaA@mail.gmail.com>
Message-ID: <CAAFQd5DLiW23a0U_JjnpvoYmpcbiKbStq7=w=7KvbDP7zLvBaA@mail.gmail.com>
Subject: Re: [PATCH] media: videobuf2: always set buffer vb2 pointer
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 12:46 PM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> We need to always link allocated vb2_dc_buf back to vb2_buffer because
> we dereference vb2 in prepare() and finish() callbacks.
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  drivers/media/common/videobuf2/videobuf2-dma-contig.c | 3 +++
>  1 file changed, 3 insertions(+)
>

Acked-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz

> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> index b052a4e36961..38767791955d 100644
> --- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> +++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> @@ -600,6 +600,7 @@ static void *vb2_dc_get_userptr(struct vb2_buffer *vb, struct device *dev,
>
>         buf->dev = dev;
>         buf->dma_dir = vb->vb2_queue->dma_dir;
> +       buf->vb = vb;
>
>         offset = lower_32_bits(offset_in_page(vaddr));
>         vec = vb2_create_framevec(vaddr, size);
> @@ -788,6 +789,8 @@ static void *vb2_dc_attach_dmabuf(struct vb2_buffer *vb, struct device *dev,
>                 return ERR_PTR(-ENOMEM);
>
>         buf->dev = dev;
> +       buf->vb = vb;
> +
>         /* create attachment for the dmabuf with the user device */
>         dba = dma_buf_attach(dbuf, buf->dev);
>         if (IS_ERR(dba)) {
> --
> 2.33.0.685.g46640cef36-goog
>
