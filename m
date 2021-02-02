Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED23C30CB95
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 20:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239803AbhBBT3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 14:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbhBBTZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 14:25:24 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4581AC061786
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 11:24:44 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id a25so25334679ljn.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 11:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p9owLXMczWEb4Ztg0zvw8dotQtfhOiQnS8DYe98Uq1Q=;
        b=C1d/u70iNVqF0YU3/uMpTxQ0i1/b49rZKO9wZhcDe9fq/gMk1BRfTBbDSx7VzP1DlN
         +q2AIdzhBfJ4dzhyz+FQB5W08mXgvo3JpNybGr36rDPgCfkPhKUZLK0hJ4MQCsA6sX7W
         XNPheltPipapQI6sztWLU5CYXj+imwMPzmn7bcjBkrNnqhGr9wyTk4cNmvJqWzGlyKMI
         RDLHwSicaXXtVz+Wj7JE34/UjHEtq73pudJueXEPVgtuzOd55DtZJNfd9JrcbYmY17YT
         izu1uLg+L8YZF8GyWk9H2W3UVJjbKLyUS73Uc5HDOE0v4BdL/Ufmy5k//VUsn0ZDKPnL
         31dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p9owLXMczWEb4Ztg0zvw8dotQtfhOiQnS8DYe98Uq1Q=;
        b=eRoFIg8v4VbMGAcTlJ1uNGlB7FYNUfF0ghXlSDre03CBXbvlPS7+7S7gHBLhyCXHES
         p2qprFEyrs13C01TbEcwqO7Ue67CHvSMjjjDKurOx0Akv2sNBPWuOoIXxjWUXZ6xi20V
         f7X9RSokrEXhiM/Uc79qNM+N1yizeqt0A/cXzR33viAIIxA+dtXyaafIKar6UvImx9tX
         UrU/YWJ37wLZ01XU6KEs1Es8lPEsiPoICGX0lK1I5/qlmQxyAJFMvh+u9kpNUO/Hq1lf
         6ML58sti7TCK1jYgRGJaee+P+ufOZxEJy9c0Vsl8/3rW7wLtD0pWz+L9XTJfZsjRIN3z
         b1tA==
X-Gm-Message-State: AOAM5311jP04vMPwPJ9wiM02dQVZLO1lAa6icvvlGZPzmTQPAsuJXseF
        riZhnYcYJNSGA4sIQyKtcy/khLUsS7U7NSlpmm90mw==
X-Google-Smtp-Source: ABdhPJw19V4spv4EJbAssYDHp9VPhqKgCm9OtOemkVez3j2HW/g7+RN/7eYzkiLVuxBKet770V59kl8cU/7dEYxYL6U=
X-Received: by 2002:a2e:8ec3:: with SMTP id e3mr13398675ljl.467.1612293882781;
 Tue, 02 Feb 2021 11:24:42 -0800 (PST)
MIME-Version: 1.0
References: <20210128122123.25341-1-nikita.shubin@maquefel.me>
In-Reply-To: <20210128122123.25341-1-nikita.shubin@maquefel.me>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Feb 2021 20:24:31 +0100
Message-ID: <CACRpkdZs6Z1r9Fa0p2vu+234rXrJ3tvS=0OeJsKJE0hnkvJ5+g@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] gpio: ep93xx: fixes series patch
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

For the entire series.

Yours,
Linus Walleij
