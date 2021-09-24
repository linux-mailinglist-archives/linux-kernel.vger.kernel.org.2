Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965CB4169C4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 04:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243842AbhIXCE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 22:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243792AbhIXCEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 22:04:25 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3841AC061574;
        Thu, 23 Sep 2021 19:02:53 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id r43-20020a05683044ab00b0054716b40005so4286757otv.4;
        Thu, 23 Sep 2021 19:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vb8VHhj5ZR3ApECLbPR2Ms+JdFGgy9RMbESsdYMrHnU=;
        b=AcV7cQmNHVAJ8RDH6Tq6JdR7zsKwzWNCqci8hsPnXIB+fprutIWyfIQ7kMgbxzkF4W
         QepjbDdX+feQLuEYJ8WBgaRxdRJQPbfgCx05WLkpD5bw2rSjx6IMbieD6WM7jbcwUwjE
         T5PC0P22FkM9T5B3ZKNBoK/k/khUTqOa3GRzDjvG8nSBN1Nscvbu120Mvlqxpu9iN3Nq
         /jft5KSVFw22+8zo3rbq9oVSuewPmYbPM2H0hhsQWd4xpPuoV3Cr1vIr64hKX6APL0Xk
         IEiyjpReEMm07xk0w1dujFkHeEQrzcp7GOgS32smxLKecTizeuJpDLLMBi12nM1SXAhq
         nw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=vb8VHhj5ZR3ApECLbPR2Ms+JdFGgy9RMbESsdYMrHnU=;
        b=ZIaA5Gmua17T1NJA2ieVrwPpSTksk/i593O5Gj02DOGi4oT/AchGJQpRG56QLT+GnW
         2mTaqZbJCZRTRObaUm3BX3FoAvSfkf10KVOK5jGCf7TROrQeShuPyicOfldmAzAnkNNh
         73mg6Cvj1+4oMmkoFe1PjNrjPWbktSIrIrxCs/ypxkN4KnMILXUhlQbcrzJhO7+qeIGg
         PtzDTG/kW9U9c45Og+eVenf+lolS5NAnYu1mDkecHIOuLX/vB+5azYBccZjYwzcsIfGI
         0DGrq1gRXjVekXckR+mkDaMF7nDzA6hljteV1+w27o6+6HqGKsjSY5mq2lrP4eDxaghU
         BBqg==
X-Gm-Message-State: AOAM532wQejimy91pPpl6qF+zeZGpoi6cdk+iueLHBoABTSo8GA7sTa4
        rjfWPyziW7JUjfiKJm8J0CK8wJFgZ2c=
X-Google-Smtp-Source: ABdhPJxGfjVj8x4wGq9uVV+kK0ji95Lk7Cz7pJzJFRtiiTvC6TwnhFdqKZjFuy1i9W5mcPG4E2AmVQ==
X-Received: by 2002:a05:6830:3189:: with SMTP id p9mr1645429ots.147.1632448972593;
        Thu, 23 Sep 2021 19:02:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s24sm1791146oic.34.2021.09.23.19.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 19:02:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 23 Sep 2021 19:02:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Daniel Dawson <danielcdawson@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add another customer ID for NCT6683D sensor chip on some
 ASRock boards.
Message-ID: <20210924020250.GA3031547@roeck-us.net>
References: <20210921165859.48714-1-danielcdawson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921165859.48714-1-danielcdawson@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 09:58:59AM -0700, Daniel Dawson wrote:
> This value was found on a Z370M Pro4 rev. 1.01, with an
> NCT6683D-T chip.
> 
> Signed-off-by: Daniel Dawson <danielcdawson@gmail.com>

Applied. In the future, please indicate the subsystem and the affected
driver in the subject line. See other patches for examples.

Thanks,
Guenter

> ---
>  drivers/hwmon/nct6683.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/hwmon/nct6683.c b/drivers/hwmon/nct6683.c
> index 35f8635dc7f3..6a9f420e7d32 100644
> --- a/drivers/hwmon/nct6683.c
> +++ b/drivers/hwmon/nct6683.c
> @@ -174,6 +174,7 @@ superio_exit(int ioreg)
>  #define NCT6683_CUSTOMER_ID_MITAC	0xa0e
>  #define NCT6683_CUSTOMER_ID_MSI		0x201
>  #define NCT6683_CUSTOMER_ID_ASROCK		0xe2c
> +#define NCT6683_CUSTOMER_ID_ASROCK2	0xe1b
>  
>  #define NCT6683_REG_BUILD_YEAR		0x604
>  #define NCT6683_REG_BUILD_MONTH		0x605
> @@ -1221,6 +1222,8 @@ static int nct6683_probe(struct platform_device *pdev)
>  		break;
>  	case NCT6683_CUSTOMER_ID_ASROCK:
>  		break;
> +	case NCT6683_CUSTOMER_ID_ASROCK2:
> +		break;
>  	default:
>  		if (!force)
>  			return -ENODEV;
