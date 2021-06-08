Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F9739F271
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 11:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhFHJdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 05:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhFHJdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 05:33:49 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A51C061574;
        Tue,  8 Jun 2021 02:31:56 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id r14so6955478ljd.10;
        Tue, 08 Jun 2021 02:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0nP0gHTe3x9dAdv/JFwqsfNFClBUXlKdSohrAmZVKnU=;
        b=eeCPim92wu2BCXwdt2pnN6t8X7cDLh9Pm1NYGYdr8AuLW1/HVnjqseyjbMFYujURRK
         PEV0ckxktSm6QKfp/WZamYOH7IUGadjjRR1pivqp1lZrZEVM7JFaNeG7XqayN7hQSLDA
         V4i/iJy2sQXe0FHzPdNhkzQ5hkgV7q4VyRlZJAsjOB/RaU/4AGNmNj/pCkkvU6RthoLb
         33S952Du/X1HPAh6TO+cp8+IH7rHwcewnOc/976EZBznL5/xK17ekHC6aOw/mNUW0NxV
         4WxgQWEmIImA2MdaNPD1ICd4Ob0F0uLG0hFOE9HYIU5c2USsJG0mPHeOk5YcQUOAIGNg
         ar4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0nP0gHTe3x9dAdv/JFwqsfNFClBUXlKdSohrAmZVKnU=;
        b=Mww55pp0zVO5dM3rXvFIFHKqTPn7AL5HcCDsUVW7bT+CzqJ9BPR/2xl2f2A0vP5/0N
         v+C+s0vVgh89lDRiPG5cKvuwawPzW46rMNJvAy3fE3Jx6bMM2js1eFVXUZpI0HPZn1O6
         nkUz53yLJamHDVkYvj/O2R4QM5hh9j/aGSc3P3uDW5jVT7QVZQW+90NRljxJFDO/Av3R
         BdkRbxYJNpjTu2W7VdULyQDz3WdV6FvNtmZa92ek8lrKGSs3Sz5EUrhrBzWWMIjJ5Z0T
         q7DG+ONi+RpDHvkpcdLUpkAlLsA/F33kyEzToFPFMVuyr77IxDib8/2ftFUIUjAntjce
         yhOg==
X-Gm-Message-State: AOAM532XZ2d4AJd7oOAE4nw9Wdjh743gRlLsAYbtbszTfPm2JZAT79AH
        PjV0MTHmC4SXrgkbpPgU6b6LGeh8/5g=
X-Google-Smtp-Source: ABdhPJyNZGwUNhTSVXWJ3tJgGiyLbGfqFYX4bpwnrtRReKqqpn491eLOT3L8gRGncb5l6wzL4ndDJQ==
X-Received: by 2002:a2e:97c9:: with SMTP id m9mr11980520ljj.186.1623144714659;
        Tue, 08 Jun 2021 02:31:54 -0700 (PDT)
Received: from [192.168.1.100] ([31.173.86.68])
        by smtp.gmail.com with ESMTPSA id p36sm1825153lfa.227.2021.06.08.02.31.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 02:31:54 -0700 (PDT)
Subject: Re: [RFC PATCH 2/7] usb: typec: ucsi: Don't stop alt mode
 registration on busy condition
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Benjamin Berg <bberg@redhat.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210607131442.20121-1-heikki.krogerus@linux.intel.com>
 <20210607131442.20121-3-heikki.krogerus@linux.intel.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <2f4bf248-cd27-623d-5984-fafa931404fa@gmail.com>
Date:   Tue, 8 Jun 2021 12:31:45 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210607131442.20121-3-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 07.06.2021 16:14, Heikki Krogerus wrote:

> If the PPM tells it's busy, we can now simply try again.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>   drivers/usb/typec/ucsi/ucsi.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 366c8a468bc18..a8e0e31dcddf5 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -437,8 +437,11 @@ static int ucsi_register_altmodes(struct ucsi_connector *con, u8 recipient)
>   		command |= UCSI_GET_ALTMODE_CONNECTOR_NUMBER(con->num);
>   		command |= UCSI_GET_ALTMODE_OFFSET(i);
>   		len = ucsi_send_command(con->ucsi, command, alt, sizeof(alt));

    Could insert your check here, to reduce the indentation...

> -		if (len <= 0)
> +		if (len <= 0) {
> +			if (len == -EBUSY)
> +				continue;
>   			return len;
> +		}
>   
>   		/*
>   		 * This code is requesting one alt mode at a time, but some PPMs

MBR, Sergei
