Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F253C43D2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 08:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbhGLGJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 02:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhGLGJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 02:09:03 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5FAC0613DD
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 23:06:15 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id g22so21219972iom.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 23:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QQbTdwpHiSKGRKYlqDaIH++wFzRy31sqh5rrqS0iJ60=;
        b=t0Y/ybxJlERi6+gcvIqxVoSHTxGvCReSlnUccJ0b1pilessjk+biRgnQ360cyUs5gF
         DVmXtwAxqwsWyEfnN/s9dN/8smb09/5fMY5dXaJYUSvYX0q8kAZtiSD2XXmy5PC8BXIG
         L+f1CAFBBKhgbXBIJhWwGV4rK9oIRHCprc+giXaWBITPhymUkEPPaTtjW9m4ICbDXRcT
         5cZ6hOz0l3DqGbNT0Om0M9SQVz+hAaMDp9lzyXaN19+Fy8sTIHN3klJ8Urf+Ss35Q+Um
         hI1P+L5PNxTSCzSIatiGeR8jrcg7SLbNGsdVkp3Z6vN89yM9w60EI7VCKhqwk7D9520R
         WVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QQbTdwpHiSKGRKYlqDaIH++wFzRy31sqh5rrqS0iJ60=;
        b=uKG3cxxflV7EzCf7T/hLibh5BRvNdnBVU01f45vjezEUyZSPfrF7VyhCH9/PxKhwG+
         0hFJormZuDUPIlkD1zAUqsmyzT1idLKFlSyaJmioOWhTSj2nToGmQzcCOvf0enYFQfuz
         0HuYu6bm6GuqamWYKvUzVZuQfcZ7ESclPc6E+vHAGD/jzJ9LFMEKlRKbab7IOvVFaCus
         pVp41dEDa/Lh3EFO3Y6bh8EfI3bePG5dG6Noq+uJkBV/9VeuiiXvC1N/9sXSR8XDL11d
         HvdlhZyFk8OP7PEFBmdJn3Zfv4S2WrKnJXl/ly6EHcvJ7pVFt6bxIqU3TSZopD4BhTVB
         hrDw==
X-Gm-Message-State: AOAM532SaDsOz39AnW4vgOggYkD80FJDC3aAY3l+pIGgcZrx/risg88f
        0nprqc+Lu/VOrdiJnlGJSt57/KklsPgOhphAQO56Vg==
X-Google-Smtp-Source: ABdhPJy7eNcQX+XxQ8vkxSM7FMxxg2yrDt9MGG1GMQdcRqA3qp7XJidTxHybq7Q7j5orvAzZQJxZZLV5b5QuCu0V/M4=
X-Received: by 2002:a5d:87d0:: with SMTP id q16mr38727515ios.109.1626069973247;
 Sun, 11 Jul 2021 23:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210710122446.5439-1-tinghan.shen@mediatek.com> <20210710122446.5439-2-tinghan.shen@mediatek.com>
In-Reply-To: <20210710122446.5439-2-tinghan.shen@mediatek.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Mon, 12 Jul 2021 14:06:02 +0800
Message-ID: <CA+Px+wXJo1R5WU-Acn==DEqubzzZDfxnJpCeFvKoYzzrzr-H1A@mail.gmail.com>
Subject: Re: [v2 2/2] remoteproc: mediatek: Support mt8195 scp
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2021 at 8:25 PM Tinghan Shen <tinghan.shen@mediatek.com> wrote:
> @@ -785,11 +785,13 @@ static int scp_probe(struct platform_device *pdev)
>         if (ret)
>                 goto destroy_mutex;
>
> -       scp->clk = devm_clk_get(dev, "main");
> -       if (IS_ERR(scp->clk)) {
> -               dev_err(dev, "Failed to get clock\n");
> -               ret = PTR_ERR(scp->clk);
> -               goto release_dev_mem;
> +       if (of_get_property(np, "clocks", NULL)) {
> +               scp->clk = devm_clk_get(dev, "main");
> +               if (IS_ERR(scp->clk)) {
> +                       dev_err(dev, "Failed to get clock\n");
> +                       ret = PTR_ERR(scp->clk);
> +                       goto release_dev_mem;
> +               }
Use devm_clk_get_optional().
