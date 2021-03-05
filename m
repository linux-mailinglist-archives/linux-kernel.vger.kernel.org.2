Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF99E32F61D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 23:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhCEWxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 17:53:09 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:37871 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhCEWwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 17:52:37 -0500
Received: by mail-ot1-f51.google.com with SMTP id 75so123039otn.4;
        Fri, 05 Mar 2021 14:52:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fUZFQaxs9RK/nivefXJKnBUxIyLdj8Lj9lxBmJxd9y8=;
        b=ibiunizmizbd1JCiVCiOUHRH5N55da89jXdEz9o/jfyFpevCgy6PK++7EpWF1hCud0
         GHYFgtqtYoyhwU6RVI7+Y/YZwrIGK31u4sT9Djj7NKU/ArVyRZDhhiMWBoqicEy4tmtD
         fNkcmA9C41D7uYroD4iGALK+fN/TPtdJIhdOJBSlb/t9rJci349jyTvxgbRUOmVrdilR
         sFuXGYMiYT08gYmVApr82OiDHLAXGfVP8or1i0u0BcRFl0/hA5NIoh78+SUi0a4hE8xi
         Ogc2+WvOMYEj0tiEoIrKwQZad9gihDKcY6RX0HzIyZQAfPAZ1e3l49x78AIdazCmtnOH
         Tz3Q==
X-Gm-Message-State: AOAM533tKFNMAs134Uu3gEIIlp4K221UdZqc+Q8+ueksNLc6eIkZjpf8
        qxt4fGGvHmN681wrQQMjFQ==
X-Google-Smtp-Source: ABdhPJwlh+CUnCHrztqC0i3YQRWh8hWwtwlWL3hesELWhTlIBXv8/e94LdBUBtiOVgIXc/QuyRjaNw==
X-Received: by 2002:a9d:67c2:: with SMTP id c2mr10005348otn.343.1614984757122;
        Fri, 05 Mar 2021 14:52:37 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g11sm835060oif.9.2021.03.05.14.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 14:52:35 -0800 (PST)
Received: (nullmailer pid 790202 invoked by uid 1000);
        Fri, 05 Mar 2021 22:52:34 -0000
Date:   Fri, 5 Mar 2021 16:52:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     David Airlie <airlied@linux.ie>, Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh+dt@kernel.org>,
        allen <allen.chen@ite.com.tw>, Shawn Guo <shawnguo@kernel.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Max Merchel <Max.Merchel@tq-group.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 1/9] dt-bindings: Add Jenson Display vendor prefix
Message-ID: <20210305225234.GA790152@robh.at.kernel.org>
References: <20210218225458.823773-1-giulio.benetti@benettiengineering.com>
 <20210218225458.823773-2-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218225458.823773-2-giulio.benetti@benettiengineering.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Feb 2021 23:54:49 +0100, Giulio Benetti wrote:
> From: Giulio Benetti <giulio.benetti@micronovasrl.com>
> 
> Update Documentation/devicetree/bindings/vendor-prefixes.yaml to
> include "jenson" as a vendor prefix for "Jenson Display".
> Company website: http://www.jensondisplay.com/
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
