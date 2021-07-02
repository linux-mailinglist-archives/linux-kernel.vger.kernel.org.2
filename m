Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB463B9B47
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 06:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbhGBEN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 00:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhGBEN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 00:13:26 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363AEC061764
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 21:10:54 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id l5so10133750iok.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 21:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zeSfxgHTcElRZoSpX3vn4Ly7z/IXRbCeFw0dHTkG7AY=;
        b=IuM+K/DrC/N1D8CS0EkEa3H706wC+2MyxRTwtdlaOVRQXrD1O8w7Ak9NSNpM/JQGdW
         4Bpslu4+wwkq6u06q8ny1O51SVtLSqRnnZ7YBekiG0zikWd3ZGF0l6ACkcPgyZIVQWP1
         EXvgsk07oRH7T6lLI6wvDLR2FcIzd8wOz9o+6BCh9CgD/g2hH6jhEsx2ctv1NKMqKQ/0
         MkfamFBQBIcbgWJY+gVydu+F/z1KyT1ezsV8HY2ZDA9c8C9ZWPGinZdPbMqcMql9GkRd
         G2Q48cdZlVKAmqHBiQqGteQSZo3jAv33rzxqDiBlaq3hy4A54huCAin9LmrbfGhYRiIR
         BYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zeSfxgHTcElRZoSpX3vn4Ly7z/IXRbCeFw0dHTkG7AY=;
        b=q8meMkAj9TjuvSL1Qt2DBDDCA9oVqGzU+VlI9EcQpBXUq7gZsbwmJbvPLsLhnnMJsn
         Lo5qdAZZoPFYXkYSMKDHMvQgSJ9p7Gk8X+fxNqJB5M8KWgP5WoLM3XEW2fvUB9lNNs68
         ULByzsVsdUdBRKt+X1KyKRcp/oOdT68KdnfRObkP094xtBmN0xHmzzbiOwDfJSw46R6l
         P6OfFDyzT4/ZUvLn5C76tfDuGUruv7+lzUjWxrYB9gvGbcBSgiUyDU1VLfF2mMKO4rhr
         vlquP6X9sfAxagSkpu0h/XyP1ai8/tDu5+ET7nS/1RjyhuuJ5d9FAqeXF6SWOidR3lEW
         XvkA==
X-Gm-Message-State: AOAM532yeg5f/5ewCPX6Zm69nfM4OJX1oSlz0DPdoqKHYKDV3BdLFI9O
        hbyW/RKD3nyue022EIfkQ8dhLHWju6QPqCmU0a493Q==
X-Google-Smtp-Source: ABdhPJyBQxBUgBEzL+AgJh2pPTIZG1lq9jnjj4ShF+UvDdDfl3o1JmKmztNrF6SH8uOwDhhHcI3j4ElRt8sBOwAeUb0=
X-Received: by 2002:a5d:840c:: with SMTP id i12mr2078731ion.185.1625199053517;
 Thu, 01 Jul 2021 21:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210630085247.27554-1-irui.wang@mediatek.com>
In-Reply-To: <20210630085247.27554-1-irui.wang@mediatek.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 2 Jul 2021 12:10:42 +0800
Message-ID: <CA+Px+wUZJQXtF2_eti5baY_z_24Rm-_+389KAeT5+sNretTD5A@mail.gmail.com>
Subject: Re: [PATCH 0/3] Support h264 encoder on MT8195
To:     Irui Wang <irui.wang@mediatek.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <Yunfei.Dong@mediatek.com>,
        Fritz Koenig <frkoenig@chromium.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 4:52 PM Irui Wang <irui.wang@mediatek.com> wrote:
>
> Add MT8195 H264 venc driver
>
> Irui Wang (3):
>   media: mtk-vcodec: Clean redundant encoder format definition
>   dt-bindings: media: mtk-vcodec: Add binding for MT8195 VENC
>   media: mtk-vcodec: Add MT8195 H264 venc driver
A typo in the commit message of DT binding patch.  With that:
Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
