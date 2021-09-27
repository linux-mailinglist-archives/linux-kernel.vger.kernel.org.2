Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05F5419E23
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 20:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236067AbhI0S0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 14:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236134AbhI0S0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 14:26:51 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE75C061740
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 11:25:12 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id w19so26751732oik.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 11:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=immT2jAhoOTZjCViu3O8ELrYgFsMLychvMRIWexQ/KU=;
        b=Cp4rnnHiIjrkbUyqIMaTeHHkLfJulxDaOmRpSbYhLZsyhXoTzCiq/ACdnFKIsH2Jvl
         hh78cPAgoTKKxzmfTyKgNZzgcN5fusv/lz3DEoSHEwr6gZA8NYp+zd+1ZXZ7tOindhwX
         1dnWsgZf1AfJuavXaAQR+3o+UpIWOU2zFOE3I32sJLhi+WnJlk6g26QY2g23cA92xY96
         aWvkwdjzeOXKY98nCc7p3y5b9eluMLi38LEWHle1joxQmrNvIU/umoUEz62nw4RuzF0v
         ASC+Vr8GjN7Zsi8k6dV/0dypVkDufzMpCGNz/FZL+6VtwaLbGLNmcF7mPqJGYWYdRjgh
         wUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=immT2jAhoOTZjCViu3O8ELrYgFsMLychvMRIWexQ/KU=;
        b=6KZIWetg6aBcDKbU4dV4dOgnxDPmefzpMDZGvignnbsP5TZbCHKuySZx5Y9vjtgqRU
         hUAnyJka7UsaORXl7Yj+tEP1tfF0nzWTrEMBbpV5YY5H2zTnftrQ3Uhtq+Sg+8k9ig+s
         H5y6LrDMTR+c9rW76zzsuOk2Uy1jj7UXqBobHM+CQHTn9ojnD36+qbW4j66AV6EySo8h
         q7DontnqD+XBhiUgMzvexAfSbhCKqNT+2PAYEO2Ct8ia4jIIqcTqWhEcYhjrKfzGRvmQ
         I9jJvbQD709ho23+wROMrv/pWgNnB/Vlivb4L+7JVn+hQiSvAiG0+YivT7WA9X0DPCAD
         Kv4Q==
X-Gm-Message-State: AOAM531HyzNUvS/PF8TR/rNSfDNgvYElnXbV1L6Iglq9l9h/QgpJ8OQp
        WAVeWxEvTAO1QTKhdabOW6pfncO7ohLV7bAvClEm2A==
X-Google-Smtp-Source: ABdhPJyuP7620rRFr/wyVWuuH8Wu6RLFCNwNZQikRGa4mjLU7uimRN3J8C2XnzgUaVNJKBDLwgkC7890rtq4icsgJII=
X-Received: by 2002:a54:418a:: with SMTP id 10mr385378oiy.13.1632767111388;
 Mon, 27 Sep 2021 11:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210927170225.702078779@linuxfoundation.org> <20210927170227.414776158@linuxfoundation.org>
 <CA+G9fYs2a78_RXaqfE3WMjSOh=HhuS=OjVxh9Hswzrme+pqxqQ@mail.gmail.com>
In-Reply-To: <CA+G9fYs2a78_RXaqfE3WMjSOh=HhuS=OjVxh9Hswzrme+pqxqQ@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 27 Sep 2021 23:55:00 +0530
Message-ID: <CA+G9fYvjwocyLdMt9a-QgPfvvWNcDOwhO-S1+RmPxkPewrykjw@mail.gmail.com>
Subject: Re: [PATCH 5.10 048/103] s390/qeth: fix deadlock during failing recovery
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sept 2021 at 23:15, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> Following commit caused the build failures on s390,

Also noticed on stable-rc 5.10 and 5.14 branches.

> > diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
> > index 7b0155b0e99e..15477bfb5bd8 100644
> > --- a/drivers/s390/net/qeth_core_main.c
> > +++ b/drivers/s390/net/qeth_core_main.c
> > @@ -5406,7 +5406,8 @@ static int qeth_do_reset(void *data)
> >                 dev_info(&card->gdev->dev,
> >                          "Device successfully recovered!\n");
> >         } else {
> > -               ccwgroup_set_offline(card->gdev);
> > +               qeth_set_offline(card, disc, true);
> > +               ccwgroup_set_offline(card->gdev, false);
>
> drivers/s390/net/qeth_core_main.c: In function 'qeth_close_dev_handler':
> drivers/s390/net/qeth_core_main.c:83:9: error: too few arguments to
> function 'ccwgroup_set_offline'
>    83 |         ccwgroup_set_offline(card->gdev);
>       |         ^~~~~~~~~~~~~~~~~~~~
> In file included from drivers/s390/net/qeth_core.h:44,
>                  from drivers/s390/net/qeth_core_main.c:46:
> arch/s390/include/asm/ccwgroup.h:61:5: note: declared here
>    61 | int ccwgroup_set_offline(struct ccwgroup_device *gdev, bool call_gdrv);
>       |     ^~~~~~~~~~~~~~~~~~~~
> make[3]: *** [scripts/Makefile.build:280:
> drivers/s390/net/qeth_core_main.o] Error 1
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
>
> Build url:
> https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc/-/jobs/1626658768#L73
>
>
> --
> Linaro LKFT
> https://lkft.linaro.org
