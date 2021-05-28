Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6284B393EB3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 10:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbhE1IZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 04:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235958AbhE1IZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 04:25:46 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7CFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 01:24:11 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id o8so4267820ljp.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 01:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r0sxrV3i0KPoPCBtAeF9wpjfeXf/1JMQgY054n8rtMA=;
        b=xw4bNl917hEV10RuSfp0fXTPhGRHUyeEtmvCn6xEDq1V8t+O/ks+Nid/2WSjBLV7VC
         Z9C/ioPjli0bkRURHkrM6y6eO49pLtzgX4TCZPWpsABqSiQgvdMMRSYJ9ffaPEr4Q1Ra
         ZjQO4QfzgQKFZRfu/ETQ4TSKzkirYKFvdYKAXmSHe+R/yeF6+gHvCWBfyMkRNYIbXqMc
         MzZkg3rtL2BbeXQuC3JVBYpY+BiTp/zZ0B5KqV+LGAiWkqtLtuaLkQKeIBviCltQmnKt
         TY12G1f5fd+Af+cOqPCpb7ZQaWd9LbKgf2LtRUwWDbTDnWP5wG4Lr80w0t08Ywx+4+jm
         lSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r0sxrV3i0KPoPCBtAeF9wpjfeXf/1JMQgY054n8rtMA=;
        b=jzZgsQzm1FMpkFwpShKLt22OfP+gKQYQ8VB8AJBW/6+ck/r7K41u+hJISIyCXw2d3Y
         /PYuKO+NjgQ7H9j44NYakzYd8gm3AFov57Q/D+FaKSssztTVdgPhTv8D/cL3YWWKiGzH
         kI3Acg+05P90hlMaGkmvcDZnQj4Xrs2xsp7QOyBbVZQ4hwo8XY4Jaz5Pksj4lBBbIbSn
         rJHGJZFUu9TEBACev6zelJLhjVlbp7i2f/6XWIrb01PkYAPnznXHQChX8gr6O2vf6qT2
         bxmKgXYXt0av1pReq6bsjsB0eVLC2Hnim2GA4X8NiLc6HP8/L9V17Ja181CrfT01XAR1
         wDwQ==
X-Gm-Message-State: AOAM530uvIy0gB+6k5bwfPQuuUCT8VZzRySpzfax+LbtRBNYKyZCbPq7
        Qp7mKq/FvgM/3NzhlzJ+UHACQyBuAvSeqPmrcd2vY5F908I=
X-Google-Smtp-Source: ABdhPJyM1XvyOsxWGFG4wNTD/2cZcXzm5CymVosSszClAb7zPBtL7mYK6fbjUSEt6CtfCATvHzhHXUkxamEdLnarOsI=
X-Received: by 2002:a2e:1319:: with SMTP id 25mr5619292ljt.200.1622190249395;
 Fri, 28 May 2021 01:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210528035209.2157823-1-masahiroy@kernel.org>
In-Reply-To: <20210528035209.2157823-1-masahiroy@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 May 2021 10:23:58 +0200
Message-ID: <CACRpkdb-CsQtaiRjUWsimSmBw8tAgvr_ET1BS47rsVxd-eY0VA@mail.gmail.com>
Subject: Re: [PATCH] ARM: simplify the build rule of mach-types.h
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     patches@arm.linux.org.uk,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 5:52 AM Masahiro Yamada <masahiroy@kernel.org> wrote:

> The directory of mach-types.h is created a couple of lines above:
>
>   _dummy := $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)') \
>
> The 'mkdir -p' command is redundant.
>
> scripts/Kbuild.include defines real-prereqs as a shorthand for
> $(filter-out $(PHONY),$^). Let's use it to simplify the code.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Can you put this into Russell's patch tracker or shall I sign
it off and put it there?

Yours,
Linus Walleij
