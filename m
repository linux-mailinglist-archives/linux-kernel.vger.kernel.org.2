Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191A33DB5F3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 11:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238248AbhG3JcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 05:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238223AbhG3JcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 05:32:20 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D2DC061765
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 02:32:16 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id f6so4832522ioc.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 02:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UENAkyvXIftlcsdFlCx7zKVE+FxyVIbvdXexL7kT+QE=;
        b=Kj9ECAHYD/ijOc+AQmZERa4YCkM0N5gIPeIWfCnUyHR1t+9tBHkIlIgtQppwjeZEg+
         m+/Krzw/xOGSKDEPyWPrKdHqh+Rpm8rOgo6iDpbrT1oiqbWUuGSj6xibOJ2Veabnvecx
         xDxtKVUuWGlBTbXQHvyTbVRqXNfSjAD7c2Ob0wQTTdYb5eFIqW+Rw7L6ZTSj0gPHGRx6
         OkiRts6pTOHsu3rxnrxlf0Cpv3OwBN53ETx2xyuDFYHtQ1gL4sv0tp4f2NcVHIoU4NHC
         vTCMMr6CI9VEYJAW24EowB/UQn0I1CPwCVD64bhfsua21IJ+/98fgFjwuAtIZD8/iGrP
         diGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UENAkyvXIftlcsdFlCx7zKVE+FxyVIbvdXexL7kT+QE=;
        b=oYDV5LSmEvOW24J8NNHVl+k/llrNm9rr+oxEqzwSxlGSVA311uIFFAVgCuaKWbPVTU
         pSkKkKw9BMlr65/VeMuR1GFSCqiEzD4xeVJ/TjaFjdME6AbZgpO1zyymNA/Y3Q5y74mD
         VYJFMcq/2nmC/ZCFrcXtRlIiXezrYLyEYL5HGhz+s0sp9xvNaTarSAknAj2LLO7T7bRm
         x0SHHk5pk275KnShTHjDRRgZSU+9n7EDF6qfLEbBRaZ7dqs7b3iPZO3tRp6gCgLxTcWI
         e4kYN6HJtkNwZQ83y0m7Azen8FAaestnNTjC4dciY+sjROLVcgEB3QckIi6quL6I4SLN
         8bTA==
X-Gm-Message-State: AOAM533f+flFMc1CAojnZYWFdOnI1OE+U25ayeV/8EUU82te2mDhXhfY
        YS7MtT7Mt9nXt4oz1+G3zwgHuyJeKOpDOJIVYJ7feQ==
X-Google-Smtp-Source: ABdhPJyD5fhu1x1POggBPj9r5dqca/AUQYvuZYJIMAyvwmAD/h2B6cTR9Lr0qps5U3HnSkkqjCdA8z2hd4f997Fsgjs=
X-Received: by 2002:a5d:87d0:: with SMTP id q16mr486487ios.109.1627637535819;
 Fri, 30 Jul 2021 02:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210727101051.24418-1-yunfei.dong@mediatek.com> <20210727101051.24418-4-yunfei.dong@mediatek.com>
In-Reply-To: <20210727101051.24418-4-yunfei.dong@mediatek.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 30 Jul 2021 17:32:05 +0800
Message-ID: <CA+Px+wVfaAZ-PmrDM2=jG6NqcLHnXhnQFPLtiX8oRLS+UuZXwA@mail.gmail.com>
Subject: Re: [PATCH v3, 03/15] media: mtk-vcodec: Refactor vcodec pm interface
To:     Yunfei Dong <Yunfei.Dong@mediatek.com>
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Irui Wang <irui.wang@mediatek.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 06:10:39PM +0800, Yunfei Dong wrote:
> Using the needed param for pm init/release function and remove unused
> param mtkdev in 'struct mtk_vcodec_pm'.
>
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
