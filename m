Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9558D32EEC6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 16:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhCEP01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 10:26:27 -0500
Received: from mail-oo1-f52.google.com ([209.85.161.52]:33649 "EHLO
        mail-oo1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhCEP0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 10:26:05 -0500
Received: by mail-oo1-f52.google.com with SMTP id z22so513499oop.0;
        Fri, 05 Mar 2021 07:26:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UGAA0VPbUBDV2qLusFPRZCr8HQGQiMTQXTjHRkiKM9U=;
        b=HKASSMqMSjBlcfAflKNFZejHVHZn4XlVArsVye2cqBUZ4XRFyfrlt8NgfFcrJZDrIZ
         MGz8sQJz3TvF55704qEcM5fqze80UWIECh1VyjxLH8NKUJfUw5nOMW5t1FnR609As3oi
         XT/DLiPIJT9r0GNQ74GyB4FgySsnXb0R9Vvk+0uK5oRt2Un9XaFsL3nsUsdknRi15DD1
         SiNjEcTqXPYDufmrDT6wnktnkgzxWn+4T16Q8pJLHOWo10mmSFpLhh1zg9ssVs0TUtHM
         cRztYxEneDXULu36PYUPeQNhcwr1J/4U7T3nedqsuoxJLhN2vk0v1j/m6mXNS9z+CP41
         /f6w==
X-Gm-Message-State: AOAM531mbGllPyHy7MXWxn5G1vPTFn9XAze9S036JEMIvbMHf8ZiNkwm
        1jwYN45oDbKkuX5R0BpmLV9k6GR8uQ==
X-Google-Smtp-Source: ABdhPJx3lV/XmuOxRe9jwX3wFlzW99kU6evn3a/1b6kGViDLbxlbZSot1vM6FZNCeizVp/3t0bzTyw==
X-Received: by 2002:a4a:3901:: with SMTP id m1mr8185039ooa.60.1614957964956;
        Fri, 05 Mar 2021 07:26:04 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c2sm575653ooo.17.2021.03.05.07.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 07:26:03 -0800 (PST)
Received: (nullmailer pid 185595 invoked by uid 1000);
        Fri, 05 Mar 2021 15:26:01 -0000
Date:   Fri, 5 Mar 2021 09:26:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     linux-amarula@amarulasolutions.com,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [PATCH v3 01/10] dt-bindings: arm: stm32: Add Engicam MicroGEA
 STM32MP1 MicroDev 2.0
Message-ID: <20210305152601.GA185123@robh.at.kernel.org>
References: <20210228154323.76911-1-jagan@amarulasolutions.com>
 <20210228154323.76911-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210228154323.76911-2-jagan@amarulasolutions.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Feb 2021 21:13:14 +0530, Jagan Teki wrote:
> MicroGEA STM32MP1 is a STM32MP157A based Micro SOM.
> 
> MicroDev 2.0 is a general purpose miniature carrier board with CAN,
> LTE and LVDS panel interfaces.
> 
> MicroGEA STM32MP1 needs to mount on top of this MicroDev 2.0 board
> for creating complete MicroGEA STM32MP1 MicroDev 2.0 Carrier board.
> 
> Add bindings for it.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v3:
> - updated commit message
> Changes for v2:
> - none
> 
>  Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
