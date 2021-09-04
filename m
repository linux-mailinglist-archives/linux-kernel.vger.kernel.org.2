Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74867400B5A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 14:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236132AbhIDMf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 08:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbhIDMf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 08:35:26 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05F5C061757
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 05:34:24 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id eb14so2666661edb.8
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 05:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5+zo+4Wr/N1+qtO0Bo0/5IH229VcLBJpVABLvaQw9+Y=;
        b=krzH3n/yLFz4lPCd5+4cvhdNx8SktbX09J5W/CdMMARjeDou9AzW9SqJzGIebu+Ab2
         MdDRqy34f4ie9SozTFLwUoo+1t/BK2GrDXuYKX28lskqLzd8milT7/L0awCvLzh154ew
         PPC5pl76KQD75u4Xpkf7Iviu8qcuXpjD30XSk6XBqKY7M2HbFSZRvGMLoyKWwxtvi0AP
         nO10GPONuy7MSn62griUv8x9flscDyJNmSI17PCzXQ2xy5erSe6tuyq5uEcB5C700n2Q
         D8rH17FaQ2FLMVneAd7et9prM1nnZHLIlALAcEjTHIOLESHNij8o3S8N3Y937WNUibds
         xzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5+zo+4Wr/N1+qtO0Bo0/5IH229VcLBJpVABLvaQw9+Y=;
        b=NWDN4aUC0S9JgPsaot0cOyLptxkyKtjwzSzybjF7QC5a/ajZw2xnBDg2RuAIRkdLgH
         w8/XQaduuSeuq974193LFgIN1WXoWnf712CFcUIEh5A7o9OWnhlQIAz2eYlU5m1iDNKm
         9GrjstCTSuljGc/ff51BUp/yo/NT/C0uNiz8OrPG0g3gcZOcVl/KJf5z3vfzMs2QmbDx
         5B9YFoYG16hURK6cCA1biGwK9Cplz3sZ/XY800FCCkh5alaoxmq8yhI/PsK+nLq6q0nH
         Z7+ZnVU7xoeXn2dkcizP4vWfJKZVWE1CVy8JJwAp8lNHBpwFsgfpisEB/ON2XTeL3SfR
         Ja2w==
X-Gm-Message-State: AOAM531SMvOT2XrUNWxbhs+Qdh0MbSP8Hgsymkovo/tU9mmKX+GjeiJF
        hlVPjGFdwAuRsNGJ57xsPBTVX8U3e3eyTJtT1k5WXA==
X-Google-Smtp-Source: ABdhPJxTnsvckyGgNMH1nCQCPjnCx2xmJcfaKIBG5ezGLlI/cFtqEY0Wn5EOslI/SFO5VcI8R4u9GAwp2c4cQxyl6L8=
X-Received: by 2002:a05:6402:743:: with SMTP id p3mr3988258edy.26.1630758863159;
 Sat, 04 Sep 2021 05:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210825063323.3607738-1-eizan@chromium.org> <20210825163247.v7.2.Ie6d1e6e39cf9b5d6b2108ae1096af34c3d55880b@changeid>
In-Reply-To: <20210825163247.v7.2.Ie6d1e6e39cf9b5d6b2108ae1096af34c3d55880b@changeid>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Sat, 4 Sep 2021 09:34:11 -0300
Message-ID: <CAAEAJfDNDXdJFfB-bHhFcqnnKZ0TY--d_wLGddKRymQOLQY4TQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/7] mtk-mdp: add driver to probe mdp components
To:     Eizan Miyamoto <eizan@chromium.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        chunkuang.hu@kernel.org, Yong Wu <yong.wu@mediatek.com>,
        wenst@chromium.org, ck.hu@mediatek.com, houlong.wei@mediatek.com,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        yongqiang.niu@mediatek.com,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-media <linux-media@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eizan,

Sorry for seeing this series so late.

On Wed, 25 Aug 2021 at 03:35, Eizan Miyamoto <eizan@chromium.org> wrote:
>
> Broadly, this patch (1) adds a driver for various MTK MDP components to
> go alongside the main MTK MDP driver, and (2) hooks them all together
> using the component framework.
>
> (1) Up until now, the MTK MDP driver controls 8 devices in the device
> tree on its own. When running tests for the hardware video decoder, we
> found that the iommus and LARBs were not being properly configured.

Why were not being properly configured? What was the problem?
Why not fixing that instead?

Does this mean the driver is currently broken and unusable?

> To
> configure them, a driver for each be added to mtk_mdp_comp so that
> mtk_iommu_add_device() can (eventually) be called from dma_configure()
> inside really_probe().
>
> (2) The integration into the component framework allows us to defer the
> registration with the v4l2 subsystem until all the MDP-related devices
> have been probed, so that the relevant device node does not become
> available until initialization of all the components is complete.
>
> Some notes about how the component framework has been integrated:
>
> - The driver for the rdma0 component serves double duty as the "master"
>   (aggregate) driver as well as a component driver. This is a non-ideal
>   compromise until a better solution is developed. This device is
>   differentiated from the rest by checking for a "mediatek,vpu" property
>   in the device node.
>

As I have stated in Yunfei, I am not convinced you need an async framework
at all. It seems all these devices could have been linked together
in the device tree, and then have a master device to tie them.

I.e. something like

mdp {
  mdp_rdma0 {
  }
  mdp_rsz0 {
  }
  mdp_rsz1 {
  }
}

All this async games seem like making the driver really obfuscated,
which will mean harder to debug and maintain.
I am not sure we want that burden.

Even if we are all fully convinced that you absolutely need
an async framework, then what's wrong with v4l2-async?

I would start by addressing what is wrong with the IOMMUs
in the current design.

Thanks,
Ezequiel

> - The list of mdp components remains hard-coded as mtk_mdp_comp_dt_ids[]
>   in mtk_mdp_core.c, and as mtk_mdp_comp_driver_dt_match[] in
>   mtk_mdp_comp.c. This unfortunate duplication of information is
>   addressed in a following patch in this series.
>
> - The component driver calls component_add() for each device that is
>   probed.
>
> - In mtk_mdp_probe (the "master" device), we scan the device tree for
>   any matching nodes against mtk_mdp_comp_dt_ids, and add component
>   matches for them. The match criteria is a matching device node
>   pointer.
>
> - When the set of components devices that have been probed corresponds
>   with the list that is generated by the "master", the callback to
>   mtk_mdp_master_bind() is made, which then calls the component bind
>   functions.
>
> - Inside mtk_mdp_master_bind(), once all the component bind functions
>   have been called, we can then register our device to the v4l2
>   subsystem.
>
> - The call to pm_runtime_enable() in the master device is called after
>   all the components have been registered by their bind() functions
>   called by mtk_mtp_master_bind(). As a result, the list of components
>   will not change while power management callbacks mtk_mdp_suspend()/
>   resume() are accessing the list of components.
>
> Signed-off-by: Eizan Miyamoto <eizan@chromium.org>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Houlong Wei <houlong.wei@mediatek.com>
> ---
>
