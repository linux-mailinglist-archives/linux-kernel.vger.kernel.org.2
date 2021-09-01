Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35393FD42A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 09:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242424AbhIAHFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 03:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhIAHFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 03:05:03 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B613AC061575;
        Wed,  1 Sep 2021 00:04:06 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id y144so2011845qkb.6;
        Wed, 01 Sep 2021 00:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BwspnAUn7LZfXZcrhkHTYVy+rXA4pIPXL34zOpZGxK4=;
        b=SPJxPpuo/j9tEgD6ltzaqOx/sV+mchjODDAQBBJVbWHtCPMnHVru5zR64daWMyGhjE
         2RfVMPV+AUwK2AlphScysxTEgGXA2iBjO3OK1l/vard0PeJZKASUECGoW7fw3VkxTojy
         XuBZWU3nVo1ATczUZINa3oz+84TiBSLnJIloc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BwspnAUn7LZfXZcrhkHTYVy+rXA4pIPXL34zOpZGxK4=;
        b=kzyt1z7n11FGVoPfyP8ZDHlKhCSTah2chPi7GCTVLWZaorFmI3edU1r+OmiKtILWP5
         HqkAv2f9R7fTuFq7TdQM5TzqWAB75WuEkEV9sKg1H9emkbh9xUXPc45fBxkoDnrv3VEt
         8eOnl68f1x9GYrsY04rJEZh7jimZ1vAljF5qgL3BYco2Hasyt9t3/OSpF77W3m6EVvo2
         gxgYebKmOXxvtqEyjsXWELIP5iti5zKOd2/4+XjsXfRR/spTiESftL68wto7/adk0lOU
         OmNCGKsS4HV5g/LwVF1AgtnXbWfybRU4OkRBOwCDQt7vk6Op04tM0iYppPR5nUMGui1c
         61iQ==
X-Gm-Message-State: AOAM531lBh53hO0DdnY1Ok9uLz91FIrK3cDxCyhqca4M/gj5Tih8KWvu
        /kIbqndNnx3NV+U/AOeZD1ml7xN3Q8VqjHXB0I4=
X-Google-Smtp-Source: ABdhPJwOjrH7Db3eOfeVdU/0wU7BzglfHksR1phlXCYSZeg1N7U+I8ZNr83Bo0XubUpL87Ew1JIdLl0xC2Tds7DPCVA=
X-Received: by 2002:a37:40d3:: with SMTP id n202mr7026774qka.357.1630479845711;
 Wed, 01 Sep 2021 00:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210901062216.32675-1-chiawei_wang@aspeedtech.com>
In-Reply-To: <20210901062216.32675-1-chiawei_wang@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 1 Sep 2021 07:03:52 +0000
Message-ID: <CACPK8XfeU0+w03fgYxXVMVYOW-2woXQtUZ4FEDri3MSe+80_Wg@mail.gmail.com>
Subject: Re: [PATCH 0/2] arm: aspeed: Add LPC uart routing support
To:     Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
        John Wang <wangzhiqiang.bj@bytedance.com>,
        Lei YU <yulei.sh@bytedance.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        Oskar Senft <osk@google.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Sept 2021 at 06:22, Chia-Wei Wang <chiawei_wang@aspeedtech.com> wrote:
>
> Add LPC uart routing driver and the device tree nodes.

Thanks for submitting this driver. There are many parties who are
interested in this, so hopefully they can step forward and review.

Is this LPC UART routing, or UART routing in general? I know the
register to control the routing is hidden in the LPC space, but I
thought it was just general routing. I would drop the LPC part of the
name.

You also need to update the bindings document with the new compatible
string. Send a patch for
Documentation/devicetree/bindings/mfd/aspeed-lpc.txt.

Cheers,

Joel



>
> Chia-Wei Wang (2):
>   soc: aspeed: Add LPC UART routing support
>   ARM: dts: aspeed: Add uart routing to device tree
>
>  arch/arm/boot/dts/aspeed-g5.dtsi             |   6 +
>  arch/arm/boot/dts/aspeed-g6.dtsi             |   6 +
>  drivers/soc/aspeed/Kconfig                   |  11 +
>  drivers/soc/aspeed/Makefile                  |   9 +-
>  drivers/soc/aspeed/aspeed-lpc-uart-routing.c | 621 +++++++++++++++++++
>  5 files changed, 649 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/soc/aspeed/aspeed-lpc-uart-routing.c
>
> --
> 2.17.1
>
