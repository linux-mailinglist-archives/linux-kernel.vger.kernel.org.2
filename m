Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E3A3B6B7B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 01:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236148AbhF1XlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 19:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbhF1Xkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 19:40:51 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2036DC061760
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 16:38:25 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id p7so6986546qvn.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 16:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=24QEkp0ruWhDlT9VQmxg2IKCctjJ1YCdLUMV4LRFyKE=;
        b=n26F1lBmm4to9yGPrWtcwiSQlCE8KWJY8cbH7iQ4rk1IYXPxPFs2M6rM8hmszNUgqL
         hZf4vIMkv9rQ8DcEDy+TH2m7mmH6Z0/QKLcNLz/OUc6Ck2sn0ncFULz1+CMCYw+x9Mv+
         mdFa22ui/u+464tf4K7a8BDoPKWzQ75CHlRjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=24QEkp0ruWhDlT9VQmxg2IKCctjJ1YCdLUMV4LRFyKE=;
        b=aIlAMKCF3nlnSIzCiwCYoc0MZmVDB8+E8hSUhvb+yGeRvXY9C0OUdNB2vBphi52F33
         nAPe8AaAMBBCOppvY2i4Y57knfxekxh9fDYpOJ18D5lFl499oddNBp1tDUICwIcel6b2
         +39j3gsRb4vuQWkAqqfvl5pL10Rdi3T2+2tgaV43ILqVkWvPMI+oL6LmzxG2Sy2DJMd9
         GKdJPHH0+EwTOGbqv+i20OCfjE0SIaLA7lGQccVZOka7ItStR8uUs3czzeBqPsHZB/zL
         UOgJjx44tBNL5A9eY4AEi9xpCvdVZsZ4obkxTo8kso1iNaZuCu+ttSTiJD3URtuOJ3ma
         6JFw==
X-Gm-Message-State: AOAM531uSQZI6BpfzQ2eNVuMTWDOxmc2VEiSBlNKPjCP+/p1DPyvQhKr
        y4hyw6Pf+Ltloco03YXDpTd3f+3S+wxvQA==
X-Google-Smtp-Source: ABdhPJzhizMeiZ7vP8AmLad50bBphEhUnhMqVadYifpCNChBfXXKjSEz+aYy4Yefg/sbvfIVD6rlsg==
X-Received: by 2002:a0c:b8aa:: with SMTP id y42mr27699634qvf.17.1624923504107;
        Mon, 28 Jun 2021 16:38:24 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id y7sm11355526qkp.103.2021.06.28.16.38.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 16:38:23 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id p22so8106654yba.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 16:38:23 -0700 (PDT)
X-Received: by 2002:a25:6088:: with SMTP id u130mr35812620ybb.257.1624923502959;
 Mon, 28 Jun 2021 16:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210625052213.32260-1-vkoul@kernel.org> <20210625052213.32260-3-vkoul@kernel.org>
In-Reply-To: <20210625052213.32260-3-vkoul@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 28 Jun 2021 16:38:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=ULVo=vz2Vww6_bcfrhosy0GRC2oVEcXt6zw8n4C2MiuQ@mail.gmail.com>
Message-ID: <CAD=FV=ULVo=vz2Vww6_bcfrhosy0GRC2oVEcXt6zw8n4C2MiuQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] soc: qcom: geni: Add support for gpi dma
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 24, 2021 at 10:22 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> +static void geni_se_select_gpi_mode(struct geni_se *se)
> +{
> +       u32 val;
> +
> +       geni_se_irq_clear(se);
> +
> +       writel(0, se->base + SE_IRQ_EN);
> +
> +       val = readl(se->base + SE_GENI_S_IRQ_EN);
> +       val &= ~S_CMD_DONE_EN;
> +       writel(val, se->base + SE_GENI_S_IRQ_EN);
> +
> +       val = readl(se->base + SE_GENI_M_IRQ_EN);
> +       val &= ~(M_CMD_DONE_EN | M_TX_FIFO_WATERMARK_EN |
> +                M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN);
> +       writel(val, se->base + SE_GENI_M_IRQ_EN);
> +
> +       writel(GENI_DMA_MODE_EN, se->base + SE_GENI_DMA_MODE_EN);
> +
> +       val = readl(se->base + SE_GSI_EVENT_EN);
> +       val |= (DMA_RX_EVENT_EN | DMA_TX_EVENT_EN | GENI_M_EVENT_EN | GENI_S_EVENT_EN);

nit: the above has some extra parenthesis that aren't needed.

I will continue to assert that all of the "set mode" stuff doesn't
really belong here and should be managed by individual drivers [1].
I'll accept that it doesn't have to block forward progress, though I'm
at least a bit disappointed that we asked Qualcomm to do this over 8
months ago and no action was taken. :(

In any case, this looks OK to me:

Reviewed-by: Douglas Anderson <dianders@chromium.org>


[1] https://lore.kernel.org/r/CAD=FV=VWPqswOXJejyXjYT_Yspdu75ELq42cffN87FrpTwPUQg@mail.gmail.com/
