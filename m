Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293CD3C98DC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 08:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235684AbhGOGn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 02:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbhGOGn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 02:43:26 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FA2C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 23:40:33 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id b26so7996909lfo.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 23:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=unaBiWnJarMH1gL7KYAkXbKz3od/E6fqsCgI629LIGM=;
        b=etu1S8miUnZsNSpg3HW7x38uMVbiLPD1tNvKTPEnOlRvEcWJzm7exG7BPJaod1ka0w
         CDa1vvopBYQX351vd75gYooym69T9Nf/RaGcFiYe3LjhfDCFhimGra+WB9snRBMOwYDS
         EPTfEacpnlvH9TbmEuvaYVdzOLBjl4lRLI9Wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=unaBiWnJarMH1gL7KYAkXbKz3od/E6fqsCgI629LIGM=;
        b=Extbq+HtFaEGH4NTeLhGCuYkUMwPLUru7mlaZM3eKOF1CV2GpCBpsB2hbVYxr/YHzP
         qxV+ARcVw6yeI1StlkKXtuBpWH3z50eeGwqRl2avkhBGKwNIHj71Ak7RmBisXMJRKHm2
         OXEI1yy5sQ1I69lPT5YLKHWyYkkHTWHEYwpk/Gaa7OdxcTtevQN6jgsk6NVQAms2LtHX
         /Jxs/iSR38lJDrKpX3OtZ/5Y+r759UAQQXYu82+0VgLjAfdJXWXHepUFs0SnOGVI78n8
         bsOVSEvJp/QmwC+DzpdgW6/Jw+jxFSUxgbyr11N0MxS6I1cXMKID5o7YMpdhUwDeIoON
         UBKw==
X-Gm-Message-State: AOAM531eTAvYHMasHrkueXKqPGqkSPB8sqp6nixfEJnT0AR38883U6pk
        BVJ2Ao2hni18JZPsvilLwwUaOA1PgkaDYYJMjZTH8Q==
X-Google-Smtp-Source: ABdhPJy9IXnVib4DwY4g5a0dAWpWJk7dTChMptWv36qjycMCr9phL4RvEij4IZ7zX1gWMYsr8+0hSgzSXnmOIVcsi3U=
X-Received: by 2002:ac2:48b8:: with SMTP id u24mr2049392lfg.587.1626331232261;
 Wed, 14 Jul 2021 23:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210705054111.4473-1-chun-jie.chen@mediatek.com> <20210705054111.4473-6-chun-jie.chen@mediatek.com>
In-Reply-To: <20210705054111.4473-6-chun-jie.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 15 Jul 2021 14:40:21 +0800
Message-ID: <CAGXv+5ETE=qSPyKL6AjDtSHCDvu3Ua-rrLZWOECjZXrcNZ-9Tw@mail.gmail.com>
Subject: Re: [v3 5/5] soc: mediatek: pm-domains: Remove unused macro
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 5, 2021 at 1:48 PM Chun-Jie Chen <chun-jie.chen@mediatek.com> wrote:
>
> Due to clk resource data will be allocated dynamically by
> searching parent count of clk in power domain node, so remove
> the unused marco MAX_SUBSYS_CLKS for static allocation.
>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  drivers/soc/mediatek/mtk-pm-domains.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
> index caaa38100093..1b8967b9829e 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.h
> +++ b/drivers/soc/mediatek/mtk-pm-domains.h
> @@ -72,8 +72,6 @@ struct scpsys_bus_prot_data {
>         bool ignore_clr_ack;
>  };
>
> -#define MAX_SUBSYS_CLKS 10
> -

Future advice: cleanups like this and other fixes should be put in the
front of the series, before any patches that introduce support for new
features or hardware. That way if the new code still needs work,
maintainers can optionally apply the fixes so you don't have to carry
a large patch series forward.

ChenYu

>  /**
>   * struct scpsys_domain_data - scp domain data for power on/off flow
>   * @name: The name of the power domain.
> --
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
