Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243DD32F3FD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 20:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhCETeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 14:34:18 -0500
Received: from mail-oo1-f52.google.com ([209.85.161.52]:35363 "EHLO
        mail-oo1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhCETdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 14:33:51 -0500
Received: by mail-oo1-f52.google.com with SMTP id p6so702643oot.2;
        Fri, 05 Mar 2021 11:33:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vcI7VkYAMZBG9jFCnhUIoHlBO/JdrDHPaCddk7VwNrE=;
        b=LNZ+N8yOJhz1LyupFAU5nl2X3/e5ID6vhLzBi13JyDbn+jYtwjILbguzx7heQIKYzX
         pmvFhP93qtMWgyvBuYXAsFTqTKOA091PdyfGO5ieuDAGzWOa/Qw2OogVaPOM9fBN/UGk
         K52iEArY6/q3EvLYdhiQZ7sXH8/YHIHabBRz/2O/s419TL9iPBA/y1UnFc3GbALxCwKV
         LMPB96umvSvZqtMfDv7ZCJ5CyIH8yKNdtBlRLSyqVKPKrhB41kN8HtPaxNINQoMoUCVZ
         yH4WQp664ZTtCTYxcD+/UXHRZv6SpAsqGo1iR8Xmey4odX9YG8UzV9AklGsS6dpfZdwM
         25EQ==
X-Gm-Message-State: AOAM530cndz6/nBzYDK4WzYn6xQYXYT0EmzD+dkSqjUQJa/7Nlfd0Qx1
        2QgWXV/aeJIOiTfwSNZNmw==
X-Google-Smtp-Source: ABdhPJySqjYTYbV4xbM1b4VaI0WeS4gtoNGw2xbh6SBopsV4+nNQasg3DrzI+jpK0xXRFl0WzkDa+Q==
X-Received: by 2002:a4a:1883:: with SMTP id 125mr9042190ooo.6.1614972830794;
        Fri, 05 Mar 2021 11:33:50 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v7sm145630otq.62.2021.03.05.11.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 11:33:50 -0800 (PST)
Received: (nullmailer pid 521258 invoked by uid 1000);
        Fri, 05 Mar 2021 19:33:49 -0000
Date:   Fri, 5 Mar 2021 13:33:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     linux-kernel@vger.kernel.org, Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Bao Cheng Su <baocheng.su@siemens.com>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Le Jin <le.jin@siemens.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: arm: ti: Add bindings for Siemens
 IOT2050 boards
Message-ID: <20210305193349.GA521229@robh.at.kernel.org>
References: <cover.1613071976.git.jan.kiszka@siemens.com>
 <68c2099e6b3a568fe43f522a042592b120f871a3.1613071976.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68c2099e6b3a568fe43f522a042592b120f871a3.1613071976.git.jan.kiszka@siemens.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Feb 2021 20:32:54 +0100, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> These boards are based on AM6528 GP and AM6548 HS SOCs.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  Documentation/devicetree/bindings/arm/ti/k3.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
