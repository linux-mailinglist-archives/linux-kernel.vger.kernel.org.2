Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC82E38C150
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 10:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbhEUIIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 04:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbhEUIIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 04:08:00 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB604C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 01:06:36 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id k132so5683581iof.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 01:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RT+JgsYt45829ZHd2BYc40XqO99OHa9pHrzKSSD5j9A=;
        b=kLDJ66UxJgXBhTlXqQcr4bzo/A2l5Q8HqghhVGTZn1NhjtsLvIntyyuByjyK72XJiV
         EguZV7WiHzjL9tIOuUpIheqlo/zIR7fCiXRdRsiM9XgCDiG83jwTK8jfkfWII0aiEc+B
         XLW4AK2y3GYblWpuR0WfCpTNh59ZKDqfw+BUVoJ2NPRJ9b+p4M7w32T5SIS0ZEyI8iTF
         uZuzVOQ6hRqrSmIIzBC73CSBQ6vQkLdiJzGnB1y4VMW6hz66G7NvqwOFP97s21DQ5hvw
         VPRizS0txzrgGhqLjoUKanc3unVj53BjOFJS5QE2/1UNWd370D6MHF3o4TDKN7Pdd7uN
         yxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RT+JgsYt45829ZHd2BYc40XqO99OHa9pHrzKSSD5j9A=;
        b=ElYx/WbULiVXETu2vj4LyUUDTsyzUtuLG/4qopZq+bsVWPqHHs2jFBd9s/KSv/v+4n
         qsjmKlqbmCg0MHNJ3sjst1J6fa1jbimXDRinuhXLcLfaQ7d9oBktn9JxIHbA2fKJSS6y
         J0Fe1446U90bkt9E+G6p4WoLjLdMvKTMMGeBOFqc4D/ceMNypmuafChSIH3cff8OP2xK
         PXXaba2ETvpx/dnOgov8DjY7L01D2z3aymUMGjSNctLWj6WdfjXJWrMIuLzaDC82MUIa
         7clr7OW4Ff7XTQjGpvHUlXby1LIyK74L4FKtKF7p/hGhx9HQCEwwJFUhbFJZc3Ov7wJU
         e6xA==
X-Gm-Message-State: AOAM530Hrli9rgWpLgIfkd4CbdE6AQPlIrZVRlV7nB3RG+6C0ZfltCmO
        FuFU87X86XA+m3b6zWi6VaBY200ocyxc4H+YkVLAPw==
X-Google-Smtp-Source: ABdhPJzli/TP6ekzSUzbblqRjUcznUEUpI63eE2KDBygtddGTKqTJLATk1eu/Q+8mrD9doz5sb8hrdaLnSgi1Azv0y0=
X-Received: by 2002:a05:6638:3010:: with SMTP id r16mr2626171jak.126.1621584396061;
 Fri, 21 May 2021 01:06:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210521070139.20644-1-irui.wang@mediatek.com> <20210521070139.20644-6-irui.wang@mediatek.com>
In-Reply-To: <20210521070139.20644-6-irui.wang@mediatek.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 21 May 2021 16:06:25 +0800
Message-ID: <CA+Px+wXOKM6y4aHsHTGOiT-VJJ=wzghNDiKSkgaxiefhs+mO3A@mail.gmail.com>
Subject: Re: [PATCH v4,5/6] media: mtk-vcodec: Add MT8192 H264 venc driver
To:     Irui Wang <irui.wang@mediatek.com>
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Fritz Koenig <frkoenig@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        linux-media@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        srv_heupstream@mediatek.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 3:02 PM Irui Wang <irui.wang@mediatek.com> wrote:
>
> Add MT8192 venc driver's compatible and device private data.
>
> Signed-off-by: Irui Wang <irui.wang@mediatek.com>

Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
