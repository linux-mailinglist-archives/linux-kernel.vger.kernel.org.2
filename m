Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1027D33F907
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 20:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbhCQTUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 15:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbhCQTUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 15:20:22 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD1BC06174A;
        Wed, 17 Mar 2021 12:20:22 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id u198so98126oia.4;
        Wed, 17 Mar 2021 12:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6e6zQc/19HQ6BdWcR/vmHGAZli2nNFcvrmaXF8jJF10=;
        b=cwfVirQEr9MRL+WyBIWLYoxUiRVJjIVIZDWMCYtfg9Gol0AH5HY3DtC2gUCaBN9vmO
         yRVlXzxS/Q24aBKCMFCvI3tKhkdcanXvnDeuqtvmjvDwY4A0dVNHKUw1vcYy4vnK+CuV
         zfz01dRY+0kW2EDYLYBn3vc3+pFUhy0Ns4SxQM4Z3rLcsPk5nc4FavnZEP+RsGgYSmn8
         gqZoxqj4Fe+XuMEKK3sGEeKQQEWMt5A9er0HDkQlb5NWL8i1RJA7qgPKbvY/LtlVouBq
         DOIWVKmb/RtCvNPtcdeeHpfptm6t49rq6ILghBm37ZpGb9GHG8lvTdjely3DY3UikWo4
         6MtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6e6zQc/19HQ6BdWcR/vmHGAZli2nNFcvrmaXF8jJF10=;
        b=fMMN643du4gWUu6FX6pFXQlflsh4o7OH842Q8Lj2ot+9r91S2frLBlpkoWCnp2Mola
         OymZPrLJtTPr4V+K5GtrAQdNLpb5Hi8uEVZhtd4fgCVC7I3ixLCff4+YLsP/OTeeDoJh
         +cJyCsD6AhNe4hxaVL8Cy5z4HuDfqQ7cLnuKRuYRhn2FSvlG+z8Gp86hzPmQqTPi1EkZ
         XsyZlxhT/oDVGyuFpILD50W7Dd/sZZPPJiL2TZ7JZn61j0F+DR+qOHQ0HLllH161814F
         Lj2noXeJzn7yuUcxyj1niX5nqf0YoIbXT1ocbqNnQ15mHrIgay//2tG0PTzpo6Vscrna
         0yBg==
X-Gm-Message-State: AOAM533rqEIxy6wF4QEm+8oX/IFzKsLWmiCjoHzOvqvuZ81eFxI/VoZI
        JRMfJnL38HHuMw2giW5CEQ8YatE30wY=
X-Google-Smtp-Source: ABdhPJyzsIsAvuoUqiNYz4lEipMnUwycQhUu5z3yYyrX1My67JwGmEBwnxiLFYs6pLd+4q16MCp5ig==
X-Received: by 2002:a05:6808:907:: with SMTP id w7mr265501oih.94.1616008821352;
        Wed, 17 Mar 2021 12:20:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 64sm8869760otu.80.2021.03.17.12.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 12:20:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v1] usb: typec: tcpci: Added few missing TCPCI register
 definitions
