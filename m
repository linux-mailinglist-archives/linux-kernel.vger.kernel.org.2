Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE518361CF3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 12:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241215AbhDPJIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 05:08:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235236AbhDPJID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 05:08:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 299C96121E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 09:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618564059;
        bh=S1RgGOvLnt8Uq+i5YbXxuESPSFtFlBFj8NXZsRYtyYU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TrbtffF9jVbxJ+tb3hJiiPgd2BcMAxp2TSa1h8omIasuU+URPtW7urBygsErjRQvE
         exLWkyz0NyDc2WeOVvo8NRj7GUKwW/QgrkhXBE3Gbk3xh4KU2Pt3SrqAkrEwObwrY8
         WKwuKbLhV+NY5hGILQM0iMFowvDlA2SlgB0K/8xQ8PHKfjR/upvWZhi+lmy5W/PZgB
         xOY6JLarkmgreVxiiThVeTihatl3aHoPjhjSP92oqPCvLGEZOlsSiETxX3o2FyT5Gd
         tKtoBdyW2aBcXL/LJmhBMNqmJm6S7X3RathWWCZTUKs9+r8Sikr2JwVbn6e0zPQRU8
         T5q+nvh3YXiXQ==
Received: by mail-ed1-f45.google.com with SMTP id i3so5702557edt.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 02:07:39 -0700 (PDT)
X-Gm-Message-State: AOAM533KbB/+hUktCOngLpoX2DL90gUwP16kD6YTGSgi8FkGwKed3nOK
        xebRbugbNxT5QExbVGLr/G9oz9MDOiN4bDHBZHE=
X-Google-Smtp-Source: ABdhPJyoLKjcIf5H3PNFNwAinXaqu3cZQXJay5heRNq9YsT2IQ1iB7QMeeaB0QcE6v0s0pHHd4CoF8oe7YmBOMxa694=
X-Received: by 2002:a05:6402:11c9:: with SMTP id j9mr8734093edw.348.1618564057803;
 Fri, 16 Apr 2021 02:07:37 -0700 (PDT)
MIME-Version: 1.0
References: <1616403070-35776-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1616403070-35776-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 16 Apr 2021 11:07:25 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdPcQ1=UZiUumuLz8JSR2gTh=a-E01WE8ffdaa4+vsHUw@mail.gmail.com>
Message-ID: <CAJKOXPdPcQ1=UZiUumuLz8JSR2gTh=a-E01WE8ffdaa4+vsHUw@mail.gmail.com>
Subject: Re: [PATCH] drm/omap: dsi: Add missing IRQF_ONESHOT
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     tomba@kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2021 at 09:53, Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> fixed the following coccicheck:
> ./drivers/gpu/drm/omapdrm/dss/dsi.c:4329:7-27: ERROR: Threaded IRQ with
> no primary handler requested without IRQF_ONESHOT
>
> Make sure threaded IRQs without a primary handler are always request
> with IRQF_ONESHOT
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/gpu/drm/omapdrm/dss/dsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
> index b31d750..844cb0b 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
> @@ -4326,7 +4326,7 @@ static int omap_dsi_register_te_irq(struct dsi_data *dsi,
>
>         irq_set_status_flags(te_irq, IRQ_NOAUTOEN);
>
> -       err = request_threaded_irq(te_irq, NULL, omap_dsi_te_irq_handler,
> +       err = request_threaded_irq(te_irq | IRQF_ONESHOT, NULL, omap_dsi_te_irq_handler,
>                                    IRQF_TRIGGER_RISING, "TE", dsi);

Did you test it? There are several patches like this all over the tree
so it looks like "let's fix everything from Coccinelle". It's a trend
recently... multiple people send these patches. The point is that you
should not blindly follow coccinelle but adjust the change for real
case (e.g. is it a nested interrupt). Without this consideration and
testing - NACK.

Best regards,
Krzysztof
