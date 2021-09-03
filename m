Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDBF40017F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 16:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236163AbhICOux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 10:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbhICOuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 10:50:52 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFA7C061575;
        Fri,  3 Sep 2021 07:49:52 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id t15so8602651wrg.7;
        Fri, 03 Sep 2021 07:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZSZsYJo1TwLrOI6mOU5kddR0wUijI2KCqfg09r8Ks7Y=;
        b=l5v/CVr7CgrXHirQq5mOZV5zF5GFIoFObhSZIHcq2UYp8b7ubfcoWcm8YnAL4OwX+w
         +SIeYmhC1mraCOv5g6UB2pEL6cA+MKZKu51+j59ZWKlkSbU1PtzG9QSeMxIREbvP/TzY
         YOC+wzvbDcVB+dF9OFgRilwWfzNg6wTQi2PprFzSKQOjIzRKra0kUqO9fD632E9BWMdM
         m9CVMKJ9r7vUkZc2I62U22ap48W3TEcrn24I9vetW1i83tGcv8npzjcO9SviQmZfDan4
         RUxe/R+Rz9KEZGdRPlIRxGtXIK5Pc0RXQaEXwf23BdcSA4pA8z69rUzY0xNguiyuWLxk
         Mzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZSZsYJo1TwLrOI6mOU5kddR0wUijI2KCqfg09r8Ks7Y=;
        b=qvjdg/Ow/dquAllq/N1ejiD/AC96qG1wa7jBuazBy3Cubd4cnHV6jozuTZc81J4nHW
         6hCGlkIRt9wJtYTjB/THHD0m0fHFspi4XTTP77Fl650CLyaMvY3SmH4rlTbvkKUz/QsX
         ihKITCWh/ztoFhOZnFI127jWZs2GRnSW1h0kdKP9KRtDdvItMPZ2XUXZsoGvIm+sQSSU
         UNQR8eXgM96Qx/J6ZD91k49MVUs8H5YvqMtpfB8hbeANI2OK8tq+a7oFMWe8zmfsGg+g
         ip+uwoy8KeXQzL7yMVmUMV9EiGxAL3HiPQq+cGmuwcJ6W/Y4F6IrkscOoRLXLuswoQic
         lVnQ==
X-Gm-Message-State: AOAM5332UK5xBlAZW4ws2MDHttUNx8nFa0H4HaxcJAfYJjOSWAeNSmM0
        ucpat8Dxk+yJkR9TFNTyJQN1ncnZxoQGL7yR50I=
X-Google-Smtp-Source: ABdhPJxkF816f/hTx1Ho5iGqTqbkepANdHgYQJKfy+V1BgAY5r0WjyIBRC6EnKKQ73xhoZZHwYyvTz5LA2gywM7uL50=
X-Received: by 2002:adf:edc2:: with SMTP id v2mr4619556wro.255.1630680590698;
 Fri, 03 Sep 2021 07:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210902123216.787025-1-daniel.baluta@oss.nxp.com>
 <20210902123216.787025-2-daniel.baluta@oss.nxp.com> <20210902144913.GE11164@sirena.org.uk>
In-Reply-To: <20210902144913.GE11164@sirena.org.uk>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Fri, 3 Sep 2021 17:49:38 +0300
Message-ID: <CAEnQRZAfBwgfOM6w_azSw4n=qw2Cc2HPHSaTXmFa9LKXM_OQJQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: SOF: imx: Add code to manage DSP related clocks
To:     Mark Brown <broonie@kernel.org>
Cc:     Daniel Baluta <daniel.baluta@oss.nxp.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, peter.ujfalusi@linux.intel.com,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        s-anna@ti.com, Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 3, 2021 at 2:27 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Sep 02, 2021 at 03:32:15PM +0300, Daniel Baluta wrote:
>
> > +     for (i = 0; i < clks->num_dsp_clks; i++) {
> > +             clks->dsp_clks[i] = devm_clk_get(sdev->dev, clks->dsp_clks_names[i]);
>
> Looks like this could benefit from the use of the clk_bulk_ APIs?

Indeed! I open coded exactly what clk_bulk API is doing! Will use it in v2.
