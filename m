Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F24E41D94D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 14:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350637AbhI3MGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 08:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350490AbhI3MGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 08:06:32 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E632C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 05:04:49 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id b15so24126761lfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 05:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UjgEbYgB1dUBICvlxnlZlHIbnstojizK8xPrV/3hfiU=;
        b=Mw5fy5Cd5FuSkEKCvXD9IxDwtLhyBdpOPgz00UTazXrMZctuiJzGTNrp8lpgTVhkQD
         oW7Uepf9piLCCyJslJdJ86U8PPnfNR/Juv7M4d51MRmTybBLrCNsoehE3W0sYRNxxFC2
         qnM43L2+H6yg1zwNdWGQXYSbfjZ5wDO/w/KicnBV2JyZV4G9/VeUBhR3PnLLrxSIFkww
         mrx00ZjbEtK165HMNp7y2D14CjeaBIeILnnVtQF3j8GpRGjFy+zQ9GhjbICdhUNoAv90
         ElrMv4NKkeXuFKIDj0BNuY8E75WhNgDEoV9WvHrg1gEfIinGOTVs1tcaHi3uPsrywqil
         ZKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UjgEbYgB1dUBICvlxnlZlHIbnstojizK8xPrV/3hfiU=;
        b=snenfYPu/PiTZjBIq9wvu772yo4vfHHqXqDQP/5jc7SI26ZmJRCcAUz3v0AGuerATb
         chUstr3DUQl3KGoe8iCBkGJjfdCdEvBufMCa/I9QNzz5ZXgTN2RjpOCQYm3cBqp+DeSl
         kVvSzrpoSbSh6iyuyOSRrTrMVEOi4LW4iot/jQXiBrJ0gKgc1QnbwdZYLYOl9pBLH8ga
         a1M8CRfgbTEGnAGDzhSIYmAjlgJqfSEYcZNVDDC05hahuuyUODlRUI+wuzpMxaJ/3S9z
         CxRsIxt/GsNhIhTXHEqEcV/lRAjLksrIYT1GSYwX73xpOPlwABG0PDhAdj4Rx8hm/+pe
         0hwg==
X-Gm-Message-State: AOAM532tDUxOZmvBuvTQSE6smUrX6gtke9sUR4YuOXO71m9UmyKhrVIR
        ItKzZgyLxYdtX5Bir3zv3U9eTu25wA9JgKxO14GLqQ==
X-Google-Smtp-Source: ABdhPJw1zA/FsBBHwIphCACp2TVxErJ29YjNcxKmb8wd2yWA60DQ7TBOfEMVQcydPvMdjJTFM5zGbzLcVJ1nv16IfDI=
X-Received: by 2002:a05:6512:1515:: with SMTP id bq21mr5610691lfb.71.1633003487945;
 Thu, 30 Sep 2021 05:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210929190549.860541-1-saravanak@google.com>
In-Reply-To: <20210929190549.860541-1-saravanak@google.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 30 Sep 2021 14:04:11 +0200
Message-ID: <CAPDyKFoomRvg-sgiaf+SwXWDyQcThqXVS5Hcg6sG0QNN4286VA@mail.gmail.com>
Subject: Re: [PATCH v2] driver core: Reject pointless SYNC_STATE_ONLY device links
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Sept 2021 at 21:05, Saravana Kannan <saravanak@google.com> wrote:
>
> SYNC_STATE_ONLY device links intentionally allow cycles because cyclic
> sync_state() dependencies are valid and necessary.
>
> However a SYNC_STATE_ONLY device link where the consumer and the supplier
> are the same device is pointless because the device link would be deleted
> as soon as the device probes (because it's also the consumer) and won't
> affect when the sync_state() callback is called. It's a waste of CPU cycles
> and memory to create this device link. So reject any attempts to create
> such a device link.
>
> Fixes: 05ef983e0d65 ("driver core: Add device link support for SYNC_STATE_ONLY flag")
> Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
> v1 -> v2:
> - Moved the check higher up in the function.
>
>  drivers/base/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 15986cc2fe5e..249da496581a 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -687,7 +687,8 @@ struct device_link *device_link_add(struct device *consumer,
>  {
>         struct device_link *link;
>
> -       if (!consumer || !supplier || flags & ~DL_ADD_VALID_FLAGS ||
> +       if (!consumer || !supplier || consumer == supplier ||
> +           flags & ~DL_ADD_VALID_FLAGS ||
>             (flags & DL_FLAG_STATELESS && flags & DL_MANAGED_LINK_FLAGS) ||
>             (flags & DL_FLAG_SYNC_STATE_ONLY &&
>              (flags & ~DL_FLAG_INFERRED) != DL_FLAG_SYNC_STATE_ONLY) ||
> --
> 2.33.0.685.g46640cef36-goog
>
