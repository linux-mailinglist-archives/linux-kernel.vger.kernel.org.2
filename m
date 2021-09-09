Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F684045CD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 08:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350859AbhIIGxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 02:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350839AbhIIGxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 02:53:38 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16741C061757
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 23:52:29 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id bd1so1303297oib.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 23:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n/dbtsQItzFXG3VUtr5tpCtogf60jhbRfY1HqI+6zeg=;
        b=gyFgjz4/3LjQCakqfOSTVUCjrvKZcjbZHuTwspXxUdu8JCq0c29GPSXdlOJKg8kEX/
         whefJmwhR4dTsN+4Gtszow3uSHaLa5N4E7aWgjz+fNO0IEHOy7H0M4nx65A/RsyTaZOd
         bFa5if1a/nFRzVskAHrouMI9W4Vnu7ZFnuBB87FdKR5L0hsBQlzU0YTb2e3JofdAJqy1
         byh6cJb/po6bcwbieRkpagopbAf7WGXNJVdA8iTq3Q3KX+yphpw35xa2wVt9WnPNA9xT
         i4CI2w7tN6MPiCB+aeM+VQefMXj5aKzAEQSX6vvBYMNa7rfqiB2GgaLjhYbOhkOVqtET
         o5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n/dbtsQItzFXG3VUtr5tpCtogf60jhbRfY1HqI+6zeg=;
        b=yAW/WyuHaPMpovKljzp3rToRzVCXasA+VHelu95IjbI+Wi9EhvsUuBq6xtDqvLawIF
         reqJLrB88H0HAry+3IIlhNB6RMzJUiwyNmERlVXEw1saI0pPrl4VxaILDP5bE/GwPF5Z
         KRTYuS1FnrhQdt65RcLo3Qy21AOpZa1CvZoPByBdvgYCkGV0wm/211jsTG4Cc+SngPx/
         6QqSyoi6d3ueZ0lBobMq6esiTeDTxMQTdoPh2jeha8BZkTj03zRRuLQY/6Ptu5fUgsV1
         8UhSNSYa4JRnmoe1oFpf1QhhJTzfgSO1yTTvqiImqYfABUIOnt5AIAeOBiB/Dj/rhzir
         Pohg==
X-Gm-Message-State: AOAM532euONT1XmpHzEPidcfMSAV1LUXYN+aNEsw1SSagkp5QvGR+Ozo
        E0ejWspuDiCU8S3CtnSetV39qoFe1XkFHyixmWMxFg==
X-Google-Smtp-Source: ABdhPJxYlOZA1Z3SpX9pxnUob+P/iJhoYZcvVtQEHgSSu3BJmDqo3PtVCpNE/CpESGExUkz55CWZKfuAz539Xbp3cZY=
X-Received: by 2002:a05:6808:1294:: with SMTP id a20mr962310oiw.4.1631170348266;
 Wed, 08 Sep 2021 23:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210902021817.17506-1-chiawei_wang@aspeedtech.com>
In-Reply-To: <20210902021817.17506-1-chiawei_wang@aspeedtech.com>
From:   Lei Yu <yulei.sh@bytedance.com>
Date:   Thu, 9 Sep 2021 14:52:17 +0800
Message-ID: <CAGm54UERFkOLXtG3wwL9x1-HAXjmRoaG4ZRbZZOLjP1bLZ=LSg@mail.gmail.com>
Subject: Re: [External] [PATCH v2 0/3] arm: aspeed: Add UART routing support
To:     Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, lee.jones@linaro.org,
        Oskar Senft <osk@google.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>,
        openbmc <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patches are tested on meta-g220a build and it works fine with some
changes in the sysfs path[1].

Tested-by: Lei YU <yulei.sh@bytedance.com>

[1]: https://github.com/openbmc/meta-bytedance/blob/master/meta-g220a/recipes-phosphor/console/obmc-console/obmc-console%40.service#L7-L10

On Thu, Sep 2, 2021 at 10:20 AM Chia-Wei Wang
<chiawei_wang@aspeedtech.com> wrote:
>
> Add UART routing driver and the device tree nodes.
>
> v2:
>  - Add dt-bindings
>  - Add ABI documents for the exported sysfs interface
>  - Revise driver implementation suggested by Joel
>
> Chia-Wei Wang (3):
>   dt-bindings: aspeed-lpc: Add UART routing compatible string
>   soc: aspeed: Add UART routing support
>   ARM: dts: aspeed: Add uart routing to device tree
>
>  .../testing/sysfs-driver-aspeed-uart-routing  |  15 +
>  .../devicetree/bindings/mfd/aspeed-lpc.txt    |  22 +
>  arch/arm/boot/dts/aspeed-g5.dtsi              |   6 +
>  arch/arm/boot/dts/aspeed-g6.dtsi              |   6 +
>  drivers/soc/aspeed/Kconfig                    |  10 +
>  drivers/soc/aspeed/Makefile                   |   9 +-
>  drivers/soc/aspeed/aspeed-uart-routing.c      | 601 ++++++++++++++++++
>  7 files changed, 665 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing
>  create mode 100644 drivers/soc/aspeed/aspeed-uart-routing.c
>
> --
> 2.17.1
>


-- 
BRs,
Lei YU
