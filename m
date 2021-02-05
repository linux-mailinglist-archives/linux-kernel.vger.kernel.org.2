Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB8E310F4E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 19:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbhBEQRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 11:17:25 -0500
Received: from mail-oo1-f43.google.com ([209.85.161.43]:40225 "EHLO
        mail-oo1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbhBEQOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 11:14:04 -0500
Received: by mail-oo1-f43.google.com with SMTP id d3so1826936ool.7;
        Fri, 05 Feb 2021 09:56:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T42QgMy/ntJkBGGqkjSbsJZWWBXpaF/+D1lujMvpfJc=;
        b=szzp/a+SVbqOecyk+QP31dFleLINaDlEq6dM/OBhIAf4AVHBGkh4aIO9kVb47cVJm6
         F18SGpQQiNO5WCVamvdEzsrSyVzlBWvrzQmbh1LVxF645K9pAOnXqyBLr4+Tb02NDip3
         WaGas72Tboma9wnR7zGGsbMOg45HARwYAQm1X0jJX0W9qZXHRWSfhijQul1eotZkM2Nv
         wNbrbXRmcJYU+TibSWUUcpIcCWQGdo0TbvdeRvHk4TmNTdZYYL6JUDjfshrsBLudD1bk
         Mrp6v1LRX2mCHYtuRCJdoXWPs9CsqQZYxXYVigIo2UQH3JJnmHaF77Ouu77u9JMlTrW0
         2i9A==
X-Gm-Message-State: AOAM531HU8/oNvz1RlC+vsxy/fxnsH7bvMYs1WEP5fgDJ0qkZG51zN33
        itlpC8B/gOfrpC/GhENw9w==
X-Google-Smtp-Source: ABdhPJySCZ7kdYpyhimOLr/9yznPkOjWJYIhPiUxyeO0L7wpfbeLU1V09oGJfG5EdCAHFIQTPlY7BA==
X-Received: by 2002:a4a:a745:: with SMTP id h5mr4329374oom.21.1612547745786;
        Fri, 05 Feb 2021 09:55:45 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x9sm1919074ota.23.2021.02.05.09.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 09:55:44 -0800 (PST)
Received: (nullmailer pid 3364197 invoked by uid 1000);
        Fri, 05 Feb 2021 17:55:43 -0000
Date:   Fri, 5 Feb 2021 11:55:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org, hsinyi@chromium.org,
        Matthias Brugger <matthias.bgg@gmail.com>, fshao@chromium.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        boris.brezillon@collabora.com, dri-devel@lists.freedesktop.org,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Steven Price <steven.price@arm.com>, hoegsberg@chromium.org
Subject: Re: [PATCH v11 1/4] dt-bindings: gpu: mali-bifrost: Add Mediatek
 MT8183
Message-ID: <20210205175543.GA3363048@robh.at.kernel.org>
References: <20210126011759.1605641-1-drinkcat@chromium.org>
 <20210126091747.v11.1.Ie74d3355761aab202d4825ac6f66d990bba0130e@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126091747.v11.1.Ie74d3355761aab202d4825ac6f66d990bba0130e@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jan 2021 09:17:56 +0800, Nicolas Boichat wrote:
> Define a compatible string for the Mali Bifrost GPU found in
> Mediatek's MT8183 SoCs.
> 
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
> 
> Changes in v11:
>  - binding: power-domain-names not power-domainS-names
> 
> Changes in v10:
>  - Fix the binding to make sure sram-supply property can be provided.
> 
> Changes in v9: None
> Changes in v8: None
> Changes in v7: None
> Changes in v6:
>  - Rebased, actually tested with recent mesa driver.
> 
> Changes in v5:
>  - Rename "2d" power domain to "core2"
> 
> Changes in v4:
>  - Add power-domain-names description
>    (kept Alyssa's reviewed-by as the change is minor)
> 
> Changes in v3: None
> Changes in v2: None
> 
>  .../bindings/gpu/arm,mali-bifrost.yaml        | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

