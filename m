Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581AD3C7166
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 15:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236636AbhGMNrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 09:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236222AbhGMNrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 09:47:45 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB718C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 06:44:54 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y42so50394519lfa.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 06:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A9GCE1XyokBjHqSgBA/iJEz3drr7IdUuNv0RdsnzLeE=;
        b=EqpBeNlnm4ViPyJwMUgvpLbBGimxy8xUkaxEZarGaWkEXICuUxFFVTvA+wNN/nvEn6
         pgVxHY/63YMpCOFYGKlNZGhhOhRcTKpfiPpmLretPtpO6zu2QV1/4l2yP4QL0ruMFIDX
         6sFSCpc9GeIPsOLFoAb8fuv15fponjyWlCeKQQAsvZ9bJXtvqhhlls4bT3KoRUV4OJX0
         L9CujbEumsmiCetHoMatkDpyaxIt5iOPMCSsJ4LMdsaztrwyJAvPL3AC6oMMA+3ktx9I
         LnugzSh7/SCUe49vfiS+QYKv1GB7FZBy3flf7gn4TtC3NQ271reHq5tX+VBZpE5pUW7r
         uOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A9GCE1XyokBjHqSgBA/iJEz3drr7IdUuNv0RdsnzLeE=;
        b=oN7z7v/W1Us+DZW/GbykNDkFIUSj4ArnlhPZMzs2kzkoKWqj6Mi/wyaD9R4PYWz6QQ
         RkNZsuIEPI9xtxVjdmmNNcwMAFSKKhWNd9COcg2kqEFzO43K8C2CWp3hiDMon892DLYh
         EbE4dyzJsPSIasDcApCpToXg6umqBqlD9jwHlwbfmqM1jyABwMEDCX6YYda5ZbtO/ikY
         Dw00frDS+bI5bIFiDSube+i5EFTpdUksBGSkdSvOYP69H9Nf2x19LiMe8LTz3GtYqluc
         SochU7m5NxCWq6PAEZJm9wiSIyxI44/Y3MEcG2HbVdYNrZDHXUIfTvR7fwZfaoect+DQ
         B1gw==
X-Gm-Message-State: AOAM531MUQSbY/BqHrlA5nlOM2qBttzxjfHYv9C2d2AeHkt5fM6HZI8M
        tYGceFzOUax2gnBfkJ/Nrg2N8BdSKzOSHosmRFM=
X-Google-Smtp-Source: ABdhPJwWbAqgQWlLJw0BY2EdKR+e7hDanpON3XRb3mTM4I19Xn3x28jmKb62g0+4v6fwWkjtyCsW11A4OB50rjdY6Is=
X-Received: by 2002:ac2:5297:: with SMTP id q23mr3528281lfm.223.1626183893269;
 Tue, 13 Jul 2021 06:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210713133230.GA1872993@pc>
In-Reply-To: <20210713133230.GA1872993@pc>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 13 Jul 2021 10:44:41 -0300
Message-ID: <CAOMZO5C05uBJXxg+Vmy1EAxx5rh7UsF-KQFi2w3cBQ-b=tTDOA@mail.gmail.com>
Subject: Re: [PATCH] gpu: ipu-v3: use swap()
To:     Salah Triki <salah.triki@gmail.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>, alexdeucher@gmail.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Salah,

On Tue, Jul 13, 2021 at 10:33 AM Salah Triki <salah.triki@gmail.com> wrote:
>
> Use swap() instead of implementing it since it makes code more clean.

s/more clean/cleaner

> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
>  drivers/gpu/ipu-v3/ipu-image-convert.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/ipu-v3/ipu-image-convert.c b/drivers/gpu/ipu-v3/ipu-image-convert.c
> index aa1d4b6d278f..5f730cd6009d 100644
> --- a/drivers/gpu/ipu-v3/ipu-image-convert.c
> +++ b/drivers/gpu/ipu-v3/ipu-image-convert.c
> @@ -1021,11 +1021,8 @@ static int calc_tile_offsets_planar(struct ipu_image_convert_ctx *ctx,
>
>                         u_off = y_size - y_off + uv_off;
>                         v_off = (fmt->uv_packed) ? 0 : u_off + uv_size;
> -                       if (fmt->uv_swapped) {
> -                               tmp = u_off;
> -                               u_off = v_off;
> -                               v_off = tmp;

The 'tmp' variable seems to be unused now, so its declaration should be removed.

Thanks
