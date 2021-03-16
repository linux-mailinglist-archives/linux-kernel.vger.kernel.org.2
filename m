Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A2E33E197
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 23:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhCPWnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 18:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbhCPWnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 18:43:00 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF652C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 15:42:59 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id f20so38943357ioo.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 15:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nuo8qs2E9bNWxjIOzW3JTgzm3d5Dfp8vsCU/3Qa6t88=;
        b=O+WCe1p3rgOaS++9BFjpMM82u4k7HgZ+tUtI8/i7C8wSfTxjTLsES0Kwkc6Pyjmpn3
         V+XwqZKcNmpEQ7jeuhuhQMg7zAY31el+OvxW+w6pF68n8+cR4tjnLxB3AwSJl4JMv9nV
         RKhkbQBQIW/YcSLxl8rUxG/IkkTQ803Ah4muvFR8flWOBL0OASSryQS5R0SjwEBJsOvM
         A2KaWKRKkxK+QLFuXgHs1MlmwoIk/esovp+dj3tcP+7m1uMzBvwWExTnRAz7NwOrM6bX
         2+bTjqSTIk3HTqbjYp4UruBs0BAr4d0nHSdq4GgyVKXWxCHwjJO1251FKLd61uEIty9q
         UmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nuo8qs2E9bNWxjIOzW3JTgzm3d5Dfp8vsCU/3Qa6t88=;
        b=SMGjspe6mbYQjdymtWIYg6hw2RQk9wbtcsXepcRJFUw2RyVQTwTCRpq0ipFlhjOlJA
         9tviAZX0Tg8aYabmg65RGYGAL6ZT+9dOe+64izsuhSw3nHxnTPNSev0xPi5PdlUxrNJ9
         SvJpdFkPkYEii5RbK8oQ0kuH4kpLVaN/8QesW9/PPXz94ZaZq66hrXS94ESdiTeIB7pI
         xBQghceziieo5/4u9fXF4qpfPrUDUnu2hwJf/o+S1XcJfPLSr3Ifnvar4F+NUf3hSFE6
         aswnWXO9mgtxjS3hfmxS8NwRQ/KAbRmwurfA04m/PCjQ73XAPPkG763jA49KEOXoFunJ
         ckpQ==
X-Gm-Message-State: AOAM530AzgHAbtSTubx3V0/BnP1Wbr6+5EXTfe+YTR1ozxplThMLVa8Z
        vHoUuA42IcVXjxJjGyfUIHFIUl97X7tOMOp247o8v5e11tc=
X-Google-Smtp-Source: ABdhPJx3/3mIcSknxKnXWI34tD0kNGwm2EmFMjsjAb/RBupR9xopS7fIkQrzcy1z1BPPkjm5n84JKv4+1daF4b+snkQ=
X-Received: by 2002:a02:ba13:: with SMTP id z19mr669975jan.131.1615934579422;
 Tue, 16 Mar 2021 15:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210314035757.2740146-1-ztong0001@gmail.com> <5d7a5e1c-35ab-58cb-ebcd-da5b280c802e@mev.co.uk>
 <858341a6-c105-1440-aa4d-ea0217f2ec89@mev.co.uk> <CAA5qM4AJRYndkXSiW5Y4OCFcH97mf6UiiEEox+TQs8-N957mJA@mail.gmail.com>
 <92b7c57b-b645-9965-8157-4ca76a803cba@mev.co.uk>
In-Reply-To: <92b7c57b-b645-9965-8157-4ca76a803cba@mev.co.uk>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Tue, 16 Mar 2021 18:42:48 -0400
Message-ID: <CAA5qM4BKu-KAc8=S14us5HvgYqB6G6DKzF11ESho8zzMe73VCw@mail.gmail.com>
Subject: Re: [PATCH] staging: comedi: replace slash in name
To:     Ian Abbott <abbotti@mev.co.uk>
Cc:     H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        devel@driverdev.osuosl.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 6:37 AM Ian Abbott <abbotti@mev.co.uk> wrote:
>
> Thanks.  I think the only other Comedi driver with the same problem is
> "drivers/staging/comedi/drivers/das800.c".  It passes dev->board_name as
> the name argument of request_irq(), but that is "cio-das802/16" for one
> of the boards supported by the driver.
>

Thanks Ian, I think you are right, das800.c also shares the same issue.
I have sent a patch for das800.c as well according to your comments.
Best,
- Tong
