Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664963AB68E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 16:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhFQO4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 10:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbhFQO4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 10:56:41 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F941C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 07:54:32 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id og14so10373954ejc.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 07:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kP9FZJ6E9jOuvBEfkZXpWLxsS4aT6M+o/FNvbytEBx4=;
        b=TAos1Myg6tlEtCXWGma2vcvlxK36hv6B5mhPDSIIXLJYHBezJ9p5/jWLLPjdXyNYV1
         FxomDl3fMGV0SvrzgsumjDVbUm/n8EgyOTJHV6KVK5soWZejWDV/gpXg7RtzmUyH5f7i
         nqIcyVq1AkuAyFzDLbrtLetR1gtiFS/w6kPyk3/YUICArZ6jnEzitOo+uce7OieRAmYu
         eZw1rgReSSuT7johry48W+XUPoF0o8ODuBNmlXNZD8e6z5wt5ZBH+R+jXKC4mgXfKJA8
         dP5pivfJr8M3DePenSPzKXIEjFp22RUrjlGZMMHzmrfMfNqpu0p0h7dTxpinblwIIHRZ
         ve0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kP9FZJ6E9jOuvBEfkZXpWLxsS4aT6M+o/FNvbytEBx4=;
        b=BoaNKvYuRpSqmPc4dK703yG7qYRIYKliL460thHngecEaFyyxzgjcZf4HfUGwCByFN
         ylO0qELdgc6JP3vOKGIZmSwf3ViKIyALlgAQlGHfSJLX+ojtC96nGrZf5WWYLTdcj5ef
         GUfJQswW+tfHGRPHtoegxaa4hUw5rCSOZpFY+Wpae1dFZFbfvfniKLitQ3U7p7NcANQD
         zDuF46YeVTuyb+pwGq7CKcdtjLq7sxTXCnf1InZAeSgFwKPtJ3H2yLpgTThFLjnwuNJ1
         /A3UEEZpWfV0n8r6YOtkoGbQk8T9pSbcvNc/bb8yyyC/jgXXxJm8IuKsl0o3wez1TJL4
         bl8A==
X-Gm-Message-State: AOAM5326Tc/Eg7QhYI7qfl3h23VbXh1cYLvr4KF0TujM+Nh++ZSiBVc9
        QakosVj6LKwv/6rpbMvmKvfsT2UaIBRbJVm+GNroIA==
X-Google-Smtp-Source: ABdhPJxrtEngye1FPnWP5qJqASxWqbVqz1llqVe9GVdKKRDt8N04M+Sb6HXeXjfsZEZA3AoWNAfc503S+WZNzPFUUYE=
X-Received: by 2002:a17:906:5648:: with SMTP id v8mr5645692ejr.421.1623941670599;
 Thu, 17 Jun 2021 07:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <1623924351-22489-1-git-send-email-akhilrajeev@nvidia.com>
In-Reply-To: <1623924351-22489-1-git-send-email-akhilrajeev@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 17 Jun 2021 16:54:18 +0200
Message-ID: <CACRpkdYj9utWedo1-5NiRJRCHqhUmzYXHQzo8rvVq_4PETr0oA@mail.gmail.com>
Subject: Re: [PATCH] gpio: tegra186: Add ACPI support
To:     Akhil R <akhilrajeev@nvidia.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Suresh Mangipudi <smangipudi@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akhil,

thanks for your patch!

On Thu, Jun 17, 2021 at 12:05 PM Akhil R <akhilrajeev@nvidia.com> wrote:

> From: Akhil Rajeev <akhilrajeev@nvidia.com>
>
> Add ACPI module ID to probe the driver from the ACPI based bootloader
> firmware.
>
> Signed-off-by: Akhil Rajeev <akhilrajeev@nvidia.com>

Please include ACPI GPIO maintainer Andy Shevchenko on subsequent
posts, he is looking after ACPI handling in the GPIO subsystem and
always provide excellent reviews. (Added on To:)

It looks OK to my untrained eye, but I don't know ACPI details
and expected behaviours as well as Andy.

Yours,
Linus Walleij
