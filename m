Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16359413C15
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 23:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbhIUVMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 17:12:54 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:33439 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbhIUVMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 17:12:50 -0400
Received: by mail-oi1-f181.google.com with SMTP id 24so1267578oix.0;
        Tue, 21 Sep 2021 14:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hRXRuE1+8asJXNy5ZzL9E4nuBT3tipZBLbRPGxp4BLg=;
        b=uXvjWTVenh2jrpwLmCS9HMOArDDN+YGnTrhGB577R7LQLgSE9OCSFvRlnXps9vB5fv
         KbtueU8804X2zB+D9NX9dOlIr90SB2ZVmvFO5IGhabzIQfulwwwXsyOQQWcHJhv1mCPX
         pLRjxlwJ+L5mekuSOFKNQkc/vB/ZaUoN9zsL2QApanPMr441mhniaIcqmazxpqpTimkS
         HmE17DoBNFGc5j6u0pvHeG+SBKGjV85dZ3/4EN5e4EupVsQnDA/3xFPh580W3LtXPuYO
         nZ4FHCRFNMp0j7g0a8eO+z0GHohvJCSx6UKgaIBQ0XO0njC7m9mssiL77+65yVy6RVYE
         S8ww==
X-Gm-Message-State: AOAM533QrwVyksneXZo2kHBprxCW7zCqlsonVZsgsGUHJCUKJeFduMF2
        kAZXbKohgfJFiwHX4cieOw==
X-Google-Smtp-Source: ABdhPJyQW2Koz8jAd+1kZk3ODPjulP75q4aqnYchN8Z4GaHg8ebHZAfcJEYJmGfJ1+vn9F+/nK3kHQ==
X-Received: by 2002:a05:6808:35a:: with SMTP id j26mr5444088oie.140.1632258680931;
        Tue, 21 Sep 2021 14:11:20 -0700 (PDT)
Received: from robh.at.kernel.org (rrcs-192-154-179-36.sw.biz.rr.com. [192.154.179.36])
        by smtp.gmail.com with ESMTPSA id i25sm40330otf.31.2021.09.21.14.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 14:11:20 -0700 (PDT)
Received: (nullmailer pid 3331641 invoked by uid 1000);
        Tue, 21 Sep 2021 21:11:19 -0000
Date:   Tue, 21 Sep 2021 16:11:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Romain Perier <romain.perier@gmail.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Daniel Palmer <daniel@0x0f.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] dt-bindings: add vendor prefix for Wireless Tag
Message-ID: <YUpKd4m776uEO5wO@robh.at.kernel.org>
References: <20210914184141.32700-1-romain.perier@gmail.com>
 <20210914184141.32700-3-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914184141.32700-3-romain.perier@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2021 20:41:40 +0200, Romain Perier wrote:
> This adds a vendor prefix for wireless tag boards and SOMs.
> 
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
