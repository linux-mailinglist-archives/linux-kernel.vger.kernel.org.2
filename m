Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25D6330EFD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 14:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbhCHNQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 08:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhCHNQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 08:16:28 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF8FC06175F;
        Mon,  8 Mar 2021 05:16:28 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id cw15so4503793qvb.11;
        Mon, 08 Mar 2021 05:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mq/RjOi7oMvBkyqqQDEJlkZFAJdUsCm3Qg8+RS8/HSo=;
        b=BdHyVo3yQuV3DV48f3bJjriWahibIKWTlkYMWIxyjaeMsJ0eLXR8/VVMc34NswrBkC
         nKHr9BKZyu88I8ghJ6Kz0bzo/xOsVeSY5AW9j3eSukKNb6S9EoyrHqodb/q4uU8cCXcN
         Po3Jw1pEtrFsNCNXsPE842EFlS8agYdjp/MUiN2RO/1OWj1wtXDqUBtThXJ0hMa3zYgz
         L6BdI+D+n6aycm+pFueaaDTXSSZycUyibySGKH0sExDhkPr/eT4gnVnPNS+PyzZFXRuo
         sK39l5TRhwHhFKTo/4rbSyBnSv80SmWhlhrQyai6FZws9G78Ok8rJi2z9Xe+Lv8QsLYJ
         ECDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mq/RjOi7oMvBkyqqQDEJlkZFAJdUsCm3Qg8+RS8/HSo=;
        b=TI6L3yG6x0/NQjC3Tlnc1g/IZhUrXF7H1pNloNiogKyDbYxlW1wPheSQPgb37aC4xf
         ZrGcJbHbphjaAZY0Cm65qP40UtvmmMAsw+U2cwEblU0ixOeRA6AJnzFT1+ln0p/RVX5L
         r/pSUH5cjUe5Qr1MvdWOdnGwUZAswC+9rwLa/uJThHVIJMS6TODD9UtujFKY0dMO3p2e
         L+War/hDsokxma7567yz/NE21/y5zWouNJhte9vGLD3YhFGVuQPXTbNu4qwlnB58036D
         fqDlZ2gfPoMQ/fkrrX3q/Rk60udfEWPiygOofISOWu2oojLcY63/hq1iCxOVr5soT1lD
         04rw==
X-Gm-Message-State: AOAM533UvVgUO9iMfX8yMe0xdyT8aPxY5RHJKGKFCtBqcGx95hRzPdoq
        AYn8RhxGoe5NI1bYY0ESk3YpVAN2r7ohoU2TBwoWmE4LY6o=
X-Google-Smtp-Source: ABdhPJygKdeW7eWlM9tZB3oGSyuFSBjt6ZqB3nTQwnEAkBjDRdfL3US7UMWjWXaXySP+UvXlKsBkA6VqexayPm1FufM=
X-Received: by 2002:a05:6214:76f:: with SMTP id f15mr20582682qvz.56.1615209387754;
 Mon, 08 Mar 2021 05:16:27 -0800 (PST)
MIME-Version: 1.0
References: <1614221563-26822-1-git-send-email-shengjiu.wang@nxp.com>
 <1614221563-26822-8-git-send-email-shengjiu.wang@nxp.com> <20210306203617.GA1164939@robh.at.kernel.org>
In-Reply-To: <20210306203617.GA1164939@robh.at.kernel.org>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Mon, 8 Mar 2021 21:16:16 +0800
Message-ID: <CAA+D8APUVqyRRPc4GDwJqQEcnEPLxQMcZ+VhkbbrOx7hQs1jSA@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] ASoC: dt-bindings: imx-rpmsg: Add binding doc for
 rpmsg machine driver
To:     Rob Herring <robh@kernel.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org,
        Timur Tabi <timur@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 7, 2021 at 4:37 AM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Feb 25, 2021 at 10:52:43AM +0800, Shengjiu Wang wrote:
> > Imx-rpmsg is a new added machine driver for supporting audio on Cortex-M
> > core. The Cortex-M core will control the audio interface, DMA and audio
> > codec, setup the pipeline, the audio driver on Cortex-A core side is just
> > to communitcate with M core, it is a virtual sound card and don't touch
> > the hardware.
>
> This sounds like 1 h/w block (the interface to the cortex-M), your DT
> should be 1 node. If you need 2 drivers to satisfy the needs of the OS,
> then instantiate one device from the other device's driver.
>

Ok, I will change it in v4.

best regards
wang shengjiu
