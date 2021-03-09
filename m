Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118043331E5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 00:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbhCIX1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 18:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhCIX0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 18:26:45 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C50C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 15:26:45 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id c131so15777024ybf.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 15:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qhSEkLXLJX3iiF4hpNgfL2YcHSiS7i6XFN/5vC1WyUA=;
        b=YY9jRNTTVsTQzvhZFt8T6uCl2Yu1EYs3jSVA1lwvxixtXbZVLUgYaBm9Jk0+lSbrTg
         FIb9hqeYbr49ctC5u8qZNiriK5xPOFNDi0v77t7FwQvmBZnqNDFrI2HRY/x15pMTc4/w
         Ibf0cqVR6rO5rulqW+soJVm1mRY3AbN3A3TZOBKimtg60qpdastc68E9/MkK4/ElXuJs
         0LxJKRVP1jM5WXQBy92AJCHATXm0peL1JaNiSdCAfkYCJ3obSpGemjn22wgyIAWguV9r
         PysnyZlBTvRkAmpDBjFgS5Xxe2lIqlCl1RvVBRDamM9m8yO0Gr5Xf0yBE8U/hLxaaZGH
         JB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qhSEkLXLJX3iiF4hpNgfL2YcHSiS7i6XFN/5vC1WyUA=;
        b=P2N1en4V1Yu2tqgRkn1A6RW0o3duMIyci5w7NVeJwLig/4RKj9m/v9ITjFbsrWsMso
         m8bYOqpZdK29v30ZU8FcDIYWJD3uRQ7I0S50pHMCxOU9DT8SI7yme0NT3pKR8fkRXw8R
         /dKyAjZDAx53lSHQ37tueGubuxXC9HlM+4kwnddwpqcRVGnnAwE4jdZn8ZVk4n4OkiIY
         q7jjWlg6sov0thI44IR926UQlfo0L5jNdrL7nsEA/XBWd88MfY/SkmFazXY/uzB4iyRR
         n0seMLWXKoebTiau9aRuTZdQpQbMRy7o782aBARSop9w4ePOEg9HE5UiIo7rh5qo1utD
         2omw==
X-Gm-Message-State: AOAM530DYJ3zCdHVENzF5MbXsxWekQVWjcP7DsSIjR2qNlKeVsN4zIrt
        RYbfagia3cbSKn4hlwHqObXUL5oapBp1y3SYWCRzRg==
X-Google-Smtp-Source: ABdhPJyKAXzRQvHmXScFAe/fa4YHa7QVBJ94jHfDFKlWU1hBj8Zc0uwgObXmqL9axT9PEk2vNH/oZgaAECmuPNSBfXk=
X-Received: by 2002:a25:ca8f:: with SMTP id a137mr347710ybg.228.1615332404101;
 Tue, 09 Mar 2021 15:26:44 -0800 (PST)
MIME-Version: 1.0
References: <20210302211133.2244281-1-saravanak@google.com> <20210302211133.2244281-2-saravanak@google.com>
In-Reply-To: <20210302211133.2244281-2-saravanak@google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 9 Mar 2021 15:26:05 -0800
Message-ID: <CAGETcx81SLrDGe3KMR1OfjSgo7T-kbj1ENwkvnfo6_A82E0j7g@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] driver core: Avoid pointless deferred probe attempts
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Michael Walle <michael@walle.cc>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 2, 2021 at 1:11 PM Saravana Kannan <saravanak@google.com> wrote:
>
> There's no point in adding a device to the deferred probe list if we
> know for sure that it doesn't have a matching driver. So, check if a
> device can match with a driver before adding it to the deferred probe
> list.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Rafael/Greg,

Any concerns with this specific patch? Do you see any bugs? I'm asking
because some of the other improvements I'm working on depend on this
flag. So I want to make sure this can land before I take my work in
progress too far.

-Saravana

> ---
>  drivers/base/dd.c      | 6 ++++++
>  include/linux/device.h | 4 ++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 9179825ff646..f18963f42e21 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -123,6 +123,9 @@ static DECLARE_WORK(deferred_probe_work, deferred_probe_work_func);
>
>  void driver_deferred_probe_add(struct device *dev)
>  {
> +       if (!dev->can_match)
> +               return;
> +
>         mutex_lock(&deferred_probe_mutex);
>         if (list_empty(&dev->p->deferred_probe)) {
>                 dev_dbg(dev, "Added to deferred list\n");
> @@ -726,6 +729,7 @@ static int driver_probe_device(struct device_driver *drv, struct device *dev)
>         if (!device_is_registered(dev))
>                 return -ENODEV;
>
> +       dev->can_match = true;
>         pr_debug("bus: '%s': %s: matched device %s with driver %s\n",
>                  drv->bus->name, __func__, dev_name(dev), drv->name);
>
> @@ -829,6 +833,7 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
>                 return 0;
>         } else if (ret == -EPROBE_DEFER) {
>                 dev_dbg(dev, "Device match requests probe deferral\n");
> +               dev->can_match = true;
>                 driver_deferred_probe_add(dev);
>         } else if (ret < 0) {
>                 dev_dbg(dev, "Bus failed to match device: %d\n", ret);
> @@ -1064,6 +1069,7 @@ static int __driver_attach(struct device *dev, void *data)
>                 return 0;
>         } else if (ret == -EPROBE_DEFER) {
>                 dev_dbg(dev, "Device match requests probe deferral\n");
> +               dev->can_match = true;
>                 driver_deferred_probe_add(dev);
>         } else if (ret < 0) {
>                 dev_dbg(dev, "Bus failed to match device: %d\n", ret);
> diff --git a/include/linux/device.h b/include/linux/device.h
> index ba660731bd25..569932d282c0 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -439,6 +439,9 @@ struct dev_links_info {
>   * @state_synced: The hardware state of this device has been synced to match
>   *               the software state of this device by calling the driver/bus
>   *               sync_state() callback.
> + * @can_match: The device has matched with a driver at least once or it is in
> + *             a bus (like AMBA) which can't check for matching drivers until
> + *             other devices probe successfully.
>   * @dma_coherent: this particular device is dma coherent, even if the
>   *             architecture supports non-coherent devices.
>   * @dma_ops_bypass: If set to %true then the dma_ops are bypassed for the
> @@ -545,6 +548,7 @@ struct device {
>         bool                    offline:1;
>         bool                    of_node_reused:1;
>         bool                    state_synced:1;
> +       bool                    can_match:1;
>  #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
>      defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
>      defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
> --
> 2.30.1.766.gb4fecdf3b7-goog
>
