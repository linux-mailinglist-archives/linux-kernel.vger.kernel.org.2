Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5623956AE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 10:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhEaILQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 04:11:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54395 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230111AbhEaILD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 04:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622448564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vxnQuYD3EHtlcKesWh+gtipSrlYX4BLUcn/92eSQqRY=;
        b=HhMCWT5B7uk4mldUfIXHwhbDJkUm0zNhHTt69FfU5IqregW1Ie9FsHlI+9o966687TneaR
        XfVVnhXoWDEl2j0rkr5KopFQfB5LGKMhR63XX+yIbmjTXuDHJ0O42hGyGZMF0MNn3TQkOx
        +/HBwXMxhDDMMMW6jRji2zcqOM0uAWU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-ZKMSnwnrNCq1ZSCNh4dSHg-1; Mon, 31 May 2021 04:09:22 -0400
X-MC-Unique: ZKMSnwnrNCq1ZSCNh4dSHg-1
Received: by mail-ej1-f72.google.com with SMTP id dp16-20020a170906c150b02903f1e4e947c9so447685ejc.16
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 01:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vxnQuYD3EHtlcKesWh+gtipSrlYX4BLUcn/92eSQqRY=;
        b=S+hp0NGyWljv/it8qoAaT8CEQBjJ2c18+23SNJWOqOSQhG5iOsBNNNlgs9reZkP/BM
         TS4JnUQxtfDdaGaJyjxLwTZ+JD6q8eAwVV11+tsleR9P3hZovWduT4n83kQvzqmspTVe
         AAigpzJWw9pgRAVno4sWQppzmO9QZHuhOsFA6rcR9sNn7+60VlTCNGssyWgBVnzZyUw1
         hR9rM1/jtEK1i4ZBwzXjmy+ZvJ/Ow1f+H8zj9UZmE9FDthP84GxFySORGyrg+BFpjFYe
         hGaEYX3Lx5MrOYRoORzDTfVaBpk5KZ5JzgO5cIuzsGgDOgGEL17s61I3tdLW9MmPh9Vr
         hnjQ==
X-Gm-Message-State: AOAM532h/PdUIG5BXxXLgXnZ1G0fTfwx7C3aLwf3DIfLG0h6RXatGEor
        nn9oD7+4gwQZm0sinYqLP4EJuJngulsDIiM89eDSZxXRrW07xSXC5xSAy7pzDXYqjsguxYyok3R
        fEFmGv18LW9Pn+ojvnT0qvcnoPCd1cWGJ8LF7R3PtRMC5KgTOQcEqDkHPWgT96QTM4O5mFPCcH2
        Zv
X-Received: by 2002:aa7:d844:: with SMTP id f4mr23366163eds.203.1622448561297;
        Mon, 31 May 2021 01:09:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjJw09/l45t71IeTqqLiV2n+cL2pRrJ3J2UK89TAz+Gy6PjoTkuAcGHVk2mGaGGwXUjVK0lw==
X-Received: by 2002:aa7:d844:: with SMTP id f4mr23366147eds.203.1622448561025;
        Mon, 31 May 2021 01:09:21 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id t14sm6512751edv.27.2021.05.31.01.09.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 01:09:20 -0700 (PDT)
Subject: Re: [PATCH 1/2] usb: typec: mux: Use device type instead of device
 name for matching
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Li Jun <jun.li@nxp.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210526153548.61276-1-heikki.krogerus@linux.intel.com>
 <20210526153548.61276-2-heikki.krogerus@linux.intel.com>
 <YLSQkynoJO2+hYGW@kuha.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <48e89766-42d0-ce04-53bf-2195a7479296@redhat.com>
Date:   Mon, 31 May 2021 10:09:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YLSQkynoJO2+hYGW@kuha.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/31/21 9:30 AM, Heikki Krogerus wrote:
> On Wed, May 26, 2021 at 06:35:47PM +0300, Heikki Krogerus wrote:
>> Both the USB Type-C switch and mux have already a device
>> type defined for them. We can use those types instead of the
>> device name to differentiate the two.
> 
> This should still be OK, right?

