Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296AB3BCB51
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 13:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhGFLDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 07:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbhGFLDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 07:03:46 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C03C061764
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 04:01:08 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id g22so24464934iom.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 04:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FYk8/MFnVtA7gBfngdQB39lzbb1HLN8KQZCQ/UZ++gI=;
        b=mqRfuAl9FMaPmM8mndYbPgNaTr/4muXGUtAj0aCIVo1DzDJZHyZxeNF57pK/mEv4G2
         bCYhHwF3fX7HA8RxBT8bMsEaXi5swrk6OA2lSrk7s9Bd3Y1QYqzG8ChA2G1FIhPDgDs6
         Mftlv3kB7UFCoozmFUffi/lYHnU1fchrthktlfUbcONCXWyLYtWUsMJsZNM169S4pNZd
         QxaLqqDFtyZ8OuBFNuBPSLrOHtb8+4L6a5s7/JrMGfJj+pvUNYtDQHNz2oqYH9mjum96
         VNtiixoAp3LPgG7Roj8oGTOI8UBQWLwtgFEkf+QxM1lQjGOY+BIkqTtd06ukNz327txp
         bWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FYk8/MFnVtA7gBfngdQB39lzbb1HLN8KQZCQ/UZ++gI=;
        b=XRN94eDgqrBC0yCUCY5FOckngxqXR3zLDseTWdoJknxixy9kERFGrBSESraTm1ABgl
         J90VTPFu4G+Z7ekNvmytdlnnqURnXIbLDibkaPimidIJUIe83LEvNUSn8iBMxM6OEsLF
         NPPSnoUcNeXxRxnbgJNCRvPkiDo5aOZNx58O5IHDUGCevQ2aHrrpsg5nFwH6V5yERpmK
         iXEIZ3VK2pP8jdUKds8VKv8JtTdKPsZHPe7JEAqnQNWFPUJL9JhSTquUyK4asMAxQMQ7
         hJoNT9ycM+FioIszdXxEbtATdWT6Wwqz/ftf46cfVwbFkpufS9CkUjuLLuVCMX1iJbQM
         Xr3Q==
X-Gm-Message-State: AOAM531gF6ZhCPTPNu2ZNoU8M5HaxMsE3onAW6ZRZt2QHQk8MQlm73Zj
        s09ykKUSDYRNBXJ8ZTWMh6Gbeg9/NZTXifmx8TNHlw==
X-Google-Smtp-Source: ABdhPJwfVqDJZJ8YMxlfHDI/5iWfU93hNngTm71CYO5d2lEfAycitsV1Wbt0lZDaTUxVYOgEgo1j1trbkKDAIraFWas=
X-Received: by 2002:a5d:96cb:: with SMTP id r11mr586569iol.53.1625569267395;
 Tue, 06 Jul 2021 04:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <1625038079-25815-1-git-send-email-kyrie.wu@mediatek.com> <1625038079-25815-9-git-send-email-kyrie.wu@mediatek.com>
In-Reply-To: <1625038079-25815-9-git-send-email-kyrie.wu@mediatek.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Tue, 6 Jul 2021 19:00:56 +0800
Message-ID: <CA+Px+wVwuujSM2MN3VC=kAAU4+M8ZwDhVE3WbUe9R39EuEWDuQ@mail.gmail.com>
Subject: Re: [PATCH v2,8/9] media: mtk-jpegenc: Generalize jpegenc HW
 operations interfaces
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

On Wed, Jun 30, 2021 at 3:28 PM kyrie.wu <kyrie.wu@mediatek.com> wrote:
> Generalizes jpegenc select/deselect HW and set params interfaces.
No code is using the functions.  The patch needs to be submitted with
other patches.

> +static int mtk_jpeg_select_hw(struct mtk_jpeg_ctx *ctx)
> +{
> +       int hw_id = -1;
> +       int i;
> +       unsigned long flags;
> +       struct mtk_jpeg_dev *jpeg = ctx->jpeg, *comp_jpeg = NULL;
comp_jpeg doesn't need to be initialized.
