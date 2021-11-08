Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6217B447ED4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 12:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239231AbhKHL1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 06:27:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31241 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239220AbhKHL1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 06:27:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636370694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d9STRiI6KucgPVBhAUB/ZaQYLqQS9QZpyJnKok3uPOc=;
        b=X2yXPhO8A4E0Axa8oxiLD2GD3MQlmvUL0CDD0R6ktaDSNMCWlJadYXfii9MUWYRouzNBSn
        TyrUyfft/watIqE2MdtFsky3EPD6MV50GvlofHaWxuVly8boQ1d1ZGRIhf9cOC8q+Irrk2
        3eJqULniYifRr8KfPKehacah1ABiXK4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-nXh_RO-sPpO8iwrT8Vzjzw-1; Mon, 08 Nov 2021 06:24:53 -0500
X-MC-Unique: nXh_RO-sPpO8iwrT8Vzjzw-1
Received: by mail-ed1-f71.google.com with SMTP id f20-20020a0564021e9400b003e2ad3eae74so14580774edf.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 03:24:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=d9STRiI6KucgPVBhAUB/ZaQYLqQS9QZpyJnKok3uPOc=;
        b=q0hNm9ZyX3dUwbBqprGw0NrmGBTcKZChpUb6DS9Q3OM4Hf994pBHNQMWUYRaTZfLSV
         qt3fS1xyyfZZbkL5B0JX7mS+GvX3MvFsa+xf6CkAUSxmN8KxzzKW+rFIKvwzvOEHvqpz
         xQv2VjwxEkJ3U6x0w7nd3kx36o5MQOQVH0X2PKjwl6AmkCBjZ4yw1Ky8EL6MukVWZc3p
         SelNCAoLaLur+LWYfr38l4sAiTXR0pdmTlvrlMvSqBDZak/jQUnTOkmYT8t8iYvImZeF
         QSAT/at76YpOrOFOnVAJ0fdwo7cKg6af6vuJRdJF5KuKgs//2ED53pd81mVD5uX0oKPL
         oqEA==
X-Gm-Message-State: AOAM532DAEC/canBlTpu0aB89RfanoIkS86oVA3mT/oKGWk9DZ4px690
        MgfZ2iohX85GsMCi2jTCV7mBX01LjDxNK8cWBXmtBN7gkqcM0DejG9wPzvcUK/Mhn281Lcp4+FF
        YpMLbJyKPqM9gI5nJ7mudHWXR
X-Received: by 2002:a17:907:7f18:: with SMTP id qf24mr55204558ejc.568.1636370692015;
        Mon, 08 Nov 2021 03:24:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQ1Pfgel7h3DuLzHBNGPV5ClhUoEziQRIG7lqu2tiK3KfHXtfnhCqLwPpnzxoZ5sSYfpPKHw==
X-Received: by 2002:a17:907:7f18:: with SMTP id qf24mr55204542ejc.568.1636370691856;
        Mon, 08 Nov 2021 03:24:51 -0800 (PST)
Received: from [10.40.1.223] ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id k23sm9106957edv.22.2021.11.08.03.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 03:24:51 -0800 (PST)
Message-ID: <3e646803-346c-8650-d407-21af3f017366@redhat.com>
Date:   Mon, 8 Nov 2021 12:24:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] usb: typec: fusb302: Fix masking of comparator and
 bc_lvl interrupts
Content-Language: en-US
To:     Ondrej Jirman <megous@megous.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Badhri Jagan Sridharan <badhri@google.com>,
        "open list:USB TYPEC PORT CONTROLLER DRIVERS" 
        <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20211108102833.2793803-1-megous@megous.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211108102833.2793803-1-megous@megous.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/8/21 11:28, Ondrej Jirman wrote:
> The code that enables either BC_LVL or COMP_CHNG interrupt in tcpm_set_cc
> wrongly assumes that the interrupt is unmasked by writing 1 to the apropriate
> bit in the mask register. In fact, interrupts are enabled when the mask
> is 0, so the tcpm_set_cc enables interrupt for COMP_CHNG when it expects
> BC_LVL interrupt to be enabled.
> 
> This causes inability of the driver to recognize cable unplug events
> in host mode (unplug is recognized only via a COMP_CHNG interrupt).
> 
> In device mode this bug was masked by simultaneous triggering of the VBUS
> change interrupt, because of loss of VBUS when the port peer is providing
> power.
> 
> Fixes: 48242e30532b ("usb: typec: fusb302: Revert "Resolve fixed power role contract setup"")
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> Cc: Hans de Goede <hdegoede@redhat.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  drivers/usb/typec/tcpm/fusb302.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> index 7a2a17866a823..72f9001b07921 100644
> --- a/drivers/usb/typec/tcpm/fusb302.c
> +++ b/drivers/usb/typec/tcpm/fusb302.c
> @@ -669,25 +669,27 @@ static int tcpm_set_cc(struct tcpc_dev *dev, enum typec_cc_status cc)
>  		ret = fusb302_i2c_mask_write(chip, FUSB_REG_MASK,
>  					     FUSB_REG_MASK_BC_LVL |
>  					     FUSB_REG_MASK_COMP_CHNG,
> -					     FUSB_REG_MASK_COMP_CHNG);
> +					     FUSB_REG_MASK_BC_LVL);
>  		if (ret < 0) {
>  			fusb302_log(chip, "cannot set SRC interrupt, ret=%d",
>  				    ret);
>  			goto done;
>  		}
>  		chip->intr_comp_chng = true;


> +		chip->intr_bc_lvl = false;

FWIW this is not necessary because the fusb302_set_toggling(chip, TOGGLING_MODE_OFF)
already does this, but it makes the code more clear, so lets keep it.

>  		break;
>  	case TYPEC_CC_RD:
>  		ret = fusb302_i2c_mask_write(chip, FUSB_REG_MASK,
>  					     FUSB_REG_MASK_BC_LVL |
>  					     FUSB_REG_MASK_COMP_CHNG,
> -					     FUSB_REG_MASK_BC_LVL);
> +					     FUSB_REG_MASK_COMP_CHNG);
>  		if (ret < 0) {
>  			fusb302_log(chip, "cannot set SRC interrupt, ret=%d",
>  				    ret);
>  			goto done;
>  		}
>  		chip->intr_bc_lvl = true;


> +		chip->intr_comp_chng = false;

Idem.

>  		break;
>  	default:
>  		break;
> 

Regards,

Hans

