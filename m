Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE693E8665
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 01:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235419AbhHJXWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 19:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbhHJXWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 19:22:05 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF61CC061765
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 16:21:42 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x14so576226edr.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 16:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pLuq5hIP1TC6eCB3bmdE0iWbfeNXvkHejJhYd7AnBm8=;
        b=VN343goDZO0MW5Oyd9qkCinN1a+84Iaq+REbd4dLsZogvnLVV6ELCzY9GZbGZ8yFBy
         yV6apnmcLkx6xtD9b9Lk8q+4up4EHdssaOgn2H2YuKcMa/Q5U5dsL3e9gdBHNEIeYvwB
         pjF4JcwdGBAyizx1ZT6mxxHbk/PYmTOWP8wJZQBjyjnmbXDW0zsw88+nWxC/XID/X6oS
         wr+e9UkJP9jJaqkwCiOdgFLo9SqEKND//fmMt+QjuTYXhsDrInRyn0C+682kFu2ZN8o3
         3XgmFFEq78eCNrVAA7AwZoM+QfzwGLGTn0QCl9p9LCLMjoX8nJ+L6LPDBdu2WeU+Jgqg
         JGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pLuq5hIP1TC6eCB3bmdE0iWbfeNXvkHejJhYd7AnBm8=;
        b=KcT5pm69EmMvk9IY5u/h7o+ENri8Hot87sIqrjGe5bg8ygd7yXfqFs1LPoBMB3+ZoU
         WAxZ6C0Uzdw3MTCTuoyPCcm4pib7NltjYP8h1DlxMzGbcTQ6PNmK08+Gh8G+UM7vUxpw
         kVmKlZR1DnnUgg5BTchX7txeRvK8qvHvzHlBTlDai9UNsPcgKn3FCpvEDS4heRX5FoKk
         3W0smMROBcUBYWe4+O6OVYs9ADX6PdbKDfv0a4ijTH2gRsll6qU1YJ24WS/7YxwAipua
         hB4QTHOoI+XWBBe3Y02PVmQrX6KPbMmxmYxh9pU9KZz9B+SmQGbb2WV2LTvs+9YHLGrK
         0OkA==
X-Gm-Message-State: AOAM532Zp5HBkJvSVgbCyCays+hRKbTcV8x1E9H7v8XTtz5RCGOFR5DK
        1jByp0wtB6QtzOhuLTD518AkDWk7hWGvFckToF8gWRj782I=
X-Google-Smtp-Source: ABdhPJwaVQvYPtD2Tq08mSbIi7a/VmYh0uZ28VlOB80DvSptQcm6YfhNpB6TEUb/rX4ZlPTpxoR0AiDC+G6aEXWmmNo=
X-Received: by 2002:a05:6402:10d9:: with SMTP id p25mr7625998edu.51.1628637701475;
 Tue, 10 Aug 2021 16:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <1627640999-17706-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1627640999-17706-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Tue, 10 Aug 2021 16:21:29 -0700
Message-ID: <CAMo8BfL6D3MU-_RO-FQoywPJfdZPaa2=TRZw4ZgxwPfjRXbG=g@mail.gmail.com>
Subject: Re: [PATCH] xtensa: ISS: Fix warning comparing pointer to 0
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiapeng,

On Fri, Jul 30, 2021 at 3:30 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warning:
>
> ./arch/xtensa/platforms/iss/console.c:204:10-11: WARNING comparing
> pointer to 0.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  arch/xtensa/platforms/iss/console.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/xtensa/platforms/iss/console.c b/arch/xtensa/platforms/iss/console.c
> index 81f9889..92d4624 100644
> --- a/arch/xtensa/platforms/iss/console.c
> +++ b/arch/xtensa/platforms/iss/console.c
> @@ -201,7 +201,7 @@ static void iss_console_write(struct console *co, const char *s, unsigned count)
>  {
>         int len = strlen(s);

Here's a bigger issue in this function: s is used in strlen before it
is checked for NULL.
I've posted another patch that fixes it.

> -       if (s != 0 && *s != 0)
> +       if (s && *s != 0)
>                 simc_write(1, s, count < len ? count : len);
>  }
>
> --
> 1.8.3.1
>

-- 
Thanks.
-- Max
