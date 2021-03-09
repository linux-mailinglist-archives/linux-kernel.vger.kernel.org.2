Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51053332C2E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 17:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhCIQek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 11:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbhCIQeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 11:34:16 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A78C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 08:34:15 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id c19so13148193ljn.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 08:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EInm0LEnIi7XLKD6zyKq8F4CqLBLvPBrEiCalMxA2ew=;
        b=QFCUfjyZ4xnhe0B+dyRwT4L7N42IypkyBWHBEcDUQLyrvB1LT+5M1yqzKzbOba5dQ4
         RsmcLSF8OBfOJotv21zMWOFayWlqRkAvd6OaQaKUZrSFzfCx7VThVzmcMyprHOix0c3z
         Ft6zo0djGIu9DR/IZJNnJmPEuDUibch6vSohkq3tH5bnOIB8nilOj0y2BdkeVxZzxR51
         hxQ8qQ2Ukx+t1Tf0q5JBwOD9wdfugEvno+I4uDWrEgwP49b0GCsQ8A6EGAIQj1i9VwTz
         zPigDd3wds5T7tibLYVgBzIBpTJiUNO0ZTOnaR41f+d1Cg1uwExHIPs7xtsCnjCZS7eU
         K5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EInm0LEnIi7XLKD6zyKq8F4CqLBLvPBrEiCalMxA2ew=;
        b=Qmi4b3tLzJLQ4U/RxbHbZTtG7VwYOBpIXVB2SJjbYSfchEGhZkO7K+OVrHKS69hJBe
         Udca+raC936mmZvPRkp7MTXwvvVGJXoqG9Ul0pfyvSfY8kh1J6yIdLejnVxQVg8/IA/L
         COAZHZkSGsWUCHY8Bs+yjcpnW2Nm6VR0zUv/IyobPDrXaPcIgzzeRLEsNqjtBb5MNntW
         s0ufTJ8EmUGNkt79ajvyBnq0cbWahwQQw9jiZqCiFPf7/3217QPHCGsnKmxRWr0lDi1r
         nQhNILn6Uiu/+CbJGsZGl7/csBqgSsStcpObGakfKyP5s3TVsoHt7FfIfnh/gThSK0fQ
         BySw==
X-Gm-Message-State: AOAM5335uBVKMg6X2dYvbotwyzbmhAMGJCSl6eteGc+wD4Iebe6RqODj
        4wwINeOrsub9Tjhnc4jJv3ZcOAhRgtxizYlVrHWF9w==
X-Google-Smtp-Source: ABdhPJwNXAb9NrkkJhTzXglp6OzgZuNzRajKOhmHnYIlN9N9Kod+C9/W2ePM1dzVD0/tuS4O8FWQKlypJ/aXUx+mFvQ=
X-Received: by 2002:a2e:864a:: with SMTP id i10mr16949254ljj.467.1615307653884;
 Tue, 09 Mar 2021 08:34:13 -0800 (PST)
MIME-Version: 1.0
References: <20210308194535.66394-1-andriy.shevchenko@linux.intel.com> <20210308194535.66394-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210308194535.66394-2-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Mar 2021 17:34:02 +0100
Message-ID: <CACRpkdZO7TPcz6p8Gfavqd1SboCt7ZXwFa4+4TuWNTZuoXZqgg@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] irqdomain: Introduce irq_domain_create_simple() API
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 8, 2021 at 8:45 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Linus Walleij pointed out that ird_domain_add_simple() gained
> additional functionality and can't be anymore replaced with
> a simple conditional. In preparation to upgrade GPIO library
> to use fwnode, introduce irq_domain_create_simple() API which is
> functional equivalent to the existing irq_domain_add_simple(),
> but takes a pointer to the struct fwnode_handle as a parameter.
>
> While at it, amend documentation to mention irq_domain_create_*()
> functions where it makes sense.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Marc Zyngier <maz@kernel.org>

Excellent work Andy!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I suggest Bartosz just apply this with the rest to the GPIO tree.

Yours,
Linus Walleij
