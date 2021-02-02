Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B79A30CBEA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 20:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239945AbhBBTjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 14:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239907AbhBBThT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 14:37:19 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE8CC061786
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 11:36:38 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id t8so25314352ljk.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 11:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R4c/MM2OeFxJQCR1Po/yb9CvVRI26WIGkF2c978zb24=;
        b=pAiCeAfTIOpU0VtEgN2YFrXkOkFP9QnwxlCDVYDCxLN+UwFlq14HnXaBt+eaJTenk9
         iCtULZalTFxA2CC0fL0ZsiavI3kKWb+ytS0Gei3NJZLvwNnG4C0IWEcu8bFyegBm7rhk
         OX/O/ZrKnbJ7PsmmwNIq8kuK34ds8jO8jgCN8Vph4pQdgP1FkoHgQV170oPvNm7A02Cz
         AujZsYeZ6WgS6V84BPbHYVbbMLOYOWl/SaB33eoJ+nkRP8Z0jjzCAMChsNR5QgLuTv/1
         ycNMlVdYLVMFL6cyf/Jeu2Y115NBZcm9OVuXiyC/p3C29M4xNg8IVwVfNtjiy3hwRw6n
         /YwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R4c/MM2OeFxJQCR1Po/yb9CvVRI26WIGkF2c978zb24=;
        b=F9UaaiWXCao8deVJdbSByOY1mPXxAGTGPHfC25DIn7DlKztkBKhrzMxZpt9MQIuYJa
         sz+N0S8Z4uAnBfLp9FSqk1lNIu1oO6ORYRB3rRewp70UrfSAxhW7lUKVgXnWjx5LpGzD
         XB9l33PRamLfE/Ecc/aFYOBHIr3ZhYdMQ30GwbiLQ+GSuT538IEjsY1vILg588cW33lr
         XUp9uiJWV4qGBORf7zhIAzhPKnRSgwNTnogS3IeQpMwz44VT9Ixypyt1rM0shcE1dTr/
         BkjbELNTl2cyR6Z0IIOhkkfGTbM/5zayhk2lgJtrPgeQe1vxeCXEMP0bdMQ7w/65x7Zv
         oRhw==
X-Gm-Message-State: AOAM5305tzvYHhYKLxG8jEQDetucgfVUMGZFOuF3kIF+phhDAtvXGZGD
        Yh8HTfxYeWjw3srDY0UVq+4mzScwS+/Zxki3LYTQ3w==
X-Google-Smtp-Source: ABdhPJzhTzTJ1uQCVb9kr69LR9RlGJOUL9l0IrxMLMaflVEsFSxIUD+PVs0yz3q00wphUieXc9ty22nBzf6H+YmzLp0=
X-Received: by 2002:a2e:894d:: with SMTP id b13mr13907025ljk.438.1612294597310;
 Tue, 02 Feb 2021 11:36:37 -0800 (PST)
MIME-Version: 1.0
References: <1611930410-25747-1-git-send-email-srinivas.neeli@xilinx.com> <1611930410-25747-4-git-send-email-srinivas.neeli@xilinx.com>
In-Reply-To: <1611930410-25747-4-git-send-email-srinivas.neeli@xilinx.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Feb 2021 20:36:26 +0100
Message-ID: <CACRpkdYXddxbV-WGZaNSO=oMsDPZiawWb1fOU0D1YjnRP1Tgfw@mail.gmail.com>
Subject: Re: [PATCH V5 3/5] gpio: gpio-xilinx: Add interrupt support
To:     Srinivas Neeli <srinivas.neeli@xilinx.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Srinivas Goud <sgoud@xilinx.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>, Robert Hancock <hancock@sedsystems.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 3:27 PM Srinivas Neeli
<srinivas.neeli@xilinx.com> wrote:

> Adds interrupt support to the Xilinx GPIO driver so that rising and
> falling edge line events can be supported. Since interrupt support is
> an optional feature in the Xilinx IP, the driver continues to support
> devices which have no interrupt provided.
> Depends on OF_GPIO framework for of_xlate function to translate
> gpiospec to the GPIO number and flags.
>
> Signed-off-by: Robert Hancock <hancock@sedsystems.ca>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
> ---
> Changes in V5:

This v5 version looks very nice to me!

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
