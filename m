Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14AE0315C65
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbhBJBhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:37:41 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:41602 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbhBIX02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 18:26:28 -0500
Received: by mail-oi1-f179.google.com with SMTP id v193so8139oie.8;
        Tue, 09 Feb 2021 15:25:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3Bs5+vaQTu+eCwDRoOXl16FTbRsekAUffxOjU2JLISk=;
        b=uhxT6cw/kYa2gXPJSq2UGhm6qbNOgDtSSiDczi4Zik0YvsWfPUVIKl8rjNcUxxMvOg
         KqqnP/UHhQwqZ6W41pR6qbt2/L0LSOLZjNy1UfCRWr8R4JQGWTzUlZX32dV9ByBBnoLX
         zoi/jPB/dP/A2/S/QGzctg3mGbSiZ9NTanfYRnFE9p7jIcE9/kBX3lQxJGOKv6BgpTrS
         BCRXCQFJ8hOVNvWYEIMm6/UznYqdZF1b2woOkQED7NHIr6fBMN4iFWk19rd9WoU72u97
         flCP2ZVcvqaxMLr7JMUOu4kXAw3bdGFovfYLxGOrG8iRkio5Kxgv/zyfgFj/xdqhCmtl
         VyPg==
X-Gm-Message-State: AOAM533d+Vr3fvf1VovDSe5zqHpClvcSU3JA7lOrX0e2hjSplMGGDBSX
        NpkGUGPOCjTEoyhCqUl+HA==
X-Google-Smtp-Source: ABdhPJwuRLU0qA6aSkp6ZsCLRlc1ySgFvlDhnByEU6jyCSWa/eOdPW6uZYxHS23tscc7L8lpayL5xA==
X-Received: by 2002:a54:4886:: with SMTP id r6mr122676oic.54.1612913092548;
        Tue, 09 Feb 2021 15:24:52 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m22sm10147otn.62.2021.02.09.15.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 15:24:51 -0800 (PST)
Received: (nullmailer pid 429553 invoked by uid 1000);
        Tue, 09 Feb 2021 23:24:49 -0000
Date:   Tue, 9 Feb 2021 17:24:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tianling Shen <cnsztl@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Johan Jonker <jbx6244@gmail.com>, linux-kernel@vger.kernel.org,
        Jensen Huang <jensenhuang@friendlyarm.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        David Bauer <mail@david-bauer.net>,
        Tobias Schramm <t.schramm@manjaro.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Emmanuel Vadot <manu@freebsd.org>,
        Marty Jones <mj8263788@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: Add doc for FriendlyARM NanoPi R4S
Message-ID: <20210209232449.GA429524@robh.at.kernel.org>
References: <20210208191646.6511-1-cnsztl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208191646.6511-1-cnsztl@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Feb 2021 03:16:45 +0800, Tianling Shen wrote:
> Add devicetree binding documentation for the FriendlyARM NanoPi R4S.
> 
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
