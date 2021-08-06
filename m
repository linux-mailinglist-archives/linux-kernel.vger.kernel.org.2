Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471FB3E309E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 23:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238068AbhHFVDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 17:03:19 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:36526 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbhHFVDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 17:03:18 -0400
Received: by mail-io1-f50.google.com with SMTP id f11so13945318ioj.3;
        Fri, 06 Aug 2021 14:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TQ+1J/oSmyy58ro7pu71MH0rvdIYdla0sRpmF6tCuWM=;
        b=ISnhRSe8nFytHYNchJnHfNXZFHdQBZw2KdsQfWUQRfi6FqDCOZJFkrf5S/xEX8B7g0
         Z2Xcgnezy/NH0FVtbRvjO7T37V+HpBnI7HWe5iAUV7NMyyivyDM/6dR8dnRhesD71YPu
         nofvv/EzF4kVjoqoflEhTdu/wHz+3K/EWcKkh5/9p2zgf7TVXqCyOUSW1JCZcObrqu8q
         S5Om2DC1wB5qG3p+EA8AWV7cJGaoRep45ru/SpQf7fEHiN/nG7Z7MFNg6GyxbcKOl+O0
         8ZRryVawcupEgpZau2p7Bq3klc36W9L4qbdZilWVQYUpm8LYIP8xVRAI7CIPIzhZmsbE
         aVKA==
X-Gm-Message-State: AOAM531yP6EQxCAHNH9LCBZWVdYE9niFR+i4tg65aFGJEb/gCVywgVym
        mscqKLCU6yioNk7tg+jhJg==
X-Google-Smtp-Source: ABdhPJz7k/I8gGPnzKdwDC+lKONhc+T7+etGmbtEnhSUA3ROo258cn7y+zIEVRvrbYIcHh3fc1Rcnw==
X-Received: by 2002:a5e:d91a:: with SMTP id n26mr565726iop.96.1628283781117;
        Fri, 06 Aug 2021 14:03:01 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id u9sm2991459ilv.75.2021.08.06.14.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 14:03:00 -0700 (PDT)
Received: (nullmailer pid 1792397 invoked by uid 1000);
        Fri, 06 Aug 2021 21:02:58 -0000
Date:   Fri, 6 Aug 2021 15:02:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bert Vermeulen <bert@biot.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Max Merchel <Max.Merchel@tq-group.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Hao Fang <fanghao11@huawei.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Felix Fietkau <nbd@nbd.name>, linux-kernel@vger.kernel.org,
        John Crispin <john@phrozen.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Palmer <daniel@0x0f.com>
Subject: Re: [PATCH 1/5] dt-bindings: Add vendor prefix for EcoNet
Message-ID: <YQ2jgnAvtMNyx2c/@robh.at.kernel.org>
References: <20210730134552.853350-1-bert@biot.com>
 <20210730134552.853350-2-bert@biot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730134552.853350-2-bert@biot.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jul 2021 15:45:48 +0200, Bert Vermeulen wrote:
> From: John Crispin <john@phrozen.org>
> 
> Add vendor prefix "econet" for EcoNet.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Bert Vermeulen <bert@biot.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
