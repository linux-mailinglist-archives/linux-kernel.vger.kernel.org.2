Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032943EF54F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 23:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbhHQV4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 17:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbhHQV4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 17:56:08 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B08C061764;
        Tue, 17 Aug 2021 14:55:35 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so219555otk.9;
        Tue, 17 Aug 2021 14:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rAW4lU/RJvKOFz0SR+OmypjLALjP6fD0yLpDz8M0/vE=;
        b=rLfwX9mAQGzSs2M5Vri3NNozYyJTwOYNfC+vfvhgAw+36QDDelZNtABBDv6RZEpvbI
         6WW0rCEDemJ2bT1tQFG45JUTqIBG8TfEv5SHWvacACOIkces337g4zkUGrz5jX1AtB/F
         vqjRP7L9ciJts/cxIKWDj3NyRO4vJFUakzpDRMhLlctEQ6rBjNxenhglBwwy7zeh7M+2
         gacNfgP7wahNgMYBPuMGzsJbhcVv0yj7yjf3fXDhVsNs+rLyHQ3CaOEbNpkJpVTmEejS
         ynvOLGl1SiZuwcQ8hP/hdiMFqXhLwKV0C/0Sf6b57RBoQAFhfkv0iaeaa4gmp4+hO3nT
         MAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=rAW4lU/RJvKOFz0SR+OmypjLALjP6fD0yLpDz8M0/vE=;
        b=DTZ6RffUC2MaqTq9ip6H/okciqT4EuFMJr2Gk4UjhprjdmzVR5HuVvRhcdxpbrmXmb
         mqDVjj+KEeFNMPWz/EG+7cSq2SKqlrT+GQusuJ4wHlRS6kGOfnaDueUCqYLjlQ0SDLSC
         B8++TT7BKyrqJC9kSq8paxBy35+6xt+s43CWlUJTbm/QfM2zbM7nYMVeT9sLMASfZ3Jw
         EtfdcEZGevM9hPtDbVM4pLoWPhqFZzfD6ob2GSNiRXibY+19iQBA0cAvHA2XBKC00gl6
         mNE5Xy04UqY5A6rmxm6/0XtIwLd/qHT+bzxk7q1ecD1xD3R+uHlaLsDAKhTCMKSpHBir
         erRA==
X-Gm-Message-State: AOAM531PRdpjtCz2aEV7PY0vgr6PCAyF4IFEAGetVi30xSZtaQoD3nEe
        5DIPdS3LriiOnTXTAHRxjsU=
X-Google-Smtp-Source: ABdhPJyXlMiFqSZFkfwoB7TTrvIk/perMWhdiWzRtwiL0zCZgay8BQOmbKt+t6CyHvvYIRYGEdD3Iw==
X-Received: by 2002:a05:6830:2a06:: with SMTP id y6mr4088503otu.134.1629237334432;
        Tue, 17 Aug 2021 14:55:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z25sm771568oic.24.2021.08.17.14.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 14:55:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 17 Aug 2021 14:55:32 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: remove amd_energy driver in Makefile
Message-ID: <20210817215532.GA471009@roeck-us.net>
References: <20210817084811.10673-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817084811.10673-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 10:48:11AM +0200, Lukas Bulwahn wrote:
> Commit 9049572fb145 ("hwmon: Remove amd_energy driver") removes the driver,
> but misses to adjust the Makefile.
> 
> Hence, ./scripts/checkkconfigsymbols.py warns:
> 
> SENSORS_AMD_ENERGY
> Referencing files: drivers/hwmon/Makefile
> 
> Remove the missing piece of this driver removal.
> 
> Fixes: 9049572fb145 ("hwmon: Remove amd_energy driver")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/Makefile | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 53a8f4b500b8..4b33421746c0 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -45,7 +45,6 @@ obj-$(CONFIG_SENSORS_ADT7462)	+= adt7462.o
>  obj-$(CONFIG_SENSORS_ADT7470)	+= adt7470.o
>  obj-$(CONFIG_SENSORS_ADT7475)	+= adt7475.o
>  obj-$(CONFIG_SENSORS_AHT10)	+= aht10.o
> -obj-$(CONFIG_SENSORS_AMD_ENERGY) += amd_energy.o
>  obj-$(CONFIG_SENSORS_APPLESMC)	+= applesmc.o
>  obj-$(CONFIG_SENSORS_ARM_SCMI)	+= scmi-hwmon.o
>  obj-$(CONFIG_SENSORS_ARM_SCPI)	+= scpi-hwmon.o
