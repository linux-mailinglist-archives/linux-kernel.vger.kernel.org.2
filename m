Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E2C30CBFF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 20:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239856AbhBBTlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 14:41:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55758 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233000AbhBBNym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 08:54:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612273992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RXWyGsw/g+kXDg92dby3YWd7Rwh1t4c3WfYN8+M0r30=;
        b=MIHUI7O81GwyNxEdCVBH4y98MSMxP5lKTWPEo93MJ5ywb/+igyvo48JvVE8U7uc4SJSvpE
        Dw7exIDg7d1yonE9VyX+GTOlVEYJqmLviLOuUwbqhw/DHflkHPt0WcZ/86ly81QmB7/ulz
        eJsqK06LT1WhfMSjomoMUHXOAwvCyFM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-jG9mQVAIMlCybxm5Qc2THQ-1; Tue, 02 Feb 2021 08:53:11 -0500
X-MC-Unique: jG9mQVAIMlCybxm5Qc2THQ-1
Received: by mail-ed1-f72.google.com with SMTP id i4so3569780edt.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 05:53:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RXWyGsw/g+kXDg92dby3YWd7Rwh1t4c3WfYN8+M0r30=;
        b=UaU6LwL75KRWTtWLY6ACzxv5ALnEf8K72gl/GkhHcAyim/efYP5vxB0Se0+VXK0onO
         q+cg8ThZZCW9c4Ubbz+8wDApP+TUp7Fvixq7HbSvovwgVp8gJ+8bovuyp9IDNDYKr6sE
         /wCCHmoDrjiAfyj0DH6OB1JFGmMMEywe6C1euWUZ/gw0gZaTkBDNEIIEpeZKYuKhr0wu
         G/Xvrlv3Gx1Or5MCiYmZkdSJ9xsURvPmN1vcNLlc8yF/FsngyU3QKff1bcWuiDqYlGVN
         7yXxpXNwAGvR3nS7Wsh3vmWqFNP9FkAQ7XrN8YhMb4qzsA/fXXmTe8PAv4sKsBFmKIMn
         USdg==
X-Gm-Message-State: AOAM531DSmoq3zHRgDxX+IAZWXirgYvIzJMeq4kuXP/p9nwalu4Euz7F
        gUY7L949IU8izmE0M8r4VekrVVQM9EmxfACpQARmmcTlsT2yvqVsW2J5/2KY7NavRTXO9wCqs6r
        bLE7dkwpYr6MnMZW1Uc8YwMQ5
X-Received: by 2002:a05:6402:202a:: with SMTP id ay10mr3009431edb.93.1612273989985;
        Tue, 02 Feb 2021 05:53:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzQDeS/pPYAoLQFBALZHEC5WdFDmOL6+GAB9vty5Ldgr6v4dvAH9SHZ7dAbwCe4h7PJkiF0kQ==
X-Received: by 2002:a05:6402:202a:: with SMTP id ay10mr3009417edb.93.1612273989802;
        Tue, 02 Feb 2021 05:53:09 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id s1sm9640961ejx.25.2021.02.02.05.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 05:53:09 -0800 (PST)
Subject: Re: [PATCH 6/6] xhci: ext-caps: Use software node API with the
 properties
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20210202125032.64982-1-heikki.krogerus@linux.intel.com>
 <20210202125032.64982-7-heikki.krogerus@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9ca885a2-4d42-58d8-3724-52c409eecf05@redhat.com>
Date:   Tue, 2 Feb 2021 14:53:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210202125032.64982-7-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/2/21 1:50 PM, Heikki Krogerus wrote:
> This replaces the platform_device_add_properties() call with
> the safer device_create_managed_software_node() that does
> exactly the same, but can also guarantee that the lifetime
> of the node that is created for the device is tied to the
> lifetime of device itself.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/usb/host/xhci-ext-caps.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-ext-caps.c b/drivers/usb/host/xhci-ext-caps.c
> index 3351d07c431f1..7a4c2c4ad50e8 100644
> --- a/drivers/usb/host/xhci-ext-caps.c
> +++ b/drivers/usb/host/xhci-ext-caps.c
> @@ -54,7 +54,8 @@ static int xhci_create_intel_xhci_sw_pdev(struct xhci_hcd *xhci, u32 cap_offset)
>  	}
>  
>  	if (pci->device == PCI_DEVICE_ID_INTEL_CHERRYVIEW_XHCI) {
> -		ret = platform_device_add_properties(pdev, role_switch_props);
> +		ret = device_create_managed_software_node(&pdev->dev, role_switch_props,
> +							  NULL);
>  		if (ret) {
>  			dev_err(dev, "failed to register device properties\n");
>  			platform_device_put(pdev);
> 

