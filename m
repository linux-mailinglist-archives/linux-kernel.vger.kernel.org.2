Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37AD34EBA4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbhC3PL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:11:56 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:40534 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbhC3PLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:11:33 -0400
Received: by mail-oi1-f177.google.com with SMTP id i3so16790925oik.7;
        Tue, 30 Mar 2021 08:11:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hxiRgGrHFPg7KAvZ4t1c11BIVLtDAzthILe1SRoyjHA=;
        b=kCIB4brpWMq9wT5v/1UGF3uuQu47jLJiBIgAQbuXJCJzE9pANxOhFAWn53Ir8h7Xnt
         zV+tZCYcxpzZhoublL+IcjScGSoTBID8bNgEebVsHJZmunm7e99Ug5EjYHcki1vWue6b
         5zzR6lS9L12YSC/TYus7Z6nVcYbttHLlDV5UDR6ELz8HNdccMMFNDSeYfRkkAdnpcrhh
         qd+huGfJOKe7O4aZqHqkn93lZ+CkOBrBkkxNlvr5uLF8KB36x2h2YrIjGozVbzvQSG5W
         RmIDTkZfZ6W2fBP9ygH99KMpg6l89cpP+UdwEVZyjlJBr0r3ySHphEr7hpxnuLmPj2/C
         y6cA==
X-Gm-Message-State: AOAM533qDCYOKFNpq18EDclPuReAwX5PVMrt6brg2lUrDxJfhNu61zOo
        oU6dLKGqyXd7W6nckuYLZA==
X-Google-Smtp-Source: ABdhPJw0XrDRTHQBPa6izTxumFKlle3x3qjyVFuTlT6uHcmzIoAeL/EtCJftHsR6dr6qDDl/OS2byg==
X-Received: by 2002:a54:488a:: with SMTP id r10mr3636242oic.23.1617117093265;
        Tue, 30 Mar 2021 08:11:33 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.99.136])
        by smtp.gmail.com with ESMTPSA id e12sm4500621oou.33.2021.03.30.08.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 08:11:32 -0700 (PDT)
Received: (nullmailer pid 317113 invoked by uid 1000);
        Tue, 30 Mar 2021 15:11:29 -0000
Date:   Tue, 30 Mar 2021 10:11:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ray Chi <raychi@google.com>
Cc:     gregkh@linuxfoundation.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kyletso@google.com, badhri@google.com
Subject: Re: [PATCH] dt-bindings: usb: dwc3: Add usb-psy-name string
Message-ID: <20210330151129.GA314367@robh.at.kernel.org>
References: <20210327191520.1824466-1-raychi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210327191520.1824466-1-raychi@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2021 at 03:15:20AM +0800, Ray Chi wrote:
> This commit adds documentation for usb-psy-name string.
> The string will use to find the power supply interface.
> And then, DWC3 can use the interface to control charing
> current with USB state and USB speed.

Why is this DWC3 specific?

Where does it find the power supply interface?

> 
> Signed-off-by: Ray Chi <raychi@google.com>
> ---
>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> index 2247da77eac1..ad62f4552fad 100644
> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> @@ -301,6 +301,13 @@ properties:
>      items:
>        enum: [1, 4, 8, 16, 32, 64, 128, 256]
>  
> +  usb-psy-name:
> +    description:
> +      Contains the name for power supply interface. To follow
> +      BC1.2 specification, DWC3 could use power supply interface
> +      to control current with corresponding USB state and USB speed.
> +    minItems: 1
> +
>  unevaluatedProperties: false
>  
>  required:
> -- 
> 2.31.0.291.g576ba9dcdaf-goog
> 
