Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760844168E6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 02:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236202AbhIXA1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 20:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbhIXA1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 20:27:05 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6778C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 17:25:32 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id ee50so29482843edb.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 17:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9sFsmQpYcq6KTeilStx5cjaIzM5JQed8U/3AcvM6iMg=;
        b=mfrLArPjt3IaiQk2emEhgwiwTEgfIkwRNjz19IaswetPS2GNRqPDVbsTRheVjY6f2c
         KVEwXBwdakM8qzT6cI/Zg4OQo6mAXQGCLKs0IiUxSqvtsuoYvSF0fgtT2F6Z4M50YUB6
         Q4FLO5LpyAOacLE64+KZrd4qKdv9OL9fFWRNkIEX/qpEerSSLApxQ0clDlXxpJpO3ir/
         GXkPDtkKDxKvJcmwzkQvCjBjRquQzg4Pt5k8PgydV+GWG1wKfRoO+fSNwxPjcJkh3Zl8
         EsoB6oogW6QYck0hoRL6lbGkFoa62Jprqa769zYPsUjQQbDj1MOi4IgX5bcJzTG2XOf6
         MqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9sFsmQpYcq6KTeilStx5cjaIzM5JQed8U/3AcvM6iMg=;
        b=vr/vwaI+I5O5JYacOI6xn3R+7m6d+bVEwNDpTRItw9KtSnv3UypRdF+4OBukWCwvfb
         l4o2Mz4+Nz7cr8EfQ4lgkuYnBBPCDY+nbCZMWZ5ukq/otVnO93opsCpX2DWXVyJMREZE
         Y9KI9+0XB7Sxw4UcwtdljWKHF1qifyad+0uqbrc2FnEwyAR0WF9Vf+f7h0gfoSpslzS5
         HEZhAbhv+8WLBs4zQN5hw0/SYxYLc7gkB7bqPwJx+hk9R5tbLUNJEciphMl5dc+Ig0/c
         ye/0piCSrTXpcWMhCrdFVns/yhm7Ts+IwHE10Dgm4k0f98iWhzj9RYZO4ZuuYBvK5ske
         n3sw==
X-Gm-Message-State: AOAM53187fYCAsd1CdBI1cJRwhvwHmq8MiSRkQZDE/Am4l/6cUa9UXlw
        oOgTdm69okYbpK8NIaUcIjVqokzmYFWvsPCQ294/cf+YtmI=
X-Google-Smtp-Source: ABdhPJyQDT5qw60tVdljdes/AGVlZAAw5bKzrqgZ52fwH72RWzqqI+uzmwEkDw6Xfj/R0WnQY1BAnWYO+aZZkQ0qTsk=
X-Received: by 2002:a17:906:dbd7:: with SMTP id yc23mr8377246ejb.187.1632443130598;
 Thu, 23 Sep 2021 17:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210923200321.3623222-1-pmalani@chromium.org>
In-Reply-To: <20210923200321.3623222-1-pmalani@chromium.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 23 Sep 2021 17:25:19 -0700
Message-ID: <CABXOdTemBe5EePGkTTzB_fOKjr=1W_oCuMDVg11jK-0+ZtujMg@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros-ec-typec: Cleanup use of check_features
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 1:03 PM Prashant Malani <pmalani@chromium.org> wrote:
>
> cros_ec_check_features() now returns a boolean. Remove the double NOT
> operator since it's not required anymore.
>
> No functional changes are expected with this patch.
>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/platform/chrome/cros_ec_typec.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 262a891eded3..7b3afb6cda5d 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -1116,9 +1116,8 @@ static int cros_typec_probe(struct platform_device *pdev)
>         }
>
>         ec_dev = dev_get_drvdata(&typec->ec->ec->dev);
> -       typec->typec_cmd_supported = !!cros_ec_check_features(ec_dev, EC_FEATURE_TYPEC_CMD);
> -       typec->needs_mux_ack = !!cros_ec_check_features(ec_dev,
> -                                                       EC_FEATURE_TYPEC_MUX_REQUIRE_AP_ACK);
> +       typec->typec_cmd_supported = cros_ec_check_features(ec_dev, EC_FEATURE_TYPEC_CMD);
> +       typec->needs_mux_ack = cros_ec_check_features(ec_dev, EC_FEATURE_TYPEC_MUX_REQUIRE_AP_ACK);
>
>         ret = cros_typec_ec_command(typec, 0, EC_CMD_USB_PD_PORTS, NULL, 0,
>                                     &resp, sizeof(resp));
> --
> 2.33.0.685.g46640cef36-goog
>
