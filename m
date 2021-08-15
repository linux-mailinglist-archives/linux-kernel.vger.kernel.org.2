Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7E23EC8E7
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 14:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237917AbhHOMRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 08:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236645AbhHOMRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 08:17:44 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D175BC061764
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 05:17:14 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id j18so4127883ioj.8
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 05:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=8DvauyvpbVYFz5wZrX0yCvcyUcWWBYMnjHoQjtjcTZY=;
        b=tDrqQlK7njdPCWOirSQAGsmYrQQPQeS9v/61ZGsPYUKSvq+yiwJRgcRbNl29nCZGvQ
         PDB/qD2mJOtPi9avSq/X7ifBP6QJAcr7Tsr5mvcjlWV3S8KBSJieRzOfgisAkjmblSdt
         AyQrE0/txnNiytzfH0NiwbcDZ5OyrwgUD6Ex8kK8EoBKMCrl3eB/rrwQn738QIlxK3qZ
         DZ5b+I9QDdBtKxh2Ff0o8gSBP51mtd/5ZNWingGFTmZICbMW6txG+vPA3b6qTk+vfhXl
         0aqA3ZK4+Y173szqwSZy4Z8z4QOVVdmKhiIAz5oBEI+GDAusw5+a9HIJ10zxXPryDio7
         A1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8DvauyvpbVYFz5wZrX0yCvcyUcWWBYMnjHoQjtjcTZY=;
        b=qSDQRooZVn5deBjDHR5J0+CLw8rzV/IMjQgV2Gk8qZjdl50gtU+LOztCJDFeWo3yEt
         TbGJtkW15Pm/p6cKp7VeizqxoWCRX6t6ngZr/WSP8pJi5PaGVJRtIbnZYvR9e9s+YX5P
         KEg4mPETVrhO8meP6bcSU1lImEH7Dbg5oPAytJo4XNvzHu7tmwbABVlmq63p5HR4CNiD
         F0OvxEWGaoZGysySBvbQpdR2+lv/dy5/MzE0aVnVnEgv+tndcxKuHhl7x5I0vFgN6039
         moi/iQgw5FK/PrAGI9++z02o66u91d+i7VPRyuxu1n6yxpOK4neq4L7kTAWhjAQtqo3C
         jsRA==
X-Gm-Message-State: AOAM531zsx3omreHRfKYQyO6OciY+kqLKrDPIEmGDjBH4vR7Ix5nwyXD
        /2tiWnfxPXSiopDGUKI5qfXWUWW/yYXcK7v2Qns=
X-Google-Smtp-Source: ABdhPJzzhgd216ADTBfYtOOwAPhsEklI7zPACDNcuxOfG1D27PRthPO75EOf5ANbbckQR9e9PckmjuEhy0nJw2Jcu1k=
X-Received: by 2002:a02:cc22:: with SMTP id o2mr10625613jap.26.1629029832993;
 Sun, 15 Aug 2021 05:17:12 -0700 (PDT)
MIME-Version: 1.0
From:   Alistair Francis <alistair23@gmail.com>
Date:   Sun, 15 Aug 2021 22:16:47 +1000
Message-ID: <CAKmqyKMLyx+CvBQbLz-xQvwLS692tx-4xOgU7b-V2J676D29yg@mail.gmail.com>
Subject: Revert "video: fbdev: mxsfb: Remove driver"
To:     Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, Marek Vasut <marex@denx.de>,
        b.zolnierkie@samsung.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Commit f225f1393f034 "video: fbdev: mxsfb: Remove driver" removed the
mxsfb fbdev driver.

I am now working on getting mainline Linux running on the reMarkable 2
eInk reader [1]. Unfortunately the rM2 doesn't use the standard EPD
controller on the i.MX SoC, but instead uses the LCD controller.

eInk panels are complex to control and require writing temperature
dependent waveforms. As these waveforms are proprietary [2] the rM
team runs closed source software called SWTCON in userspace to control
the panel [3].

This closed source software expects the fbdev mxsfb driver and it
doesn't work with the DRM mxsfb driver (at least not that I can get it
to).

The NXP fork of Linux also re-adds the fbdev driver [4], so they also
see some uses for it.

I was wondering if the community would be open to re-adding the fbdev
mxsfb driver to mainline? It could be re-added with a different
dt-binding so that it is not used by default and only enabled for
boards when required (like for the rM2).

1: https://remarkable.com/store/remarkable-2
2: https://goodereader.com/blog/e-paper/e-ink-waveforms-are-a-closely-guarded-secret
3: https://remarkablewiki.com/tech/rm2_framebuffer
4: https://source.codeaurora.org/external/imx/linux-imx/log/drivers/video/fbdev/mxsfb.c?h=lf-5.10.35-2.0.0

Alistair
