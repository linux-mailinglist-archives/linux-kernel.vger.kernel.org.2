Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01EA309888
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 22:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbhA3VpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 16:45:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46441 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230360AbhA3VpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 16:45:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612043027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KY38Yv3dX+Efk7Jch8wqw9QHlMFgj63ZWy69oyr9HzE=;
        b=JkF2iYzmiCzpqY+uwOkMKF2YJpGGkGIafksWn+rLC28feeueObnWix4paTdIn2fvOAEigs
        kBX6cjvd1rruTjimPJPo63aOH77y1Ar3PlHEBm7LIDxtXMh9E1ExKZlAh2ebSuu2lagU/o
        s87bUeoTkuebMYq+csYWh/iO9h7ZIpE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-aMIfstknPoujNJaYNIRQdw-1; Sat, 30 Jan 2021 16:43:45 -0500
X-MC-Unique: aMIfstknPoujNJaYNIRQdw-1
Received: by mail-ej1-f72.google.com with SMTP id le12so5926390ejb.13
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 13:43:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KY38Yv3dX+Efk7Jch8wqw9QHlMFgj63ZWy69oyr9HzE=;
        b=EVF2G9tp5YJl91D9ePtfNRp7Y85OlzA9aLlJhxLvAwQTBJhBneYrjLwPszB4FsLidf
         EUI2I5beqSC8cwI7ddy0wLh0TfD8W75Bx3wCtXlam2+iECc9hVDaZB3NnLxnmyRyeF5/
         UA6V2Am8B0Ct2VKvtVIeDnVDUXAt0X46WzBAj0cgUqCCPlYTXdsfKPyO6mqbqFtcO4wZ
         4Cyb5/7TaWLD0KG0ewiE0rd9Xw2hhOHabwWsBb8gJ+33KlvUBPXlQuB6a7xIJbzGKYgb
         IoAgIrBn+VEsC97Ad0BIxTWr2FpONR8OesQYqL6D7JFDo2+V9EYK9av1Zxy6pE68Hhh7
         SHrQ==
X-Gm-Message-State: AOAM532buMyPS5n2JCZ91TlEcYLZ4OPlruYZH2oYAcomLtN+lbKhEpZm
        IblIwJBivvN+SqwK8ktn4hdMtrJpKFU1lPk8xjglbDBUvDmnqUajg1w5rxn4aisX06leSzek6gm
        +nLgNBAJ29RmIzRCdtPUmJYjG
X-Received: by 2002:a17:907:1b27:: with SMTP id mp39mr10545765ejc.519.1612043024223;
        Sat, 30 Jan 2021 13:43:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyg+51j/F9EnIRu2VdUBTmnDBB1pmKAFdYpf71MvO6TWqpL5hIeu9lRUlVRlh/pPZAHQgoCNw==
X-Received: by 2002:a17:907:1b27:: with SMTP id mp39mr10545757ejc.519.1612043024068;
        Sat, 30 Jan 2021 13:43:44 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id n27sm5805415eje.29.2021.01.30.13.43.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Jan 2021 13:43:43 -0800 (PST)
Subject: Re: [PATCH] platform/x86: dell-wmi-sysman: fix a NULL pointer
 dereference
To:     Mario Limonciello <mario.limonciello@dell.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
References: <20210129172654.2326751-1-mario.limonciello@dell.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <0da9ca30-53b1-8d34-4fc7-62edb6423b26@redhat.com>
Date:   Sat, 30 Jan 2021 22:43:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210129172654.2326751-1-mario.limonciello@dell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/29/21 6:26 PM, Mario Limonciello wrote:
> An upcoming Dell platform is causing a NULL pointer dereference
> in dell-wmi-sysman initialization.  Validate that the input from
> BIOS matches correct ACPI types and abort module initialization
> if it fails.
> 
> This leads to a memory leak that needs to be cleaned up properly.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> ---
>  drivers/platform/x86/dell-wmi-sysman/sysman.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell-wmi-sysman/sysman.c
> index dc6dd531c996..38b497991071 100644
> --- a/drivers/platform/x86/dell-wmi-sysman/sysman.c
> +++ b/drivers/platform/x86/dell-wmi-sysman/sysman.c
> @@ -419,13 +419,19 @@ static int init_bios_attributes(int attr_type, const char *guid)
>  		return retval;
>  	/* need to use specific instance_id and guid combination to get right data */
>  	obj = get_wmiobj_pointer(instance_id, guid);
> -	if (!obj)
> +	if (!obj || obj->type != ACPI_TYPE_PACKAGE) {
> +		release_attributes_data();

All calls of  init_bios_attributes() have the following error handling:

        ret = init_bios_attributes(INT, DELL_WMI_BIOS_INTEGER_ATTRIBUTE_GUID);
        if (ret) {
                pr_debug("failed to populate integer type attributes\n");
                goto fail_create_group;
        }

	...

fail_create_group:
        release_attributes_data();

So that added release_attributes_data() call is not necessary. If you can respin
this patch Monday with the release_attributes_data(); addition dropped, then
I will try to get this to Linus in time for 5.11 .

Or I can fix this up locally if you agree with dropping the unnecessary
release_attributes_data() call.

Regards,

Hans




>  		return -ENODEV;
> +	}
>  	elements = obj->package.elements;
>  
>  	mutex_lock(&wmi_priv.mutex);
>  	while (elements) {
>  		/* sanity checking */
> +		if (elements[ATTR_NAME].type != ACPI_TYPE_STRING) {
> +			pr_debug("incorrect element type\n");
> +			goto nextobj;
> +		}
>  		if (strlen(elements[ATTR_NAME].string.pointer) == 0) {
>  			pr_debug("empty attribute found\n");
>  			goto nextobj;
> 

