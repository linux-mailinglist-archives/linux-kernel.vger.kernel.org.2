Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C02E35722B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 18:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344793AbhDGQbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 12:31:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26407 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232103AbhDGQbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 12:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617813096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R3hmDVIoA8SS7AT3Bh88v69hWmH2wvHwoStkQGgqOaw=;
        b=Ja71QM6l2qxVszto0JMS5hln4dbF4xYiEAIkrIdvdrPGI7eUpkk4y2WAXcjzzcBAfJ4Pyf
        1GgEfPbg2L87BDaK6HfVnbyyZQIJGmJrvk5cZDIaV1ThSN3568aioxpnIT5qx9IuGqQu0w
        1YWCZBjBiVmctxw2VqjLwMipENUKQ2I=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-QJ2U76qcPGehy2xX1qfOGw-1; Wed, 07 Apr 2021 12:31:34 -0400
X-MC-Unique: QJ2U76qcPGehy2xX1qfOGw-1
Received: by mail-ej1-f72.google.com with SMTP id v27so7120709ejq.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 09:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R3hmDVIoA8SS7AT3Bh88v69hWmH2wvHwoStkQGgqOaw=;
        b=sRoUDTPQ4miMqaG6tEx9cXcZYPVm645fDa0n2NYmzmnTRYqG7oPpMXHef3BtE3Bh0W
         A/gqlg4r4QKgVctMjvI+1aMaZWagiWYWUg4uxRlA4q/tJgUTkA317mrTWkBMtTdh6Z7+
         U62FLtihfuh+tZCJqIijNu9FJsuW9GKC4od+ve9BAysMyG5kd33mzr2qo7459jpNrC4x
         0tbOcQU5ud2qwxFBKFufcG1dxVchOuke8bT+uDe7O2SGpj3veu4PuNvlQ6RLt0tSOiQh
         sx+x2vlL/3VDfros+uDK2XkEscPACrbCKLLsFXBCryGbtZry+uQDwnOd8lxYl8F09f26
         6dPg==
X-Gm-Message-State: AOAM530Cszuz4ywX2ESyO0CupFlwIOUG5iX6kY6yCUTjzBHx2plDagep
        DKyIwGZv8l/xeSVSqDfuRUjJTn2EmbheOe698wAkIrHAxLxQG7XY9JfqcE0pPrCITSJhs4U0e7o
        NnpiaFzYfJsIgfHNNGDNyY9gEI79BrUBbB1oB6IN2jO4iqvghTebeg3rCqhJd15LO35MaZTuJrq
        BD
X-Received: by 2002:a17:906:1d01:: with SMTP id n1mr4761035ejh.140.1617813093222;
        Wed, 07 Apr 2021 09:31:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAaOx62F3wRfxpkotHOfmgPZChzj/mCZvUV3n6qeXRQdWA32ya07TTtIg3EO6b7ZDEukJ+4w==
X-Received: by 2002:a17:906:1d01:: with SMTP id n1mr4761011ejh.140.1617813092953;
        Wed, 07 Apr 2021 09:31:32 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id x17sm12836122ejd.68.2021.04.07.09.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 09:31:32 -0700 (PDT)
