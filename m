Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98068389626
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 21:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbhESTGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 15:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbhESTGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 15:06:24 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DF6C06175F;
        Wed, 19 May 2021 12:05:04 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id k4so2715203qkd.0;
        Wed, 19 May 2021 12:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/Sti41iyLVrlU2n6ZSPC8mSP6YPcl5tF0AUrVMAmpAw=;
        b=VEcmRVIh2d2u+1BC9LAKIrkIR/tTzh0E0ceIDcWUQhEBLvSNlqcHMXXy6bN38nFqIq
         0iTM0EnUb4ZTUm6pinFP4keyzXNi2ci1dADUUOryl3U7NH1UH2bUSHOa8zoI0CZdKyq4
         lS6Kb878MC9HAcHjGV8Q4WxTSfyMUqoMjoxva8611f6J2B5WjIHjh25hvaie8xop881G
         8CA8LPCq/1S+YWXpV2SnLyKKl8YZJyr9g34hGWd3/BM3X0KZ8e8Kh/qs6pVRJX7qfRBh
         xrTwm3cRvL01jGiZ5ij7bqoZ0F93NkfnwjdOfB3C64zgwoSvi94GwQbhqly0SqJrQKmA
         ZcOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/Sti41iyLVrlU2n6ZSPC8mSP6YPcl5tF0AUrVMAmpAw=;
        b=kalvKw1HsuWh2ayWQ7r1z8MmRycJKiMj7PrBCCPUMKyQsKvLOFlOXKxAiC92zil3by
         tr1fOReKhlZkfKFBuEEgW+8ovoFISokoPyvW24LgRhyVcXuDPkIS8K/3ekvjqdWD3EvA
         8E1hlDg7xzopkiPTGaBtYaG8rRcZdXCEOmDRUaDFK+68K2IMDypT84Ih2zW0UKQs2+hz
         M4F3uOdLoKTe3Wwzgbd8D7i6euqjLu0LAU4ME+TEG89dIBMt1qLGRzZBPaHrn5y0PDOq
         VW3vCJvfuWxHgGuBPrciRGq90rhCBFlrRglUwfY+wCeghk4dPxxkTS/QjbryMhcCPy1P
         uL/g==
X-Gm-Message-State: AOAM531m9AI8Jqhu0lH1xTIDMKPxndvR/EU3axVAsmf7L9WODAlMhfrF
        SRaZ9abdjg5M7tMuOCUvBK8=
X-Google-Smtp-Source: ABdhPJwvAZDiUwD3wNz9OlFdnDD8+m5zjnwbT89+9ZJSaMeQt9Ye5i/PJXLb5vXrmCj2pBYq6syPEw==
X-Received: by 2002:a05:620a:2947:: with SMTP id n7mr1023748qkp.450.1621451103238;
        Wed, 19 May 2021 12:05:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n21sm423836qka.114.2021.05.19.12.05.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 12:05:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2 1/1] usb: typec: tcpm: Use LE to CPU conversion when
 accessing msg->header
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
References: <20210519100358.64018-1-andriy.shevchenko@linux.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <fe2d34aa-46bc-61c6-e2b4-4fe9f63cf86e@roeck-us.net>
Date:   Wed, 19 May 2021 12:05:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210519100358.64018-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/21 3:03 AM, Andy Shevchenko wrote:
> Sparse is not happy about strict type handling:
>    .../typec/tcpm/tcpm.c:2720:27: warning: restricted __le16 degrades to integer
>    .../typec/tcpm/tcpm.c:2814:32: warning: restricted __le16 degrades to integer
> 
> Fix this by converting LE to CPU before use.
> 
> Fixes: ae8a2ca8a221 ("usb: typec: Group all TCPCI/TCPM code together")
> Fixes: 64f7c494a3c0 ("typec: tcpm: Add support for sink PPS related messages")
> Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v2: fixed subject prefix
>   drivers/usb/typec/tcpm/tcpm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 64133e586c64..8fdfd7f65ad7 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -2717,7 +2717,7 @@ static void tcpm_pd_ext_msg_request(struct tcpm_port *port,
>   	enum pd_ext_msg_type type = pd_header_type_le(msg->header);
>   	unsigned int data_size = pd_ext_header_data_size_le(msg->ext_msg.header);
>   
> -	if (!(msg->ext_msg.header & PD_EXT_HDR_CHUNKED)) {
> +	if (!(le16_to_cpu(msg->ext_msg.header) & PD_EXT_HDR_CHUNKED)) {
>   		tcpm_pd_handle_msg(port, PD_MSG_CTRL_NOT_SUPP, NONE_AMS);
>   		tcpm_log(port, "Unchunked extended messages unsupported");
>   		return;
> @@ -2811,7 +2811,7 @@ static void tcpm_pd_rx_handler(struct kthread_work *work)
>   				 "Data role mismatch, initiating error recovery");
>   			tcpm_set_state(port, ERROR_RECOVERY, 0);
>   		} else {
> -			if (msg->header & PD_HEADER_EXT_HDR)
> +			if (le16_to_cpu(msg->header) & PD_HEADER_EXT_HDR)
>   				tcpm_pd_ext_msg_request(port, msg);
>   			else if (cnt)
>   				tcpm_pd_data_request(port, msg);
> 

