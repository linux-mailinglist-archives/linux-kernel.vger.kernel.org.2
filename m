Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260B43D7AEC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 18:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhG0Q3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 12:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhG0Q3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 12:29:21 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F039C061757;
        Tue, 27 Jul 2021 09:29:21 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id w6so7152068qvh.3;
        Tue, 27 Jul 2021 09:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X8o1ICcfUCVy4RMO2SfTG9lQ7NmFTVFh6T/2D7Rv0uM=;
        b=mBRN3GP35ZGkSmMvJPctrOfTIpTi4hps6uN+yH3DoJCavUMtWf+m1qOgD7RGj3wVUf
         BocJaevCOvce2ifwYajyw6J9DW9QzugBWYOVR7heQKcylDGCnt50UeEt3nMV3f5PbOKB
         6RF8G/L9Cwx7oG3uvmED3ngY18SdprjBGuPF163Pv2CGxWOraO84Mdhu6aTtToGDx3I4
         aHwXTK/5sBOT8abUnhUt+KVzdy6bO32niAT2folOlfXfQoTvuslD893gWwO1KRmWU9S0
         R7WCx+TjEA3jrWPAaoSjLEu5GLEuJN+k2WYd+CjHL3zT3YPEkAliBIayrCpUdYqgm95y
         WRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X8o1ICcfUCVy4RMO2SfTG9lQ7NmFTVFh6T/2D7Rv0uM=;
        b=V9eFVzT+I1VSufY8+i4qdEHrap/WQk620C016J5Ovc1611PrHczUf5iZ8UgNuligvW
         SO60AxaIWoeQrtakhK9e2RSeKnpQoNMxcAU6pmT5WDWGFF/mAzM8LjRC9UVeO7AVhM7q
         Pd9RDNWEJdyJVXWh94t9IA/GQ9IXwLKwYgjR2+9mQniBbb9OCkB03Vz+o9VHyVrCn/Wb
         jC6BYh3DrXXcGR6cXldgZQpwl6lBPuwQhpHsUsdsYmTY/GA52jZnVTxt4m6BS1M3ImHq
         zrSSmQa+EAVcMu5NxfttI54kKKhX/j+doZSYqQ/N4hwqe+wPHEKuwjtE5hJDNPgzxTTL
         ZznA==
X-Gm-Message-State: AOAM5327qcG2uRnubW0svhZIHViVTVl45F91am4yJno/FpCL/oFa+a7c
        uymtSVpCzBgjLt3j4bLab3Hw4AFsysw=
X-Google-Smtp-Source: ABdhPJwvlP6I8giavWPvyB+4/griGm84V3fQN7Os3WsaLflfgnRO7wgehDOROMCxUPU5ZqFqBrxwTg==
X-Received: by 2002:ad4:5050:: with SMTP id m16mr20501450qvq.2.1627403360003;
        Tue, 27 Jul 2021 09:29:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g13sm1628551qtj.2.2021.07.27.09.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 09:29:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: connector: Add pd-supported property
To:     Kyle Tso <kyletso@google.com>, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20210727151307.2178352-1-kyletso@google.com>
 <20210727151307.2178352-2-kyletso@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <482e2770-f371-9755-f125-96b4cf11c2e3@roeck-us.net>
Date:   Tue, 27 Jul 2021 09:29:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210727151307.2178352-2-kyletso@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/21 8:13 AM, Kyle Tso wrote:
> Set pd-supported property if the Type-C connector has power delivery
> support.
> 
> Signed-off-by: Kyle Tso <kyletso@google.com>
> ---
>   .../devicetree/bindings/connector/usb-connector.yaml         | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> index 92b49bc37939..8ed271feea08 100644
> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> @@ -111,6 +111,10 @@ properties:
>         - 1.5A
>         - 3.0A
>   
> +  pd-supported:

I think that would have to be a property indicating that pd is _not_
supported, for compatibility reasons. Otherwise all existing bindings
would indicate that pd is not supported.

> +    description: Set this property if the Type-C connector has power delivery support.
> +    type: boolean
> +
>     # The following are optional properties for "usb-c-connector" with power
>     # delivery support.
>     source-pdos:
> @@ -312,6 +316,7 @@ examples:
>           label = "USB-C";
>           power-role = "dual";
>           try-power-role = "sink";
> +        pd-supported;
>           source-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM)>;
>           sink-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM)
>                        PDO_VAR(5000, 12000, 2000)>;
> 

