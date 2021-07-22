Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E890E3D2715
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 17:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbhGVPOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 11:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhGVPOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 11:14:54 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE0EC061760;
        Thu, 22 Jul 2021 08:55:28 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id o72-20020a9d224e0000b02904bb9756274cso5712978ota.6;
        Thu, 22 Jul 2021 08:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pEI9JoD+EK/NQibnY1I31vk0qudP9D/krryg6PZfRnY=;
        b=uspIcQM5PhSYwYzZZR+fn1zErcWeV+JFzXKqecRhfmJmEyqySJgAsIRxONQW4tBRM6
         00KJthNIrjXaydppLa2HWm8hFaJt9zEDeHT+ea9Lxa04U6kdsy/SAnEUoyyaOY7nzRNz
         2aeH5TriQbfqa2pI+FNFRomY85vROLOEI351mB+7at3nkv3y50TDfGCMf5OPOGJkh3Dj
         ZRgt23fu5qLf+Lmr1eA9dwMG/5fUfzGRbMBBNNHUOts4s/M9vv6s54MuKh3KhBgkCwcI
         Kzv4n9t1BwQ68UHhOjKl+EfBWgNU6jk0+HCFmhtGi0KcgJ+FHLKCpii9H+mW9jqS8+Bm
         MAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=pEI9JoD+EK/NQibnY1I31vk0qudP9D/krryg6PZfRnY=;
        b=TxcxYRMcmyVtJya2jJIjJGYb6RZvGZAicb570XKSAHfYH4fBC3j4rRIHNcx+wcbDsi
         HLcKtkVH/XQUwq4h+dOv1zPSZRHstW3GU1VwheB0DjTsTYESkF8iYcIZ+QPGEKcUa7+I
         cEJdEKpVMZNNttSnYnLckfjXRlNS/l62U5LwsjHHFyfQHLK3bJOpegv2ksN1RmYTFQ8P
         FfYHe+IeCiOUatavp3y25fbtnOOSWEI7sKmmkPwe8IbYTM2uMvVu0wlOr3215xWe52Na
         /trOstBFpU1Tl5tkcF5NFpjYbSXI7VhBzclc4sJXTZcY7h/byPXILJhqSGFcNwqch8up
         dACg==
X-Gm-Message-State: AOAM530KdiMaG6/vLds7FPllSR7gjIuBfFAuEspz1OiNT4ratN/PjG8X
        axAkD2JEJny/rUhPRrVwnRw=
X-Google-Smtp-Source: ABdhPJz815fgYZGdhbFAKwJRnDFTOlCEwBGSbPHJavudPzt52w02lj8OvUugq9e02yFANCbpEPlzng==
X-Received: by 2002:a9d:37c9:: with SMTP id x67mr294339otb.2.1626969327645;
        Thu, 22 Jul 2021 08:55:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s19sm973940ooj.7.2021.07.22.08.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 08:55:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 22 Jul 2021 08:55:25 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/15] dt-bindings: firmware: update arm,scpi.yaml
 reference
Message-ID: <20210722155525.GA3369686@roeck-us.net>
References: <cover.1626947923.git.mchehab+huawei@kernel.org>
 <b5a2b0cb83e7f8193b4be4cef9250dd4c42877ab.1626947923.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5a2b0cb83e7f8193b4be4cef9250dd4c42877ab.1626947923.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 11:59:59AM +0200, Mauro Carvalho Chehab wrote:
> Changeset 1496be719468 ("dt-bindings: firmware: arm,scpi: Convert to json schema")
> renamed: Documentation/devicetree/bindings/arm/arm,scpi.txt
> to: Documentation/devicetree/bindings/firmware/arm,scpi.yaml.
> 
> Update its cross-reference accordingly.
> 
> Fixes: 1496be719468 ("dt-bindings: firmware: arm,scpi: Convert to json schema")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  Documentation/hwmon/scpi-hwmon.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/hwmon/scpi-hwmon.rst b/Documentation/hwmon/scpi-hwmon.rst
> index eee7022b44db..1e3f83ec0658 100644
> --- a/Documentation/hwmon/scpi-hwmon.rst
> +++ b/Documentation/hwmon/scpi-hwmon.rst
> @@ -32,5 +32,5 @@ Usage Notes
>  
>  The driver relies on device tree node to indicate the presence of SCPI
>  support in the kernel. See
> -Documentation/devicetree/bindings/arm/arm,scpi.txt for details of the
> +Documentation/devicetree/bindings/firmware/arm,scpi.yaml for details of the
>  devicetree node.
