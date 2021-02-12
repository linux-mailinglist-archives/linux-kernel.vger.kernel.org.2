Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 214E9319BE2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 10:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhBLJaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 04:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhBLJ37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 04:29:59 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95438C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 01:29:17 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id v6so6119412ljh.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 01:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gQdfOeAQ7lpFeaVg0peNbPSNJaBEcknECYCS0PLjCVc=;
        b=h3EbwiWkSrjuE1APlCgTujpVh5LKOkzicShqpts5zAylZcH9uX8BmWPdY+DVQtGGPh
         EkN/7gx+3p99tk9J0Cx+Qp+HkpO9mSsLWXeVwn/mlPRfmOdKhWoWxX4bT6/40YfpA4tr
         W74eZZYC8zzN/CgWplga4RCQD2hWAcL8+GG/RlrI0PkGibBU94c39IAl10ciGdKX20hd
         kIZ/nHitbyxyKUXSpS4jtkErx4bLPBHtQ5U5G3bxmzhtKHlFwPVLbJBcpcIGw+nCjo30
         /q2BnNQbi/MWrqqB+0gTbpcW06KrFkYkTtiwOi5+Kgt/3MfCfwK+SjUdu4lsoosLOAnk
         f6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gQdfOeAQ7lpFeaVg0peNbPSNJaBEcknECYCS0PLjCVc=;
        b=dhJmzHNKOIGDc03ePOjfk1go7fhKx8K+HNkzQuTsNMPNLgG6dA0Pit/3Pc/fojrsiF
         WAKvE5s/7SioP3/TqDZtLymZP4uxBDVVdjGLljFZstU0RARpDTTuVc939OslCScLmRnl
         UbIBwIjpyR4/HE7ZEH+ChjD4ga0uiycUv2KSyJURDiS+OE8+fk8TEKVhRqw5vXliaQuz
         D1BR0D53GStJvKvW7WHtGD2C9JULmO0+opN+pkfrXi3kv0g7SkMji2+YdcaXz83+Mevk
         kjkwhUfeB4ZVhe1d1u6JlJ0J11rD6vvPsx8yaQFjnz+oySnYvsHVC0TvqjJAJe3bALmY
         e8PA==
X-Gm-Message-State: AOAM5324uka8/2DMdclhk2ifQcA8etID2we6RfpFsFdC5JljngyX5aS3
        tIf4LZ8KBnX8PfxuinieJYXPEMJYRJUvG4ItpaGjuA==
X-Google-Smtp-Source: ABdhPJzFecvZy6+ocBqloea+lkJRPr2kKX82BS8AdTUqtM6sJ1Yd4dbi0ddZTznSRUsOxm6+2H4qMFH/hTOQ9PLqxPg=
X-Received: by 2002:a2e:8e84:: with SMTP id z4mr1130022ljk.467.1613122156038;
 Fri, 12 Feb 2021 01:29:16 -0800 (PST)
MIME-Version: 1.0
References: <20210208135347.18494-1-o.rempel@pengutronix.de> <20210208135347.18494-2-o.rempel@pengutronix.de>
In-Reply-To: <20210208135347.18494-2-o.rempel@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 12 Feb 2021 10:29:04 +0100
Message-ID: <CACRpkda54NjkU=yedgOmghhx0pRN2k352c3AKVETG-_PcpxcUw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: counter: add event-counter binding
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 8, 2021 at 2:53 PM Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Add binding for the event counter node
>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Works for me:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> +required:
> +  - compatible

Ideally it should be "interrupts OR gpios required"
(at least one of them must be present) but I don't know if
we can express that.

Perhaps also write that if both are defined, the interrupt will
take precedence for counting events.

Yours,
Linus Walleij
