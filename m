Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB62371ECA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 19:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhECRjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 13:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbhECRjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 13:39:35 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2CDC06174A;
        Mon,  3 May 2021 10:38:41 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id g4-20020a9d6b040000b029029debbbb3ecso5807692otp.7;
        Mon, 03 May 2021 10:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RoEpohl42agZ26CA5g3lHocroLmL8wt1UqK06liZcNA=;
        b=jZUZwVcmp0v8n6ktJ4cGl2yH1AsdUWduqqEwJg2y9vjKrjqG6AcmtQ90kVPk0+d5YM
         cZSf/K6Xg+rWUEKqdvs01usDyBEiAj8xHFfrFyqjY+g6xz2xtJ/GAEJBbRS0segh5WW+
         SQ7yMQH2rXIjws/jDEegkJT/Zq4Mor5U1+ow02ne8E0eXO+Em/5oq5Kot9wEd4XJzcUy
         jILr0Ly7rAx/ZWuCPPxSWmE13PdxgTUcQObqz/e3cXoHgkukmAObgFM1mwghByZgqDpA
         Rxz8JKmnkbEvOn2BAcTH+0UyJKiJHp/iXlS2Cx4J32TH01KP7HeMFt9RRU1KvPLdt7Pk
         tljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RoEpohl42agZ26CA5g3lHocroLmL8wt1UqK06liZcNA=;
        b=ZepbC4RgtH3FqAHLPc61hdNWzbZvu4R0bYqJe9jPUc3d5pSD3l7VhcJHTtboBMBVfN
         /UaNHHGguS/j+ctRf6JikK4BSWtmcH5e1oKlPMnFb1WEDzrmGbjCF7qWS83DiwAtIoFT
         CYRWUkzlfvwrmEe3s0NhTLLhK3JdE0OKBfP9DHyFki3itsK0eDnFs5MWk+ElBXPwv+t0
         9nRtd7hhvE2wHVLGv7vDQZ9s66iZeZKbRWefn/jiSgSV0YJvuo/ErjgXDqXKDzuZnjBQ
         LMeypgu8s0wX3KNeTDXGGoQ+KwuIBJzWPaqQKKqi8i6iJE17q3yx8c5Wr6VhZpu2avqq
         LQWg==
X-Gm-Message-State: AOAM5318u3qzyKtYas6Q5CnuWPf/NP28v8TT/aGm229j3/PG8P1t9a1N
        avgfQmPNT1unvQS8RGIDJ5sQEloypuI=
X-Google-Smtp-Source: ABdhPJziDWzV53+SBPSor2x8t7v/amS2+LWM22gAexwPCJVC+bLKLjVFGDyD25EVLX/2BRHPg8T/sQ==
X-Received: by 2002:a9d:2212:: with SMTP id o18mr14555095ota.91.1620063520872;
        Mon, 03 May 2021 10:38:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l13sm109966ota.62.2021.05.03.10.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 10:38:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] usb: typec: tcpm: Fix wrong handling in GET_SINK_CAP
To:     Kyle Tso <kyletso@google.com>, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210503171849.2605302-1-kyletso@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <044df789-6415-d842-9995-179f987d26dc@roeck-us.net>
Date:   Mon, 3 May 2021 10:38:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210503171849.2605302-1-kyletso@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/21 10:18 AM, Kyle Tso wrote:
> After receiving Sink Capabilities Message in GET_SINK_CAP AMS, it is
> incorrect to call tcpm_pd_handle_state because the Message is expected
> and the current state is not Ready states. The result of this incorrect
> operation ends in Soft Reset which is definitely wrong. Simply
> forwarding to Ready States is enough to finish the AMS.
> 
> Fixes: 8dea75e11380 ("usb: typec: tcpm: Protocol Error handling")
> Signed-off-by: Kyle Tso <kyletso@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index c4fdc00a3bc8..68e04e397e92 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -2390,7 +2390,7 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
>  		port->nr_sink_caps = cnt;
>  		port->sink_cap_done = true;
>  		if (port->ams == GET_SINK_CAPABILITIES)
> -			tcpm_pd_handle_state(port, ready_state(port), NONE_AMS, 0);
> +			tcpm_set_state(port, ready_state(port), 0);
>  		/* Unexpected Sink Capabilities */
>  		else
>  			tcpm_pd_handle_msg(port,
> 

