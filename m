Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4742D30A51A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbhBAKLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbhBAKJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:09:44 -0500
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82531C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 02:09:00 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id d6so3788072vkb.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 02:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5RCKOWm6pdB8AyLaZ0Rrsns+97YnjtL19FObq56DbaM=;
        b=hPfR1AoYfcZiquipnmCfwNJAFvIf1NCLc3oWmyR4JBbMm9cfaaqKofbLeW24XvyrFN
         08iYvetlEL5zdwk1RVPPgm91a++QLVKTSk/uld/01q5XYQBO/5j7ZmquzfM3Uy2b5SJn
         t6zXEHIDtdMYUEyE1uQ2Lf9Xi3B9m2jcLEVlnyEshKdPSB9rZmBoEfaHO2NG58NcbMB9
         6OqWPPxbaQbjJUF9612tp74+bc8cACHCZlpNgK8Xr9eEJ1ollkRLKES0KjN/KkdyFud+
         Qc7aBBIpo1RE8y0nwVgLEJ1InHBsMjMDoUlUmotjAXIqRR7KOsxxpxoOEAYubxFW0mfD
         rT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5RCKOWm6pdB8AyLaZ0Rrsns+97YnjtL19FObq56DbaM=;
        b=BdrkmBqFN9d8EB/JO8pBskcmqXaqmnST0o+tyC7LYKQ72E6bzYX5j9WQJqg1JZwy99
         2pvXWLugjMAk+yn7k3lFFu+6iB7zzVxK3rPpw8v0VHl9EXt4IIyNBE6ZBUSiCChiFQt2
         fBz0yKsMroUohGjLlLGq4g1l5xB26dcFGagGBseTU5ZwE9U6lLQt095bb3bUy+5iiDph
         dGQNwA9NPf1sG/YqC4mhQ3lDnXZ9whMXouP0hx1yPtUH2Nplr5E+hKbMLMF1QTnFkXDb
         GWopH3SQWJPkiV1dfFQb9Cbrx+RVxmXzKQV13GAje0fZrKzlRfcCfky1ir+6OM2DQj5n
         skFg==
X-Gm-Message-State: AOAM532+vc7AOn0hPHSBOuDe0vYQLaChC76hcQ+WWFY5UyrRzP0K2uq1
        Yphw9a4YAm33Q8SdrmW82FVlbBUV22/yhS1fCQ9WoQ==
X-Google-Smtp-Source: ABdhPJxYwhN75hYopsWmLZymShiPcRCVhsChLIuB0H9arKcqRntfRfpFWLrXLTfGCy8ufTg4kWsEh0Tpno9oy18wvMY=
X-Received: by 2002:a1f:9d87:: with SMTP id g129mr8389213vke.7.1612174139684;
 Mon, 01 Feb 2021 02:08:59 -0800 (PST)
MIME-Version: 1.0
References: <1611736925-32547-1-git-send-email-abaci-bugfix@linux.alibaba.com>
In-Reply-To: <1611736925-32547-1-git-send-email-abaci-bugfix@linux.alibaba.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 1 Feb 2021 11:08:22 +0100
Message-ID: <CAPDyKFrtwFwPjLz7OYOtF4S7WORoyGFgpv9n6xABn-vp3w59dQ@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: Simplify the calculation of variables
To:     Abaci Team <abaci-bugfix@linux.alibaba.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jan 2021 at 09:42, Abaci Team <abaci-bugfix@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warnings:
>
> ./drivers/base/power/domain.c:938:31-33: WARNING !A || A && B is
> equivalent to !A || B.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Suggested-by: Jiapeng Zhong <oswb@linux.alibaba.com>
> Signed-off-by: Abaci Team <abaci-bugfix@linux.alibaba.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 9a14eed..e689710 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -934,8 +934,7 @@ static int genpd_runtime_resume(struct device *dev)
>  err_stop:
>         genpd_stop_dev(genpd, dev);
>  err_poweroff:
> -       if (!pm_runtime_is_irq_safe(dev) ||
> -               (pm_runtime_is_irq_safe(dev) && genpd_is_irq_safe(genpd))) {
> +       if (!pm_runtime_is_irq_safe(dev) || genpd_is_irq_safe(genpd)) {
>                 genpd_lock(genpd);
>                 genpd_power_off(genpd, true, 0);
>                 genpd_unlock(genpd);
> --
> 1.8.3.1
>
