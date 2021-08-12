Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751A53EAC27
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 22:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbhHLU6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 16:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbhHLU6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 16:58:36 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671A6C061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 13:58:10 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id c130so8293616qkg.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 13:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8poO9qbTswl4eqnW3A9uCrg2kT6adQeU51qtZPM+DAk=;
        b=gk/CsYq+XN5/dfXyMvyrpVc4sby1TjVK90AINWd5uRj2jTbKY97tGgn1yCxOZYhXlz
         x+M1bnYhB/d4zMvxNHVQwr3gH6T7YvOlo6CtGoQsqsFoil11wAE0OXYXkBU2eFOcqmKN
         U0T3+NUaMDj0AKlGkolkg2MDJFhc6R718TPe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8poO9qbTswl4eqnW3A9uCrg2kT6adQeU51qtZPM+DAk=;
        b=qvKvSe9xWSaWTT/aCMrDTDtie87a73S2l1EekCMpOblQbqekqxQr6en6JVI/slalaH
         kMTk3haEOFsXHT7Pnd9ATqvBY2s354/KXMFSfWss+xvIWEVEkImFY+drSMFA1B4XReES
         VxRrfviSwOkDEEAxxEUa8Q1GqAiFFsJ5YAiDcg2hUmhhuXAbP78uLYAuL05DMVL2zoYh
         RFhbzm++kUbggQDWIEZYN/OMebaMHSvIlmV9L8tP3XA9GkkrvnHy1aXFj8hEzTU98iME
         jcnx6qB58I8kWN8bsGEzcKdEieCM0MB/t3hY7VkncZsbWUkVM+Ko08+N5I4sTiZSaPsD
         ryqQ==
X-Gm-Message-State: AOAM533ZwnewXwo71s9O15YehrpmWN2AAp7TBRql0Vtyn/7Ynh1bCNMj
        E8EUQVJgrJeLgQ9rDLGNupHCe5nBQbcdyxkMlHvChRxWpKw=
X-Google-Smtp-Source: ABdhPJxxr80qSIG8NWRODL8POoOdYlduF3atwt6HEpn7vLX420nY/qnOYc7Iycq5lLjQqOwCHMNw9LQ5dzRpHiUD01g=
X-Received: by 2002:a37:e50e:: with SMTP id e14mr6465631qkg.71.1628801889289;
 Thu, 12 Aug 2021 13:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210803173619.91539-1-pmalani@chromium.org>
In-Reply-To: <20210803173619.91539-1-pmalani@chromium.org>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 12 Aug 2021 13:57:58 -0700
Message-ID: <CACeCKadTnvghkJq26rFVnJcmhAqhvB6mbpuUx21hVD5K+=DNPw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] platform/chrome: cros_ec_proto: Update feature check
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping.

On Tue, Aug 3, 2021 at 10:36 AM Prashant Malani <pmalani@chromium.org> wrote:
>
> EC feature flags now require more than 32 bits to be represented. In
> order to make cros_ec_check_features() usable for more recent features,
> update it to account for the extra 32 bits of features.
>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
> Changes in v2:
> - No changes.
>
>  drivers/platform/chrome/cros_ec_proto.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index a7404d69b2d3..772edad80593 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -813,6 +813,7 @@ EXPORT_SYMBOL(cros_ec_get_host_event);
>  int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
>  {
>         struct cros_ec_command *msg;
> +       u32 mask;
>         int ret;
>
>         if (ec->features[0] == -1U && ec->features[1] == -1U) {
> @@ -839,7 +840,12 @@ int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
>                 kfree(msg);
>         }
>
> -       return ec->features[feature / 32] & EC_FEATURE_MASK_0(feature);
> +       if (feature >= 32)
> +               mask = EC_FEATURE_MASK_1(feature);
> +       else
> +               mask = EC_FEATURE_MASK_0(feature);
> +
> +       return ec->features[feature / 32] & mask;
>  }
>  EXPORT_SYMBOL_GPL(cros_ec_check_features);
>
> --
> 2.32.0.554.ge1b32706d8-goog
>
