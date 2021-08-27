Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837E03F95C8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 10:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244562AbhH0IKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 04:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244564AbhH0IKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 04:10:07 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAF6C061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 01:09:18 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 17so5363628pgp.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 01:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KnZ771ayVYug9bm/elMLHVvvuIW6MW3AL+IJic34BwE=;
        b=SudM1diPRRY31Q9YnYRHFhjU3SgL8fYD+iwkN7o3OIV7wt//stVVcnQvZME5kHWYh2
         4/rI3PJfRhPi+X5K8ZTW5iJ9AvJJ9OrSbcs8SmOcQQ6n0qQPvil8So4fOj6wYanwLMhp
         b3MMwAvob9r3HiqJdBBrZkHg2jM8X5QLIF6RtaGb9fbQR/a2AO3t0EkNaam3YrBWNbDz
         FB7DbGO0Vyu0XiqZ8W0nCza0JJixi00AJh7TM9VVTL5se452F2ZU5V7/ibrrEscJErFb
         Lg39mCopIT97Lujp6jGykqqNdXzV7AzAnL9gBkOCHoxHF2SywHvmK6N1MOn3PBVT2kLy
         I8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KnZ771ayVYug9bm/elMLHVvvuIW6MW3AL+IJic34BwE=;
        b=ZS0p5Sj3ySP/w3xLjCmkD/fba0mQOz2RSVa61DiUT/eVDXXKOZf7VMbN5nFt1lhsX0
         poXqZYPh+gZnpZuwahBNx9Mj2G+zXQ66jHp95qif0qgYmJnvF8D/AYE2Oz0zQais+wQp
         ljrXhWj8eugF378tdmDlc4OiRKMOVt5XZP3/ipSJ+L0/dGZLgAiUnNqbmmoxRXgtOqkQ
         b8QPxgPG6RIA2ZYMsLNcyyDUx+ptXdr0dliucapAKgG7Be6d4SkSO8yAtvfnD5Lbh4EA
         14w0LLJ5S82I+5M2j8IPx+RWj3IW68v7LGYB4BrqJKJMmDMqNMzCUFxClxUQSDX8Qzfi
         enYA==
X-Gm-Message-State: AOAM530sekY0SV67jfAfKe1dQyqJiZ45R14P5K6OMIc/ZGjZvRwxV9D2
        C746CQJe6WIfZEj9jh21cLxo3r5oEhEQAG+6nb4=
X-Google-Smtp-Source: ABdhPJyuozem33uKrywaxg5pMh/3wNwFSdzH9Id5YqkBidB1EZrDvDNU1pc2Ckotx4qwYOtkq8XtpRxlckvXA8g52cQ=
X-Received: by 2002:a65:45c3:: with SMTP id m3mr6873837pgr.203.1630051758158;
 Fri, 27 Aug 2021 01:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <c857f334e3c9e651e088b675b3938cb5f798b133.1629906123.git.robin.murphy@arm.com>
In-Reply-To: <c857f334e3c9e651e088b675b3938cb5f798b133.1629906123.git.robin.murphy@arm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 27 Aug 2021 11:08:38 +0300
Message-ID: <CAHp75VejabzoA8xBYFH1X-9vwS4U8SsivnS4be+H7vUTGH8fKQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: dwc: Get IRQ optionally
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 7:04 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> The IRQ is explicitly optional, so use platform_get_irq_optional() and
> avoid platform_get_irq() logging a spurious error when trying to use the
> thing in DMA mode.

...

> -       irq = platform_get_irq(pdev, 0);
> +       irq = platform_get_irq_optional(pdev, 0);

>         if (irq >= 0) {

It has to be changed to if (irq > 0).
But since it's already applied, I think it will be another patch.

>                 ret = devm_request_irq(&pdev->dev, irq, i2s_irq_handler, 0,
>                                 pdev->name, dev);

-- 
With Best Regards,
Andy Shevchenko
