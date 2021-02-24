Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC0E32444E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 20:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbhBXTDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 14:03:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39409 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235102AbhBXTCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 14:02:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614193238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DnxnFJgU7W5jWRFfiH8sdIyWjtSa+LHW3XMoL6YE26o=;
        b=aeoKZjWdtNotnZRr8/2saX2gVbBSZxcgBztXNMyEdo60XkubOhzQZyeXFkDLn0uYmH/qSE
        OwMMXGjkdj7nw0Z0nlR9zMIzt+Z7OTGrfrwZJOdZ7ebmIJv1O+zxw1njcTtO1ClNrmonzk
        7fwxIf9KDemoGp2F1x09YQ3bmA0Y7gU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-orOs35nkPRS1A0o0TLI6Rw-1; Wed, 24 Feb 2021 14:00:36 -0500
X-MC-Unique: orOs35nkPRS1A0o0TLI6Rw-1
Received: by mail-ed1-f70.google.com with SMTP id s26so1405728edq.18
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 11:00:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DnxnFJgU7W5jWRFfiH8sdIyWjtSa+LHW3XMoL6YE26o=;
        b=sFXuX/Srdmq0I0Dnrka3XAgBMR4Ue61xq11hTRsDFhIajHmKiGU99CFe//9iw8XoPQ
         SjZTlPSPcVhMmYBjlBKKCbb164m1kpTPm34in6MLm2rMF90fCMPGtZ8BNWwHjc/TQSVT
         06OHC8GIBRJEd9uqwhiKfzlzWxu/RCg0ZeBSoAQ8HVFJEMHk+oJ8FuHDLrxSjEIfsjlz
         i/YUfu9qyiUGyFk4twD11TM7lHHw72mpE5+xj6F0a56o2YsfmAA2gAQ2Hy9FMgm6I9fL
         ozg4YvGyCI2deCPENs2pb1tqEIM19nMYqfoVz2Q1F2JwpMpS8GMpzdnXsYQNB+6XgULU
         o50Q==
X-Gm-Message-State: AOAM531hL1qITevzoiCqCLfULKPKtwlTwDEvDAbFWYt3sjvY5N2MkK4h
        NuL3Mym9z8zDcOeKFrBKs5YJ+7LuyVf4hHHlTa7KVD/ofTRRxBBXhjOIYj7x1ykm+rHACgvVHB7
        ATa9VB9zr2RJXF2h1hgsp7Brj
X-Received: by 2002:a17:907:1b21:: with SMTP id mp33mr27731491ejc.358.1614193235355;
        Wed, 24 Feb 2021 11:00:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzj+2WmVaiUi/krvnzTn86QSwWYDjGXYcEUpgB5xC/nRZUWHTyuRFFoMACPej3WsSOwfkUlcQ==
X-Received: by 2002:a17:907:1b21:: with SMTP id mp33mr27731482ejc.358.1614193235190;
        Wed, 24 Feb 2021 11:00:35 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id h4sm2288887edv.80.2021.02.24.11.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Feb 2021 11:00:34 -0800 (PST)
Subject: Re: [PATCH v1] platform: x86: ACPI: Get rid of ACPICA message
 printing
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Chen Yu <yu.c.chen@intel.com>
References: <2074665.VPHYfYaQb6@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <46166c43-ee54-4a6b-5e48-36ff8e08cba6@redhat.com>
Date:   Wed, 24 Feb 2021 20:00:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <2074665.VPHYfYaQb6@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On 2/24/21 7:41 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> A few x86 platform drivers use ACPI_DEBUG_PRINT() or ACPI_EXCEPTION()
> for printing messages, but that is questionable, because those macros
> belong to ACPICA and they should not be used elsewhere.  In addition,
> ACPI_DEBUG_PRINT() requires special enabling to allow it to actually
> print the message, which is a nuisance, and the _COMPONENT symbol
> generally needed for that is not defined in any of the files in
> question.
> 
> For this reason, replace the ACPI_DEBUG_PRINT() in lg-laptop.c with
> pr_debug() and the one in xo15-ebook.c with acpi_handle_debug()
> (with the additional benefit that the source object can be identified
> more easily after this change), and replace the ACPI_EXCEPTION() in
> acer-wmi.c with pr_warn().
> 
> Also drop the ACPI_MODULE_NAME() definitions that are only used by
> the ACPICA message printing macros from those files and from wmi.c
> and surfacepro3_button.c (while at it).
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thank you for your patch for this.

This looks good to me, except that I already fixed the acer-wmi.c case
a couple of weeks ago, and that fiox was merged into Linus' tree already:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ef14f0e82c9b225ae19476fa5bed89d55b2a96d5

