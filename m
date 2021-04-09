Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC4E35A934
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 01:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbhDIXVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 19:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234880AbhDIXVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 19:21:53 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D28EC061762;
        Fri,  9 Apr 2021 16:21:40 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so7271471otk.5;
        Fri, 09 Apr 2021 16:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Tjadi9gWiZf3KwIFwiKeQrMHEpLjgOQPNAFRf78f8yU=;
        b=jvGwIo/yMRm9sb0hxpgzQG3L01wPiDBqCbpQemdhdC0QrhmNMVXEvJe0cgP3Ybm1Xk
         GHJShl32LIGMtQxG4uX9X+J3WX0/4EuQQW4IQ+5pnxDMHK5/naT/jr01lcFaTEPYM7U2
         ZFMGGY1F1Vfu7fc8//9Y9spoOgp/gtU7bdd9btdU7AciRR9u0obaU5CrhzvvkyEK9Jg0
         URvIc6rg2Om/9b4t6tYFZ/CBpIbxkWugWA1fL5orEhy2SOasee7WSouErCkENz+aNeci
         8rQ0kXo3/ur75aRMf8dqjESGITd5ZJuZcNWDYUWjCpXUMbbUO47dQ4ogjjMLAzW3/pM9
         x6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tjadi9gWiZf3KwIFwiKeQrMHEpLjgOQPNAFRf78f8yU=;
        b=eLQDJIpSbmwZfYn1rOrpjmKtBom68vYiONUcq1MzbGgTkNcoqXntGnscovRNKGleMZ
         Lasepi/rfwRm5m7qDiTGwEyX8haOEHtR8I74LHmODqfKpLo2t0Ow4r8ualCQvHsYdrMN
         t1mIgmQPIEHTjS6xEF1DQfNN8oYpFV6b4qmTKcj3h6gD9/Cit7r5QQoxw1bjyta3fiW2
         3pUqz11EFP+Lh9DAuhQdZm2r0dvaqWk5qm2o/rxJn4IGhq6dr3bCL/GzlVa+fmoEleuk
         huoFlackJauK6eNCw545U1YFhb04nvxRX7tdv2xd/GyifF/B1dczgP3odSUNfV/oe/hA
         XA8w==
X-Gm-Message-State: AOAM530g94ja7mOiqeKKxWKkbL2yOWtUq+JH1cZVzad3xE+mWMvd1y9b
        P5rWeXU5mkmCk2yMDqm2THac5rh+fNM=
X-Google-Smtp-Source: ABdhPJzG/OROLHRdsVDoT1NMneB+k8fbjA6Nj4YkiPknfTm0Q0R9M+U13PCfH8pqRibiSQxoStPnwg==
X-Received: by 2002:a9d:5ae:: with SMTP id 43mr2535063otd.347.1618010498818;
        Fri, 09 Apr 2021 16:21:38 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k8sm775584oig.6.2021.04.09.16.21.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Apr 2021 16:21:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 9 Apr 2021 16:21:36 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sebastian Oechsle <setboolean@icloud.com>
Cc:     pali@kernel.org, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (dell-smm) Add Dell Latitude 7440 to fan control
 whitelist
Message-ID: <20210409232136.GA70972@roeck-us.net>
References: <EE8F83B0-0C39-4E2A-B5FB-B94A1389588D@icloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EE8F83B0-0C39-4E2A-B5FB-B94A1389588D@icloud.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 07:02:55PM +0200, Sebastian Oechsle wrote:
> Allow manual PWM control on Dell Latitude 7440.
> 
> Signed-off-by: Sebastian Oechsle <setboolean@icloud.com <mailto:setboolean@icloud.com>>

This patch is corrupt, to the point where it doesn't show up in hwmon patchwork.
I just happened to find it, but I can not convince git to apply it. Please
fix the problem and resubmit.

Thanks,
Guenter

> ---
> drivers/hwmon/dell-smm-hwmon.c | 8 ++++++++
> 1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index 73b9db9e3aab..2970892bed82 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -1210,6 +1210,14 @@ static struct dmi_system_id i8k_whitelist_fan_control[] __initdata = {
> 		},
> 		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
> 	},
> +	{
> +		.ident = "Dell Latitude E7440",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Latitude E7440"),
> +		},
> +		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
> +	},
> 	{ }
> };
> 
> --
> 2.31.1
