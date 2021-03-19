Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6558C3427BF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 22:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhCSV20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 17:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhCSV2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 17:28:12 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E64C06175F;
        Fri, 19 Mar 2021 14:28:12 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id n140so6245827oig.9;
        Fri, 19 Mar 2021 14:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ilcSk8VycjIw9PpYr/RlJKjxl+yFh+ALRPCRLrC3KD4=;
        b=t37/PSzAFqFe0VfH5iLTfUWXBBIcWzy2W1c0iXyjSkl6GHHLWsFF+MuCs+rj/sCuth
         BXUkR5EIDuqsnSPOYU6b/Yf23dyM+NCdZ7cb7x+dDhUtO+MRmWFd7FRAHfKFPsPK0JSe
         u4flGkAgV3ItTRUX5uOUa09wEzM+zKuIVpXR+/lh1IcP0gA+oqjVmH2qe/WeM5WsVtQ0
         EN4l0ZAutX14zNjjsn5ktDHMiccZ9X+Y9AsoXg4EV78B4ZKSJ14XVP/Ha7LCyZhlii23
         5EpeoahcWjbCLbZiLJUI/UgljIZvP+aHiI2CwrMfsxL0gPiSxC+EOqM93izw7ImYx8+w
         9NBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ilcSk8VycjIw9PpYr/RlJKjxl+yFh+ALRPCRLrC3KD4=;
        b=IzP39VhZstG9hvf1pQl8BsBDGMYgfHZprgXlWl4oUM7KBwAEv0n18tcxYPU8STr5jE
         W+d1fKJGXjNGs7hZhRJKyFozpuHm5TwVSni4nKw4Z5sxl7DPabn7RnLOsOmGFDj5nxrs
         pkbfvZRlIbTpqoNhiVlO9p7pzwJYys7mJ85BZKnv49iBqfB3mBpMs+ZTKvoWYuk5hRsF
         JiWm+18V/8Y6r7zKWVrk5OLeeqwARh9Xxn7C94XBkoDUnlwNc7nJZ0HEIvgH5FPZki2/
         o0TRM9c+yFD1NIkWB4SOLJTXginfRAC739IQuMTEEt0Hx5ildP3Jsn5FMlehnTI62atK
         XQ9A==
X-Gm-Message-State: AOAM533DJGH8hOISpBobi0pJwgZjAYw2beUbqrzITw8TnnJIsXc6e50M
        dJosB0sie2zSSY/kFMq7Yec=
X-Google-Smtp-Source: ABdhPJyJnGs39V72ai5EC8itdQv3Lux6+l61DgJh5h65b6BkcfGWsg6zCGJ8IUoG7CjmItc52Y9NZg==
X-Received: by 2002:aca:d884:: with SMTP id p126mr2456643oig.118.1616189291677;
        Fri, 19 Mar 2021 14:28:11 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s191sm1462660oie.0.2021.03.19.14.28.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Mar 2021 14:28:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 19 Mar 2021 14:28:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Erik Rosen <erik.rosen@metormote.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: Add trivial device entry for TPS53676
Message-ID: <20210319212809.GA24020@roeck-us.net>
References: <20210318212441.69050-1-erik.rosen@metormote.com>
 <20210318212441.69050-2-erik.rosen@metormote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318212441.69050-2-erik.rosen@metormote.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 10:24:40PM +0100, Erik Rosen wrote:
> Add trivial device entry for TPS53676
> 
> Signed-off-by: Erik Rosen <erik.rosen@metormote.com>

For my reference (waiting for dt maintainer acceptance):

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index a327130d1faa..2e29c2a91966 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -288,6 +288,8 @@ properties:
>            - ti,tmp103
>              # Digital Temperature Sensor
>            - ti,tmp275
> +            # TI Dual channel DCAP+ multiphase controller TPS53676 with AVSBus
> +          - ti,tps53676
>              # TI Dual channel DCAP+ multiphase controller TPS53679
>            - ti,tps53679
>              # TI Dual channel DCAP+ multiphase controller TPS53688