I can drop the acer-wmi.c chunks when I merge this, so there is no
need to send out a new version.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/platform/surface/surfacepro3_button.c |    2 --
>  drivers/platform/x86/acer-wmi.c               |    4 ++--
>  drivers/platform/x86/lg-laptop.c              |    2 +-
>  drivers/platform/x86/wmi.c                    |    1 -
>  drivers/platform/x86/xo15-ebook.c             |    6 ++----
>  5 files changed, 5 insertions(+), 10 deletions(-)
> 
> Index: linux-pm/drivers/platform/x86/lg-laptop.c
> ===================================================================
> --- linux-pm.orig/drivers/platform/x86/lg-laptop.c
> +++ linux-pm/drivers/platform/x86/lg-laptop.c
> @@ -678,7 +678,7 @@ static int __init acpi_init(void)
>  
>  	result = acpi_bus_register_driver(&acpi_driver);
>  	if (result < 0) {
> -		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error registering driver\n"));
> +		pr_debug("Error registering driver\n");
>  		return -ENODEV;
>  	}
>  
> Index: linux-pm/drivers/platform/x86/xo15-ebook.c
> ===================================================================
> --- linux-pm.orig/drivers/platform/x86/xo15-ebook.c
> +++ linux-pm/drivers/platform/x86/xo15-ebook.c
> @@ -26,8 +26,6 @@
>  #define XO15_EBOOK_HID			"XO15EBK"
>  #define XO15_EBOOK_DEVICE_NAME		"EBook Switch"
>  
> -ACPI_MODULE_NAME(MODULE_NAME);
> -
>  MODULE_DESCRIPTION("OLPC XO-1.5 ebook switch driver");
>  MODULE_LICENSE("GPL");
>  
> @@ -66,8 +64,8 @@ static void ebook_switch_notify(struct a
>  		ebook_send_state(device);
>  		break;
>  	default:
> -		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> -				  "Unsupported event [0x%x]\n", event));
> +		acpi_handle_debug(device->handle,
> +				  "Unsupported event [0x%x]\n", event);
>  		break;
>  	}
>  }
> Index: linux-pm/drivers/platform/x86/acer-wmi.c
> ===================================================================
> --- linux-pm.orig/drivers/platform/x86/acer-wmi.c
> +++ linux-pm/drivers/platform/x86/acer-wmi.c
> @@ -30,7 +30,6 @@
>  #include <linux/input/sparse-keymap.h>
>  #include <acpi/video.h>
>  
> -ACPI_MODULE_NAME(KBUILD_MODNAME);
>  MODULE_AUTHOR("Carlos Corbacho");
>  MODULE_DESCRIPTION("Acer Laptop WMI Extras Driver");
>  MODULE_LICENSE("GPL");
> @@ -1605,7 +1604,8 @@ static void acer_kbd_dock_get_initial_st
>  
>  	status = wmi_evaluate_method(WMID_GUID3, 0, 0x2, &input_buf, &output_buf);
>  	if (ACPI_FAILURE(status)) {
> -		ACPI_EXCEPTION((AE_INFO, status, "Error getting keyboard-dock initial status"));
> +		pr_warn("Error getting keyboard-dock initial status: %s\n",
> +			acpi_format_exception(status));
>  		return;
>  	}
>  
> Index: linux-pm/drivers/platform/surface/surfacepro3_button.c
> ===================================================================
> --- linux-pm.orig/drivers/platform/surface/surfacepro3_button.c
> +++ linux-pm/drivers/platform/surface/surfacepro3_button.c
> @@ -40,8 +40,6 @@ static const guid_t MSHW0040_DSM_UUID =
>  #define SURFACE_BUTTON_NOTIFY_PRESS_VOLUME_DOWN		0xc2
>  #define SURFACE_BUTTON_NOTIFY_RELEASE_VOLUME_DOWN	0xc3
>  
> -ACPI_MODULE_NAME("surface pro 3 button");
> -
>  MODULE_AUTHOR("Chen Yu");
>  MODULE_DESCRIPTION("Surface Pro3 Button Driver");
>  MODULE_LICENSE("GPL v2");
> Index: linux-pm/drivers/platform/x86/wmi.c
> ===================================================================
> --- linux-pm.orig/drivers/platform/x86/wmi.c
> +++ linux-pm/drivers/platform/x86/wmi.c
> @@ -32,7 +32,6 @@
>  #include <linux/fs.h>
>  #include <uapi/linux/wmi.h>
>  
> -ACPI_MODULE_NAME("wmi");
>  MODULE_AUTHOR("Carlos Corbacho");
>  MODULE_DESCRIPTION("ACPI-WMI Mapping Driver");
>  MODULE_LICENSE("GPL");
> 
> 
> 

