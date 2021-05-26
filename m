Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 915FD3910BD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 08:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbhEZGde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 02:33:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:39957 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232591AbhEZGdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 02:33:32 -0400
IronPort-SDR: GAgX5s0O/nx66Fvl3b/LPwlJl1pEe8Z+f4Y8Xo9dsudCO4o8bknzv+5Pxn4YDRPPB1Y8ha3hM3
 h4xi+EGY6T4A==
X-IronPort-AV: E=McAfee;i="6200,9189,9995"; a="189512086"
X-IronPort-AV: E=Sophos;i="5.82,330,1613462400"; 
   d="scan'208";a="189512086"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 23:32:00 -0700
IronPort-SDR: lyhjnbscqwWOtB2Ue8vR+6xPh+qHKNVBYRF+E0FVbCNPTTo3D5k8xVEJGJaUN+4Dn5KjxSUisO
 TUTImWWgD1Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,330,1613462400"; 
   d="scan'208";a="547077456"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 25 May 2021 23:31:56 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 26 May 2021 09:31:55 +0300
Date:   Wed, 26 May 2021 09:31:55 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Lee Jones <lee.jones@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] usb: roles: add helper usb_role_string()
Message-ID: <YK3rW6NjED+07IdC@kuha.fi.intel.com>
References: <1621932786-9335-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621932786-9335-1-git-send-email-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 04:53:05PM +0800, Chunfeng Yun wrote:
> Introduces usb_role_string() function, which returns a
> human-readable name of provided usb role, it's useful to
> make the log readable.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/roles/class.c | 9 +++++++++
>  include/linux/usb/role.h  | 6 ++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
> index 33b637d0d8d9..dfaed7eee94f 100644
> --- a/drivers/usb/roles/class.c
> +++ b/drivers/usb/roles/class.c
> @@ -214,6 +214,15 @@ static const char * const usb_roles[] = {
>  	[USB_ROLE_DEVICE]	= "device",
>  };
>  
> +const char *usb_role_string(enum usb_role role)
> +{
> +	if (role < 0 || role >= ARRAY_SIZE(usb_roles))
> +		return "unknown";
> +
> +	return usb_roles[role];
> +}
> +EXPORT_SYMBOL_GPL(usb_role_string);
> +
>  static ssize_t
>  role_show(struct device *dev, struct device_attribute *attr, char *buf)
>  {
> diff --git a/include/linux/usb/role.h b/include/linux/usb/role.h
> index 0164fed31b06..031f148ab373 100644
> --- a/include/linux/usb/role.h
> +++ b/include/linux/usb/role.h
> @@ -65,6 +65,7 @@ void usb_role_switch_unregister(struct usb_role_switch *sw);
>  
>  void usb_role_switch_set_drvdata(struct usb_role_switch *sw, void *data);
>  void *usb_role_switch_get_drvdata(struct usb_role_switch *sw);
> +const char *usb_role_string(enum usb_role role);
>  #else
>  static inline int usb_role_switch_set_role(struct usb_role_switch *sw,
>  		enum usb_role role)
> @@ -109,6 +110,11 @@ static inline void *usb_role_switch_get_drvdata(struct usb_role_switch *sw)
>  	return NULL;
>  }
>  
> +static inline const char *usb_role_string(enum usb_role role)
> +{
> +	return "unknown";
> +}
> +
>  #endif
>  
>  #endif /* __LINUX_USB_ROLE_H */
> -- 
> 2.18.0

-- 
heikki
