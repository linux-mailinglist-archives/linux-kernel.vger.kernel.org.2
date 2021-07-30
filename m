Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0693DB399
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 08:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237424AbhG3G3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 02:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237420AbhG3G3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 02:29:15 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CBEC0613C1;
        Thu, 29 Jul 2021 23:29:10 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id h63-20020a9d14450000b02904ce97efee36so8437032oth.7;
        Thu, 29 Jul 2021 23:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/YmkoeXmhmKuU8zgRSXd2MrrHRV9HDVXo1+GFiCPMV8=;
        b=WEjBFvjcsm1P/5l6I/Qmr82R9ku/UZsPgDZ7xKDPmqWBlOefkBb4+hsnty4KbZ88gW
         GefwZXnnSWwXsVy4VjEmXoupwW1UERK2MMSRO9aX4NnmOJuPzlJQAOlGWVyjbA9K5/Pe
         m4xy8WX7DFtigEaayZe9XURNKZuLb2y59rYWtTJMBnwkc6mdnxOy2VXXFAYmaEGpcT5Q
         PiRtEAyvh4GqDLSPRxpJkKgvVPLTe6JU6BEJfbTMSTK2UpEmUXUEYw6NiPLZ25i7NdlM
         gwdInO7rlh8+B+5kOMuaiRFrS5qLUCVaJs4+VvxcnVRbwgAePF3c/y1DoqvNai2g5HkY
         un8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/YmkoeXmhmKuU8zgRSXd2MrrHRV9HDVXo1+GFiCPMV8=;
        b=FbfhHB+G0OKx4XjLUjlPXri3/4+d6d6YCd3gM7gx3vaGaJb/XflAcftP5Wjrjwm5Ym
         0kXmj4np5PyzkwXmOwn75rFoqJwWk07LaRz8i0yI2a6feoRX4tiTorWXgKJGtPyGzdbz
         Q1xMwpAnX6r4kbQn5QFTGgQnwn/C+pawX/3Baw3N13cB+t5zkK8OrcVtHj1/raCZYC+a
         bHoIkRD0kGYHAFTlJxLvlk74uZnCFJBPpQa2ho3O0Y2krt3+67q115WNxRQyWz1quvS0
         91UzUN9D0t11IOOy7OPkblBQiSDwt18dkC8ZHxKTsLIF8A2X/QNp4J2KU0tNiMNcW+V2
         t+hg==
X-Gm-Message-State: AOAM533q7+BLLv/DZ7jOYtWKMsERNvm9LZtUetaNTL6OnBshDTST+bx1
        JVxrTplgqrd3sRghsWGTrty+iPekZd8=
X-Google-Smtp-Source: ABdhPJznxKwtyj4BQFaa0HkanOt/oNuv3VsYcwyH0w0R6qkvLW2fXzBbkhdQeDL1fwz/e00lSNbQWQ==
X-Received: by 2002:a9d:bb2:: with SMTP id 47mr906274oth.102.1627626549348;
        Thu, 29 Jul 2021 23:29:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bh3sm153111oib.30.2021.07.29.23.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 23:29:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: connector: Add pd-supported property
To:     Kyle Tso <kyletso@google.com>, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20210730061832.1927936-1-kyletso@google.com>
 <20210730061832.1927936-2-kyletso@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <68732310-d53a-a86b-f43c-2ceb22051338@roeck-us.net>
Date:   Thu, 29 Jul 2021 23:29:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210730061832.1927936-2-kyletso@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/21 11:18 PM, Kyle Tso wrote:
> Set "pd-unsupported" property if the Type-C connector has no power
> delivery support.
> 

subject is still wrong (it says pd-supported).


> Signed-off-by: Kyle Tso <kyletso@google.com>
> ---
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

