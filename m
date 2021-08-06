Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142DC3E314F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 23:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244526AbhHFVpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 17:45:15 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:36836 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241587AbhHFVpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 17:45:14 -0400
Received: by mail-io1-f47.google.com with SMTP id f11so14168433ioj.3;
        Fri, 06 Aug 2021 14:44:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OiJRnkJaUjfv/aLiJhC4+fz+0EuCXrsBg4+ADr+wcwA=;
        b=ASzVSkMFjNHsGosgd71SD8A2L1BafojMpVMLrgYGtIJaH7bOZ0BJZCf0m4GqEpdz6R
         1UNZEoKRRNhGIbkdwPHjdSezvJJR0SE2aFe6hy/i/aeq+EW7Vz3ndruP1MVd2qugfFt5
         KXCVHNwftMNuezTTycYmqFL1I5qxX2LBR/IALa9SDegTKtpMglwiAeakW2fHHebX0TVN
         G5ZYCc/iErG6uAAomI2qO8/rMsByFeo4pBHEnnasUdjSAA0qFYzuhe4PjhKel0MGntLC
         PRGqDHlSlzqcAZlAd8q07deo2uzvz9NBPGDjTkmu/N91OpLUl7/fZpIxlmrqRYYHHGMG
         2mRA==
X-Gm-Message-State: AOAM532V8gWiB69xuVWcZjB7PTWjz0OstPjYxCo38g+EG6dRJI/cCG4y
        RYJ02+dyjvLmCuO2cNYpLQ==
X-Google-Smtp-Source: ABdhPJwLfIBh9khfUI7Z/9TbGgFOAVVJ+cjV1JQDbb3YB5JIM5Bc430e/apfLRVKBcGRXjsQfcPU9g==
X-Received: by 2002:a6b:ba02:: with SMTP id k2mr575119iof.164.1628286296708;
        Fri, 06 Aug 2021 14:44:56 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id f5sm5329303ilr.72.2021.08.06.14.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 14:44:55 -0700 (PDT)
Received: (nullmailer pid 1858212 invoked by uid 1000);
        Fri, 06 Aug 2021 21:44:54 -0000
Date:   Fri, 6 Aug 2021 15:44:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@sipeed.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 1/4] dt-bindings: vendor-prefixes: add Zhishengxin
Message-ID: <YQ2tVnKsLNTn4tUF@robh.at.kernel.org>
References: <20210802063538.75583-1-icenowy@sipeed.com>
 <20210802063538.75583-2-icenowy@sipeed.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802063538.75583-2-icenowy@sipeed.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Aug 2021 14:35:35 +0800, Icenowy Zheng wrote:
> Shenzhen Zhishengxin Technology Co., Ltd. is a LCD module supplier.
> 
> Add vendor prefix for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@sipeed.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
