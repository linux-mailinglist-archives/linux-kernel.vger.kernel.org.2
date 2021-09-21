Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467B8413C95
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 23:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbhIUVhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 17:37:12 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:41822 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhIUVhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 17:37:09 -0400
Received: by mail-ot1-f54.google.com with SMTP id 97-20020a9d006a000000b00545420bff9eso456335ota.8;
        Tue, 21 Sep 2021 14:35:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T4j5cvKZQ8N+YvWUCi17+Fr4x/Z3vE4XiOx0eKjk+tU=;
        b=xSkYb9nz3PfC8r7zBi2uMr5z6JkP0cyrCubNZZBpdOPa9K04QEPgmtl/imufGXZkLy
         QR2+5HuzoBRGSIfADTFOmicYMPIMoAhMKOsvS5EKnZAE7jRYVeZcrXQKZdfEXZaj1meY
         GxwGEnI/TaZR3dB63i8joHXY3EEk1uCEu4t7G9UekxPg8wAMiyg3lyR7wumptS5u1dur
         AxYTm+3caVDCTthfBd3a+T4JzEc5TBgtlxRaI8IxeYjapsiWK11jmtGE9qEPYqTsAgjS
         geuUQ8wBJtiy3MGZCAiE6+RsG+OyAoM2Gnki1EvlyuX3ViX8nhEX313k8m9BVcys3Izb
         jZcg==
X-Gm-Message-State: AOAM532PIUum5r9DrEa009vEOgvT5M3WF9OlplQQcRc2V9skcM9/EQqr
        FOeWEYqEiuJMaM+JynRUHQ==
X-Google-Smtp-Source: ABdhPJxmma6JhoB5zdppHeGnccC3TREmxZ6BnGVfI08ib2UHUPXJUaOhty7Iqw6WCnvNBoQJGWSnpA==
X-Received: by 2002:a9d:6206:: with SMTP id g6mr12495159otj.62.1632260140624;
        Tue, 21 Sep 2021 14:35:40 -0700 (PDT)
Received: from robh.at.kernel.org (rrcs-192-154-179-36.sw.biz.rr.com. [192.154.179.36])
        by smtp.gmail.com with ESMTPSA id u12sm47768otq.20.2021.09.21.14.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 14:35:40 -0700 (PDT)
Received: (nullmailer pid 3363560 invoked by uid 1000);
        Tue, 21 Sep 2021 21:35:37 -0000
Date:   Tue, 21 Sep 2021 16:35:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bao Cheng Su <baocheng.su@siemens.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Chao Zeng <chao.zeng@siemens.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] dt-bindings: arm: ti: Add bindings for Siemens
 IOT2050 PG2 boards
Message-ID: <YUpQKbl5OCVxoLbp@robh.at.kernel.org>
References: <cover.1631708830.git.jan.kiszka@siemens.com>
 <336ade4715b3d2f5f83c3ed8f3fa2989f5699578.1631708830.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <336ade4715b3d2f5f83c3ed8f3fa2989f5699578.1631708830.git.jan.kiszka@siemens.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2021 14:27:08 +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Product Generation 2 (PG2) boards are based on SR2.x SoCs and will be
> released soon.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  Documentation/devicetree/bindings/arm/ti/k3.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
