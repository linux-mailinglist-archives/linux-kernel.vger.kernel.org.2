Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A39134F3E2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 00:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbhC3V76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 17:59:58 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:38717 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbhC3V7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:59:40 -0400
Received: by mail-ot1-f49.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so17019344otk.5;
        Tue, 30 Mar 2021 14:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ct7bQjqlmuzUZdOiA5dbz3QfeJ0p9yFzsZbuoy4bHrU=;
        b=OaSndu1DGZzBBdg/O9TnauELRH+0sk9j0oBcplULXB4Q76WVI6dPDz9uoGd6IfYgwN
         4DA1hgkZHkVtlV4V42RTDe26EBmM9zbY4PQf1TMs/JFet9+HxC+P4F4PirpEqSMXV25m
         S4+JGgsHW5tkFyZoO+ae1aKu2MXHczod29vAElrYmz8qKeKwumYSn1ypBk7VmQMT2xCj
         Fvfe3TLxPRbfJCuJ2gdiqK5aO0IpT/Pu9ZFXithRXkpCYN27POdM1vIKPNoFeniFdrEV
         UgGKRlhruWuS+rg1Zsxw5e3RHCpPprpDnoFP6KZuIR1HUkM77NQTy7nurCmvcakZQfkM
         JQeg==
X-Gm-Message-State: AOAM530KZMJcl4ghNb+kAKl3e6RPoYRhezO5uqklwsRZTEAEUBK2sqVt
        nq9vP7kzMORpHS8bCLrGhA==
X-Google-Smtp-Source: ABdhPJxtjGfrnIV6FqaxZx99Gyr7rWag7GQjzOLgtAbpPj6cRxrK/b0wK/km+25shVcpcrVsP8FQ3A==
X-Received: by 2002:a9d:550b:: with SMTP id l11mr46907oth.218.1617141579649;
        Tue, 30 Mar 2021 14:59:39 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x18sm20207otr.73.2021.03.30.14.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 14:59:39 -0700 (PDT)
Received: (nullmailer pid 788808 invoked by uid 1000);
        Tue, 30 Mar 2021 21:59:38 -0000
Date:   Tue, 30 Mar 2021 16:59:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: usb: mtk-xhci: remove redefinitions
 of usb3-lpm-capable
Message-ID: <20210330215938.GA788756@robh.at.kernel.org>
References: <1617002411-9015-1-git-send-email-chunfeng.yun@mediatek.com>
 <1617002411-9015-2-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617002411-9015-2-git-send-email-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2021 15:20:09 +0800, Chunfeng Yun wrote:
> The property usb3-lpm-capable is defined in usb-xhci.yaml which is
> already referenced in this file, so no need 'description' and 'type'
> anymore.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v3: new patch
> ---
>  Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