Subject: Re: [PATCH] platform/surface: aggregator_registry: Give devices time
 to set up when connecting
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210405231222.358113-1-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3a053611-d4ff-bab4-f7df-b98251eb6b68@redhat.com>
Date:   Wed, 7 Apr 2021 18:31:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210405231222.358113-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/6/21 1:12 AM, Maximilian Luz wrote:
> Sometimes, the "base connected" event that we rely on to (re-)attach the
> device connected to the base is sent a bit too early. When this happens,
> some devices may not be completely ready yet.
> 
> Specifically, the battery has been observed to report zero-values for
> things like full charge capacity, which, however, is only loaded once
> when the driver for that device probes. This can thus result in battery
> readings being unavailable.
> 
> As we cannot easily and reliably discern between devices that are not
> ready yet and devices that are not connected (i.e. will never be ready),
> delay adding these devices. This should give them enough time to set up.
> 
> The delay is set to 2.5 seconds, which should give us a good safety
> margin based on testing and still be fairly responsive for users.
> 
> To achieve that delay switch to updating via a delayed work struct,
> which means that we can also get rid of some locking.
> 
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> ---
>  .../surface/surface_aggregator_registry.c     | 98 ++++++++-----------
>  1 file changed, 40 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
> index eccb9d1007cd..685d37a7add1 100644
> --- a/drivers/platform/surface/surface_aggregator_registry.c
> +++ b/drivers/platform/surface/surface_aggregator_registry.c
> @@ -13,10 +13,10 @@
>  #include <linux/kernel.h>
>  #include <linux/limits.h>
>  #include <linux/module.h>
> -#include <linux/mutex.h>
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
>  #include <linux/types.h>
> +#include <linux/workqueue.h>
>  
>  #include <linux/surface_aggregator/controller.h>
>  #include <linux/surface_aggregator/device.h>
> @@ -287,6 +287,13 @@ static int ssam_hub_add_devices(struct device *parent, struct ssam_controller *c
>  
>  /* -- SSAM base-hub driver. ------------------------------------------------- */
>  
> +/*
> + * Some devices (especially battery) may need a bit of time to be fully usable
> + * after being (re-)connected. This delay has been determined via
> + * experimentation.
> + */
> +#define SSAM_BASE_UPDATE_CONNECT_DELAY		msecs_to_jiffies(2500)
> +
>  enum ssam_base_hub_state {
>  	SSAM_BASE_HUB_UNINITIALIZED,
>  	SSAM_BASE_HUB_CONNECTED,
> @@ -296,8 +303,8 @@ enum ssam_base_hub_state {
>  struct ssam_base_hub {
>  	struct ssam_device *sdev;
>  
> -	struct mutex lock;  /* Guards state update checks and transitions. */
>  	enum ssam_base_hub_state state;
> +	struct delayed_work update_work;
>  
>  	struct ssam_event_notifier notif;
>  };
> @@ -335,11 +342,7 @@ static ssize_t ssam_base_hub_state_show(struct device *dev, struct device_attrib
>  					char *buf)
>  {
>  	struct ssam_base_hub *hub = dev_get_drvdata(dev);
> -	bool connected;
> -
> -	mutex_lock(&hub->lock);
> -	connected = hub->state == SSAM_BASE_HUB_CONNECTED;
> -	mutex_unlock(&hub->lock);
> +	bool connected = hub->state == SSAM_BASE_HUB_CONNECTED;
>  
>  	return sysfs_emit(buf, "%d\n", connected);
>  }
> @@ -356,16 +359,20 @@ static const struct attribute_group ssam_base_hub_group = {
>  	.attrs = ssam_base_hub_attrs,
>  };
>  
> -static int __ssam_base_hub_update(struct ssam_base_hub *hub, enum ssam_base_hub_state new)
> +static void ssam_base_hub_update_workfn(struct work_struct *work)
>  {
> +	struct ssam_base_hub *hub = container_of(work, struct ssam_base_hub, update_work.work);
>  	struct fwnode_handle *node = dev_fwnode(&hub->sdev->dev);
> +	enum ssam_base_hub_state state;
>  	int status = 0;
>  
> -	lockdep_assert_held(&hub->lock);
> +	status = ssam_base_hub_query_state(hub, &state);
> +	if (status)
> +		return;
>  
> -	if (hub->state == new)
> -		return 0;
> -	hub->state = new;
> +	if (hub->state == state)
> +		return;
> +	hub->state = state;
>  
>  	if (hub->state == SSAM_BASE_HUB_CONNECTED)
>  		status = ssam_hub_add_devices(&hub->sdev->dev, hub->sdev->ctrl, node);
> @@ -374,51 +381,28 @@ static int __ssam_base_hub_update(struct ssam_base_hub *hub, enum ssam_base_hub_
>  
>  	if (status)
>  		dev_err(&hub->sdev->dev, "failed to update base-hub devices: %d\n", status);
> -
> -	return status;
> -}
> -
> -static int ssam_base_hub_update(struct ssam_base_hub *hub)
> -{
> -	enum ssam_base_hub_state state;
> -	int status;
> -
> -	mutex_lock(&hub->lock);
> -
> -	status = ssam_base_hub_query_state(hub, &state);
> -	if (!status)
> -		status = __ssam_base_hub_update(hub, state);
> -
> -	mutex_unlock(&hub->lock);
> -	return status;
>  }
>  
>  static u32 ssam_base_hub_notif(struct ssam_event_notifier *nf, const struct ssam_event *event)
>  {
> -	struct ssam_base_hub *hub;
> -	struct ssam_device *sdev;
> -	enum ssam_base_hub_state new;
> -
> -	hub = container_of(nf, struct ssam_base_hub, notif);
> -	sdev = hub->sdev;
> +	struct ssam_base_hub *hub = container_of(nf, struct ssam_base_hub, notif);
> +	unsigned long delay;
>  
>  	if (event->command_id != SSAM_EVENT_BAS_CID_CONNECTION)
>  		return 0;
>  
>  	if (event->length < 1) {
> -		dev_err(&sdev->dev, "unexpected payload size: %u\n",
> -			event->length);
> +		dev_err(&hub->sdev->dev, "unexpected payload size: %u\n", event->length);
>  		return 0;
>  	}
>  
> -	if (event->data[0])
> -		new = SSAM_BASE_HUB_CONNECTED;
> -	else
> -		new = SSAM_BASE_HUB_DISCONNECTED;
> +	/*
> +	 * Delay update when the base is being connected to give devices/EC
> +	 * some time to set up.
> +	 */
> +	delay = event->data[0] ? SSAM_BASE_UPDATE_CONNECT_DELAY : 0;
>  
> -	mutex_lock(&hub->lock);
> -	__ssam_base_hub_update(hub, new);
> -	mutex_unlock(&hub->lock);
> +	schedule_delayed_work(&hub->update_work, delay);
>  
>  	/*
>  	 * Do not return SSAM_NOTIF_HANDLED: The event should be picked up and
> @@ -430,7 +414,10 @@ static u32 ssam_base_hub_notif(struct ssam_event_notifier *nf, const struct ssam
>  
>  static int __maybe_unused ssam_base_hub_resume(struct device *dev)
>  {
> -	return ssam_base_hub_update(dev_get_drvdata(dev));
> +	struct ssam_base_hub *hub = dev_get_drvdata(dev);
> +
> +	schedule_delayed_work(&hub->update_work, 0);
> +	return 0;
>  }
>  static SIMPLE_DEV_PM_OPS(ssam_base_hub_pm_ops, NULL, ssam_base_hub_resume);
>  
> @@ -443,8 +430,6 @@ static int ssam_base_hub_probe(struct ssam_device *sdev)
>  	if (!hub)
>  		return -ENOMEM;
>  
> -	mutex_init(&hub->lock);
> -
>  	hub->sdev = sdev;
>  	hub->state = SSAM_BASE_HUB_UNINITIALIZED;
>  
> @@ -456,27 +441,25 @@ static int ssam_base_hub_probe(struct ssam_device *sdev)
>  	hub->notif.event.mask = SSAM_EVENT_MASK_NONE;
>  	hub->notif.event.flags = SSAM_EVENT_SEQUENCED;
>  
> +	INIT_DELAYED_WORK(&hub->update_work, ssam_base_hub_update_workfn);
> +
>  	ssam_device_set_drvdata(sdev, hub);
>  
>  	status = ssam_notifier_register(sdev->ctrl, &hub->notif);
>  	if (status)
> -		goto err_register;
> -
> -	status = ssam_base_hub_update(hub);
> -	if (status)
> -		goto err_update;
> +		return status;
>  
>  	status = sysfs_create_group(&sdev->dev.kobj, &ssam_base_hub_group);
>  	if (status)
> -		goto err_update;
> +		goto err;
>  
> +	schedule_delayed_work(&hub->update_work, 0);
>  	return 0;
>  
> -err_update:
> +err:
>  	ssam_notifier_unregister(sdev->ctrl, &hub->notif);
> +	cancel_delayed_work_sync(&hub->update_work);
>  	ssam_hub_remove_devices(&sdev->dev);
> -err_register:
> -	mutex_destroy(&hub->lock);
>  	return status;
>  }
>  
> @@ -487,9 +470,8 @@ static void ssam_base_hub_remove(struct ssam_device *sdev)
>  	sysfs_remove_group(&sdev->dev.kobj, &ssam_base_hub_group);
>  
>  	ssam_notifier_unregister(sdev->ctrl, &hub->notif);
> +	cancel_delayed_work_sync(&hub->update_work);
>  	ssam_hub_remove_devices(&sdev->dev);
> -
> -	mutex_destroy(&hub->lock);
>  }
>  
>  static const struct ssam_device_id ssam_base_hub_match[] = {
> 

