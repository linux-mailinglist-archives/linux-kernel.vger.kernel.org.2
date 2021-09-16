Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1B940D1B4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 04:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbhIPCiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 22:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbhIPCiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 22:38:12 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DCAC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 19:36:52 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id c22so10905546edn.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 19:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4pivBmX79OxYLqLYjnA/tZYIYmiXw6WSEyP3eBaiP1k=;
        b=E/VTVDStcufd/tuYPBljVXmhiPYns0w121EeTWot8KEStcN7yOrBglcpw9FeyUct48
         GxeB9C1JbZ0o4k8DU1do28aldZ+Gv7YvgD30JdvBhDGkTH+Y0RCtbyVz15kYZAfEZYnX
         GesPVQdg6XJm15yaDjFOOrP+2dQiMRdD2C4SEMH92oyJDjzMuICgMhzoKSwgV5MLhIuR
         q3XoR+9limGNblyy30vrGBU03tGqNN4rBxpWxhK5c6/G8SR37wiHBr+IIO4QCg8lggX2
         BIkQrU2eV6MxDIgonI2r+ZwwWD1B61xlF5i18Pd1YNUH7uGmBb0zHsrnFrsr6XxkmH5F
         WQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4pivBmX79OxYLqLYjnA/tZYIYmiXw6WSEyP3eBaiP1k=;
        b=T4mDuz+0j8Iq9bignmuftLV7MxVvaQGuydJ2c9pbxLh+aRshLDillbrC3MkrwcEA4Q
         JHyMETgw5O1LM3Hh9xr4RmyN5XNi97d1UGQyMhHabqAqjH4nsQt+zngD62cUKqcz67MA
         eZ6adP5BB4xFKhrondbRzgHGzFVA6oE4i0v8UsekMtH3ILAj1ZUJDIrSZmigrg1aFhTQ
         oAPVRANIR8KiMEPBYjXC3DgyMk5AoF+9zTFJ9ARpLfjSyFrAYmWrqjozyfiurqUSDMhm
         bZ8DVk0NyfsUjaQt/fByDQUdjKJZt3zAtZs8qTTuzltEIW6QW4Qx9XyyuimpYwXMSGZC
         ufuQ==
X-Gm-Message-State: AOAM530LPK+aXgPs7WvvAcPniVCqzZSFuhkuv6Z54/xBN718dfqtFMW2
        Yve/pGZcA/ZYV50w18+ZwNdO4mpnxI6+cT/X/Qic1g==
X-Google-Smtp-Source: ABdhPJxMebfuz5mAuV4CswK5j4WxcjKq7dSHYxDr+A8SSgHGoKC62/kk+VpRVOEJvf6oqlod5zJWrY7eOcTSvfh4e/I=
X-Received: by 2002:a50:9b17:: with SMTP id o23mr3716974edi.341.1631759810609;
 Wed, 15 Sep 2021 19:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210916014632.2662612-1-pmalani@chromium.org>
In-Reply-To: <20210916014632.2662612-1-pmalani@chromium.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 15 Sep 2021 19:36:39 -0700
Message-ID: <CABXOdTdTUj-Pi=dfcvCRc=K004EBe5pepe4FcUrOQzWWUuopKQ@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_proto: Fix check_features ret val
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 6:47 PM Prashant Malani <pmalani@chromium.org> wrote:
>
> The kerneldoc for cros_ec_check_features() states that it returns 1 or 0
> depedending on whether a feature is supported or not, but it instead
> returns a negative error number in one case, and a non-1 bitmask in
> other cases.
>
> Since all call-sites only check for a 1 or 0 return value, update
> the function to return boolean values.
>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/platform/chrome/cros_ec_proto.c     | 12 +++++++-----
>  include/linux/platform_data/cros_ec_proto.h |  2 +-
>  2 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index a7404d69b2d3..a34cf58c5ef7 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -808,9 +808,9 @@ EXPORT_SYMBOL(cros_ec_get_host_event);
>   *
>   * Call this function to test whether the ChromeOS EC supports a feature.
>   *
> - * Return: 1 if supported, 0 if not
> + * Return: true if supported, false if not (or if an error was encountered).
>   */
> -int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
> +bool cros_ec_check_features(struct cros_ec_dev *ec, int feature)
>  {
>         struct cros_ec_command *msg;
>         int ret;
> @@ -818,8 +818,10 @@ int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
>         if (ec->features[0] == -1U && ec->features[1] == -1U) {
>                 /* features bitmap not read yet */
>                 msg = kzalloc(sizeof(*msg) + sizeof(ec->features), GFP_KERNEL);
> -               if (!msg)
> -                       return -ENOMEM;
> +               if (!msg) {
> +                       dev_err(ec->dev, "failed to allocate memory to get EC features\n");
> +                       return false;
> +               }
>
>                 msg->command = EC_CMD_GET_FEATURES + ec->cmd_offset;
>                 msg->insize = sizeof(ec->features);
> @@ -839,7 +841,7 @@ int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
>                 kfree(msg);
>         }
>
> -       return ec->features[feature / 32] & EC_FEATURE_MASK_0(feature);
> +       return !!(ec->features[feature / 32] & EC_FEATURE_MASK_0(feature));
>  }
>  EXPORT_SYMBOL_GPL(cros_ec_check_features);
>
> diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
> index 02599687770c..55844ece0b32 100644
> --- a/include/linux/platform_data/cros_ec_proto.h
> +++ b/include/linux/platform_data/cros_ec_proto.h
> @@ -227,7 +227,7 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev,
>
>  u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev);
>
> -int cros_ec_check_features(struct cros_ec_dev *ec, int feature);
> +bool cros_ec_check_features(struct cros_ec_dev *ec, int feature);
>
>  int cros_ec_get_sensor_count(struct cros_ec_dev *ec);
>
> --
> 2.33.0.309.g3052b89438-goog
>
