Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 433693504DC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 18:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbhCaQmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 12:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbhCaQl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 12:41:26 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F1FC061574;
        Wed, 31 Mar 2021 09:41:25 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id n140so20587136oig.9;
        Wed, 31 Mar 2021 09:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mVhSVBF1vh56E8yvJoKpeQSChQSpdEi9lBFjUoFTP/0=;
        b=FNQOePFFHxbO2gMENUR/9GpA44eRlFZxqrBemMiUar88kRFWzME41+Q2SuBoDGUDw+
         LujxUcl+LlNk8JNWqiSMGzXPqDtHB5KeBwthW1uzQbZncQ2QGFSFOHNSzuE9F0oaSWQa
         /7l3i/b6Vizq9k65v1AMtuPzPq6IS1LcxSdGZmm4aZul8LxfpHaDfaOzagzPhOLUHsgI
         vkj2iLvO+wkrG9HcTa4bZ/wsWWHkWYWjVvJJQ2mdZsdye8Qq7xn3KnQfrNUU5y7/2MyE
         +2L/qebMwy9IaiZEmAahtOBLEzxCjqcDTuz0rwa+tMiZcwk0ZONquOHYHRzI3g+9QK+l
         Aw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mVhSVBF1vh56E8yvJoKpeQSChQSpdEi9lBFjUoFTP/0=;
        b=DwuJyrjurNzRrJbz1GfVIOzeN4juOMAhP2GnB4nwUZJlHWOd2Ag3TZ+QtTS08o89Ik
         r8gSbKazTnEgZuUK3sNa49qcK1kRkOLXYbOcW7jHEA4ZX1oaL348QJGAB0eETR6PBteO
         k28jLavnvVeCb4rlAh8JK6oP1l35zn7zb0LkVS2hJWdtDb1WO0VG8/pkLf2qZDaz+jp6
         npHucJh9JAe+BvOTvnF08zKItlCKrbqz6rgw0UbtwJRd8xck5rQaq6nhV+hmnHHLJs/x
         Yg1B8QhjswYbIHJXNiJ94C75Ei9AsibAvsfZoQErHqJQEADcHyZKI1ygY7Lg4VWAv//n
         KwgA==
X-Gm-Message-State: AOAM532pfYllq3zimpx2lttiMjfWepySr9VlGHVM9QJ6ntCmTVNX6apa
        Lq1d/OOkofiZ22D3RmBgAEegwdcZJj0=
X-Google-Smtp-Source: ABdhPJwhkM74SWt3zdy9/D/XrKxNBOmUfXw8KazT8tIsweIsf5E/Yl2aLsI0D+K0/VnrdFxBbhArfw==
X-Received: by 2002:a54:488a:: with SMTP id r10mr2920360oic.23.1617208884686;
        Wed, 31 Mar 2021 09:41:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v30sm580362otb.23.2021.03.31.09.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 09:41:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v3 5/6] usb: Iterator for ports
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210331105908.67066-1-heikki.krogerus@linux.intel.com>
 <20210331105908.67066-6-heikki.krogerus@linux.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <7cf8093e-20ab-ab88-5ba1-c2e6128c0480@roeck-us.net>
Date:   Wed, 31 Mar 2021 09:41:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210331105908.67066-6-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/21 3:59 AM, Heikki Krogerus wrote:
> Introducing usb_for_each_port(). It works the same way as
> usb_for_each_dev(), but instead of going through every USB
> device in the system, it walks through the USB ports in the
> system.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> ---
>  drivers/usb/core/usb.c | 46 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/usb.h    |  9 +++++++++
>  2 files changed, 55 insertions(+)
> 
> diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
> index 2ce3667ec6fae..62368c4ed37af 100644
> --- a/drivers/usb/core/usb.c
> +++ b/drivers/usb/core/usb.c
> @@ -398,6 +398,52 @@ int usb_for_each_dev(void *data, int (*fn)(struct usb_device *, void *))
>  }
>  EXPORT_SYMBOL_GPL(usb_for_each_dev);
>  
> +struct each_hub_arg {
> +	void *data;
> +	int (*fn)(struct device *, void *);
> +};
> +
> +static int __each_hub(struct usb_device *hdev, void *data)
> +{
> +	struct each_hub_arg *arg = (struct each_hub_arg *)data;
> +	struct usb_hub *hub;
> +	int ret = 0;
> +	int i;
> +
> +	hub = usb_hub_to_struct_hub(hdev);
> +	if (!hub)
> +		return 0;
> +
> +	mutex_lock(&usb_port_peer_mutex);
> +
> +	for (i = 0; i < hdev->maxchild; i++) {
> +		ret = arg->fn(&hub->ports[i]->dev, arg->data);
> +		if (ret)
> +			break;
> +	}
> +
> +	mutex_unlock(&usb_port_peer_mutex);
> +
> +	return ret;
> +}
> +
> +/**
> + * usb_for_each_port - interate over all USB ports in the system
> + * @data: data pointer that will be handed to the callback function
> + * @fn: callback function to be called for each USB port
> + *
> + * Iterate over all USB ports and call @fn for each, passing it @data. If it
> + * returns anything other than 0, we break the iteration prematurely and return
> + * that value.
> + */
> +int usb_for_each_port(void *data, int (*fn)(struct device *, void *))
> +{
> +	struct each_hub_arg arg = {data, fn};
> +
> +	return usb_for_each_dev(&arg, __each_hub);
> +}
> +EXPORT_SYMBOL_GPL(usb_for_each_port);
> +
>  /**
>   * usb_release_dev - free a usb device structure when all users of it are finished.
>   * @dev: device that's been disconnected
> diff --git a/include/linux/usb.h b/include/linux/usb.h
> index ddd2f5b2a2827..ebcd03d835d04 100644
> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h
> @@ -882,6 +882,15 @@ extern struct usb_host_interface *usb_find_alt_setting(
>  		unsigned int iface_num,
>  		unsigned int alt_num);
>  
> +#ifdef CONFIG_USB

#if IS_ENABLED(CONFIG_USB)

> +int usb_for_each_port(void *data, int (*fn)(struct device *, void *));
> +#else
> +static inline int usb_for_each_port(void *data, int (*fn)(struct device *, void *))
> +{
> +	return 0;
> +}
> +#endif
> +
>  /* port claiming functions */
>  int usb_hub_claim_port(struct usb_device *hdev, unsigned port1,
>  		struct usb_dev_state *owner);
> 

