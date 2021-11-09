Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E1A44B402
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 21:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244396AbhKIUe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 15:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243374AbhKIUeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 15:34:25 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A328C061764;
        Tue,  9 Nov 2021 12:31:39 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id v40-20020a056830092800b0055591caa9c6so524270ott.4;
        Tue, 09 Nov 2021 12:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0iPeom/RXDmxBJQ3zLHV+Je+RfBhkacFHk1wyxX/Ogc=;
        b=mDvvydLi755kfTLxeZOh8qakmmIZwyImVdNs20LIa53hjrjkaVqBtqyzzhJDc/S6Kc
         OE6RQWnAZTdu8g5Et5lORQvJE6yP13s6nJUQOJjVSx+04nHeB0DPndyP7kbPglR0MY3N
         6e9dtR7ZVRRBGuFhmhURK1aNkQcetEmdDr6/MRz6lHfBn+tLLQmDHlvWBmqRbgmR18Ls
         hsh5GnSW0TFj7XbFdZFS5F6XHOZwRnnxMxHO02VTZTBRGQ1Hcqj7/+EIhOJl22lasKRb
         Rxh296VdlQiB/PRF6h7FQ6Cti31S9ryjlP8bx+QL9MBkgE4tRa37BvGASRlyMZhMwPcb
         vMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=0iPeom/RXDmxBJQ3zLHV+Je+RfBhkacFHk1wyxX/Ogc=;
        b=kaOjmfRHm+o5t8rB38OGObpKyJCmvLyRmXtOjrKCPFNnXEgw3NY9m7CaDMl9X2L0EW
         GpGk2tjGiSabWr6YUTy1O9WoKDiYhSyyekjbh19C3vKHIWwHbwvgZF33cyfnhrfDt6gX
         iGgpsO+MyDV1/5yIlsmrPrCp8+6rF5NeQIEFXbm7WFr9YTq9DGNUT5/GqwGYDecCfeDc
         A9Jqc6dxqnhAtoZuTAfoCiECKqm2bl4clE41UqZ+lmJUgqxlQrczmmZSsFvVTAQMxiX+
         ivSonhxfP1AfgWdb5LrUI9nc+M4IykylCKJ5qGhTgG6meSCNKEseufFty9j1G9cmX9E6
         03nA==
X-Gm-Message-State: AOAM530QrFzESQ0XbqmXv/YkdYYzMiBpA1Udlr4BY0YGIgxKyK7dLyVU
        kppDte351SqhFmKwUjUKSwg=
X-Google-Smtp-Source: ABdhPJyzZQTj73+kP6eiDITJkcNhaAE99CRI6u/xGuKsxlabTAn8zvyVcfvicZPHiwXHhJzC0GbAaA==
X-Received: by 2002:a9d:73da:: with SMTP id m26mr765633otk.366.1636489898971;
        Tue, 09 Nov 2021 12:31:38 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u28sm5212211oth.52.2021.11.09.12.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 12:31:38 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 9 Nov 2021 12:31:35 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nathan Rossi <nathan@nathanrossi.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nathan Rossi <nathan.rossi@digi.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: hwmon: ti,ina2xx: Document ti,ina238
 compatible string
Message-ID: <20211109203135.GA3693254@roeck-us.net>
References: <20211102052754.817220-0-nathan@nathanrossi.com>
 <20211102052754.817220-1-nathan@nathanrossi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102052754.817220-1-nathan@nathanrossi.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 05:27:54AM +0000, Nathan Rossi wrote:
> From: Nathan Rossi <nathan.rossi@digi.com>
> 
> Document the compatible string for the Texas Instruments INA238, this
> device is a variant of the existing INA2xx devices and has the same
> device tree bindings (shunt resistor).
> 
> Signed-off-by: Nathan Rossi <nathan.rossi@digi.com>
> Acked-by: Rob Herring <robh@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> ---
> 2.33.0
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
> index 6f0443322a..180573f26c 100644
> --- a/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
> @@ -26,6 +26,7 @@ properties:
>        - ti,ina226
>        - ti,ina230
>        - ti,ina231
> +      - ti,ina238
>  
>    reg:
>      maxItems: 1
