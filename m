Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83CAE3929B5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 10:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbhE0IpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 04:45:05 -0400
Received: from mail-vs1-f51.google.com ([209.85.217.51]:46830 "EHLO
        mail-vs1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbhE0IpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 04:45:04 -0400
Received: by mail-vs1-f51.google.com with SMTP id q6so2142159vsp.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 01:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YcHAcZ99LPh3KvdHc6+dwPmzciohpUzegXnqArlUae4=;
        b=ahMi40+BE7aAawqPtI559ia3SBdUnS7DaiJEnGWLBUpwysCrflyBNjrY2CmxE9GUcw
         0iTYDK0uO7gevnyiG2bnFI9Eb5OsHU+T51yhxfqkjvQ0Te+5kBEpXxHfnf5UgBeq0+rm
         k4GvEfVZzExgJCRv1byVbMqrlVJCLn0sSCoHJDnE+VGL/i3VE05kRa0c1HcMBETAUDvu
         qdeS67PfXErFLCoVRC64g8pWJLeNFqTaU3tg+9DyHGUoud7E76Ol/HX+F8i2uPgalAfj
         oIEUEJRPcYnCbaM0JnHlPivkr95ydyNHqJZ2UX4z3zRC8BpMiMnpOjbF364IO4NaIPfX
         Z6+Q==
X-Gm-Message-State: AOAM531z2SC8aqksuQdQyV9uA2XoLXogAVkGN+JrPR5La8YDiVB4bSIE
        8UpadXUz4/y3kw6rgJSp882IQMwcrSiAoY1maes=
X-Google-Smtp-Source: ABdhPJwtMi0jMzxDHtCUV2SgEGd7LCRzwNK2Sumq2bMqbtu9N1gVIPP1bmFwaX5W7NkNQu33jCjEp7W89CRMWla1Gbc=
X-Received: by 2002:a67:8713:: with SMTP id j19mr1387811vsd.3.1622105010380;
 Thu, 27 May 2021 01:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210524152128.20519-1-harold@mrtz.fr>
In-Reply-To: <20210524152128.20519-1-harold@mrtz.fr>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 27 May 2021 10:43:18 +0200
Message-ID: <CAMuHMdWQqoqeaym5apdN8ppvkSm3DkKVeDn=S4e5Z2ytCVVUww@mail.gmail.com>
Subject: Re: [PATCH] staging: emxx_udc: fix alignment issues
To:     Harold Mertzweiller <harold@mrtz.fr>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Sean Behan <codebam@riseup.net>,
        Colin Ian King <colin.king@canonical.com>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Harold,

On Mon, May 24, 2021 at 6:46 PM Harold Mertzweiller <harold@mrtz.fr> wrote:
> Three function calls can now be properly formatted inside the 100
> characters limit.
>
> Signed-off-by: Harold Mertzweiller <harold@mrtz.fr>

Thanks for your patch!

>  drivers/staging/emxx_udc/emxx_udc.c | 11 ++++-------

I'm so happy people are improving this driver!
Is it working well on your hardware?
Do you think it's ready to migrate out of staging?

Thanks again!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
