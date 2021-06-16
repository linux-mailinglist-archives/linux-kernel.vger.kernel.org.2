Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203563A9E0A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 16:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbhFPOuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 10:50:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52445 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234153AbhFPOuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 10:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623854892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IvtAfkdui48DNcpbQR2o5Pss84Ycf8cKv7uo587U+1U=;
        b=Dsv5D/41lNWm5G2miVC5+4KJXSVizqg/zo2jjiBTY033Iz8sBwjIHpVvK4J5A5ccOZdQHQ
        1Un87t5kGShyutDqc24FPM11lp6VVQIzqYvU9XtZ0N2d+OaRuqDCKiklNIK2iHzJtCabkY
        jyLnOQrPSKVpDq3b4bZmQrgcUxNG0Kc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-R8USG57xPqun0TuMoypWhw-1; Wed, 16 Jun 2021 10:48:10 -0400
X-MC-Unique: R8USG57xPqun0TuMoypWhw-1
Received: by mail-ed1-f69.google.com with SMTP id j3-20020aa7c3430000b0290393f7aad447so1173142edr.18
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 07:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IvtAfkdui48DNcpbQR2o5Pss84Ycf8cKv7uo587U+1U=;
        b=Yyz4rkkcsP5P3/Owhxt6OqTxp1TOzIevM8bHzNhnM9nzoq8/qsMU9IXjJj5FYbIqST
         HMBmYJqF2FhOdRCMmgp0qIw4c1mCTqqzkBg93pZQNtYRRcjoeWz3Bs3cjmFlqmUgHOO1
         XAVLuOLWhveLVt6IOHZ1fZT0IZMDzW3ZA9gD5UkS5BNUaJ45TC21Xsat71oAIq9xkF6b
         tVQIkZeiuxYo0B10nJZtcneKBdFJqdofNpJHr9Tz+pZPydZvaJfC3AZYUE+SHAdjsOAW
         X/h7C5xIoyDq7H5AoyC+Pvqr3yIPrqePqBYbZplBCCvBCSaQczBabDD9bwWCBydaoG05
         jeRg==
X-Gm-Message-State: AOAM533wgZY7IZQEvopH50c+W+KwrEgU6ikxtA3CT4dwOSJsf+K9eRLI
        MVp6+FT3Qr1aC3pWvCZp4/1OAZt2vTUQUhyAxmNMDKzFCCZz7kO1cZGSfxQGuSTgnSCzIw0AoW9
        0Hg8YpdTOac0Ssr3iV6hNp+6yMNlIueg+loCwXXAViHDdlFknAc6XPl9vvCzYDD1BR4vABM/sAh
        4+
X-Received: by 2002:a05:6402:31a8:: with SMTP id dj8mr4735674edb.296.1623854889445;
        Wed, 16 Jun 2021 07:48:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNlVZnPN4c2QDPjEhBJpunBgYCKdSnZYkQWQtFv6b4qQ4mchIgWG4G2np0uMtWo3iB6a75bQ==
X-Received: by 2002:a05:6402:31a8:: with SMTP id dj8mr4735650edb.296.1623854889281;
        Wed, 16 Jun 2021 07:48:09 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id n11sm1793001ejg.43.2021.06.16.07.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 07:48:08 -0700 (PDT)
Subject: Re: [PATCH 3/5] ACPI: scan: Fix device object rescan in
 acpi_scan_clear_dep()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <3140195.44csPzL39Z@kreacher> <7272740.EvYhyI6sBW@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <0cd3a0b5-f656-2b4f-b5bc-67680bc80603@redhat.com>
Date:   Wed, 16 Jun 2021 16:48:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <7272740.EvYhyI6sBW@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/16/21 4:23 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In general, acpi_bus_attach() can only be run safely under
> acpi_scan_lock, but that lock cannot be acquired under
> acpi_dep_list_lock, so make acpi_scan_clear_dep() schedule deferred
> execution of acpi_bus_attach() under acpi_scan_lock instead of
> calling it directly.
> 
> This also fixes a possible race between acpi_scan_clear_dep() and
> device removal that might cause a device object that went away to
> be accessed, because acpi_scan_clear_dep() is changed to acquire
> a reference on the consumer device object.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/scan.c |   50 +++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 45 insertions(+), 5 deletions(-)
> 
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -2115,16 +2115,56 @@ static int acpi_dev_get_first_consumer_d
>  	return 0;
>  }
>  
> -static int acpi_scan_clear_dep(struct acpi_dep_data *dep, void *data)
> -{
> +struct acpi_scan_clear_dep_work {
> +	struct work_struct work;
>  	struct acpi_device *adev;
> +};
> +
> +static void acpi_scan_clear_dep_fn(struct work_struct *work)
> +{
> +	struct acpi_scan_clear_dep_work *cdw;
> +
> +	cdw = container_of(work, struct acpi_scan_clear_dep_work, work);
>  
> -	acpi_bus_get_device(dep->consumer, &adev);
> +	acpi_scan_lock_acquire();
> +	acpi_bus_attach(cdw->adev, true);
> +	acpi_scan_lock_release();
> +
> +	acpi_dev_put(cdw->adev);
> +	kfree(cdw);
> +}
> +
> +static bool acpi_scan_clear_dep_queue(struct acpi_device *adev)
> +{
> +	struct acpi_scan_clear_dep_work *cdw;
> +
> +	if (adev->dep_unmet)
> +		return false;
> +
> +	cdw = kmalloc(sizeof(*cdw), GFP_KERNEL);
> +	if (!cdw)
> +		return false;
> +
> +	cdw->adev = adev;
> +	INIT_WORK(&cdw->work, acpi_scan_clear_dep_fn);
> +	/*
> +	 * Since the work function may block on the lock until the entire
> +	 * initial enumeration of devices is complete, put it into the unbound
> +	 * workqueue.
> +	 */
> +	queue_work(system_unbound_wq, &cdw->work);

Hmm, I'm a bit worried about this. Even with the system_unbound_wq
some code may expect at least some progress being made with processing
works during the initial enumeration. OTOH this does run pretty early on.

Still I wonder if it would not be better to create + use our own workqueue
for this ?

I guess we can always do this if we run into issues later...

With that said / otherwise the patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> +
> +	return true;
> +}
> +
> +static int acpi_scan_clear_dep(struct acpi_dep_data *dep, void *data)
> +{
> +	struct acpi_device *adev = acpi_bus_get_acpi_device(dep->consumer);
>  
>  	if (adev) {
>  		adev->dep_unmet--;
> -		if (!adev->dep_unmet)
> -			acpi_bus_attach(adev, true);
> +		if (!acpi_scan_clear_dep_queue(adev))
> +			acpi_dev_put(adev);
>  	}
>  
>  	list_del(&dep->node);
> 
> 
> 

