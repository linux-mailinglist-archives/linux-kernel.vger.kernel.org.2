Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABAD93314BD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhCHRZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:25:04 -0500
Received: from mail-il1-f172.google.com ([209.85.166.172]:43831 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbhCHRYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:24:53 -0500
Received: by mail-il1-f172.google.com with SMTP id b5so9514839ilq.10;
        Mon, 08 Mar 2021 09:24:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R8gKey3dqPPlv14cbiWtlikKVEw7APesOnqMJJKljpo=;
        b=dma5AT4kasJV1mq4Xip1CUm8H5E7B6T0yy3YFHBJ5tapZUD1kCmzIdFFYU+I4axNnS
         Xh2d/OOMz7DPq2UDTHP1Ce9vmWsqFYDibqmOA23osn8GQVsMwV3nF6CBZAKyyLycKjah
         DNCiH7w7KOk36r0TH7ipJbn0Y7X2xIV37AMB25v/weUoEOvm8bEZnNPIbeIHPblu/AKx
         gasbOePo0+z+jFBDWdZroTCspWNVVW/d7m+2GHFKWQybX2TbiwJkkR9UqT4hYpS5Mw8A
         RyA+kNFvYhaLaK1UYXOmetkjc98gaD2BWGmDOkSet9KMVwuGB5jzpTMVaw6u/YRngIhC
         vowA==
X-Gm-Message-State: AOAM532KwLIPEKmOBKkfD8XUYlM6R3O5N4IvexyUxr0g5f3VH5+VUqHi
        HSr/2LR44WUoBCXfF4mAng==
X-Google-Smtp-Source: ABdhPJxagGrSADn7x14IJxmNxUggJ5drrypy3N1weXpB6jWR8dDO41XnCg6MuTz+YTpgSPM8eE7ZMw==
X-Received: by 2002:a05:6e02:12ac:: with SMTP id f12mr20640279ilr.103.1615224293332;
        Mon, 08 Mar 2021 09:24:53 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id k23sm6361502iol.36.2021.03.08.09.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 09:24:52 -0800 (PST)
Received: (nullmailer pid 2659624 invoked by uid 1000);
        Mon, 08 Mar 2021 17:24:50 -0000
Date:   Mon, 8 Mar 2021 10:24:50 -0700
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-amarula@amarulasolutions.com, linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 06/10] dt-bindings: arm: stm32: Add Engicam i.Core
 STM32MP1 C.TOUCH 2.0
Message-ID: <20210308172450.GA2659327@robh.at.kernel.org>
References: <20210228154323.76911-1-jagan@amarulasolutions.com>
 <20210228154323.76911-7-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210228154323.76911-7-jagan@amarulasolutions.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Feb 2021 21:13:19 +0530, Jagan Teki wrote:
> i.Core STM32MP1 is an EDIMM SoM based on STM32MP157A from Engicam.
> 
> C.TOUCH 2.0 is a general purpose carrier board with capacitive
> touch interface support.
> 
> i.Core STM32MP1 needs to mount on top of this Carrier board for
> creating complete i.Core STM32MP1 C.TOUCH 2.0 board.
> 
> Add bindings for it.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v3:
> - none
> 
>  Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
