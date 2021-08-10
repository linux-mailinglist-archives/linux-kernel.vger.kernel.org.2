Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF913E58E4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 13:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240045AbhHJLN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 07:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240034AbhHJLN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 07:13:56 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3FFC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 04:13:34 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id h18so14910517ilc.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 04:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R24U8eygNrNa6Kfw/TB79Hp4avk7mrJgwEsiLlVUa14=;
        b=uc7ViAIsfak15w+R8Aguh9X+jPfNitVeN0r1HWrC+3IKVUGQ+Ru7fRo2Qo3t7Eannd
         vgxtR3KOz8QEmHD4uAmGVAWsxbyUh+oZgjtiq50VMk98OhzWV3XJcGX4OYRdTM5be+E4
         cI12L78DgJatroOaAEHh2GiLwl+0D0Qc275DogwrcvGGtWwPNO1OUrs505nTGOpEtvIU
         Agbvwaa5NdBCZ13VgfHJzV5C3plyC4d3kN0/pR6bPBqgJ3rFlqlkIrLl4AJiKcr+mIvy
         SnXj/J5HJ4MK6yGPSy+gGkqiWKeaIMjp8sovggYPj8r7mtaDivA9V4t9gQL2uWfpWqlu
         RVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R24U8eygNrNa6Kfw/TB79Hp4avk7mrJgwEsiLlVUa14=;
        b=Ar9nReJ1uWxjMhO3kbwOZUOI5n1yN5OFMzq70I+co7Kv/RR1jeTw6kfs4eCkYk976i
         4NIXkq7Nn+cjKSjV5ob4S4zB4pRd3NwrJrLHm/y45JvbMYvOtSPxOgBTELp2odz4ZE0D
         dYZpahqH7nPfkxJtLeXg70KyqPF5RMgdi22rgAUStiCuxwaxD1SGXkQn3KfcGYnV5yuR
         WaWmo2hy6NJoAgV/5gTJIxy4YGTsqiDayZokxwNXOWf6g42sbBEkkNExhVcOloXJ3tzH
         WUTEO93LlDVITwTxUxed/gIiAjofhrFtTayq9gVd2vxEiytrNwRD9QmGLDzHCwCxHf7U
         d3vg==
X-Gm-Message-State: AOAM533GxrI2NIDwGljzglBiwV1ovOn8GD/RY5mBFetuE3BUuIViHUSB
        5ksMFT1E9a7Dx0O/AddJ2NjSHxPe1q/9cO7+R0Wngw==
X-Google-Smtp-Source: ABdhPJwY2OJpBSIipazUvXTbGw/knJcOBQtgWX6jXKOHKgdkgkyuLfro/TnppdMOUgQdOF7LK2Cn0KQW+9JIsn0XqEc=
X-Received: by 2002:a92:ddc9:: with SMTP id d9mr230817ilr.204.1628594014125;
 Tue, 10 Aug 2021 04:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210810083047.16693-1-yunfei.dong@mediatek.com>
In-Reply-To: <20210810083047.16693-1-yunfei.dong@mediatek.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Tue, 10 Aug 2021 19:13:23 +0800
Message-ID: <CA+Px+wWsYUCAzwbJjFQqhtOiW1zkn6ZTbr3NymUs1TZQWwdQxQ@mail.gmail.com>
Subject: Re: [PATCH v4, 00/15] Using component framework to support multi
 hardware decode
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
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        George Sun <george.sun@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 04:30:32PM +0800, Yunfei Dong wrote:
> This patch dependents on "media: mtk-vcodec: support for MT8183 decoder"[1].
>
> Multi hardware decode is based on stateless decoder, MT8183 is the first time
> to add stateless decoder. Otherwise it will cause conflict. Please also accept
> this patch together with [1].
>
> [1]https://lore.kernel.org/patchwork/project/lkml/list/?series=507084
Didn't see anything from the link but I guess you mean the series
https://patchwork.linuxtv.org/project/linux-media/list/?series=6057


Some obvious issues from the series:
- Please remove all unneeded "Change-Id" tags.
- Please include Reviewed-by tags if no significant changes.
  - E.g. https://patchwork.linuxtv.org/project/linux-media/patch/20210727101051.24418-3-yunfei.dong@mediatek.com/
  - E.g. https://patchwork.linuxtv.org/project/linux-media/patch/20210727101051.24418-4-yunfei.dong@mediatek.com/
