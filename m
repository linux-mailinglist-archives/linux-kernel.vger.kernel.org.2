Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2C33956EB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 10:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhEaI0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 04:26:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:46660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230425AbhEaIZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 04:25:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FEAD610C9;
        Mon, 31 May 2021 08:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622449453;
        bh=8P7d3B/GlN7hz8aqxDwhACR/qaphXcmTzOMcKPMMbjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l6iom4iXr1g//E31Q4JTOMJNEIBl9AI1ytDZrSoXQbtQz5ns0OU6NDWcq6PbPibct
         aqfYzQGL80zLYrFt81XnCToJRhdcqsavxJkuHnew2dK5H6apCu7lvSe32LOQLTAGUA
         vw9GkdLQ3JCfDGabQQQhxYQP8VzE0ThilvJYO3qDnhsnewALCytaa4chbv4R+2rnes
         5Q02x8NwWXxSbflMmduvllf3QDsjcpxNS0mdB8mP8RH0yFNY60p+9dNoYiii9Uuii9
         GjYgSLF3JnnimiW5QBxR0PNQqB7GnatDWb6q5ZKwW/MTeCvrAi4HYPKf9VjvQ+Xp6a
         HQvpaeRvxKehw==
Date:   Mon, 31 May 2021 13:54:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     linux-usb@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Johan Jonker <jbx6244@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] phy: phy-rockchip-inno-usb2: add support for
 RK3308 USB phy
Message-ID: <YLSdKcOJcwzB8IeW@vkoul-mobl.Dlink>
References: <20210514150044.2099298-1-t.schramm@manjaro.org>
 <20210514150044.2099298-3-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514150044.2099298-3-t.schramm@manjaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-05-21, 17:00, Tobias Schramm wrote:
> The RK3308 SoC uses a slightly different USB phy than other Rockchip
> parts.
> This commit adds support for that phy.

Applied, thanks

-- 
~Vinod
