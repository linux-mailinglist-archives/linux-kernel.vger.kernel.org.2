Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3114F3CB2D3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 08:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbhGPGqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 02:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234855AbhGPGqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 02:46:17 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F395C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 23:43:22 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id g22so9470543iom.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 23:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IiX28Q2sDYwMuIX/qzaioGu6+VV6GkUw/FQvwDmGtLg=;
        b=YWtD9DoKqHC9Huy4wB+6rfBztqBEV5WfZtLL4wnWQ0wbzaarziMh767CGS3uSPdUtS
         x5f1oBk5WYB67qYDTTH7Ge3qLw5mhhemCAZiPSWw6+XswrNZLtl3EdSJpS1kSD4CTOPk
         pkrhsF4KkSjRigKWWgM/r2wSYZ/3lva+Di1/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IiX28Q2sDYwMuIX/qzaioGu6+VV6GkUw/FQvwDmGtLg=;
        b=m1dtSoaDgpXiMWFDBG/i6gegCeV7R0qY9/3zV2m7HgorOYzIjQN/uitg90By/e8u3g
         bVp1LffpyNMuJpkW3zE8JwbVh8EvcsloRYYqLzolcCw6XuXwPQytIs4H0vyUddqAajd2
         GQwUmxi8ysh5C1JbAiJlZhgiMB5jEbeGD2cxCjvj5zrp8uoFAYTaExmhw3QEGytZECGH
         +CeOD1SOItEbM59k8ixw+ING+btfmDPybxN1hJt9Y1nCxTVB/92f6h69ravx4dPwygHt
         HlrElOLh1RNceGY6QJ8TTV26ws12F9TamroNLnHsFH7RE3BgIGKEcJhoGD0IMApb6y/I
         Ju/A==
X-Gm-Message-State: AOAM533RmW2cxwTmPtjZUkEC2Lh7/TxCDvdjjyPW4V7+LhUGUzUIDQiD
        ZewmwTcQhbRGOKnDbZPxILUu7R7QIRmB609UrV6pbg==
X-Google-Smtp-Source: ABdhPJz5OJ30eGOyvpHpAbWoYXfnr8j0aLyXqTm8PncdRizb0DIL4m7tk7hB8pX2ypGLzNA+i1p5hmQ3mUcggVeWZ/c=
X-Received: by 2002:a05:6602:2d10:: with SMTP id c16mr6219649iow.40.1626417801637;
 Thu, 15 Jul 2021 23:43:21 -0700 (PDT)
MIME-Version: 1.0
References: <1626417143-8015-1-git-send-email-yongqiang.niu@mediatek.com> <1626417143-8015-2-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1626417143-8015-2-git-send-email-yongqiang.niu@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 16 Jul 2021 14:42:55 +0800
Message-ID: <CAJMQK-hDH9QGz_FL+gSBhq-+xrzbWn7wgSOqv4QRLY8RfiSHSg@mail.gmail.com>
Subject: Re: [PATCH v3, 1/3] drm/mediatek: Separate aal module
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Fabien Parent <fparent@baylibre.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 2:32 PM Yongqiang Niu
<yongqiang.niu@mediatek.com> wrote:
>
> mt8183 aal has no gamma function
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>

Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>

This version fixes the issue in v2.

<snip>
