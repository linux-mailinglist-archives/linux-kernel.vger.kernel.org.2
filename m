Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D3A34AFCD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 21:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhCZUGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 16:06:50 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:35377 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhCZUGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 16:06:31 -0400
Received: by mail-io1-f44.google.com with SMTP id x17so6652934iog.2;
        Fri, 26 Mar 2021 13:06:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZPC6AhpeUK9aDOYittyj6FiD+H8vNNaEbL6HgDphH9Y=;
        b=QFyF30XkK6kvv3tsmiv46JJYIRxDKL+nVO/x1AiIlSGHF2U752hDXiNW2Wwa433Gh/
         xMZqt6E8eRX1mo5EsnwYxX2dkcY9Sk1Sv4D6V9MWRZXB9I6q1QE3xAGtpFIzYuQMUOH4
         B8ER3aUzZXz9Dl4iq+8RemFbFvB3Sv1sZOw1fScHOZlZNe6yvyJBtmbGTdKN63gAJsaA
         leF/MelVRKSEuijc8jvONEvAS1pN76ioofCnlFx8ND0ahkJe9L6V9JW0APFAgxb/FHVN
         +lx/AljWBaakgx1zwvQVQ+LD7r0LRGu/kBoK+bYiPmU5jW7o5WcQYrTq0svtOi7NiWDd
         I5Dg==
X-Gm-Message-State: AOAM5306DcU6rti5rM4ovaCBKC9DXDPuect6j5HWygvbk65+PZRV51um
        EnKeeAMebccMTaCpCuSuSQ==
X-Google-Smtp-Source: ABdhPJzyEzuLouL86I5aw/aN83geqOXKVBaxXOaOqVr7XPwcSkwq5woeldZd12J9taFb95HyphUP2A==
X-Received: by 2002:a5d:9e09:: with SMTP id h9mr12176395ioh.178.1616789190894;
        Fri, 26 Mar 2021 13:06:30 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id y18sm4914955ili.16.2021.03.26.13.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 13:06:29 -0700 (PDT)
Received: (nullmailer pid 3781826 invoked by uid 1000);
        Fri, 26 Mar 2021 20:06:26 -0000
Date:   Fri, 26 Mar 2021 14:06:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Elaine Zhang <zhangqing@rock-chips.com>
Cc:     heiko@sntech.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        cl@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com, tony.xie@rock-chips.com,
        finley.xiao@rock-chips.com
Subject: Re: [PATCH v6 09/11] dt-bindings: power: rockchip: Convert to
 json-schema
Message-ID: <20210326200626.GA3776228@robh.at.kernel.org>
References: <20210326102738.14767-1-zhangqing@rock-chips.com>
 <20210326103036.15173-1-zhangqing@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326103036.15173-1-zhangqing@rock-chips.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 06:30:36PM +0800, Elaine Zhang wrote:
> Convert the soc/rockchip/power_domain.txt binding document to
> json-schema and move to the power bindings directory.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Link:https://patchwork.kernel.org/project/linux-rockchip/patch/20210225102643.653095-1-enric.balletbo@collabora.com/
> ---
>  .../power/rockchip,power-controller.yaml      | 291 ++++++++++++++++++
>  .../bindings/soc/rockchip/power_domain.txt    | 136 --------
>  2 files changed, 291 insertions(+), 136 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
>  delete mode 100644 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt

My review checks tell me I already reviewed this and IIRC that was 
pointed out to you in the last version. Am I supposed to review the 
whole thing again or is it unchanged or ???. I have no idea with no 
version history.

As there are other issues pointed out, I'm going with 'wait for the next 
version'.

Rob
