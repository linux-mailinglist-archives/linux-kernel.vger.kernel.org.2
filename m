Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626393566B2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 10:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347423AbhDGIXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 04:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349484AbhDGIWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 04:22:50 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD49CC06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 01:22:41 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id q6-20020a17090a4306b02900c42a012202so890027pjg.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 01:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pUnV0shR/oCMYgnmnNQwL7EnhhWY5mZeQ+eZ+38HoRw=;
        b=xj9WsROqSPdRyQELlvHezyHuV14Rw0a0E3qAWC3T0by7VCbpgwHKcU4s5cFLMoaSsr
         8llGJbbkjciSiNz8+rMycl+haAG/K+EXU6nFAbkCvT0yURtNrFsqLeI6xx3cH1QZQf9s
         wBmKKyVFEkS7oIGGm6Mn3gulSafw6Y+DBTPTngtKJRAY1i8nestLAV5gJ8XxxnaLkxGG
         G1HdclDgFpdcLHT+DU2GjSY9aY6vL7kyB9ugLxinj5jyOIoigAV557QJoMuyR5HcdXFR
         rEh+MFb65rzHltJEa+WFjOtcRAiTOY/GuGYzAJF3hcalYrNkktEiW4SVVagxpJKEO4mQ
         Q/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pUnV0shR/oCMYgnmnNQwL7EnhhWY5mZeQ+eZ+38HoRw=;
        b=czD1qc4x5VXhyyIUrq+a7LOJYp2aeZSsQ+uNX87kWxAMePlc4we5os7s4p4eqaDiZJ
         ztFlvw7y+cuTiq0v7wOlOZ7ZbC0G9qFszIWDxXHGMfLCjtf6wv6C91mIm+XBmiaVRHB7
         JU3m/IPRJqRHURlKQ4NEh5y/w6RAjbkI/+9DNwEELip15XL74jt4CzBPo9piK9nHd2yv
         qhmhW/RqHU0/BnwKaVqMSfiiVjVHJvJiKX+s14Do3wgQF9K7UItWJbNNavrdmTPg6aJm
         sYaBVyNZZX+x1PnvCvI34xDs+REI2ktlhgLsjue2KKhszkrhtLwvTsfbZCOOX+ZI7rU+
         Ycgw==
X-Gm-Message-State: AOAM532rJhl44n0Cg4zk4SCyYzNKu6VWewvUSijLOR2cBpsWe7Q/euIv
        +1ztQQnxf+0FbISKkR2kjuGCzq3WSpDGseslg6o6OQ==
X-Google-Smtp-Source: ABdhPJzEeehdY7b11JhwjjOUEOJPp0tySkkUR0tm+ie/d3TE9/NFTybrU4fI402JUg5bWgt7tDprQPPRonK9506Ty6k=
X-Received: by 2002:a17:90a:c781:: with SMTP id gn1mr2209831pjb.205.1617783761158;
 Wed, 07 Apr 2021 01:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210407025029.2616-1-jarvis.w.jiang@gmail.com>
In-Reply-To: <20210407025029.2616-1-jarvis.w.jiang@gmail.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Wed, 7 Apr 2021 10:30:51 +0200
Message-ID: <CAMZdPi_CZG1e1H+kf7NDRWDxV9hiG-ZCLca7EXgKtsY_NEKatA@mail.gmail.com>
Subject: Re: [PATCH] bus: mhi: pci_generic: Introduce Foxconn T99W175 support
To:     Jarvis Jiang <jarvis.w.jiang@gmail.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Hemant Kumar <hemantk@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        cchen50@lenovo.com, mpearson@lenovo.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarvis,

