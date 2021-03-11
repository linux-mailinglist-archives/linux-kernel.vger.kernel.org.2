Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0F8338005
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 23:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhCKWCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 17:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbhCKWCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 17:02:07 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60162C061574;
        Thu, 11 Mar 2021 14:02:07 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id q130so5831180oif.13;
        Thu, 11 Mar 2021 14:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UQ8E0btZr5f/lHfbczLb/OS7Qy0lc+CY+34s9mzBT2c=;
        b=YS+Lt/Oz7YwelAb3kwV/VTcTZhSU1VV23ljUbjBRHVXLWreAi+8q3Xyx5BzBYTRdZg
         ecHi1j8qqHW3dIEx/uc78fiN6DvHtae1RXv8A0aiBVy/Ql1J071v7r+NKWzeZCJq8CLf
         H8rXr6x3k1vhVbm72gDn+0vDKXbLr7Dg0RydDZg+L6L8uVe9hFXBxR6T+byS1ljSloMF
         emQx5ui+I9rkETtM2DHhdMBd42fidzmxmvSuiOu+uec/PLub86+HsxMNwVFIXv2kGqYm
         MFpCPKVyAbtBAHoi0bpBplTOw5NYBvLncy+YAATvZPu5nAYzpKFAeyT4NyjvfWD7b7CQ
         bBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=UQ8E0btZr5f/lHfbczLb/OS7Qy0lc+CY+34s9mzBT2c=;
        b=JQAIMdHbG2VIfGFrMG5gWbsTpXGofGCA1SViYj64XKXSilK3qr2I+8worRv9hjhzb9
         c0I7EwsWp61/yDqqbZWIk6pKSImRt5vvukAmAaiz+1WQKLcMVxoBdiFV7Kp5g899TN7M
         vVqtc429gyM/NBiSARBnGsrLKt76T/NRg1CIIWxu4JE0hjuxVOnHorMgitKcV/X9b+Ev
         PgMf0ger2s7LuuOpYeofxxsJ7gYbc1h3q9Vdnd7whKxe9/419mpRWtO6+QJMvvU3ogaQ
         /J/iJrZD3LG/yESwpzkPwBSriR51k5YsYj+qutScu3fq+g/RjxpAY7IQwvGk7xDzKrnw
         QFdQ==
X-Gm-Message-State: AOAM530apJ3CZ2ngoXaQdjEPnXDsKzjMiCpf9z0JNCaJP760H8Yvq2c0
        p/ydJ89qEaM/VqyEe8LBaAoclm5skUg=
X-Google-Smtp-Source: ABdhPJyBMus0KQ9ed2ZMwJyemHlMGIE4kSrAkjIqlUxQmSwL/KUDHRIm/sQZdhbE+aX1Dx4Ik58dGw==
X-Received: by 2002:aca:bc89:: with SMTP id m131mr7549771oif.62.1615500126879;
        Thu, 11 Mar 2021 14:02:06 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 64sm801666oob.12.2021.03.11.14.02.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Mar 2021 14:02:06 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 11 Mar 2021 14:02:05 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Erik Rosen <erik.rosen@metormote.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v3 2/2] hwmon: (pmbus/stpddc60) Add ST STPDDC60 pmbus
 driver
Message-ID: <20210311220205.GA37379@roeck-us.net>
References: <20210218115249.28513-1-erik.rosen@metormote.com>
 <20210218115249.28513-3-erik.rosen@metormote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218115249.28513-3-erik.rosen@metormote.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 12:52:49PM +0100, Erik Rosen wrote:
> Add hardware monitoring support for ST STPDDC60 Unversal Digital
> Multicell Controller.
> 
> Signed-off-by: Erik Rosen <erik.rosen@metormote.com>

Applied but ...

> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -28,9 +28,11 @@ obj-$(CONFIG_SENSORS_MP2975)	+= mp2975.o
>  obj-$(CONFIG_SENSORS_PM6764TR)	+= pm6764tr.o
>  obj-$(CONFIG_SENSORS_PXE1610)	+= pxe1610.o
>  obj-$(CONFIG_SENSORS_Q54SJ108A2)	+= q54sj108a2.o
> +obj-$(CONFIG_SENSORS_STPDDC60)	+= stpddc60.o
>  obj-$(CONFIG_SENSORS_TPS40422)	+= tps40422.o
>  obj-$(CONFIG_SENSORS_TPS53679)	+= tps53679.o
>  obj-$(CONFIG_SENSORS_UCD9000)	+= ucd9000.o
>  obj-$(CONFIG_SENSORS_UCD9200)	+= ucd9200.o
>  obj-$(CONFIG_SENSORS_XDPE122)	+= xdpe12284.o
>  obj-$(CONFIG_SENSORS_ZL6100)	+= zl6100.o
> +

I fixed this up. Please check for such whitespace errors.

Thanks,
Guenter
