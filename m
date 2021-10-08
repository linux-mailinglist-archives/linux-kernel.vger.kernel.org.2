Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9844263D6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 06:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhJHEhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 00:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhJHEhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 00:37:38 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3DEC061570;
        Thu,  7 Oct 2021 21:35:43 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id b12so382720qtq.3;
        Thu, 07 Oct 2021 21:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ZuW84FCUeNefVYpl7AXF9/6C9HEWosikSwgMkrYqEo=;
        b=XDBDrBRCGDfMhmfBsfE4sYKoyPV6PDJ6GFvDUZJKpWtPB1mLpgU0cYQm5X5YNh3mnD
         3p8FNTlquaHZ8+ppbR8E612WozKfh7KLFuGh+mqvFBHcySVnfIAmS8PDOcpVBxleTeRT
         zl7Yg1iEbVGFlmHnqu04v7jeaskKs2aT0PvDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ZuW84FCUeNefVYpl7AXF9/6C9HEWosikSwgMkrYqEo=;
        b=lckDwYVC6uIp9HUSsgMVlJ9JaeRCxCjq9hQEKPtFV6/Sjhf3Jz5+HV/0kQkzTQQ32s
         gxcufiuo649ryRmYhI3iS2inpEkWzk3+hvJeJ6gaQlGZz/+PNQjj0QFvay5c9sS0iyIC
         EyhRUPTtSypVF1g9K6mYSRD+nON3S5WqjevGg0x82lxWUTXGX18dJkGJMNdEBZ3rJO6N
         acl7SNUn45Lp6+3I5pCwjkutTtUkQEF72J8f/cCn9YHcpPx/NqMz7np+EYl6yMOFV8OM
         Anr6NpvPoNVbsOmrHwjxNFSDa30v3X36xuHTpZY85YDIL1BzfeofIWM5dHX8nzqVh7V5
         wQpg==
X-Gm-Message-State: AOAM530Zrt2wZO0Z2gGddD0ruko3vlcwidzMoAPdcsdLnEK3UMA5fRLC
        ApVxLYQUcCS2ameimOIOBqU9RpKd2qEGXGv/UYE=
X-Google-Smtp-Source: ABdhPJx23WvHqotWOkfOASvG4ZJEedhf8Z22sYYHd357XdyP13GG/0PdPRGQ7t/sI6n+IBEYzZwvvHjHMJCb9sipnQY=
X-Received: by 2002:a05:622a:1345:: with SMTP id w5mr9462603qtk.259.1633667743064;
 Thu, 07 Oct 2021 21:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210927023053.6728-1-chiawei_wang@aspeedtech.com> <20210927023053.6728-2-chiawei_wang@aspeedtech.com>
In-Reply-To: <20210927023053.6728-2-chiawei_wang@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 8 Oct 2021 04:35:31 +0000
Message-ID: <CACPK8Xc+9yFJn_pO1sAVQJu_FWkA1U9XnbB+TLYgfdbHi1TyaQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/5] ARM: dts: aspeed: Drop reg-io-width from LPC nodes
To:     Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Oskar Senft <osk@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sept 2021 at 02:31, Chia-Wei Wang
<chiawei_wang@aspeedtech.com> wrote:
>
> The 'reg-io-width' properties are not used by LPC drivers
> nor documented as part of bindings. Therefore drop them.

I assume they are there due to the lpc having a 'syscon' compatible.
THey are documented in the syscon bindings:

Documentation/devicetree/bindings/mfd/syscon.yaml

Andrew, do you have any comments?

>
> This is in preparation to move aspeed-lpc.txt to YAML schema.
>
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> ---
>  arch/arm/boot/dts/aspeed-g4.dtsi | 1 -
>  arch/arm/boot/dts/aspeed-g5.dtsi | 1 -
>  arch/arm/boot/dts/aspeed-g6.dtsi | 1 -
>  3 files changed, 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
> index c5aeb3cf3a09..45a25eb4baa4 100644
> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> @@ -345,7 +345,6 @@
>                         lpc: lpc@1e789000 {
>                                 compatible = "aspeed,ast2400-lpc-v2", "simple-mfd", "syscon";
>                                 reg = <0x1e789000 0x1000>;
> -                               reg-io-width = <4>;
>
>                                 #address-cells = <1>;
>                                 #size-cells = <1>;
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index 73ca1ec6fc24..8e1d00d8445e 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -436,7 +436,6 @@
>                         lpc: lpc@1e789000 {
>                                 compatible = "aspeed,ast2500-lpc-v2", "simple-mfd", "syscon";
>                                 reg = <0x1e789000 0x1000>;
> -                               reg-io-width = <4>;
>
>                                 #address-cells = <1>;
>                                 #size-cells = <1>;
> diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
> index 1b47be1704f8..0d1aae6887cd 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -490,7 +490,6 @@
>                         lpc: lpc@1e789000 {
>                                 compatible = "aspeed,ast2600-lpc-v2", "simple-mfd", "syscon";
>                                 reg = <0x1e789000 0x1000>;
> -                               reg-io-width = <4>;
>
>                                 #address-cells = <1>;
>                                 #size-cells = <1>;
> --
> 2.17.1
>
