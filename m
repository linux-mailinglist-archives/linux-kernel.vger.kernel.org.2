Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D635D42A009
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 10:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbhJLIjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 04:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbhJLIjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 04:39:31 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACCDC061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 01:37:29 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e3so30825912wrc.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 01:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=7WS0zaSpBK+NAgBTl6GsTa3aEhBZPxW84OT5ghLecVk=;
        b=KhrelfLFqPd1KL4W5RXkSrzgWbduYTqVapMT1C8lcC/g1GbbJ4tdgCmM2Sd1TuS50W
         3FadY6wofmG9p3GEpYZe8R0mP3pGrQjvHmy5kdKIWmYzET/27RkAGI6qISqE699ZYwt4
         KCldIC0DGv6wifdipqjBQfCZo14QDWbnq5G7cgtCkQg9yV3toPdbmGcAvSOqpbhSNhJD
         czqwDUbTNahM0iN1atotjPQwJYH/+tykcGVMBrH34+ZBh6+BLnKA/9W7AI1jtmkYflk/
         XyPEg3ld0y46UfaWck1s3OZH5UJ1F2+kN0YrvTsjIk28lsDvB44HraXOKXRPOG/1brOr
         O9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=7WS0zaSpBK+NAgBTl6GsTa3aEhBZPxW84OT5ghLecVk=;
        b=z8SXFqRHbZfYH8vbVi3dQuMh12NclLdZUwsJdZH+xyyoPPRvpG6Q8864L4Ed0OvE2s
         dKWa2oPeEnlBdULbWxy3Aj2qNVmHuJEFM+VZblqwf5cvxNq/nRt/BfPVNs88iVKQfTYv
         b/hmXawFQpgwKKz8bu3/9JiIbOeLBkBVmEEr5Wrl9SXZXHhD8S8JEY6CUgjVJR0gVnnX
         ZG3fZ+KCsdY84msleYht999zNDKq1eVeWlL6muKnITqRJh1zblgALUmumvysXOkP1TR4
         R6OwBrtZYW3P/gU2/Ovnhf6kxZKWk2kpXir/oERamVqCDklVDyOVad2XzJIgp5P66avz
         LGCg==
X-Gm-Message-State: AOAM532xHcf6VfCAtbwz2Yk0B/ZEtF45yRZ9eSkRzc2FHYED0uSDxQNx
        daJRDTfm5UYdtBwsYEqXwjE=
X-Google-Smtp-Source: ABdhPJwUsBlGJYmQxEm7N/18obU3VCdydiOD8zvRo8Ke2B32tF6VAhY0aWBSqGCNE2HH9lpJWbS/tw==
X-Received: by 2002:a1c:4b16:: with SMTP id y22mr4035180wma.73.1634027848224;
        Tue, 12 Oct 2021 01:37:28 -0700 (PDT)
Received: from [192.168.1.21] ([195.245.16.219])
        by smtp.gmail.com with ESMTPSA id l18sm1855733wmh.39.2021.10.12.01.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 01:37:27 -0700 (PDT)
Message-ID: <e50f2da7af1fa6f02fd413081fa5762837b86895.camel@gmail.com>
Subject: Re: [PATCH v2 8/8] ep93xx: clock: convert in-place to COMMON_CLK
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Mike Rapoport <rppt@kernel.org>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Oct 2021 10:37:26 +0200
In-Reply-To: <CAK8P3a0Y4uwX4B10d5CR3WjZ1qXAqhKJGJ0EhUEF60uB1q3H9A@mail.gmail.com>
References: <20210726115058.23729-1-nikita.shubin@maquefel.me>
         <20210726140001.24820-1-nikita.shubin@maquefel.me>
         <20210726140001.24820-9-nikita.shubin@maquefel.me>
         <ed557882a9530f2fd6245e34657be62399df76bc.camel@gmail.com>
         <CAK8P3a0Y4uwX4B10d5CR3WjZ1qXAqhKJGJ0EhUEF60uB1q3H9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Arnd,

thanks for the quick reply!

On Tue, 2021-10-12 at 10:29 +0200, Arnd Bergmann wrote:
> > > Converted in-place without moving file to drivers/clk.
> > > 
> > > tested on ts7250 (EP9302).
> > > 
> > > Only setting rate and change parent tested for, as they
> > > are missing on ts7250:
> > > - video
> > > - I2S
> > > - ADC/KEYPAD
> > > - PWM
> > > 
> > > Only video and I2S clock are interesting, as they are
> > > GATE + double DIV + MUX, all other are pretty much
> > > common but require ep93xx_syscon_swlocked_write to set
> > > registers.
> > > 
> > > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> > 
> > with an
> > Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> > and
> > Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> > 
> > shall I add this patch to the Russels patch system, or would
> > Arnd take it to the SoC tree?
> 
> The SoC tree is the right place here.
> 
> Please resend the patches you want me to apply to soc@kernel.org
> so they make it into patchwork and I can get them from there.
> 
> > There is already a merge commit 726e6f31b102 upstream which
> > claims to merge it, but it's actually not in.
> 
> It looks like this is just the drivers/spi/ bit of the series. Are
> there any other driver changes that are needed along with
> the arch/arm/ patches, or is it just the actual clock support now?

There is "ASoC: cirrus: i2s: Prepare clock before using it" still
unmerged as well with an ACK from Mark Brown, I did remind him
about it again this morning, but I can resend it to you if you wish.

-- 
Alexander Sverdlin.


