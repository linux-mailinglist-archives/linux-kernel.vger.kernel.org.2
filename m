Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C421830ED9B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 08:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbhBDHmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 02:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbhBDHmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 02:42:36 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E75C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 23:41:55 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id r38so1497189pgk.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 23:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+T/XkEibqIsqzl6xLjHvI2SLruRnV2ktpzaCB+SbV7U=;
        b=OZqjmFzGYOrsHrJy15QZnreBH4eSYxKU9iKZLuS8X/1AxLmy2a5h2ZW2XjQ98VEe/p
         UORWZdcrDuDvBPiHIgVumv7GuIjiSeWrEZGm1XNk7Z3vLxiZ0T/LTw6Gqsc7b0JO259T
         B/keTau4k2zcR5UqqzgQ7DnhjdyXw7f8REnlvLXJ28pb82XPsiDJ6Y5YL6nzN6C98aF8
         zvcS7aJr8O3TI+Vz6fTwaG+ojdnw7Kc9D3sCXXOUXgl9NnLOO85BcJHUOnmte8YIUuyB
         smUrlIy0/yEd6bAHSjMtgoXXptA/A97sHoBfkHteLxshAOPBlH5eH8kYuj56pkktnyIy
         TUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+T/XkEibqIsqzl6xLjHvI2SLruRnV2ktpzaCB+SbV7U=;
        b=B/vS2YIfPOXOf4fepYPf9d/Ub/1HtOTshCkIy9j+So1NkKLjsiqD8AYMMuiOCo3B0x
         3w8AfIPLEptMJM/JeioF23osk8h+hCAdpK/YcInghzWFxeC7UHlU3CZJtv6g0xuBvjZ2
         dYpEfI9e3zPEJNMfkbBkwlJ4P+BezECDOB3GoEx/mTwhU2OIUNgiwazddqPzZWEPl/jl
         Z9EVhaGFZvuZKfVuyqg8BorTBqz9VBBH8qWd4S6LU7e/EdoJDCN5kx6vG3AlVl3Gn/ir
         LoqD0HMsZ3M8WG6ZJAUjxrA4xtt5pmm1SIMv6zHJlXkqSrCmmZSDjEUIDGaRAZW2I78o
         F6rQ==
X-Gm-Message-State: AOAM531VCNvypGJoK0NlUd/cMKXOEiYRq/6zM0zBXqiOcpwWQ5UeR6sp
        bC07z1Jixu8MWh0ljBneMm4BeA==
X-Google-Smtp-Source: ABdhPJwI75LH6CnAfe9TCq1QEBoUGhuJAdIOL4m6FN7dR92B6bUDwDRCBXkfd3oSd/NaFsEbkbAw2g==
X-Received: by 2002:aa7:9012:0:b029:1bb:b49f:7eb3 with SMTP id m18-20020aa790120000b02901bbb49f7eb3mr6908617pfo.67.1612424515421;
        Wed, 03 Feb 2021 23:41:55 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id i10sm4812776pgt.85.2021.02.03.23.41.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2021 23:41:54 -0800 (PST)
Date:   Thu, 4 Feb 2021 13:11:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, anmar.oueja@linaro.org,
        Bill Mills <bill.mills@linaro.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        devicetree@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH V7 6/6] of: unittest: Statically apply overlays using
 fdtoverlay
Message-ID: <20210204074152.r7gxgippv22dufov@vireshk-i7>
References: <cover.1611904394.git.viresh.kumar@linaro.org>
 <3683a542d4141cfcf9c2524a40a9ee75b657c1c2.1611904394.git.viresh.kumar@linaro.org>
 <20210204015409.GA3150757@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204015409.GA3150757@robh.at.kernel.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-02-21, 19:54, Rob Herring wrote:
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index b00855b247e0..886d2e6c58f0 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -66,6 +66,9 @@ multi-used   := $(multi-used-y) $(multi-used-m)
>  real-obj-y := $(foreach m, $(obj-y), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y)) $($(m:.o=-))),$($(m:.o=-objs)) $($(m:.o=-y)),$(m)))
>  real-obj-m := $(foreach m, $(obj-m), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y)) $($(m:.o=-m)) $($(m:.o=-))),$($(m:.o=-objs)) $($(m:.o=-y)) $($(m:.o=-m)),$(m)))
>  
> +real-dtb-y := $(foreach m,$(dtb-y), $(if $(strip $($(m:.dtb=-dtbs))),$($(m:.dtb=-dtbs)),))
> +dtb-y += $(real-dtb-y)
> +
>  always-y += $(always-m)
>  
>  # hostprogs-always-y += foo
> @@ -332,6 +335,15 @@ $(obj)/%.dtb: $(src)/%.dts $(DTC) FORCE
>  $(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
>  	$(call if_changed_dep,dtc)
>  
> +
> +quiet_cmd_fdtoverlay = DTOVL   $@
> +      cmd_fdtoverlay = $(objtree)/scripts/dtc/fdtoverlay -o $@ -i $(real-prereqs)
> +
> +.SECONDEXPANSION:
> +
> +$(obj)/%.dtb: $$(addprefix $$(obj)/,$$(%-dtbs)) FORCE
> +	$(call if_changed,fdtoverlay)
> +
>  DT_CHECKER ?= dt-validate
>  DT_BINDING_DIR := Documentation/devicetree/bindings
>  # DT_TMP_SCHEMA may be overridden from Documentation/devicetree/bindings/Makefile

Thanks, this simplifies it greatly for platform guys.

-- 
viresh
