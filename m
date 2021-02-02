Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C7B30B610
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 04:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhBBDuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 22:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhBBDuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 22:50:52 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DE8C061573;
        Mon,  1 Feb 2021 19:50:11 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id d7so18581871otf.3;
        Mon, 01 Feb 2021 19:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZiG3XSt87tKKrBLxDBFRea47rgLwRZ/reOz1DPML+5M=;
        b=CADpQSwy8cziyz9TdzThmkA4XYJPlSIg65yjOjDG6b+U9mMzVqXJ9hKfu5MurWjM8b
         Ljeg0vEF73jIqLhFaIOpU2rIaFZyLh4CcO9kEWTO5v3tPhZRI2bwdwDL9WzxLsnZ4H45
         dRITN9CiKlmXOZJVbJFsPeUkdghcv9z52OFPRdqqCaR+GSAG/wu/kfmI4SjReeDy5dWQ
         ZWZQlIzO6bTUpFU9D/59qf5P5P1FLo3HfQCAini7/K9ZQ+LiqcAJSQcEPYctl7d6CQM4
         X8+a0tKVuuyhtqbhtk1fJjH6u/EJRR6PQBxH8GnCcCLGYMtD7sybRci5i0TDbGN0rQ4S
         7gAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ZiG3XSt87tKKrBLxDBFRea47rgLwRZ/reOz1DPML+5M=;
        b=doAQE7TK18aqDwYBpBzIh/J5gbGB17O/mrCSet0+Y0/gdSL4u+LDqqpAFXakYmg1zl
         tm/u5CQkJS1DF/OehrRvZzh3jeN7v+yid7FdpTR5kCiHuQjfnrEPndV+SRHGr0HgPSpG
         VUVmUxHcSb7pg/8Vp7DlasQU0BsQWRoszyk4gHHtNKR2R4xO3cUfuH2pxxA/GjJRXdbT
         nBs9F7iftQpQhtBTXBz+8osqcaos9Dy6bRXgSATtZCp86jFEdT4EQWbnCLhO1hvvgBxn
         0p7bxnKTt/qbLzhk9p9qc1f3uxb8VMcCNJ0Xy6z2B/Wq4ZthaWe+j+Wo1qkXfYtqtx3L
         kJAQ==
X-Gm-Message-State: AOAM53013i1qsqqUlJP8SBpil2Sg9FlAZ7ZIU0VlFMCZMUDx8/qs8aKr
        uf0/0yKMy9P6VEdpiQWQl+KwmAyd09M=
X-Google-Smtp-Source: ABdhPJxQHfw7sL9wF0vf8jdC6gS4RcjD1EF311h9w+IkvoGNN75ihdN5e1YQj4MD40JI9noOM9zO/Q==
X-Received: by 2002:a05:6830:1db8:: with SMTP id z24mr14050382oti.50.1612237810767;
        Mon, 01 Feb 2021 19:50:10 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i9sm4828504oii.34.2021.02.01.19.50.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 19:50:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v1] usb: typec: tcpm: Set in_ams flag when Source caps
 have been received
To:     Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyle Tso <kyletso@google.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210202033859.258491-1-badhri@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <34b809a3-da3c-6165-2ed9-5678944f8413@roeck-us.net>
Date:   Mon, 1 Feb 2021 19:50:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210202033859.258491-1-badhri@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/21 7:38 PM, Badhri Jagan Sridharan wrote:
> Receiving the first packet in an AMS sequence signals the
> beginning of AMS. Set in_ams flag to true when SRC_CAPS are
> received during POWER_NEGOTIATION AMS.
> This fixes the failure flagged while running TD.PD.SNK.E9
> compliance test.
> 
>>From Deterministic PD compliance MOI spec:
> TD.PD.SNK.E9. GetSinkCap in Place of Accept
> Description:
> As Provider, the Tester intentionally sends a GetSinkCap message in place
> of Accept message and verifies the UUT will send a SoftReset and recover
> from the error.
> Steps:
> a) Run PROC.PD.E1 Bring-up according to the UUT role.
> b) The Tester cycles VBus.
> c) The Tester sends a Source Capabilities message to the UUT.
> d) Upon receipt of a Request message from the UUT, the Tester replies with
>    a GoodCRC message.
> e) The Tester sends a GetSinkCap message to the UUT.
> f) If a SoftReset is not received within 15 ms after the GetSinkCap EOP was
>    sent, the test fails.
> g) If a SoftReset is received timely, the Tester replies with an Accept
>    message.
> h) The Tester sends Source Capabilities message to the UUT repeatedly until
>    nCapsCount reached or a GoodCRC is received. If nCapsCount reached, the
>    test fails.
> i) If a Request is not received timely within 30 ms after the GoodCRC EOP
>    corresponding to Source Capabilities message was received, the test
>    fails.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 0afd8ef692e8..b3e07d9b7597 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -2243,6 +2243,7 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
>  		 * handled.
>  		 */
>  			port->ams = POWER_NEGOTIATION;
> +			port->in_ams = true;
>  			tcpm_set_state(port, SNK_NEGOTIATE_CAPABILITIES, 0);
>  		} else {
>  			if (port->ams == GET_SOURCE_CAPABILITIES)
> 

