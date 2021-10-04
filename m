Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFA6421659
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 20:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238510AbhJDS0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 14:26:41 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:35345 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238247AbhJDS0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 14:26:38 -0400
Received: by mail-oi1-f173.google.com with SMTP id n64so22855680oih.2;
        Mon, 04 Oct 2021 11:24:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uqtsnyNKKJS9yEITd+jPQas/rw37SI2DxYEgJEPNXP8=;
        b=7A5Gtn5L86734LhAB3vfbyOeQfkQiqdGxUKWz253Zueu9L8yF0VtE05QL7yMas3/Cc
         OqqS24SiIte8pwjowAfLJm1oLBZs4lINr5cLTOVgdxUHgXvEH1Pi4EC0zI/tKMYhG+j2
         Hddl67XntlzpBVchapxjnpTMZzvTVWrbkLBQ0BeY02LKrY9i6MdAzxb9AzQL2Kxba9/i
         hlQD4WEVh+4Ndj1Q2/L6QdgBwl2P74RbSeb71l3P+3IV1zhobSaeSwzwlgvUrZEUi+i6
         ayjn84KodMu4fAhJHVLoARHWnwNggzbShI+394NKgoTbj8BX7quvx+NCHeECSh8983yZ
         3dMg==
X-Gm-Message-State: AOAM531Y6Lj3DevV+gh6KQ/DTcAFLZGVpzed/tDs4sxnqHOzj3rQp1J4
        ZDrSDYHjE94uHPj/fBGeQA==
X-Google-Smtp-Source: ABdhPJyTyPZM+WOk9JYo2l4wBBPBqaBkwGZycQzvuQxp5B5a6aRmAyRc76soi8nj+CiRbzOQa0HtHQ==
X-Received: by 2002:a54:4d89:: with SMTP id y9mr4913473oix.22.1633371888817;
        Mon, 04 Oct 2021 11:24:48 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l28sm2928304oof.30.2021.10.04.11.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 11:24:48 -0700 (PDT)
Received: (nullmailer pid 1605963 invoked by uid 1000);
        Mon, 04 Oct 2021 18:24:47 -0000
Date:   Mon, 4 Oct 2021 13:24:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     tommy-huang <tommy_huang@aspeedtech.com>
Cc:     BMC-SW@aspeedtech.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, joel@jms.id.au, robh+dt@kernel.org,
        linux-aspeed@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, airlied@linux.ie, andrew@aj.id.au,
        daniel@ffwll.ch
Subject: Re: [PATCH 6/6] dt-bindings: gpu: Add ASPEED GFX bindings document
Message-ID: <YVtG72uZKHrkGk6u@robh.at.kernel.org>
References: <20210928025703.10909-1-tommy_huang@aspeedtech.com>
 <20210928025703.10909-7-tommy_huang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928025703.10909-7-tommy_huang@aspeedtech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sep 2021 10:57:03 +0800, tommy-huang wrote:
> Add ast2600-gfx description for gfx driver.
> 
> Signed-off-by: tommy-huang <tommy_huang@aspeedtech.com>
> ---
>  Documentation/devicetree/bindings/gpu/aspeed-gfx.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
