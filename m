Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0F8337FDC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 22:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhCKVrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 16:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhCKVrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 16:47:19 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E715C061574;
        Thu, 11 Mar 2021 13:47:19 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 31-20020a9d00220000b02901b64b9b50b1so367863ota.9;
        Thu, 11 Mar 2021 13:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ITY+E8p2UWT+7SOeRk9gDCyhCXB32MYwyCLJwOOhVRg=;
        b=g6uOhi/7x0wpwfyEoImJ+M2vDl9paLHmbHEqlYKknFJ5eHqiXtehVRpV5dmNpaCgJv
         e+GRmBSLa8LuHk1GJ89w+89PI2ETz/lKZsLq3/aTBi6LwGAp9sOrTHqmChuO5t1uNpx9
         s3tdN/MEfh05rNxknEZdecQC6R7dPy+8pVHOhJ4yt5a8a1+zVgFDnPLbqb8FHeVygIIx
         uxbfajHK+eFaoBsWHJDgkKwgs116twvXakJaDn2H889UY5eB0fL3okNoV7ZqZKZdYGy3
         o9UzOEiPIRXdgHZtWieS/o8NuV7hUPVsGWAxZmV67H1v3xBbMo5hvzNzrIfhNhSCziF4
         svqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ITY+E8p2UWT+7SOeRk9gDCyhCXB32MYwyCLJwOOhVRg=;
        b=EtVmgeGrphz7e1l/njyA7ulnrFwSYOuGAUdIDgf3Lo5NGgLTDJPDSOt0gVHrbiyaxd
         G+gw1JkDJSXEQkL9RotkdCF9ToCUehkSFt7bh+sph8/SvjBBawxy9ompBzikGOGbBs+T
         Q6fYdrQwttY/4cASEdWQhhp2fCfyFV+7Wy/OfSOPU7LBfkikK0k6rXIRU6sxs0mw7NNz
         ge4/gLlbiCT1ElqycUDYRuXxcnRUpHgWu6t45ph/YtzXCRxnVPNn+0ckk83usAzCvo++
         7S5RvobBS7DffJPqgTqwe2dJ4sJOZXhVk/PY9xHe/MH5mFUUYd8SxgH008WEsMS5OCvF
         roRQ==
X-Gm-Message-State: AOAM532kOimBYwJbnq3gHAp/VCWmErm9c1uipBJDVB9xsoqqs806uDJg
        Q7uOXU0cE2mB/n7mxPWgEq0=
X-Google-Smtp-Source: ABdhPJw3d30ZgGip26VNqdQp+ntwoX99S8WQrY+hn5WbJANTgVMlaf7BvzlBHOz/h1Ph4XBwGrdAAQ==
X-Received: by 2002:a9d:3de5:: with SMTP id l92mr801569otc.227.1615499238382;
        Thu, 11 Mar 2021 13:47:18 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t2sm744721ool.18.2021.03.11.13.47.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Mar 2021 13:47:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 11 Mar 2021 13:47:16 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     robh+dt@kernel.org, jdelvare@suse.com, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Kosina <trivial@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: trivial-devices: Add infineon,ir36021
Message-ID: <20210311214716.GA36119@roeck-us.net>
References: <20210301035954.16713-1-chris.packham@alliedtelesis.co.nz>
 <20210301035954.16713-2-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301035954.16713-2-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 04:59:53PM +1300, Chris Packham wrote:
> Add infineon,ir36021 to trivial-devices.yaml.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Acked-by: Rob Herring <robh@kernel.org>

Applied.

Thanks,
Guenter

> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index a327130d1faa..19bc4c301f5b 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -102,6 +102,8 @@ properties:
>            - mps,mp2975
>              # G751: Digital Temperature Sensor and Thermal Watchdog with Two-Wire Interface
>            - gmt,g751
> +            # Infineon IR36021 digital POL buck controller
> +          - infineon,ir36021
>              # Infineon IR38064 Voltage Regulator
>            - infineon,ir38064
>              # Infineon SLB9635 (Soft-) I2C TPM (old protocol, max 100khz)
