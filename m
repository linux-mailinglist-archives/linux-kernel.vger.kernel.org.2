Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF0B39C09E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 21:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhFDTsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 15:48:05 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:44768 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbhFDTsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 15:48:00 -0400
Received: by mail-oi1-f181.google.com with SMTP id d21so10834240oic.11;
        Fri, 04 Jun 2021 12:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KtqFnkN2/pSMHlDYiDJde+BbiYBB4jP0/McX/0Ynb/U=;
        b=JdLYsoLQVNidrIf4BaSsQCn21Scwa3EBmLFWH6N4GQtind66UWVfg/EWl4uAx2VtOh
         hvUn73lwoAPJeyPL1K/0aSLBoD0BrlgU2Hr2+NxrmPr+/JBSRhfBt1qQIlD3TaYWUrMv
         Flk6Q7xtrcTWK06k3U8jzrFsJBwu4dL4cVnf6PqHcMzUi0H8H37zZX1MCv4/jmB3/JJo
         tlr29tXF2LJR1p8hApiXY0MPzd9bqvOBdmldyxeVhn47a/qyH0+MIJua8mFZNBkn3WLm
         RP9gAIT5He34OPuywXP0qygAWIv7wa83W8gOprNv5TkPB/bDqVS2FxQaVOgrI9dht3ff
         zvqw==
X-Gm-Message-State: AOAM532YE2kNGgwIA8WmwD0gai6cVfC/1co8knFsfHMmJHCBfJ+n47cY
        Vo/0Pr1r5vUwgx1SEzJYfdgKNpkK8w==
X-Google-Smtp-Source: ABdhPJwZU/ARO8BRqxeuXve1LsMqInu8TwgAPqA1d49sbLMhRuzdrLfQ8vkOwmH5j2+SaWWmPZiT2w==
X-Received: by 2002:aca:280a:: with SMTP id 10mr12433499oix.13.1622835973777;
        Fri, 04 Jun 2021 12:46:13 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o11sm608856oog.30.2021.06.04.12.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 12:46:13 -0700 (PDT)
Received: (nullmailer pid 3793327 invoked by uid 1000);
        Fri, 04 Jun 2021 19:46:12 -0000
Date:   Fri, 4 Jun 2021 14:46:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hao Fang <fanghao11@huawei.com>
Cc:     xuwei5@hisilicon.com, prime.zeng@hisilicon.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: hisilicon: use the correct HiSilicon
 copyright
Message-ID: <20210604194612.GA3793123@robh.at.kernel.org>
References: <1621678997-15240-1-git-send-email-fanghao11@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621678997-15240-1-git-send-email-fanghao11@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 May 2021 18:23:17 +0800, Hao Fang wrote:
> s/Hisilicon/HiSilicon/.
> It should use capital S, according to the official website
> https://www.hisilicon.com/en.
> 
> Signed-off-by: Hao Fang <fanghao11@huawei.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
