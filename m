Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98BAA35A2B8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 18:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbhDIQKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 12:10:13 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:37727 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhDIQKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:10:07 -0400
Received: by mail-oi1-f169.google.com with SMTP id k25so6289685oic.4;
        Fri, 09 Apr 2021 09:09:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n+nQDvb/53iLrx65bNFB8m0WfRA8chQiqg6z4BH6ptQ=;
        b=SmqFKk8rfDzYYc4LZfCKza/GGL8b2uA8jDOb5o48tvamP+ovP5euZH9+D5BsvSxw+I
         gR5HI9pv1oAhpz1MFJALwzFh/LNsOmCDjMMfgQjN/WNkIFnSPVvA2ykZ0GA03b+Aj4nP
         RO5phYsw9hoTT9G0jWd2yxyZzgmLchUGQ3dndjbPlAwa8q6B8vAxF23JwilmxWhqI93v
         WgIVar1WhzNqIOklJbDLnY1AxkWIJ4CT6RxIsMP5/s9gm+hsS4kizpqwLjLP4tXuCRic
         MyaKD8LUgU+XwYz3E47EyBKI7gZFO/FRporrLyCAlW/S+CHK6wS29sraOD/7JCeLZTE5
         s1qA==
X-Gm-Message-State: AOAM531VyH9hBqIvse3v/ThHQsaC01tUZazB4s31nC3t38gh5/8eUnaY
        68Uyjr8QVsD960H6CO//lA==
X-Google-Smtp-Source: ABdhPJyx96s5z7I79DNbhK+m+BlpkOsXdWoDBbvjYIrbOyvKs5VMYPdv6B4sQMa5RpY4OGpAJ5L/Ow==
X-Received: by 2002:aca:d485:: with SMTP id l127mr10614199oig.21.1617984593974;
        Fri, 09 Apr 2021 09:09:53 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n83sm575460oif.18.2021.04.09.09.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 09:09:53 -0700 (PDT)
Received: (nullmailer pid 3738915 invoked by uid 1000);
        Fri, 09 Apr 2021 16:09:52 -0000
Date:   Fri, 9 Apr 2021 11:09:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: serial: samsung: include generic
 dtschema to match bluetooth child
Message-ID: <20210409160952.GA3737690@robh.at.kernel.org>
References: <20210405172119.7484-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405172119.7484-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 07:21:19PM +0200, Krzysztof Kozlowski wrote:
> From: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Include the generic serial.yaml dtschema so the child node like
> "bluetooh" will be properly matched:

typo

> 
>   arch/arm/boot/dts/exynos4210-universal_c210.dt.yaml:
>     serial@13800000: 'bluetooth' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Drop the new example, as Rob suggested.
> ---
>  Documentation/devicetree/bindings/serial/samsung_uart.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>
