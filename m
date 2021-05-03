Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4279371787
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 17:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhECPIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 11:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhECPIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 11:08:36 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCF6C06174A;
        Mon,  3 May 2021 08:07:42 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id c22so6665028edn.7;
        Mon, 03 May 2021 08:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6PeKiC6VK6oLLbn2cnMl1YHOLyRIgp6HOXyzm858/Jc=;
        b=oqa4C1F4z7emqDWN76F8bOb8wWgz9LKcoWLQp5PhjOKBtEbe8cLd+ops1lGKoVgNzp
         gGdpC6HkkUTTlE4/2ZnwVtRC2kgKVaYR+f/lxZ1hqUQKadePdiHxKeZ2mEplsQibxdq9
         pgYxnmNyUqMP3JeUUI3LJ0PfgxH11O7dYFxIuO0nlVlGI2mZtyPvLMqqfIxoEcq5HDEZ
         A2a6HlbpIcvwJPGuN1u5O5x7YLUw3Q8qIaYvAl3nYTeZGEKPpEye4C/rXhOcaAm0rPeH
         DLw3Q+BS3ddwk3N41iGdr3wj6hFDwf1QU3ZtryNMSHyN0+wNy+vmJ0cI/o9zKK5/9THf
         Hv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6PeKiC6VK6oLLbn2cnMl1YHOLyRIgp6HOXyzm858/Jc=;
        b=DmTjS9RNoeXAIaQjaNBFVB5y9ogOpbOeyjSX35TbBJl6r2iWpJ56XxwsQKqSSA0Yz+
         r1t9sD/J8XRtU79jXu9Rf2rZzQVNjVvvSH7eNtKewTg4It8lFTdqtgMPCXjIYmr0N1p7
         izex20JmxXGJpb/BpbkUgJ5qhLr+llCiShMgRdigTTVDqceOZZOFDLVD13ORhHKxommN
         PXn8bZ8JESV8AI06CFUP9xnG6KE6OP8QjsdYkcUmW6EF2IXON6AeRstVI4tZVapqUIw7
         2PTE0k9LWtpO5w2Tevlg7upCj+oOXTuOd8Sz/hhwdb2NZecCgNJ2TSdeNZKDZBDmBQoR
         H/uQ==
X-Gm-Message-State: AOAM53191JgqXEJOvnE7uC2dviwn+PjP94yiLDJLv8Ofr8b04iy+CK3L
        FR1FgCq8Wchy+nk3X8TIXAwow2XMVwdinZX4Pzu03WQbOE0=
X-Google-Smtp-Source: ABdhPJzgzq9cLDMHr7lN6DCxUbCsnFeyWmsYaigFQVj8/gCeiG6BqYvBX+GWt81IYnAJp8Wlw3VIkmKBQgMxKEiBATg=
X-Received: by 2002:a05:6402:3109:: with SMTP id dc9mr20519018edb.13.1620054461345;
 Mon, 03 May 2021 08:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210503145503.1477-1-linux.amoon@gmail.com> <20210503145503.1477-4-linux.amoon@gmail.com>
In-Reply-To: <20210503145503.1477-4-linux.amoon@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 3 May 2021 17:07:30 +0200
Message-ID: <CAFBinCCxMvomKt9E0jT_XXpyL1_-qXH4=zVDMNdbDCnZCsnT=A@mail.gmail.com>
Subject: Re: [PATCHv1 3/9] soc: amlogic: meson-ee-pwrc: Add hdmi power domain
 Meson g12a SoCs
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On Mon, May 3, 2021 at 4:58 PM Anand Moon <linux.amoon@gmail.com> wrote:
>
> As per the S922X datasheet add hdmi power domain
> controller for Meson g12a and g12b SoCs.
>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/soc/amlogic/meson-ee-pwrc.c          | 5 +++++
>  include/dt-bindings/power/meson-g12a-power.h | 1 +
>  2 files changed, 6 insertions(+)
>
> diff --git a/drivers/soc/amlogic/meson-ee-pwrc.c b/drivers/soc/amlogic/meson-ee-pwrc.c
> index 2e07ddf2d6a6..ec402c4ab931 100644
> --- a/drivers/soc/amlogic/meson-ee-pwrc.c
> +++ b/drivers/soc/amlogic/meson-ee-pwrc.c
> @@ -154,6 +154,10 @@ static struct meson_ee_pwrc_mem_domain gxbb_pwrc_mem_vpu[] = {
>         VPU_HHI_MEMPD(HHI_MEM_PD_REG0),
>  };
>
> +static struct meson_ee_pwrc_mem_domain meson_pwrc_mem_hdmi[] = {
> +       { HHI_MEM_PD_REG0, GENMASK(15, 8) },
> +};
> +
the VPU power domain already includes:
  VPU_HHI_MEMPD(HHI_MEM_PD_REG0),
whereas VPU_HHI_MEMPD is bits[15:8]

Having two power domains which are managing the same registers sounds
like it'll be causing some trouble
So for now this is (as I am not even sure what the goal here is):
NACKed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Best regards,
Martin
