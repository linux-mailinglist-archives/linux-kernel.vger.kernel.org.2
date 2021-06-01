Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B49396BF5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 05:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbhFADwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 23:52:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:47714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232515AbhFADwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 23:52:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7157A601FF;
        Tue,  1 Jun 2021 03:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622519452;
        bh=i4cBT7a4126JA9vRrZR4rG3Ja1DCgyAcSgiF2RkUQIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C1EGD2DLmyxVT9kwenq5yLiCNDkFIElFNlZLGjtCtMIEb9fIjhQMmrdKEO8+LCH8q
         Nb/PJquc7yC0LQh6IrnjCHDUV5ghi6JLJd+PuHXnHXzoqLn33e+61wybgFCXgk15Vl
         pXhKaxGVb760lnlnTJBgNqlN0tLePe9U0VaeFUB3+PdLBE1wLM4ZxwgcLEQ0I+BGMC
         alI/qoU7x2oucE9FiuORLUDsYAoDxXZbRbh+eLb+wcmQp410Dj2GHvVbjzT7DTq++d
         zj8aJpWPknk8QCt0QVTdRidyrZ6gKq2AoDGWVj0Ff/3dPc5YU4aCCzNGDTsGR43hPS
         cEy1irijbhxGQ==
Date:   Tue, 1 Jun 2021 11:50:48 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: phy: introduce usb_phy device type with its own
 uevent handler
Message-ID: <20210601035048.GA8818@nchen>
References: <20210531122222.453628-1-grzegorz.jaszczyk@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531122222.453628-1-grzegorz.jaszczyk@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-05-31 14:22:22, Grzegorz Jaszczyk wrote:
> The USB charger type and status was already propagated to userspace
> through kobject_uevent_env during charger notify work. Nevertheless the
> uevent could be lost e.g. because it could be fired at an early kernel
> boot stage, way before udev daemon or any other user-space app was able
> to catch it. Registering uevent hook for introduced usb_phy_dev_type
> will allow to query sysfs 'uevent' file to restore that information at
> any time.
> 
> Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>

Reviewed-by: Peter Chen <peter.chen@kernel.org>

Peter
> ---
>  drivers/usb/phy/phy.c | 55 ++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 47 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/usb/phy/phy.c b/drivers/usb/phy/phy.c
> index b47285f023cf..83ed5089475a 100644
> --- a/drivers/usb/phy/phy.c
> +++ b/drivers/usb/phy/phy.c
> @@ -42,6 +42,12 @@ static const char *const usb_chger_type[] = {
>  	[ACA_TYPE]			= "USB_CHARGER_ACA_TYPE",
>  };
>  
> +static const char *const usb_chger_state[] = {
> +	[USB_CHARGER_DEFAULT]	= "USB_CHARGER_DEFAULT",
> +	[USB_CHARGER_PRESENT]	= "USB_CHARGER_PRESENT",
> +	[USB_CHARGER_ABSENT]	= "USB_CHARGER_ABSENT",
> +};
> +
>  static struct usb_phy *__usb_find_phy(struct list_head *list,
>  	enum usb_phy_type type)
>  {
> @@ -74,6 +80,18 @@ static struct usb_phy *__of_usb_find_phy(struct device_node *node)
>  	return ERR_PTR(-EPROBE_DEFER);
>  }
>  
> +static struct usb_phy *__device_to_usb_phy(struct device *dev)
> +{
> +	struct usb_phy *usb_phy;
> +
> +	list_for_each_entry(usb_phy, &phy_list, head) {
> +		if (usb_phy->dev == dev)
> +			break;
> +	}
> +
> +	return usb_phy;
> +}
> +
>  static void usb_phy_set_default_current(struct usb_phy *usb_phy)
>  {
>  	usb_phy->chg_cur.sdp_min = DEFAULT_SDP_CUR_MIN;
> @@ -105,9 +123,6 @@ static void usb_phy_set_default_current(struct usb_phy *usb_phy)
>  static void usb_phy_notify_charger_work(struct work_struct *work)
>  {
>  	struct usb_phy *usb_phy = container_of(work, struct usb_phy, chg_work);
> -	char uchger_state[50] = { 0 };
> -	char uchger_type[50] = { 0 };
> -	char *envp[] = { uchger_state, uchger_type, NULL };
>  	unsigned int min, max;
>  
>  	switch (usb_phy->chg_state) {
> @@ -115,15 +130,11 @@ static void usb_phy_notify_charger_work(struct work_struct *work)
>  		usb_phy_get_charger_current(usb_phy, &min, &max);
>  
>  		atomic_notifier_call_chain(&usb_phy->notifier, max, usb_phy);
> -		snprintf(uchger_state, ARRAY_SIZE(uchger_state),
> -			 "USB_CHARGER_STATE=%s", "USB_CHARGER_PRESENT");
>  		break;
>  	case USB_CHARGER_ABSENT:
>  		usb_phy_set_default_current(usb_phy);
>  
>  		atomic_notifier_call_chain(&usb_phy->notifier, 0, usb_phy);
> -		snprintf(uchger_state, ARRAY_SIZE(uchger_state),
> -			 "USB_CHARGER_STATE=%s", "USB_CHARGER_ABSENT");
>  		break;
>  	default:
>  		dev_warn(usb_phy->dev, "Unknown USB charger state: %d\n",
> @@ -131,9 +142,30 @@ static void usb_phy_notify_charger_work(struct work_struct *work)
>  		return;
>  	}
>  
> +	kobject_uevent(&usb_phy->dev->kobj, KOBJ_CHANGE);
> +}
> +
> +static int usb_phy_uevent(struct device *dev, struct kobj_uevent_env *env)
> +{
> +	struct usb_phy *usb_phy;
> +	char uchger_state[50] = { 0 };
> +	char uchger_type[50] = { 0 };
> +
> +	usb_phy = __device_to_usb_phy(dev);
> +
> +	snprintf(uchger_state, ARRAY_SIZE(uchger_state),
> +		 "USB_CHARGER_STATE=%s", usb_chger_state[usb_phy->chg_state]);
> +
>  	snprintf(uchger_type, ARRAY_SIZE(uchger_type),
>  		 "USB_CHARGER_TYPE=%s", usb_chger_type[usb_phy->chg_type]);
> -	kobject_uevent_env(&usb_phy->dev->kobj, KOBJ_CHANGE, envp);
> +
> +	if (add_uevent_var(env, uchger_state))
> +		return -ENOMEM;
> +
> +	if (add_uevent_var(env, uchger_type))
> +		return -ENOMEM;
> +
> +	return 0;
>  }
>  
>  static void __usb_phy_get_charger_type(struct usb_phy *usb_phy)
> @@ -661,6 +693,11 @@ int usb_add_phy(struct usb_phy *x, enum usb_phy_type type)
>  }
>  EXPORT_SYMBOL_GPL(usb_add_phy);
>  
> +static struct device_type usb_phy_dev_type = {
> +	.name = "usb_phy",
> +	.uevent = usb_phy_uevent,
> +};
> +
>  /**
>   * usb_add_phy_dev - declare the USB PHY
>   * @x: the USB phy to be used; or NULL
> @@ -684,6 +721,8 @@ int usb_add_phy_dev(struct usb_phy *x)
>  	if (ret)
>  		return ret;
>  
> +	x->dev->type = &usb_phy_dev_type;
> +
>  	ATOMIC_INIT_NOTIFIER_HEAD(&x->notifier);
>  
>  	spin_lock_irqsave(&phy_lock, flags);
> -- 
> 2.29.0
> 

-- 

Thanks,
Peter Chen