On Wed, 7 Apr 2021 at 04:51, Jarvis Jiang <jarvis.w.jiang@gmail.com> wrote:
>
> Add support for T99W175 modems, this modem series is based on SDX55
> qcom chip. The modem is mainly based on MBIM protocol for both the
> data and control path.
>
> This patch was tested with Ubuntu 20.04 X86_64 PC as host
>
> Signed-off-by: Jarvis Jiang <jarvis.w.jiang@gmail.com>
> ---
>  drivers/bus/mhi/pci_generic.c | 58 +++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>
> diff --git a/drivers/bus/mhi/pci_generic.c b/drivers/bus/mhi/pci_generic.c
> index 5cf44bcfe040..3e396c65a758 100644
> --- a/drivers/bus/mhi/pci_generic.c
> +++ b/drivers/bus/mhi/pci_generic.c
> @@ -260,6 +260,52 @@ static const struct mhi_pci_dev_info mhi_quectel_em1xx_info = {
>         .dma_data_width = 32
>  };
>
> +static const struct mhi_channel_config mhi_foxconn_sdx55_channels[] = {
> +       MHI_CHANNEL_CONFIG_UL(0, "LOOPBACK", 32, 0),
> +       MHI_CHANNEL_CONFIG_DL(1, "LOOPBACK", 32, 0),
> +       MHI_CHANNEL_CONFIG_UL(4, "DIAG", 32, 1),
> +       MHI_CHANNEL_CONFIG_DL(5, "DIAG", 32, 1),
> +       MHI_CHANNEL_CONFIG_UL(12, "MBIM", 32, 0),
> +       MHI_CHANNEL_CONFIG_DL(13, "MBIM", 32, 0),
> +       MHI_CHANNEL_CONFIG_UL(14, "QMI", 32, 0),
> +       MHI_CHANNEL_CONFIG_DL(15, "QMI", 32, 0),
> +       MHI_CHANNEL_CONFIG_UL(16, "QMI1", 32, 0),
> +       MHI_CHANNEL_CONFIG_DL(17, "QMI1", 32, 0),

Are these QMI channels need to be exposed, vendors usually expose
either QMI+QMAP or MBIM (for data and control), here you expose
IP_HW0_MBIM as 'data' channel, so I would expect that MBIM is all you
need for the 'control' channel.

> +       MHI_CHANNEL_CONFIG_UL(18, "IP_CTRL", 32, 0),
> +       MHI_CHANNEL_CONFIG_DL(19, "IP_CTRL", 32, 0),
> +       MHI_CHANNEL_CONFIG_UL(20, "IPCR", 32, 0),
> +       MHI_CHANNEL_CONFIG_DL(21, "IPCR", 32, 0),
> +       MHI_CHANNEL_CONFIG_UL(32, "AT", 32, 0),
> +       MHI_CHANNEL_CONFIG_DL(33, "AT", 32, 0),
> +       MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0_MBIM", 128, 2),
> +       MHI_CHANNEL_CONFIG_HW_DL(101, "IP_HW0_MBIM", 128, 3),
> +};
> +
> +static struct mhi_event_config mhi_foxconn_sdx55_events[] = {
> +       MHI_EVENT_CONFIG_CTRL(0, 128),
> +       MHI_EVENT_CONFIG_DATA(1, 128),
> +       MHI_EVENT_CONFIG_HW_DATA(2, 1024, 100),
> +       MHI_EVENT_CONFIG_HW_DATA(3, 1024, 101)
> +};
> +
> +static struct mhi_controller_config modem_foxconn_sdx55_config = {
> +       .max_channels = 128,
> +       .timeout_ms = 20000,
> +       .num_channels = ARRAY_SIZE(mhi_foxconn_sdx55_channels),
> +       .ch_cfg = mhi_foxconn_sdx55_channels,
> +       .num_events = ARRAY_SIZE(mhi_foxconn_sdx55_events),
> +       .event_cfg = mhi_foxconn_sdx55_events,
> +};
> +
> +static const struct mhi_pci_dev_info mhi_foxconn_sdx55_info = {
> +       .name = "foxconn-sdx55",
> +       .fw = "qcom/sdx55m/sbl1.mbn",
> +       .edl = "qcom/sdx55m/edl.mbn",
> +       .config = &modem_foxconn_sdx55_config,
> +       .bar_num = MHI_PCI_DEFAULT_BAR_NUM,
> +       .dma_data_width = 32
> +};
> +
>  static const struct pci_device_id mhi_pci_id_table[] = {
>         { PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0306),
>                 .driver_data = (kernel_ulong_t) &mhi_qcom_sdx55_info },
> @@ -269,6 +315,18 @@ static const struct pci_device_id mhi_pci_id_table[] = {
>                 .driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
>         { PCI_DEVICE(0x1eac, 0x1002), /* EM160R-GL (sdx24) */
>                 .driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
> +       { PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0ab), /* T99W175 (sdx55) */
> +               .driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
> +       { PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0b2), /* T99W175 (sdx55) */
> +               .driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
> +       { PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0b3), /* T99W175 (sdx55) */
> +               .driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
> +       /* DW5930e (sdx55), With eSIM, It's also T99W175 */
> +       { PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0b0),
> +               .driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
> +       /* DW5930e (sdx55), Non-eSIM, It's also T99W175 */
> +       { PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0b1),
> +               .driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
>         {  }
>  };
>  MODULE_DEVICE_TABLE(pci, mhi_pci_id_table);
> --
> 2.25.1
>
