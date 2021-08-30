Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9305F3FAF3D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 02:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236172AbhH3A2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 20:28:22 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:47686 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236130AbhH3A2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 20:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=Dcm0/GLJrt9KzmHwU7RfbyOIhRWjtL4QvRLXwHjpwN0=; b=T1ZOIdCcZU8NhQ5sidu4+z2xdb
        qSTd/91rd+RRwxdK95tIzy/7OxDmJZ2uERjAaCaKOfjtFxSS6PPwCse49/pCM/3L8FqXzOE/vosgy
        yT7AwRZKdoiXCCXvphnZ+Py3mgUHqBavOCp2xunEyPeBLsJHR0YORApBvBUHCuYYhqu8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1mKV90-004T2d-Om; Mon, 30 Aug 2021 02:27:22 +0200
Date:   Mon, 30 Aug 2021 02:27:22 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Matthew Hagan <mnhagan88@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] ARM: dts: NSP: Fix MDIO mux node names
Message-ID: <YSwl6oh3PX8neSuV@lunn.ch>
References: <20210829223752.2748091-1-mnhagan88@gmail.com>
 <20210829223752.2748091-3-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210829223752.2748091-3-mnhagan88@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2021 at 10:37:49PM +0000, Matthew Hagan wrote:
> While functional, the mdio-mux-mmioreg binding does not conform to
> Documentation/devicetree/bindings/net/mdio-mux-mmioreg.yaml in that an
> mdio-mux compatible is also required. Without this the following output
> is observed when running dtbs_check:
> 
> mdio-mux@32000: compatible: ['mdio-mux-mmioreg'] is too short
> 
> This change brings conformance to this requirement and corresponds
> likewise to Rafal Milecki's change to the BCM5301x platform[1].
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20210822191256.3715003-1-f.fainelli@gmail.com/T/
> 
> Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>

Thanks for the expanded commit message.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
