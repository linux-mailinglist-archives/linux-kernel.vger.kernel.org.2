Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA60379307
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 17:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbhEJPub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 11:50:31 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:36412 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbhEJPu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 11:50:28 -0400
Received: by mail-ot1-f52.google.com with SMTP id n32-20020a9d1ea30000b02902a53d6ad4bdso14826680otn.3;
        Mon, 10 May 2021 08:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jbgJ2xIcj4Tn125ILT0iif80RhniBOFq8W6ICy6OMZc=;
        b=EJwdiPkw2Y7ljGY/rHaq6imfCmDvLIqYSxKX4E4whZDY+bLBcOmg+1ebcFO4PTJh47
         xoJ8mImN5nPL5CGUZcUsX03u5jLaXfjOuaJMby+FU4cdFarmKSoXaCAIt168SHRfX61T
         384Cddyq3vGJQh/G+EZNhQR2RD+G8HQDCLzFRazhcuwBiE8AnQnHpgus2wXIl/dHEX8U
         neX7U59S8q8GhXiB6FbF5Y0LXfiy7zXMaiGx1QYBCluRe3i7Z5BzmX/x/pgCOgUFShEP
         za8dokng0qZyMHFT25qPDCDOk/y3WeuG4DmYUUb/eXCjHdH4E7Y7Zhe5ALEwbIoOSU6L
         2pFQ==
X-Gm-Message-State: AOAM531U6REJ+9L9mW8CRwkiScWTOrI+i7WZ0LpQJ/eLXHWHuKzFRrcY
        lD07ErM7Qe8iqASx8M27pftHjH/iIA==
X-Google-Smtp-Source: ABdhPJxqwatdUXu5iD5ufgA065ek3wwc3mDJfGRnXDZj4TVrpVHHBi/u5IzRcZZV+NBBHDIQv89GQA==
X-Received: by 2002:a9d:6a88:: with SMTP id l8mr22407633otq.236.1620661762113;
        Mon, 10 May 2021 08:49:22 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 19sm1129696oiy.11.2021.05.10.08.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 08:49:20 -0700 (PDT)
Received: (nullmailer pid 185884 invoked by uid 1000);
        Mon, 10 May 2021 15:49:19 -0000
Date:   Mon, 10 May 2021 10:49:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     ludovic.desroches@microchip.com, claudiu.beznea@microchip.com,
        alexandre.belloni@bootlin.com, soc@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, codrin.ciubotariu@microchip.com,
        nicolas.ferre@microchip.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: ARM: at91: document sama7g5ek board
Message-ID: <20210510154919.GA185855@robh.at.kernel.org>
References: <20210507152655.182558-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507152655.182558-1-eugen.hristev@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 May 2021 18:26:52 +0300, Eugen Hristev wrote:
> Document the SAMA7G5 Evaluation Kit based on sama7g5 SoC.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  Documentation/devicetree/bindings/arm/atmel-at91.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
