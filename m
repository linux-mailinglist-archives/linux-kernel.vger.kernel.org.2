Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5295941CC92
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 21:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346579AbhI2T0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 15:26:24 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:33371 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343505AbhI2T0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 15:26:24 -0400
Received: by mail-ot1-f41.google.com with SMTP id d12-20020a05683025cc00b0054d8486c6b8so4296767otu.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 12:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ddoEsfy4DqKh/acKTMkgvjiBMyX6ryO3FLycxiNxODw=;
        b=YJFhMQjSLSigz7/9ZkWPBfDi/AQkxySjPjLst3XH8cxCOrIPziqU0ipJWh9V+S3tfd
         /5lOy0gqWkjEvKhauDIau5xjWfZOk+mS+cg4risOZeAec5nKxzgW/6AdD1ciGREebDUK
         9q0s+wBFNKK8vkgctH1ihuSuwdIgrsxzRtup5lJ3rsc85PnmiF8ZXHrlynzLK9VKRa2R
         iqPU9xzCR5K+MYLYOSsLG7QV2hfkelgCtXt1whrzGEsOp/BCuoRw3sOsckA4GWyqjnZu
         BxjFjdZUJnZ/l8LKBXrXHt/MXy6gPTgQq8Xr8nmTwtU6d4BFrdD1+3hH0qnyBVLg2mBb
         Wx6A==
X-Gm-Message-State: AOAM532h185eIgOPvJS9F2mrWAJHyqSu3JUWqQ+h6He5UXpDlndC7kDn
        iRJ8ixGbW2zhHbbdf8ANNJnEX2PRrvmjnAfbC/A=
X-Google-Smtp-Source: ABdhPJz9PEdLMcRgmeOSBAMuXT7UcQOx1/kwAdHVPve1jEwT0MKEcaZT9k2ho00klMI/sSWd91GUbPqOT0jjlO8mx7U=
X-Received: by 2002:a05:6830:165a:: with SMTP id h26mr1493220otr.301.1632943482516;
 Wed, 29 Sep 2021 12:24:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210929190549.860541-1-saravanak@google.com>
In-Reply-To: <20210929190549.860541-1-saravanak@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Sep 2021 21:24:31 +0200
Message-ID: <CAJZ5v0iumiYc3q0Z76XpU1vGbOR9iSPnJE2hdrW=V3THfYLbnA@mail.gmail.com>
Subject: Re: [PATCH v2] driver core: Reject pointless SYNC_STATE_ONLY device links
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

On Wed, Sep 29, 2021 at 9:05 PM Saravana Kannan <saravanak@google.com> wrote:
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

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

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
