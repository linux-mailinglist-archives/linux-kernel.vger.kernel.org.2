Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34184331AA2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 00:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhCHXBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 18:01:08 -0500
Received: from mail-il1-f169.google.com ([209.85.166.169]:36459 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbhCHXAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 18:00:46 -0500
Received: by mail-il1-f169.google.com with SMTP id g9so10430821ilc.3;
        Mon, 08 Mar 2021 15:00:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nfNrk4dUEHvD4rfLoylN3736aZuvWEaDHQmC3Qo1gQg=;
        b=T5EJFTqD3+nRisBqBCd9mJcQvQSpKlPX53aQ4msfBgQgdW5QY0eGHqN5vkSzLndMsJ
         vORLrk8jajWoV2Tu+g9Y4L1E82xdPyMBSwrzO4lbskZdvXb5h+BtL0aH52rJ9UBhMsv0
         G8hCWR2Fuq65HTSzYUoNmnfooUIJ8AnsvpZc+PkozNFkrQ35IFIYhsV0M+7ZJHOoKm35
         u9junhDjKgX8HnMZLA92pf9oEWKE+fQl+MysmV/59Mes/qFhg4y5kGgpSN0MJ/v3VqW7
         HhGTRH9v+yPIeZSJLYD3lRRUFa+LzsX9ExtmFLhxwYa16d0LXm2H+ytqz+slPgeQCMHv
         KYCg==
X-Gm-Message-State: AOAM530vKdWYuGfM8LbxBRTvOz2s9ELOX1cLSU6Vp3G12gMK4LntjmpA
        GvJ0rHTN8uJ+whIYCG9McQ==
X-Google-Smtp-Source: ABdhPJxWETBzPEyhiH/YA1KYzUhRe7rvrhfdWmENtJwZANujRHJGbi6UEUFt71e/lWxO9m7/AlUT7g==
X-Received: by 2002:a92:b00d:: with SMTP id x13mr22293850ilh.128.1615244445580;
        Mon, 08 Mar 2021 15:00:45 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id y18sm6837685ili.16.2021.03.08.15.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 15:00:45 -0800 (PST)
Received: (nullmailer pid 3109377 invoked by uid 1000);
        Mon, 08 Mar 2021 23:00:42 -0000
Date:   Mon, 8 Mar 2021 16:00:42 -0700
From:   Rob Herring <robh@kernel.org>
To:     kostap@marvell.com
Cc:     linux-kernel@vger.kernel.org, vkoul@kernel.org, jaz@semihalf.com,
        kishon@ti.com, mw@semihalf.com, linux@armlinux.org.uk,
        gregory.clement@bootlin.com, linux-arm-kernel@lists.infradead.org,
        miquel.raynal@bootlin.com, devicetree@vger.kernel.org,
        lkundrak@v3.sk, nadavh@marvell.com, andrew@lunn.ch,
        stefanc@marvell.com, bpeled@marvell.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org
Subject: Re: [PATCH v3 3/5] devicetree/bindings: add support for CP110 UTMI
 PHY
Message-ID: <20210308230042.GA3109343@robh.at.kernel.org>
References: <20210307163343.25684-1-kostap@marvell.com>
 <20210307163343.25684-4-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210307163343.25684-4-kostap@marvell.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 07 Mar 2021 18:33:40 +0200, kostap@marvell.com wrote:
> From: Konstantin Porotchkin <kostap@marvell.com>
> 
> Add DTS binding for Marvell CP110 UTMI PHY
> 
> Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
> ---
>  Documentation/devicetree/bindings/phy/marvell,armada-cp110-utmi-phy.yaml | 109 ++++++++++++++++++++
>  1 file changed, 109 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/marvell,armada-cp110-utmi-phy.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
