Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D523D900B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 16:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236469AbhG1OEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 10:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235317AbhG1OEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 10:04:36 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED09C061757;
        Wed, 28 Jul 2021 07:04:33 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id g6so1549924qvj.8;
        Wed, 28 Jul 2021 07:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RJ6yiUmiMn9KXKa+d1/GNMShbg379rzibdu6zfOJPe4=;
        b=iAsLbeOiL/fKTFCVi1vRjJPRalwM8QeZESMxa70PdYSCzUNpPXxDFFC+53mgSq6Nel
         gNxLh67UXeEauvl2EiPWUIDlRr/HueXRyA483cWJVvlccGeKC3RRkzarjvxuEo5XY3xn
         pzppBYBjfwYs/KRVsyqTJ81NLlZEA50UiAKnEf58zZcLllCcRC/hZ9iUulbt2cOfFW2V
         46/c3Ty1FdNmfUerQzPtQ9vBv8zSUQm6NFHAYH92JNnJYiWk49dzwRj9U9DaHbDIenSw
         sp12Tl+mAz/dnTQtbeUWhdMG/T+QM9+p4exsu/1pQvKH7u0tk/EmXjpjV1W7NCGbcrwM
         eYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RJ6yiUmiMn9KXKa+d1/GNMShbg379rzibdu6zfOJPe4=;
        b=gnAAHC+zQ/Xr2EoDHanVHu/ntppGiSlltUzAKw+GMH7Kq+YsUVcIeCmEwidWGUEgmq
         rm26KSeff4sfaZ82GwR3Rda0DKUs626zspT9XGyFvPeuuHGtsyJ+hyOM6DTdWMVBK/gf
         SUDcuY1dlRzP3AEBSxqGopPpfwv11K4EV1Wb9ohRuQ8xZH7LyE5XKE3n8fjuaQ2g29WJ
         bMAU2/a6nBwqNHXRX5dQipElR5Ne6VUUa9XptMLj+1hSRMXf2K82fzuTAhn0jGNQhT9b
         e8wlJPxi4CvSmKcMT4A1z4JUoYTDxwNBSwrLfmYvhESJMxHQSHxql0VT+RwsWHJT3AfI
         M/QA==
X-Gm-Message-State: AOAM5332MdBtzYG6DXeH9G53NR7lezmqxpbbaOrzWaSgnrkGMTyeZgRS
        NZyKomtP0gFvLRpebGbnsfOEIaRJa4w=
X-Google-Smtp-Source: ABdhPJwyqdQ6iec8LEqxM4w3Rg/eJ2SUVEkoi2nQ6W5EMq43YfiWmvtO7v6IwoqNob0iUX2DWrqzgQ==
X-Received: by 2002:a05:6214:501d:: with SMTP id jo29mr141852qvb.43.1627481072852;
        Wed, 28 Jul 2021 07:04:32 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j198sm30674qke.120.2021.07.28.07.04.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 07:04:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: connector: Add pd-supported property
To:     Kyle Tso <kyletso@google.com>, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20210728092930.2552619-1-kyletso@google.com>
 <20210728092930.2552619-2-kyletso@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <825a816f-4049-ddc4-e42d-ffc0d68306f8@roeck-us.net>
Date:   Wed, 28 Jul 2021 07:04:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210728092930.2552619-2-kyletso@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/21 2:29 AM, Kyle Tso wrote:
> Set "pd-unsupported" property if the Type-C connector has no power
> delivery support.
> 

$subject still says "pd-supported"

> Signed-off-by: Kyle Tso <kyletso@google.com>
> ---
> changes since v2:
> - Negated the meaning and the name of the dt property. Now the name is
>    "pd-unsupported".
> 
>   .../devicetree/bindings/connector/usb-connector.yaml          | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> index 92b49bc37939..21ec470117a6 100644
> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> @@ -111,6 +111,10 @@ properties:
>         - 1.5A
>         - 3.0A
>   
> +  pd-unsupported:
> +    description: Set this property if the Type-C connector has no power delivery support.
> +    type: boolean
> +
>     # The following are optional properties for "usb-c-connector" with power
>     # delivery support.
>     source-pdos:
> 

