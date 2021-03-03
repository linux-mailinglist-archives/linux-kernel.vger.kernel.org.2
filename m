Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A383232BE4A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385449AbhCCRTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379907AbhCCNiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:38:54 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F53C0617A7
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:38:10 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id b1so26352570lfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7X3zWC8sv43JidvGXEJ+sxG+iFcCaZnwd3GWkVHn2QA=;
        b=jfBdSINz37HSrdFGnR+6H3pATTxbQpYj2UOeoXb+AdSBeZ9+RTage79zGmlP1tJ27V
         yKuiSaKmTISJjOzC6svcUltAcpl2pCPtZIzF0opf8QtBGTK1tqwrOGqsWaDy8uR/Iz7u
         ffNWNNrSvY7lS5rbtzNDtHVteYBcLJMVcdfM0JHYMP+LZYdzi6pk5utjKw+1ZMtL0Q8a
         5K3GErMzYf60UFNnXMMZdlmvwhG0c2lRU/mjPMCJsGjIRVXvlgFROVEEFla80cBu+m9k
         X5Rvnw+53pgGzxkoMpR8gOLa92SH45HJp3FsbtY8XQCl8YXJXCshw8JLngX+MOtNP84d
         1kjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7X3zWC8sv43JidvGXEJ+sxG+iFcCaZnwd3GWkVHn2QA=;
        b=r9iNvQdZnOvzPlqYbpTTTfyxuvO6prdrGeuy/cA8ceVKo7MQZeWVc1e+Pj0Jl1VJst
         4R/H7XzF7QWgaSopTuxt9+6hpI5PPemcMaDN2sPFUZQxPjGDxopBMtP2hCbjARotmkWN
         PBXFUR774fA0b3wOahE4icUZ5ScdWKtL0QP+K8rago1UY0llpG5OkjnIeUQBfLs14vNi
         NDbKS5sqbS0ce9gV+9jD+uY2bAEIV8K5omKXTlLbPe3HH7slll2H2PPpr3x/i7XS7YG0
         poQF0Wu+CZO/AT0xnxufRa4aE83RoLn/G9e1VkMhGgDVyzFi3mUDj8Ex9GnfhgdP9CQr
         LluA==
X-Gm-Message-State: AOAM530vy6ahw5h0PTwr/4wno0Twe9/tWmP4ayjenvSzWfOGLUlDenDP
        97qG5djI48p2PNdmsenLj6rlVlEIsrf4lW8f5g8=
X-Google-Smtp-Source: ABdhPJxAbpN/v8nH1IMKL/0Yhn98LsdY93KrfCpYhZOjPth1T7NFb3VeIt9Sd5cBNd1j5i9L446+OO+8m4icOEYwBvg=
X-Received: by 2002:a05:6512:6c3:: with SMTP id u3mr14579626lff.443.1614778688677;
 Wed, 03 Mar 2021 05:38:08 -0800 (PST)
MIME-Version: 1.0
References: <1614761651-86898-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1614761651-86898-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 3 Mar 2021 10:37:57 -0300
Message-ID: <CAOMZO5DhvAX3=Xv=v+yCRyzXhP0g9=016GcsRKOjBzjTvZ9X_w@mail.gmail.com>
Subject: Re: [PATCH] ASoC: hdmi-codec: fix platform_no_drv_owner.cocci warnings
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linuxppc-dev@lists.ozlabs.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

On Wed, Mar 3, 2021 at 5:54 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> ./sound/soc/fsl/imx-hdmi.c:226:3-8: No need to set .owner here. The core
> will do it.
>
> Remove .owner field if calls are used which set it automatically
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

The patch looks good, but please send a v2 with the correct Subject.

It should mention imx-hdmi instead of hdmi-codec.

Thanks
