Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D8736F220
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 23:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237088AbhD2VfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 17:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237192AbhD2VfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 17:35:11 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFC8C06138C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 14:34:22 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id c8-20020a9d78480000b0290289e9d1b7bcso48632107otm.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 14:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=94DCtsG2iFDGFG/cw++7NBkXph2eX5fX182KYqcDcOM=;
        b=jqlnxSTNisOmxaHPB0rtpEwXe4UXrel+3Ca+E4sQR+OcNLhjv0h5mXxnEv2gvFDZix
         APXmicSu3rTzUJ2PaXLMZg0mYMRnY/9ebySuie+w0TN6lR1XQS0q6p85LokN5zmO7wxv
         aid/ukI2RPPtH4YbK2rjPTEqcVM9oy7xbMrzm5HC/hrSrupgq2+rqMRDviD1HDtnnzvF
         rArJdVgyCfFkE7rd/E2m9f5m3IaTexIMEyTmrTUJuZFFTajwpNdQrOroLR+wv4/L+Nmq
         DDlBehLF0y5pun9HhKPFOaHHFqeEpvA9MICkLrCUAyw/9GQSDwo9c69X7Vi34HTKfWWi
         O/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=94DCtsG2iFDGFG/cw++7NBkXph2eX5fX182KYqcDcOM=;
        b=jehEWt1JwHG2AufeJ+UPZnyLu8CSnnskTYUxxFnqgEh/xVG+KbGt+b9ucDbDwqVSZC
         0nN/zBrp+Gyj0gc4LOL4Qt9qMVADjQEN516UHJVTlLgVhlrRxDq4y33cPBPZs/Lrdv0m
         Aqo2bTg7XLkoOw8KqE3kX0eMp+K/rkbKvx7BtYtcSjQLIzQ6xDSw8eSCLpuSaUZ7pWJG
         kbQo9NTWf0sQPBoyEeLnA7T6XkRntyjQ4aoUIrNKDHgTP1byLhHCmyIr+pvzHYZVNNGL
         z8XXRqoM2Ga8u5Ys09GY1igyUoLAzf3Mgf89x0X4nr2N7n0HYrhlLgd8pyPQHyq24qQJ
         OeEA==
X-Gm-Message-State: AOAM533Emq2+udm26UVzqzFqQYaAKFh14YQaj+LeB/SRT9nRbQQ18ORU
        bP24M9osR6wFaIFR0ykYYReFwFfbwF++bOXwEmFctw==
X-Google-Smtp-Source: ABdhPJxrdtNiNne+su1y/Z0A6Qz3Gx1qyB2Pxu71jCm+DT4diilVTACODMAbTlv2OfFVcBd5KZGzWrmWsLf3VaGndYU=
X-Received: by 2002:a9d:459a:: with SMTP id x26mr890700ote.337.1619732061558;
 Thu, 29 Apr 2021 14:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210429155713.28808-1-michael@walle.cc> <20210429155713.28808-3-michael@walle.cc>
In-Reply-To: <20210429155713.28808-3-michael@walle.cc>
From:   Alexander Williams <awill@google.com>
Date:   Thu, 29 Apr 2021 14:34:10 -0700
Message-ID: <CACqsJN9283nSmgdDTz+LhfiQwfi4ZmrSJEP+0JJ24-KZ7isMEA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mtd: spi-nor: add initial sysfs support
To:     Michael Walle <michael@walle.cc>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Heiko Thiery <heiko.thiery@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 8:57 AM Michael Walle <michael@walle.cc> wrote:
>
> Add support to show the manufacturer, the partname and JEDEC identifier
> as well as to dump the SFDP table. Not all flashes list their SFDP table
> contents in their datasheet. So having that is useful. It might also be
> helpful in bug reports from users.
>
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> Pratyush, Heiko, I've dropped your Acked and Tested-by because there
> were some changes.
>
>  .../ABI/testing/sysfs-bus-spi-devices-spi-nor | 31 +++++++
>  drivers/mtd/spi-nor/Makefile                  |  2 +-
>  drivers/mtd/spi-nor/core.c                    |  1 +
>  drivers/mtd/spi-nor/core.h                    |  2 +
>  drivers/mtd/spi-nor/sysfs.c                   | 92 +++++++++++++++++++
>  5 files changed, 127 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor
>  create mode 100644 drivers/mtd/spi-nor/sysfs.c
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor b/Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor
> new file mode 100644
> index 000000000000..4c88307759e2
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor
> @@ -0,0 +1,31 @@
> +What:          /sys/bus/spi/devices/.../jedec_id

Since mtd/spi-nor doesn't own this device (belongs to the spi subsystem), should
we put its attributes under a named subdirectory? Perhaps something like
/sys/bus/spi/devices/.../spi_nor/jedec_id ?

I'm just thinking about avoiding any potential for namespace clashes.
- Alex
