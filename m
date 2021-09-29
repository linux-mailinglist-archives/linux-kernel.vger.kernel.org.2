Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBEB41C45A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 14:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343679AbhI2MOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 08:14:19 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:33653 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343569AbhI2MOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 08:14:17 -0400
Received: by mail-ot1-f46.google.com with SMTP id d12-20020a05683025cc00b0054d8486c6b8so2635739otu.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 05:12:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9CNg75yYNwWjfDm+PNFaKy/x94GD0SVtQtkXQ6Yr1/c=;
        b=IjRkqb7CUwJ7CQ9hpUAtVcka870AbWNlncUkLvl2cK+DX7BgVFOhIO2FXN0V0Fiqpi
         AvIfH1y8Ctn3iMSUtvFp29c/YydIKGBlL4qAhIZ2D4Y2akCZUTOIIM/USOYubfgAFVcA
         pFdE6ovMJZtKAcdx6kw1H9iVGbwjvD3b5xKb9wXBF111ib7Fmm+YH3kWIrpnP8h3PtUf
         3/knSQPXCEhoiNq3Emr2U8exv+fAkO+sAQw6/gAU5FQ41hq5W3lOROPgVZAeVhe+cKbH
         O5u6L/NRYoTqzPTl4PaF03cYNwbqhVGmz2VoV5Bs+u8dBIOjBsmueYIGiGqgJKQOMgHF
         Qg+w==
X-Gm-Message-State: AOAM533QNNEbZvVx4YNmcINJLqPWUvYW0VKQESDhB6jU+BrNYEKqIpZA
        RN1OlSFuw3NnKSNFZghnAjOea5eKmc1Z8GmbhTQ=
X-Google-Smtp-Source: ABdhPJyKW5vi2gMWn56q8WndOPSPpJAlB1VcdKmmyoBmOYbRYpFm8b8bik/3sGflztJITLKlNSwjepTTqMk97Nndon0=
X-Received: by 2002:a05:6830:165a:: with SMTP id h26mr10139706otr.301.1632917556280;
 Wed, 29 Sep 2021 05:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210929005103.698172-1-saravanak@google.com>
In-Reply-To: <20210929005103.698172-1-saravanak@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Sep 2021 14:12:24 +0200
Message-ID: <CAJZ5v0juFEy-7HPAVyL6qibzhF48tH_qgzh9Kjj32iEY2j0Q9Q@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Reject pointless SYNC_STATE_ONLY device links
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 2:51 AM Saravana Kannan <saravanak@google.com> wrote:
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
> ---
>  drivers/base/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 15986cc2fe5e..eed27933ac4d 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -716,7 +716,7 @@ struct device_link *device_link_add(struct device *consumer,
>          * SYNC_STATE_ONLY link, we don't check for reverse dependencies
>          * because it only affects sync_state() callbacks.
>          */
> -       if (!device_pm_initialized(supplier)
> +       if (!device_pm_initialized(supplier) || consumer == supplier

Why do we need to get all the way down to here in order to return NULL
in the consumer == supplier case?

IMO this should be checked at the beginning along with !consumer and !supplier.

>             || (!(flags & DL_FLAG_SYNC_STATE_ONLY) &&
>                   device_is_dependent(consumer, supplier))) {
>                 link = NULL;
> --
> 2.33.0.685.g46640cef36-goog
>
