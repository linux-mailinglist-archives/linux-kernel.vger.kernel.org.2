Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBF5376C75
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 00:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhEGWUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 18:20:48 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:43565 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhEGWUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 18:20:47 -0400
Received: by mail-ot1-f51.google.com with SMTP id u19-20020a0568302493b02902d61b0d29adso8419934ots.10;
        Fri, 07 May 2021 15:19:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0UetlzgMV9sWP3u8qRhR3UDA/39bSH3aEdnfUV/MJQQ=;
        b=X7mY1BoASl1f2DNH3RGwaHHKTczlHD0569oZ9YplHjOUPmgLJMug9+Axwav+LH+tKo
         7Ky8wvj0AuXNJ4Q7eMqAj2GFlBQPts/qR8BUYzVzhKyEfGzcS/195eh1ZfE8tSay0T7x
         lBrhG5Kpojje9HtJEKdwc/Sx0O7gCdLxq2zBZc2Gv3RyOT+dcpkOyNx/H5LcGeRfHDvG
         SB+Ii/FvaqPvI9xcx6KIZVzhoslWruxYoPPUNHq9x2YxTwucwCjhFSpp6XD2+mSQ2Jhm
         HIJRW1W0bZw2mVh4RR10/AfJsC+KYcTD6gAZGSxzMAFyf0Q7sNyHQWnLrN931eJeDYEU
         ce9Q==
X-Gm-Message-State: AOAM532EFTDytLRp+Ye2CCMfo/5tHfEFCwAVCgBRMqwwlF0w/0/Z1MXS
        1bzFNP9OCObaTkMuxkqsLA==
X-Google-Smtp-Source: ABdhPJxNU1vmGTSxd18QKVJuF56qr1MXCsPEJ8Wu+etL3EOUxJ05T0RrrzEPXZuxrzm6y2HLeWnaVA==
X-Received: by 2002:a9d:69c9:: with SMTP id v9mr10185365oto.65.1620425986095;
        Fri, 07 May 2021 15:19:46 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r189sm1232402oif.8.2021.05.07.15.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 15:19:45 -0700 (PDT)
Received: (nullmailer pid 3000692 invoked by uid 1000);
        Fri, 07 May 2021 22:19:44 -0000
Date:   Fri, 7 May 2021 17:19:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     sam@ravnborg.org, robh+dt@kernel.org, airlied@linux.ie,
        thierry.reding@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/3] dt-bindings: display: simple: Add YTS700TLBC-02-100C
 and G104AGE-L02
Message-ID: <20210507221944.GA3000663@robh.at.kernel.org>
References: <20210507080017.2794-1-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507080017.2794-1-mike.looijmans@topic.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 May 2021 10:00:15 +0200, Mike Looijmans wrote:
> Adds these panels to the dt bindings:
> - Yes Optoelectronics YTS700TLBC-02-100C
> - Innolux G104AGE-L02
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
>  .../devicetree/bindings/display/panel/panel-simple.yaml       | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