To:     Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210316221304.391206-1-badhri@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <584010c9-dcb0-853a-8f17-72b3ba3264a1@roeck-us.net>
Date:   Wed, 17 Mar 2021 12:20:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210316221304.391206-1-badhri@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/21 3:13 PM, Badhri Jagan Sridharan wrote:
> This change adds some of the register bit definitions from the TCPCI spec:
> https://www.usb.org/sites/default/files/documents/
> usb-port_controller_specification_rev2.0_v1.0_0.pdf
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/usb/typec/tcpm/tcpci.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
> index 57b6e24e0a0c..2be7a77d400e 100644
> --- a/drivers/usb/typec/tcpm/tcpci.h
> +++ b/drivers/usb/typec/tcpm/tcpci.h
> @@ -47,7 +47,10 @@
>  
>  #define TCPC_TCPC_CTRL			0x19
>  #define TCPC_TCPC_CTRL_ORIENTATION	BIT(0)
> +#define PLUG_ORNT_CC1			0
> +#define PLUG_ORNT_CC2			1
>  #define TCPC_TCPC_CTRL_BIST_TM		BIT(1)
> +#define TCPC_TCPC_CTRL_EN_LK4CONN_ALRT	BIT(6)
>  
>  #define TCPC_EXTENDED_STATUS		0x20
>  #define TCPC_EXTENDED_STATUS_VSAFE0V	BIT(0)
> @@ -74,21 +77,28 @@
>  #define TCPC_POWER_CTRL_VCONN_ENABLE	BIT(0)
>  #define TCPC_POWER_CTRL_BLEED_DISCHARGE	BIT(3)
>  #define TCPC_POWER_CTRL_AUTO_DISCHARGE	BIT(4)
> +#define TCPC_DIS_VOLT_ALRM		BIT(5)
> +#define TCPC_POWER_CTRL_VBUS_VOLT_MON	BIT(6)
>  #define TCPC_FAST_ROLE_SWAP_EN		BIT(7)
>  
>  #define TCPC_CC_STATUS			0x1d
>  #define TCPC_CC_STATUS_TOGGLING		BIT(5)
>  #define TCPC_CC_STATUS_TERM		BIT(4)
> +#define TCPC_CC_STATUS_TERM_RP		0
> +#define TCPC_CC_STATUS_TERM_RD		1
> +#define TCPC_CC_STATE_SRC_OPEN		0
>  #define TCPC_CC_STATUS_CC2_SHIFT	2
>  #define TCPC_CC_STATUS_CC2_MASK		0x3
>  #define TCPC_CC_STATUS_CC1_SHIFT	0
>  #define TCPC_CC_STATUS_CC1_MASK		0x3
>  
>  #define TCPC_POWER_STATUS		0x1e
> +#define TCPC_POWER_STATUS_DBG_ACC_CON	BIT(7)
>  #define TCPC_POWER_STATUS_UNINIT	BIT(6)
>  #define TCPC_POWER_STATUS_SOURCING_VBUS	BIT(4)
>  #define TCPC_POWER_STATUS_VBUS_DET	BIT(3)
>  #define TCPC_POWER_STATUS_VBUS_PRES	BIT(2)
> +#define TCPC_POWER_STATUS_SINKING_VBUS	BIT(0)
>  
>  #define TCPC_FAULT_STATUS		0x1f
>  
> @@ -121,6 +131,10 @@
>  #define TCPC_RX_DETECT			0x2f
>  #define TCPC_RX_DETECT_HARD_RESET	BIT(5)
>  #define TCPC_RX_DETECT_SOP		BIT(0)
> +#define TCPC_RX_DETECT_SOP1		BIT(1)
> +#define TCPC_RX_DETECT_SOP2		BIT(2)
> +#define TCPC_RX_DETECT_DBG1		BIT(3)
> +#define TCPC_RX_DETECT_DBG2		BIT(4)
>  
>  #define TCPC_RX_BYTE_CNT		0x30
>  #define TCPC_RX_BUF_FRAME_TYPE		0x31
> @@ -139,6 +153,8 @@
>  #define TCPC_TX_DATA			0x54 /* through 0x6f */
>  
>  #define TCPC_VBUS_VOLTAGE			0x70
> +#define TCPC_VBUS_VOLTAGE_MASK			0x3ff
> +#define TCPC_VBUS_VOLTAGE_LSB_MV		25
>  #define TCPC_VBUS_SINK_DISCONNECT_THRESH	0x72
>  #define TCPC_VBUS_SINK_DISCONNECT_THRESH_LSB_MV	25
>  #define TCPC_VBUS_SINK_DISCONNECT_THRESH_MAX	0x3ff
> 

