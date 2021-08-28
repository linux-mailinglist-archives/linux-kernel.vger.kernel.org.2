Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C58F3FA6E6
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 19:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbhH1RII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 13:08:08 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:46140 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229822AbhH1RIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 13:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=W1ifW6XCA/QKG4jUSYf8RKjhvjEg5gxc0xP0Qx7wwJQ=; b=EDbPU2J93PPky+lj/7RSYG47O+
        VfshmhikaWWu3hpw04d5W2B5udKF7/FVBqzY7i86fwXZYgBq3yWU5IUTLdt6WgLJexbR7YN5bi304
        jzIuwqEWHqRwF/HIMcFJBm/z//rP2l7g/Em7rb8xfSIx8q/kofpAOSq3pfhurN2aUV1o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1mK1nQ-004IzB-Vk; Sat, 28 Aug 2021 19:07:08 +0200
Date:   Sat, 28 Aug 2021 19:07:08 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Matthew Hagan <mnhagan88@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] ARM: dts: NSP: Fix MDIO mux node names
Message-ID: <YSptPF8MKNahkMbm@lunn.ch>
References: <20210828112704.2283805-1-mnhagan88@gmail.com>
 <20210828112704.2283805-3-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210828112704.2283805-3-mnhagan88@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2021 at 11:27:01AM +0000, Matthew Hagan wrote:
> This patch fixes the following message by adding "mdio-mux" compatible:
> compatible: ['mdio-mux-mmioreg'] is too short
 
Err, what? This sounds like a workaround for a tool problem, not a
real fix. 

What is actually wrong with:

compatible = "mdio-mux-mmioreg";

	   Andrew
