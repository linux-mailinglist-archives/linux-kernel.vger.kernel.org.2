Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA38F3E9DA0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 06:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbhHLEgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 00:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbhHLEgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 00:36:48 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3D5C061799;
        Wed, 11 Aug 2021 21:36:23 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id e1so2431294qvs.13;
        Wed, 11 Aug 2021 21:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jpZ0477C5cf3o49NC+s1PqZcr5VpzD9GwW2JUzF4Esc=;
        b=VIGNX7lXtRH+fbiLDv8GZQsTQBtM61/hRQB4WlWwIfHR5v+z4adEzVbAwmF2ZJRdQp
         0TafmiJceYrSr1J1uh8qb18PiVpKRMujCQruk6D7f+M+NO5aoElMRd7OM8dX+jTwIVOy
         JL3medSFGsSxjSPTP5O3YIVaBb2pymmAdNizhGdBAwo6etys79jzF33xm06YKrjouy5D
         25yKAWus9tOf6UnYVKIpPdXgw1K7zcaUM0tOPy/abZkM7kCaKbDo1lV+R44SyKf36qNz
         HHVBvDBTlVVrKZdrpl/KvBTQ1m0rO39p17isoqf1e2T/hBuLS64em5GHrZJsbxiSO4lq
         aiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=jpZ0477C5cf3o49NC+s1PqZcr5VpzD9GwW2JUzF4Esc=;
        b=S9FG+Hv0AvWZQ0aWExberG4T8HopbxftK0ew8dMYW0Z5EPKSgqSrZqmPxbU1RQ2uB8
         LD99I6rnZDkwmFVTngUitmFhkfXrmqeJo17fphkAWHl8EfmFq67bRjyB2PrHqFMTt376
         C5xQzNd2c6JTpvsCZpwUqQ3D6rOqSXxdxrPhzEbixE7iSXMlsuI9w1NjV32w9Jb+SnIq
         EVmSwSuc4FPT/aLHdCUSoTbpcOys7mdYqJxMHJ+nSsjMI0Xu1nGT0WAO+vz83Itgw8sn
         SfBJPILYS6kd1ftiFq75ML/gEhAm/wDvratrgA755Ni7qe1shpO69ov7hs0SUs9fepr3
         bbTA==
X-Gm-Message-State: AOAM532nLmGs191HVJSz2d3nW3z+rk0+6LKxGQ7MjizMDzrgPyC0LLFe
        LjuKpWXcDP1LFwAD21IE0U0=
X-Google-Smtp-Source: ABdhPJxXTmu10YgComYrKxSwN+Azc2Fes+HG7vUAU4AW67kaceFtqrErJyaRenVQ7lIAyFB3Pt5mfA==
X-Received: by 2002:a0c:e883:: with SMTP id b3mr2178998qvo.23.1628742983133;
        Wed, 11 Aug 2021 21:36:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 18sm683769qkm.128.2021.08.11.21.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 21:36:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 11 Aug 2021 21:36:21 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Brandon Wyman <bjwyman@gmail.com>
Cc:     Joel Stanley <joel@jms.id.au>, openbmc@lists.ozlabs.org,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eddie James <eajames@linux.ibm.com>
Subject: Re: [PATCH v2] hwmon: (pmbus/ibm-cffps) Fix write bits for LED
 control
Message-ID: <20210812043621.GA1115124@roeck-us.net>
References: <20210806225131.1808759-1-bjwyman@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806225131.1808759-1-bjwyman@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2021 at 10:51:31PM +0000, Brandon Wyman wrote:
> When doing a PMBus write for the LED control on the IBM Common Form
> Factor Power Supplies (ibm-cffps), the DAh command requires that bit 7
> be low and bit 6 be high in order to indicate that you are truly
> attempting to do a write.
> 
> Signed-off-by: Brandon Wyman <bjwyman@gmail.com>

Applied.

Thanks,
Guenter

> ---
> V1 -> V2: Use full name instead of initials in Signed-off-by line.
> ---
>  drivers/hwmon/pmbus/ibm-cffps.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
> index 5668d8305b78..df712ce4b164 100644
> --- a/drivers/hwmon/pmbus/ibm-cffps.c
> +++ b/drivers/hwmon/pmbus/ibm-cffps.c
> @@ -50,9 +50,9 @@
>  #define CFFPS_MFR_VAUX_FAULT			BIT(6)
>  #define CFFPS_MFR_CURRENT_SHARE_WARNING		BIT(7)
>  
> -#define CFFPS_LED_BLINK				BIT(0)
> -#define CFFPS_LED_ON				BIT(1)
> -#define CFFPS_LED_OFF				BIT(2)
> +#define CFFPS_LED_BLINK				(BIT(0) | BIT(6))
> +#define CFFPS_LED_ON				(BIT(1) | BIT(6))
> +#define CFFPS_LED_OFF				(BIT(2) | BIT(6))
>  #define CFFPS_BLINK_RATE_MS			250
>  
>  enum {