I believe so and a dev_type check also seems more robust then
a name-suffix check.

Regards,

Hans


> 
>> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>> ---
>>  drivers/usb/typec/mux.c | 26 ++++++++++----------------
>>  drivers/usb/typec/mux.h |  6 ++++++
>>  2 files changed, 16 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
>> index 8514bec7e1b89..e40a555724fb6 100644
>> --- a/drivers/usb/typec/mux.c
>> +++ b/drivers/usb/typec/mux.c
>> @@ -17,21 +17,12 @@
>>  #include "class.h"
>>  #include "mux.h"
>>  
>> -static bool dev_name_ends_with(struct device *dev, const char *suffix)
>> -{
>> -	const char *name = dev_name(dev);
>> -	const int name_len = strlen(name);
>> -	const int suffix_len = strlen(suffix);
>> -
>> -	if (suffix_len > name_len)
>> -		return false;
>> -
>> -	return strcmp(name + (name_len - suffix_len), suffix) == 0;
>> -}
>> -
>>  static int switch_fwnode_match(struct device *dev, const void *fwnode)
>>  {
>> -	return dev_fwnode(dev) == fwnode && dev_name_ends_with(dev, "-switch");
>> +	if (!is_typec_switch(dev))
>> +		return 0;
>> +
>> +	return dev_fwnode(dev) == fwnode;
>>  }
>>  
>>  static void *typec_switch_match(struct fwnode_handle *fwnode, const char *id,
>> @@ -90,7 +81,7 @@ static void typec_switch_release(struct device *dev)
>>  	kfree(to_typec_switch(dev));
>>  }
>>  
>> -static const struct device_type typec_switch_dev_type = {
>> +const struct device_type typec_switch_dev_type = {
>>  	.name = "orientation_switch",
>>  	.release = typec_switch_release,
>>  };
>> @@ -180,7 +171,10 @@ EXPORT_SYMBOL_GPL(typec_switch_get_drvdata);
>>  
>>  static int mux_fwnode_match(struct device *dev, const void *fwnode)
>>  {
>> -	return dev_fwnode(dev) == fwnode && dev_name_ends_with(dev, "-mux");
>> +	if (!is_typec_mux(dev))
>> +		return 0;
>> +
>> +	return dev_fwnode(dev) == fwnode;
>>  }
>>  
>>  static void *typec_mux_match(struct fwnode_handle *fwnode, const char *id,
>> @@ -295,7 +289,7 @@ static void typec_mux_release(struct device *dev)
>>  	kfree(to_typec_mux(dev));
>>  }
>>  
>> -static const struct device_type typec_mux_dev_type = {
>> +const struct device_type typec_mux_dev_type = {
>>  	.name = "mode_switch",
>>  	.release = typec_mux_release,
>>  };
>> diff --git a/drivers/usb/typec/mux.h b/drivers/usb/typec/mux.h
>> index 4fd9426ee44f6..b1d6e837cb747 100644
>> --- a/drivers/usb/typec/mux.h
>> +++ b/drivers/usb/typec/mux.h
>> @@ -18,4 +18,10 @@ struct typec_mux {
>>  #define to_typec_switch(_dev_) container_of(_dev_, struct typec_switch, dev)
>>  #define to_typec_mux(_dev_) container_of(_dev_, struct typec_mux, dev)
>>  
>> +extern const struct device_type typec_switch_dev_type;
>> +extern const struct device_type typec_mux_dev_type;
>> +
>> +#define is_typec_switch(dev) ((dev)->type == &typec_switch_dev_type)
>> +#define is_typec_mux(dev) ((dev)->type == &typec_mux_dev_type)
>> +
>>  #endif /* __USB_TYPEC_MUX__ */
>> -- 
>> 2.30.2
> 

