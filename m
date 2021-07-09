Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D261D3C2234
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 12:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbhGIK3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 06:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbhGIK3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 06:29:30 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A404C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 03:26:46 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id i20so15287732ejw.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 03:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EE3G7qk9YjV6WICjXG49f7wI9xsGOugrChSPRCk7KBY=;
        b=j6ueWrIhKJIqX+ueklioki6dIG0OTnmNayymWlaVcRO1HjVRRLInq8113rpC0VzsJE
         LJlOHhgMqrPL7AbRHbdrjOpH5SkezCozW4eeIWh4PO1FXTa5NEVaruBmAWnQGauz7eGj
         FQ2l2WvAoKeryPAxZP6iCnPC+YpHdEbovQavQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EE3G7qk9YjV6WICjXG49f7wI9xsGOugrChSPRCk7KBY=;
        b=A9OT2+gXzjqTEFiJJ/4QOe/eadSKI8BOBMCWDbEwgFfasEp60qgsLrUb9OKo+M8TQe
         u5cRUZtMOeKTKMTxLVL4VLWYq/NUGizrM+ZFVhuTEiM8JS8wdTuEjVpqypjdl6N8ETtY
         57Vm2hhju9zaf8UdeLEuUHP98heMVX5984SmQVMUz48idINf/SoTb7o9sFVBXEagSwjb
         1sn6DCNxqb7ZFpG+ZQPcBOqka7u/OQNUHCmkWB/mHD3dvHwwCNpUwlGkqRUlejX7VpXc
         oO87o1SmC8WNL8s/iylGJpw0DmE41rKsn/iD6JnANx3uFBqEVdz9tEXzbUi6szsglOjd
         mh/g==
X-Gm-Message-State: AOAM5335UW/HxklFyCIDu/8wjDEe5LvKY88qouE/TBNPSCoCUdErUPWU
        OcPZdWmfNeV7z/WHynLE5tiZ5vrF2DImgTh7
X-Google-Smtp-Source: ABdhPJx4scGLsR7919Q6aDbiYiRYj69DwkenTqSh2eETVeb5KPFOtXMAsdLHw9EpXMz5M6WftNE6uw==
X-Received: by 2002:a17:906:5187:: with SMTP id y7mr25020141ejk.153.1625826404268;
        Fri, 09 Jul 2021 03:26:44 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id l26sm2798597edt.40.2021.07.09.03.26.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 03:26:43 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id m2so454622wrq.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 03:26:43 -0700 (PDT)
X-Received: by 2002:adf:f1c9:: with SMTP id z9mr12812492wro.159.1625826403104;
 Fri, 09 Jul 2021 03:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <1625038079-25815-1-git-send-email-kyrie.wu@mediatek.com>
In-Reply-To: <1625038079-25815-1-git-send-email-kyrie.wu@mediatek.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 9 Jul 2021 19:26:31 +0900
X-Gmail-Original-Message-ID: <CAAFQd5D+Zwh6JxJqAbyLX9XeyFdnmjUgWTpFA6GvO2qNktOxBQ@mail.gmail.com>
Message-ID: <CAAFQd5D+Zwh6JxJqAbyLX9XeyFdnmjUgWTpFA6GvO2qNktOxBQ@mail.gmail.com>
Subject: Re: [PATCH v2,0/9] Support jpeg encode for MT8195
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
        linux-mediatek@lists.infradead.org, Xia.Jiang@mediatek.com,
        maoguang.meng@mediatek.com, srv_heupstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kyrie,

On Wed, Jun 30, 2021 at 4:31 PM kyrie.wu <kyrie.wu@mediatek.com> wrote:
>
> add component framework to using multi-HW for MT8195 jpeg encode.
>
> kyrie.wu (9):
>   dt-bindings: mediatek: Add mediatek, mt8195-jpgenc compatible
>   media: mtk-jpegenc: Add MT8195 JPEG venc driver
>   media: mtk-jpegenc: remove redundant code of irq
>   media: mtk-jpegenc: Refactor jpeg clock interface
>   media: mtk-jpegenc: Generalize jpeg encode irq interfaces
>   media: mtk-jpegenc: Generalize jpegenc HW timeout interfaces
>   media: mtk-jpegenc: Use component framework to manage each hardware
>     information
>   media: mtk-jpegenc: Generalize jpegenc HW operations interfaces
>   media: mtk-jpegenc: Refactor jpegenc device run interface
>
>  .../bindings/media/mediatek-jpeg-encoder.yaml      |   3 +
>  drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c    | 600 +++++++++++++++++----
>  drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h    |  69 ++-
>  drivers/media/platform/mtk-jpeg/mtk_jpeg_enc_hw.c  | 208 +++++++
>  4 files changed, 786 insertions(+), 94 deletions(-)
>
> ---
> This patch dependents on "dt-bindings: mediatek: convert mtk jpeg decoder/encoder to yaml"[1]
>
> Please also accept this patch together with [1].
>
> [1]https://lore.kernel.org/patchwork/patch/1445298/

Thank you for the series. However, I gave reviewing it a try and
unfortunately had a very hard time following it, because of the way
the patches are organized. Please make sure to read and understand the
kernel patch submission guide[1], adjust the series appropriately and
send a new version which I'll review.

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Best regards,
Tomasz
