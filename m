Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571223BA2AC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 17:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbhGBPRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 11:17:16 -0400
Received: from mail-il1-f174.google.com ([209.85.166.174]:44729 "EHLO
        mail-il1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbhGBPRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 11:17:15 -0400
Received: by mail-il1-f174.google.com with SMTP id f12so3721265ils.11;
        Fri, 02 Jul 2021 08:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ut9imKxL6QnSk4qfHyI4LHUlOzS0PtJ0GGDAQ0op66c=;
        b=SJGZXTDhenUslSS9BqAXQ/qbYoqWr27zC5voqaxGmsBn+0WEncFCpHxyhH8tg6LJng
         EFc282MDp3NDuh96e6a4NyccrnEnZIG400oAESlHPLbqYd1YfEeBxn4Gw5nmBvvr9uBH
         LABgHn8exns+cOsWWEnFNP77hlzgX+HbcWb13/lkc7ZiiM7dn+ENULsPIj2gMAy2KdMC
         cMjDhl5djMLwn1i9Ga75oSt1Bm9O8J2xHLwougcBnHcseSAADJ4DcOJLlePbETAkWRO7
         LCw6M590+xmgueuG6swEgYmngMTsI1tVk7wbk/aTFNGUClnX+a6p7yK/PSQrhC0TikAa
         XPrw==
X-Gm-Message-State: AOAM531YR5bc/6OzUR32H8AIAWpitcm5M3sA3O5/SBiIFJHCzxhTVLvf
        v090yGPKnN4LQ8qMpztl6Q==
X-Google-Smtp-Source: ABdhPJyJQ+7r5oKAFDBY9y+s7apI5nAskZUs0JrjDvLU1ycLlp4sB/Uhwdv5yqQLYQelhXIiDZpx6g==
X-Received: by 2002:a92:dd89:: with SMTP id g9mr333572iln.209.1625238882803;
        Fri, 02 Jul 2021 08:14:42 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id g6sm1846444ilj.65.2021.07.02.08.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 08:14:41 -0700 (PDT)
Received: (nullmailer pid 437820 invoked by uid 1000);
        Fri, 02 Jul 2021 15:14:37 -0000
Date:   Fri, 2 Jul 2021 09:14:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matthew Hagan <mnhagan88@gmail.com>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        soc@kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 4/4] dt-bindings: arm: bcm: NSP: add Meraki MX64/MX65
Message-ID: <20210702151437.GA437656@robh.at.kernel.org>
References: <20210625095000.3358973-1-mnhagan88@gmail.com>
 <20210625095000.3358973-5-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625095000.3358973-5-mnhagan88@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jun 2021 10:49:51 +0100, Matthew Hagan wrote:
> Add bindings for the Meraki MX64/MX65 series.
> 
> Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

