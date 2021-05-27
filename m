Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04BE9392B7F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 12:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236132AbhE0KM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 06:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236096AbhE0KMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 06:12:23 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA9EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 03:10:50 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id q1so7169869lfo.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 03:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DAPD4ukT6eCf6HIGe5wvyHRlg/DJMReQYqQE1gSOFEE=;
        b=MuYBL86U5dNPZzYeIcrgWG2vi8zuGy7jo0PD9uelsBqLAf+9oXfb7SJ8DVVqvqUp6c
         51P6kaiGH6GHS0efDbeHaOaIInAi6nHcPFllEp9opUet4VMHfrBeX8+Tqp2R5D8jfPj3
         LG0X+qcYI0YvKRHxY6aFDIsr29BgyYjFq/zO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DAPD4ukT6eCf6HIGe5wvyHRlg/DJMReQYqQE1gSOFEE=;
        b=uV1d5T8ajUxIlmk/2LoMzOqhPbrlsBvWHNyv3HXS9BJQlHGoPK+qJBLojlWyN6ITnW
         QlEsT2CesMiLUYRKh5PM1IUfgwLHyTTSrCqx1rqbfFNnR5opgR4CVM21VLhaedqDPemT
         s1W4Z6lGFXH8xpNlaqusUXgJinwWn2NddM8/POq/msXtS0mNAx9rF6zliav8hQJGOssJ
         9gXi04nTDW995d2Bx9aut++TDh/xANhh0hWDhtIiSwx9F33TR5uXGcGuVcWt0jjuRg4B
         VwYuEe4oWyqmRREPhmSp+9zujXDAFOGno/gis5Z8N6YG9kohAoFF9uZq0yJJ3di2VooK
         f2+A==
X-Gm-Message-State: AOAM530k+207lo/DhGupQ8rm+ZxZJbKY/p0AMrdEIjZ7WTkJp64F0zbp
        kaz4lbNtnkrXXGIJ80CVXw1sbrL/v98LSg==
X-Google-Smtp-Source: ABdhPJzM7js68qDpncz1Z5gIZxnpfjGj7jMe+w0ybBMGjCOp9H5LVum2WOBjhXNXweoxR97STEivdw==
X-Received: by 2002:a05:6512:1188:: with SMTP id g8mr1853382lfr.410.1622110248757;
        Thu, 27 May 2021 03:10:48 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id j8sm159502lfh.192.2021.05.27.03.10.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 03:10:48 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id w33so7179892lfu.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 03:10:47 -0700 (PDT)
X-Received: by 2002:ac2:528d:: with SMTP id q13mr1944901lfm.73.1622110247228;
 Thu, 27 May 2021 03:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210519143011.1175546-1-acourbot@chromium.org>
 <20210519143011.1175546-12-acourbot@chromium.org> <CA+Px+wXXtsmG2q4aJ4Em1pzFcA-mA6CuATfXKevNyEOuBq+zYw@mail.gmail.com>
In-Reply-To: <CA+Px+wXXtsmG2q4aJ4Em1pzFcA-mA6CuATfXKevNyEOuBq+zYw@mail.gmail.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Thu, 27 May 2021 19:10:34 +0900
X-Gmail-Original-Message-ID: <CAPBb6MUR9nXQc=Dua67Ep7U_7LMGcEhw=yhB42KN03R19oEgCg@mail.gmail.com>
Message-ID: <CAPBb6MUR9nXQc=Dua67Ep7U_7LMGcEhw=yhB42KN03R19oEgCg@mail.gmail.com>
Subject: Re: [PATCH v5 11/14] media: mtk-vcodec: vdec: support stateless H.264 decoding
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 10:38 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
>
> On Wed, May 19, 2021 at 10:31 PM Alexandre Courbot
> <acourbot@chromium.org> wrote:
> > +#include "../vdec_drv_if.h"
> > +#include "../mtk_vcodec_util.h"
> > +#include "../mtk_vcodec_dec.h"
> > +#include "../mtk_vcodec_intr.h"
> > +#include "../vdec_vpu_if.h"
> > +#include "../vdec_drv_base.h"
>
> Would be good practice to sort them.

Done as much as possible.

>
> > +static int allocate_predication_buf(struct vdec_h264_slice_inst *inst)
> > +{
> > +       int err = 0;
>
> No need to initialize.  It will be overridden soon.

Done.

>
> > +static void free_predication_buf(struct vdec_h264_slice_inst *inst)
> > +{
> > +       struct mtk_vcodec_mem *mem = NULL;
> > +
> > +       mtk_vcodec_debug_enter(inst);
> > +
> > +       inst->vsi_ctx.pred_buf_dma = 0;
> > +       mem = &inst->pred_buf;
>
> Is it possible to inline to the variable declaration?  Or mem no need
> to initialize.

Indeed - done (also done all other suggestions in this email).


>
> > +static int alloc_mv_buf(struct vdec_h264_slice_inst *inst,
> > +       struct vdec_pic_info *pic)
> > +{
> > +       int i;
> > +       int err;
> > +       struct mtk_vcodec_mem *mem = NULL;
>
> No need to initialize.  It will be overridden soon.
>
> > +static void free_mv_buf(struct vdec_h264_slice_inst *inst)
> > +{
> > +       int i;
> > +       struct mtk_vcodec_mem *mem = NULL;
>
> No need to initialize.  It will be overridden soon.
>
> > +static int vdec_h264_slice_init(struct mtk_vcodec_ctx *ctx)
> > +{
> > +       struct vdec_h264_slice_inst *inst = NULL;
>
> No need to initialize.  It will be overridden soon.
>
> > +static void vdec_h264_slice_deinit(void *h_vdec)
> > +{
> > +       struct vdec_h264_slice_inst *inst =
> > +               (struct vdec_h264_slice_inst *)h_vdec;
>
> No need to cast from void *.
>
> > +static int vdec_h264_slice_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
> > +                                 struct vdec_fb *fb, bool *res_chg)
> > +{
> > +       struct vdec_h264_slice_inst *inst =
> > +               (struct vdec_h264_slice_inst *)h_vdec;
>
> No need to cast from void *.
>
> > +       const struct v4l2_ctrl_h264_decode_params *dec_params =
> > +               get_ctrl_ptr(inst->ctx, V4L2_CID_STATELESS_H264_DECODE_PARAMS);
> > +       struct vdec_vpu_inst *vpu = &inst->vpu;
> > +       uint32_t data[2];
> > +       uint64_t y_fb_dma;
> > +       uint64_t c_fb_dma;
> > +       int err;
> > +
> > +       /* bs NULL means flush decoder */
> > +       if (bs == NULL)
>
> To neat, !bs.
>
> > +static int vdec_h264_slice_get_param(void *h_vdec,
> > +                              enum vdec_get_param_type type, void *out)
> > +{
> > +       struct vdec_h264_slice_inst *inst =
> > +               (struct vdec_h264_slice_inst *)h_vdec;
>
> No need to cast from void *.
