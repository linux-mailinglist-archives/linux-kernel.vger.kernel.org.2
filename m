Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2403BCB54
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 13:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhGFLDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 07:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbhGFLDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 07:03:50 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3699C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 04:01:11 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id i13so20150890ilu.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 04:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kvBujR3c3TvHs4rJ1CKzRPrcuCVUy+R3S/pzO7+bJds=;
        b=vt3nO1YJYK2mbF4b07jhZqUkfFIxt0ck8MTi5rNSFoUBj+uFv4aRZWw8W2Ml5AlLxk
         IBJTtlPQYEp7nWRClNj3glvDeVZ6e7jeAUtGMN2xS23FTI2IbP3Z2fCk/DsKiZKFTCY+
         wwCi3c+jJsxjixMNwJbBkYb41v229v3nj8ZH03zRMnmOqanas1PGRkZOimScxUbvFBm9
         /ntCWNtqwHvMmyOOBzHPMMzCUZ2UM+ND0pH5nSZH2tX3KWoOVC+lqIzD0dsPAJeOUemq
         bTZZMr5MdJK41ahXs7cpaRGGQ+eRbIcgNwBFHoE3rmRFIxkEAgfQu1cWTONXzJjX/jkg
         NOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kvBujR3c3TvHs4rJ1CKzRPrcuCVUy+R3S/pzO7+bJds=;
        b=lb/viVU709RkElyV4vlVuFoOo9pgrAZPslhaFKlhgqNXXnBDuPbmgS90SYfxQyR1L8
         GMp4QUyojV6oYfnOj+SW03+6lQ5tcoc5zvjlS5A6DOAJrwBDRzfb164A3YO0h8fPVJxh
         oHGopa42Ho63Um8RrcwUcqcI8zduxGUqvWeFKb7OchLPZeB2QzcjCDT53tezy0AzFC7+
         932XMf8pzxJ2/NKBUNuce7jZV7aozj/xXKOOIyaIbH3t67SBF2QYTc/eIMtZ6YtXUoWw
         5h2IGWoS2TMZGNztYoJbFfvPvoizWcCwTMJK/zHRoJ+71KiadgV0vco9UuAhyv2jC5ZB
         BUXQ==
X-Gm-Message-State: AOAM5317OlHZns0/V8aNd+2c7M7FkRw0C/Z8oWsEgNA/063jx6myPQUt
        aH0ocFS8qbDsGPzlS5sTvX56HTRmiNcJ5J+MetaF3w==
X-Google-Smtp-Source: ABdhPJzRbRkiGYUFPhDAfHS61HWOcbGhKPv72HKYRsn+Pi3oY0xKoMEYgTUXE+U8XZn4rjZBlt0oZwDUf0K+sUHvGGk=
X-Received: by 2002:a92:dd05:: with SMTP id n5mr13596206ilm.72.1625569271156;
 Tue, 06 Jul 2021 04:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <1625038079-25815-1-git-send-email-kyrie.wu@mediatek.com> <1625038079-25815-10-git-send-email-kyrie.wu@mediatek.com>
In-Reply-To: <1625038079-25815-10-git-send-email-kyrie.wu@mediatek.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Tue, 6 Jul 2021 19:01:00 +0800
Message-ID: <CA+Px+wWkS-PMVa4DGc9df8p8QLDFEvQXbOhYJb-rqk5P-C_+7A@mail.gmail.com>
Subject: Re: [PATCH v2,9/9] media: mtk-jpegenc: Refactor jpegenc device run interface
To:     "kyrie.wu" <kyrie.wu@mediatek.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bin Liu <bin.liu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Tomasz Figa <tfiga@chromium.org>, xia.jiang@mediatek.com,
        maoguang.meng@mediatek.com, srv_heupstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 3:32 PM kyrie.wu <kyrie.wu@mediatek.com> wrote:
> modify jpegenc device run func interface and add worker for encode
The description makes less sense.

> +static void mtk_jpegenc_worker(struct work_struct *work)
>  {
> -       struct mtk_jpeg_ctx *ctx = priv;
> +       struct mtk_jpeg_ctx *ctx = container_of(work, struct mtk_jpeg_ctx,
> +               jpeg_work);
>         struct mtk_jpeg_dev *jpeg = ctx->jpeg;
> +       struct mtk_jpeg_dev *comp_jpeg[MTK_JPEGENC_HW_MAX];
>         struct vb2_v4l2_buffer *src_buf, *dst_buf;
>         enum vb2_buffer_state buf_state = VB2_BUF_STATE_ERROR;
>         unsigned long flags;
> -       int ret;
> +       struct mtk_jpeg_src_buf *jpeg_src_buf, *jpeg_dst_buf;
> +       int ret, i, hw_id = 0;
hw_id doesn't need to be initialized.

> +retry_select:
> +       hw_id = mtk_jpeg_select_hw(ctx);
> +       if (hw_id < 0) {
> +               ret = wait_event_interruptible(jpeg->hw_wq,
> +                               (atomic_read(hw_rdy[0]) ||
> +                               atomic_read(hw_rdy[1])) > 0);
Hard-coded refers to hw_rdy[0] and hw_rdy[1] here?

> -       mtk_jpeg_enc_reset(jpeg->reg_base);
> -
> -       mtk_jpeg_set_enc_src(ctx, jpeg->reg_base, &src_buf->vb2_buf);
> -       mtk_jpeg_set_enc_dst(ctx, jpeg->reg_base, &dst_buf->vb2_buf);
> -       mtk_jpeg_set_enc_params(ctx, jpeg->reg_base);
> -       mtk_jpeg_enc_start(jpeg->reg_base);
> -       spin_unlock_irqrestore(&jpeg->hw_lock, flags);
> +       spin_lock_irqsave(&comp_jpeg[hw_id]->hw_lock, flags);
> +       mtk_jpeg_enc_reset(comp_jpeg[hw_id]->reg_base[0]);
> +       mtk_jpeg_set_enc_dst(ctx,
> +                            comp_jpeg[hw_id]->reg_base[0],
> +                            &dst_buf->vb2_buf);
> +       mtk_jpeg_set_enc_src(ctx,
> +                            comp_jpeg[hw_id]->reg_base[0],
> +                            &src_buf->vb2_buf);
> +       mtk_jpeg_set_enc_params(ctx, comp_jpeg[hw_id]->reg_base[0]);
> +       mtk_jpeg_enc_start(comp_jpeg[hw_id]->reg_base[0]);
Why it uses reg_base[0]?
