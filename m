Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9DA41777F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 17:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347115AbhIXP3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 11:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbhIXP3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 11:29:44 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A321C061571
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 08:28:11 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id i132so28686655qke.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 08:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nwyPI3LLZZr7ihPl0GgiIO8sy5/11bSMLHeNbY1x328=;
        b=KKs+EtTxw0d3D6JL2hLiw8zN4WvcPcGnwKXja88WtuReKyMArN+adoqEY7CLb7VUzU
         4p+pJVqLlwLY5qqO4udseAQoxne3lztCa9oRZa3LFwk8GiPSJKFL9mK7WSXisLsv32C2
         kWWlvgHxKzEfKMdbaaU4l+mgKWIuf75IGhfOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nwyPI3LLZZr7ihPl0GgiIO8sy5/11bSMLHeNbY1x328=;
        b=hmVhx1h7aWNiDxemTDtqVoWk7Yx6K5FlRNfZnilKZFp8ZYUu5sXWIi01CSl+rra6Jo
         Lp5JJZQ8NcoTe7MUO/Z7604AR5pzwj7dgjGZjl4IR27WYvu48UhI/ouQDFAPa7r7S3VI
         QtqqW7v8f34S05HDkMf00uiLfDz+MYxmggcJ4j9SpuLiRkaQTgRm3M7a7lj04Pjmj+h4
         5FXPy01c4tNow8rUhPB+Ua+GgmjwmwhDzSCZ0z13SMccAZFAgGobWHIleUKjucAjjNGr
         Jy8Zl1hP19uNnvrnCaYZNBEz9qlXmW86+1KPNMw/opogSaN6CO5il5momBM+XcJ9JcF5
         o3bw==
X-Gm-Message-State: AOAM533CVG2jIG0BW9K8nK4RJxcMvACzOokAlgE8S7trZokCEywCMcTS
        c9BWM08bEqLUAk15FLMINKwpBNx33BjKfTHLKsfogw==
X-Google-Smtp-Source: ABdhPJxMYUhbdab5cp2PfXIC/l5A+n6t4seckd2MbOIknifAD/flknz1qEepUFO4CTi7u91hkEncRYfvTSILitI9v/o=
X-Received: by 2002:a37:a647:: with SMTP id p68mr7655770qke.482.1632497290404;
 Fri, 24 Sep 2021 08:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210924031459.8911-1-f.fainelli@gmail.com>
In-Reply-To: <20210924031459.8911-1-f.fainelli@gmail.com>
From:   Markus Mayer <mmayer@broadcom.com>
Date:   Fri, 24 Sep 2021 08:27:59 -0700
Message-ID: <CAGt4E5v31_Q5U7AR0uz8FKdAEAzZGdcRQNmV-cVVQrZruAZVJQ@mail.gmail.com>
Subject: Re: [PATCH] memory: Allow building Broadcom STB DPFE as module
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        "maintainer:BROADCOM STB DPFE DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "moderated list:BROADCOM STB DPFE DRIVER" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sept 2021 at 20:15, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> Allow building the Broadcom STB DPFE driver as a module, it is already a
> platform driver proper with all of the resource releasing device
> managed.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Markus Mayer <mmayer@broadcom.com>

Thanks!


> ---
>  drivers/memory/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> index 72c0df129d5c..0ebb83b35a64 100644
> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -55,8 +55,8 @@ config ATMEL_EBI
>           SRAMs, ATA devices, etc.
>
>  config BRCMSTB_DPFE
> -       bool "Broadcom STB DPFE driver" if COMPILE_TEST
> -       default y if ARCH_BRCMSTB
> +       tristate "Broadcom STB DPFE driver"
> +       default ARCH_BRCMSTB
>         depends on ARCH_BRCMSTB || COMPILE_TEST
>         help
>           This driver provides access to the DPFE interface of Broadcom
> --
> 2.25.1
>
