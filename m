Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D29371832
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 17:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhECPmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 11:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbhECPmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 11:42:10 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D533FC06174A;
        Mon,  3 May 2021 08:41:13 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 103-20020a9d0d700000b02902a5baf33f37so4972066oti.9;
        Mon, 03 May 2021 08:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P0kYdQA89OLTxEIWb7gFiSe/qOCNSiqgqri9HrtsctY=;
        b=OvvUsQmOPy4P9qO2fjLTf7Itb9DXEKdWyKdzpp4Rw+dlSlAFM62c73eHoFV1LXSGKG
         LKhwZpDQjyasLEJfYP8RdOpVnGE1tnYXIQVEbrBDQNW3tAwydyojrErJRBpkPzYO2Ql/
         TNQPz9X+j02n1+dejbGhApLfpFT/FGd/ye6lWCS8tPru+DCDEcqcdJiunduhkRd8Z4Uf
         NvUUt6JUVt0WKLV9MA7NPyhqejB2UFpv236OW3sUgN9+d29ICBh2hsEKSL3EDHpMJFIy
         Kc0JKQ5TjNBkKuv4En6MkAYUzUzEEU14yVKYxmmv+tGZZ4Am5wmV5Bl7tuhoIkA9tKli
         Fvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=P0kYdQA89OLTxEIWb7gFiSe/qOCNSiqgqri9HrtsctY=;
        b=boeieCi8+JattPkqnX9pCcxHRwb8gdVQlsWQGo9T/dsYxR8JsVty+2tgI+y0XtlZVm
         NIfewmWUpfC1RoeDmR85Rv2BGWwt2KHMOnTXEm1mMMYG2TqZnIOGS/II3TRDnw0xYH0I
         ldG33rIRdWFWFTNyeiXniolioQgAwXkVCVChMHSFLkxZfiH02JuDfBOpoh3fBhOgMaqV
         iF7Og7UZQw5U9GLviRGQLBYvgoNLLb6zXRzwLWcXHCxAD92OQoqL63sPDoTDcVHSFc+s
         6k+quYDDhqim73i515jMLKZwowCyFrHXwP71TfDVKW4rH619+4OEoIJH+mzAC8OJ+k2i
         jeig==
X-Gm-Message-State: AOAM532l3df95bAm2VrvmGLgiWV9PF/kY5NfiCgdG95Z7g11z1lFNMxV
        1JLwAqGfyU6ujH70gXQj7MU=
X-Google-Smtp-Source: ABdhPJwqJy7s9jD/GBNBv/AO8S7viW5WaBtm/wPHnqNKWDNNAEP+WEkGA09iE80Anjuo+l70SbcOkA==
X-Received: by 2002:a9d:69c9:: with SMTP id v9mr15198641oto.65.1620056473333;
        Mon, 03 May 2021 08:41:13 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d3sm24917oic.48.2021.05.03.08.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 08:41:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 3 May 2021 08:41:11 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     jdelvare@suse.com, corbet@lwn.net, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: hwmon: Add Texas Instruments TMP1075
Message-ID: <20210503154111.GA707815@roeck-us.net>
References: <20210429121150.106804-1-robert.marko@sartura.hr>
 <20210429121150.106804-2-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429121150.106804-2-robert.marko@sartura.hr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 02:11:50PM +0200, Robert Marko wrote:
> Document the DT compatible for TI TMP1075 which
> is a LM75 compatible sensor.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Tentatively applied to hwmon-next (unless there are objections
from dt maintainers, which seems unlikely).

Thanks,
Guenter

> ---
>  Documentation/devicetree/bindings/hwmon/lm75.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/lm75.yaml b/Documentation/devicetree/bindings/hwmon/lm75.yaml
> index 96eed5cc7841..72980d083c21 100644
> --- a/Documentation/devicetree/bindings/hwmon/lm75.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/lm75.yaml
> @@ -30,6 +30,7 @@ properties:
>        - st,stds75
>        - st,stlm75
>        - microchip,tcn75
> +      - ti,tmp1075
>        - ti,tmp100
>        - ti,tmp101
>        - ti,tmp105
