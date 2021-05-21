Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858E738C97F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 16:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237089AbhEUOuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 10:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbhEUOuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 10:50:12 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D66C061574;
        Fri, 21 May 2021 07:48:49 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id x15so19824765oic.13;
        Fri, 21 May 2021 07:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=208ZZBKRifYnxuxMP2w4ve9AZ2rMPAavL1VC++KA8QE=;
        b=cCYGWy3Ny94d9ovau1vmRsJgV9GEsxt4ifEeTgu912X9alBGmjgcYt2CIm/cv0rpJk
         WhKh35/48ADp712mreQ/qTrCqdnE4VlEm4y2rmwUTauI24KpSShQnU8YotRrznV+rdEy
         WJE295fsqzSuXBRlAgbGpEFCiaNgLjhOsh3E9qKgtZLrFwflTXy5LhAOvWNK+0n/IKz6
         yfOMxkzfCTaq6QVWniJQXDgN7uDkNxIcWhsmacLPOH+xYwBmO6Jcd7yqsJd6ge9Y+52r
         IhceRVinSKvgmem8/RyJtnqN65hkTKUUAxiNVBq5u/SMOPG8LzL+bMFk+kGtuwBsmwR+
         G8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=208ZZBKRifYnxuxMP2w4ve9AZ2rMPAavL1VC++KA8QE=;
        b=WWswknnLCTcK7dTAz0JBPjB2jYiu7inWkIh/nxkZaPXQ7MgBubCc99ZmasCdz+ux5+
         fvnxM88M1jZzNZpAkT+njD6/FM3KQ3haaFdl8yjaZJd1hX1lTpPL+0KMIsFvaKZbOQ4L
         1X5eg8dLK8cCN3BvPXC8/EKMy/JIehfO56JS4XTaHiaJP3w0AM8kQUksFGeNXU8O4Doo
         FMSIu92k9dYXYigFDymqTM44Cj92ARSxQOxo02NlRG2g9sV2F/y4uSc51bnltkOFyJ9m
         QnxGv4LoCli+MAb5rUcNDkScVYBlnAw6jeuWBZcy05/B1MwUA0K8wqxt0mCzNZvTrPZQ
         KXWw==
X-Gm-Message-State: AOAM531W0FTZ+kmUr1WixQxpumT9iTrcoVQdvVh3KxtLiyv/J2l1ok6s
        c72r92EujTa3LhljzyHJbmMa4Ctap+Y=
X-Google-Smtp-Source: ABdhPJxwNb/wwSFo32fLx/qIXKnHktLoRFguHQZx0wUgYdh66ESuc3Wo1Kx2IhPnbFrgxwMz3HqSqQ==
X-Received: by 2002:a54:4183:: with SMTP id 3mr2465968oiy.165.1621608528617;
        Fri, 21 May 2021 07:48:48 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a12sm1328594oti.12.2021.05.21.07.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 07:48:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 2/2] usb: typec: tcpm: Respond Not_Supported if no snk_vdo
To:     Kyle Tso <kyletso@google.com>, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210521130121.1470334-1-kyletso@google.com>
 <20210521130121.1470334-3-kyletso@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <b3466420-f062-51d6-2d00-73078a2e4d7b@roeck-us.net>
Date:   Fri, 21 May 2021 07:48:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210521130121.1470334-3-kyletso@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/21 6:01 AM, Kyle Tso wrote:
> If snk_vdo is not populated from fwnode, it implies the port does not
> support responding to SVDM commands. Not_Supported Message shall be sent
> if the contract is in PD3. And for PD2, the port shall ignore the
> commands.
> 
> Fixes: 193a68011fdc ("staging: typec: tcpm: Respond to Discover Identity commands")
> Signed-off-by: Kyle Tso <kyletso@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/usb/typec/tcpm/tcpm.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index deb8a9d01f73..d32caa875d9a 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -2430,7 +2430,10 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
>   					   NONE_AMS);
>   		break;
>   	case PD_DATA_VENDOR_DEF:
> -		tcpm_handle_vdm_request(port, msg->payload, cnt);
> +		if (tcpm_vdm_ams(port) || port->nr_snk_vdo)
> +			tcpm_handle_vdm_request(port, msg->payload, cnt);
> +		else if (port->negotiated_rev > PD_REV20)
> +			tcpm_pd_handle_msg(port, PD_MSG_CTRL_NOT_SUPP, NONE_AMS);
>   		break;
>   	case PD_DATA_BIST:
>   		port->bist_request = le32_to_cpu(msg->payload[0]);
> 

