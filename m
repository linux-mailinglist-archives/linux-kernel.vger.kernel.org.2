Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D24343C089
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 05:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238933AbhJ0DLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 23:11:32 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:47020 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238908AbhJ0DLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 23:11:31 -0400
Received: by mail-oi1-f176.google.com with SMTP id o204so1492150oih.13;
        Tue, 26 Oct 2021 20:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JoZ9Ccv6dpB3bGQW6nAZDyn+sb2AQg2Ft8AVAzGAOmY=;
        b=FiuJINrkpJ+1ysTFH9eY5oWmXJYFMV7BL0wPSmeCb46CURoTMeOFmqG+lg+7QzLSNC
         UDacFcmFx4uTccztkzlpMv+sexvf6wvaks8zwOZx4axAdYr7s2X1ghU+nzrg8b4twUdS
         wQSqVyE1fTbCiX5YIYCLuPCn8Jw6ByUHruUdzZDcrPw/bRW0P3ESVdY0tDjaqL//UYqt
         NLOHYZy1KrH7Ir8P6NACagBv6QpBFcS71VR7A8wou6suj3imhZoWeY43d0ma04ELvHYD
         YsmTR9QJf/2ROddkUd7L1+mpSdjj2KcP8Yr4MNtfBcEIJC1WTnmMTihjN0tdmOr7wdow
         KlBQ==
X-Gm-Message-State: AOAM5301T9E5e/UrbGIVECjGfMpfnTM5E9SBRJjPUBqd1jMbZUVtwx5Z
        5iC21RNUavS2vYhshvpdMQ==
X-Google-Smtp-Source: ABdhPJxP+HUa5HrTODDGuZIQCJRqge+TPgdplkzoWQSmyEpiPVdVAQUfsyAZcRYa5V4mMeK9wI01HA==
X-Received: by 2002:aca:1219:: with SMTP id 25mr1779645ois.149.1635304146639;
        Tue, 26 Oct 2021 20:09:06 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v17sm5152280otk.56.2021.10.26.20.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 20:09:06 -0700 (PDT)
Received: (nullmailer pid 3941125 invoked by uid 1000);
        Wed, 27 Oct 2021 03:09:05 -0000
Date:   Tue, 26 Oct 2021 22:09:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     linux-clk@vger.kernel.org, eugen.hristev@microchip.com,
        robh+dt@kernel.org, sboyd@kernel.org, nicolas.ferre@microchip.com,
        mturquette@baylibre.com, kavyasree.kotagiri@microchip.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] dt-bindings: clock: lan966x: Extend includes
 with clock gates
Message-ID: <YXjC0SXHpS0WJUnl@robh.at.kernel.org>
References: <20211019084449.1411060-1-horatiu.vultur@microchip.com>
 <20211019084449.1411060-3-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019084449.1411060-3-horatiu.vultur@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2021 10:44:48 +0200, Horatiu Vultur wrote:
> On lan966x it is allow to control the clock to some peripherals like
> USB. So extend the include file with these clocks.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  include/dt-bindings/clock/microchip,lan966x.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
