Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87FF231A19E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 16:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbhBLPZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 10:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhBLPV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 10:21:59 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3E9C061574;
        Fri, 12 Feb 2021 07:21:18 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id i11so1317628oov.13;
        Fri, 12 Feb 2021 07:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7xROe8ze/bEj3DdX2NidRAOr1uloYGmnFBNWkT1fXos=;
        b=WArc+sLe9oRtL+eq8BKz2AfW5l9OyOFD3fOieMAO90vhLtwXObMzLxjFaACfb9RTdn
         /D3EDoQ7PMsOJzGDtfpABQCB4yQsfHBZYnPwotfyqlKEEzzBZliFYOjn6LNojMxFVJlJ
         35LrxWi8eusvqex584PEUf1oKtHO7IPty3Zm0u4vNJylYnRnbXvTBECZdiXESULXKxKu
         c1kRJbGRuaLsa1FZb+AT1Q+bv4/FgygRcOi6JLi1RgVP+RSveHrbYWRrwSu80t7tbA7E
         aFcgPEnO1eNox1SxplVhwDfrWRSbzQ+YrMG5N926If4KxdIyoqIjztZ4NydNSbf+hqfp
         bYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7xROe8ze/bEj3DdX2NidRAOr1uloYGmnFBNWkT1fXos=;
        b=ThE2doBekluodxAzyMGQKZB9dTJ11so5VA5PYQnoYq2+vRmz+KL42ukDKgwDlIuDU/
         7yXb3SdCuyTr92a7DouPHnJiJkXVFiYABe9CuLA8gfFpdK1TjIiNKKQ5a9ojjrQwXb/h
         1miT6CFxBIN6ohpNtKlPj2USbdZ9xmk+V7pj3jyzPpF6eCRtdGWbJJVVA0ULKxyYzpap
         tcB37OsHHlZJ7UA8gMhXUhxLVLBxTqvtAj0c0wzlYguHnC8F0P91TLjH3LLwaAjBeKuM
         f6HjzBoGG4YSCsAicFyL/RgckPMBRigMPXdbUmx/dNWjfMQxngn7rf2axQSbGkWXwMcA
         wcYw==
X-Gm-Message-State: AOAM531a6B1loYffglQSJUfm4+G0rRmzwl7vdzukAiPM/O1tp1qqVqKx
        jb6Zo0dEHzQrZuzGqaqKHhv/qhZwJSI=
X-Google-Smtp-Source: ABdhPJwGsKh+tnGwJrtbCT3nlxnHp4rGF4TyGoukRjw9KqU+zeRmPkaUONaXwA3BdWBSRe6YH/aulw==
X-Received: by 2002:a4a:858c:: with SMTP id t12mr2217683ooh.20.1613143277522;
        Fri, 12 Feb 2021 07:21:17 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g36sm1707061otb.67.2021.02.12.07.21.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Feb 2021 07:21:16 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 12 Feb 2021 07:21:14 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kyle Tso <kyletso@google.com>
Cc:     robh+dt@kernel.org, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] Documentation: connector: Update the description of
 sink-vdos
Message-ID: <20210212152114.GC57042@roeck-us.net>
References: <20210212073743.665038-1-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212073743.665038-1-kyletso@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 03:37:43PM +0800, Kyle Tso wrote:
> Remove the acronym "VDM" and replace it with the full name "Vendor
> Defined Message".
> 
> Signed-off-by: Kyle Tso <kyletso@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  .../devicetree/bindings/connector/usb-connector.yaml       | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> index d385026944ec..ce11b2027199 100644
> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> @@ -138,9 +138,10 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32-array
>  
>    sink-vdos:
> -    description: An array of u32 with each entry (VDM Objects) providing additional information
> -      corresponding to the product, the detailed bit definitions and the order of each VDO can be
> -      found in "USB Power Delivery Specification Revision 3.0, Version 2.0 + ECNs 2020-12-10"
> +    description: An array of u32 with each entry, a Vendor Defined Message Object (VDO),
> +      providing additional information corresponding to the product, the detailed bit
> +      definitions and the order of each VDO can be found in
> +      "USB Power Delivery Specification Revision 3.0, Version 2.0 + ECNs 2020-12-10"
>        chapter 6.4.4.3.1 Discover Identity. User can specify the VDO array via
>        VDO_IDH/_CERT/_PRODUCT/_UFP/_DFP/_PCABLE/_ACABLE(1/2)/_VPD() defined in
>        dt-bindings/usb/pd.h.
> -- 
> 2.30.0.478.g8a0d178c01-goog
> 
