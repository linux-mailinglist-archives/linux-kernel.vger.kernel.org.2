Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384684138D2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 19:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhIURnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 13:43:19 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:34439 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhIURnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 13:43:18 -0400
Received: by mail-ot1-f52.google.com with SMTP id n65-20020a9d2047000000b00547334367efso2472807ota.1;
        Tue, 21 Sep 2021 10:41:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6b4IIW0sN4JgYgdnLZbHu/GA4zvnwxshVHJp0K1k4Ac=;
        b=nlu2lVp55DVcSoaEwzDh180x5aKc4BaQpVDuUPrFf3iTAO4c6iqfQfVJ9Yl2pFdRfU
         f4JLqcEIj/8KqAU5yqU8VmxhcVwgMyXLatOVM1pgVCMYInubDhqd2vUBSAvTUEb/0jWK
         a8f+/rOGbsGHiIvyXlnfVjMDsC9f886o1WbDLmg9Anz/KYC1GtDAqcOsZK7lVvAaBIGi
         JP0B3m2VXHxsKefIM04UKSl3eCuBTR58gp4g9VpjHTgapri9sx74HTL77WZmNyiaHdeC
         E4R/H4hy+MuISPRuEaXcNEsQzc2vnlzdiqO7Py595PHVUOj+uTPJAc+AHi+au512Ts6w
         n7Wg==
X-Gm-Message-State: AOAM533s8Q+jKslUNyEAB9+8oSOCoZZLtLgiZXip0qI0Lf30+7FFUQ49
        BVDQG2+7Ry2Kj+oSCtgRTA==
X-Google-Smtp-Source: ABdhPJwq32Lfdjus9F4ALYlFMLXBPgzEb5VmjZWvPnw9Sl3pngoSqz9+jwvyN2g9rSRQEgRyRuvScg==
X-Received: by 2002:a05:6830:40ca:: with SMTP id h10mr8440832otu.187.1632246109250;
        Tue, 21 Sep 2021 10:41:49 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s26sm2011789ooc.26.2021.09.21.10.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 10:41:48 -0700 (PDT)
Received: (nullmailer pid 3020375 invoked by uid 1000);
        Tue, 21 Sep 2021 17:41:47 -0000
Date:   Tue, 21 Sep 2021 12:41:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: display: Add binding for LG.Philips
 SW43101
Message-ID: <YUoZW3zfW+9W9Ouh@robh.at.kernel.org>
References: <20210909043904.12982-1-y.oudjana@protonmail.com>
 <20210909043904.12982-3-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909043904.12982-3-y.oudjana@protonmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Sep 2021 04:40:27 +0000, Yassine Oudjana wrote:
> Add a device tree binding for LG.Philips SW43101.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
> Changes since v1:
>  - Add regulator support.
>  - Add MAINTAINERS entry.
>  - Dual-license DT binding.
> 
>  .../display/panel/lgphilips,sw43101.yaml      | 75 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/lgphilips,sw43101.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
