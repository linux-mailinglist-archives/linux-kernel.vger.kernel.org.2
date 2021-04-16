Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE22361C5A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 11:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240594AbhDPItw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 04:49:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:40308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239777AbhDPItr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:49:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11EC361166
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 08:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618562963;
        bh=y5pQwjBbQFMq3bKD3QbzsNa+rjDrnoeE8rBvuO87GXU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uWxDDO68UQ+Fd7Ndr4dCXdVzu5lPFfbObq3h/s1/1XL5rV8iEc5dHmwGaH/UWImp6
         NrOGFPkGgBEY9Qt9VrlabFxMTsLXSHGBhVw9aYNenwEDOUknV+PTDwmEwvc0ReBI6t
         rOcVZLBTH3A2Nk5Hm/Je92H9G2Ww2scjDWdWWE2VwCXEoNN1X6zfipOXHYEQx4eQSi
         LS5SML2uornNySjErNr6mu0xGKeQv45A97lbvy3nfc1y9ZwUE7pArzA7JjZv4mxhvD
         dBimN5IDOu4a/k+QTA+2eR2MKkwB60TSTie/S81lb0G3oKoyHHDv1G76Ed2kYkCKp3
         kwWjELqeRybfA==
Received: by mail-ej1-f43.google.com with SMTP id w23so25187716ejb.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 01:49:22 -0700 (PDT)
X-Gm-Message-State: AOAM5323aRYshKSj0YULGfhq71/SKlcdjQYBX348xOVebCWTpvV1TLGN
        n0f8DUizQKkZFk51007j44R/76tQf6eE9oqeIqE=
X-Google-Smtp-Source: ABdhPJwp2DQQbwzEAyjC3O9KKED/xishQuYkBwfUiSbwLvp9SA9uxFeiI/SUa58fLcRRdfyYmi2cj7S9pQnxBoN9fHM=
X-Received: by 2002:a17:907:961d:: with SMTP id gb29mr1732730ejc.381.1618562961599;
 Fri, 16 Apr 2021 01:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210413061618.4999-1-zhuguangqing83@gmail.com>
In-Reply-To: <20210413061618.4999-1-zhuguangqing83@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 16 Apr 2021 10:49:09 +0200
X-Gmail-Original-Message-ID: <CAJKOXPf=X+EQJXSFAsuC54Fwvi4TNX9JAoYsEUp7j3BKio4gQQ@mail.gmail.com>
Message-ID: <CAJKOXPf=X+EQJXSFAsuC54Fwvi4TNX9JAoYsEUp7j3BKio4gQQ@mail.gmail.com>
Subject: Re: [PATCH] irq: Fix missing IRQF_ONESHOT as only threaded handler
To:     zhuguangqing83@gmail.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Apr 2021 at 15:42, <zhuguangqing83@gmail.com> wrote:
>
> From: Guangqing Zhu <zhuguangqing83@gmail.com>
>
> Coccinelle noticed:
>   kernel/irq/manage.c:2199:8-28: ERROR: Threaded IRQ with no primary
> handler requested without IRQF_ONESHOT.
>
> Signed-off-by: Guangqing Zhu <zhuguangqing83@gmail.com>
> ---
>  kernel/irq/manage.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 4c14356543d9..222816750048 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -2197,7 +2197,7 @@ int request_any_context_irq(unsigned int irq, irq_handler_t handler,
>
>         if (irq_settings_is_nested_thread(desc)) {
>                 ret = request_threaded_irq(irq, NULL, handler,
> -                                          flags, name, dev_id);
> +                                          flags | IRQF_ONESHOT, name, dev_id);

This is a core IRQ code... and you clearly see here a nested IRQ.
Please, stop sending automated coccinelle patches.

Best regards,
Krzysztof
