Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45EBC3AE203
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 05:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhFUD6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 23:58:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229905AbhFUD6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 23:58:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 55B3660FE6;
        Mon, 21 Jun 2021 03:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624247785;
        bh=o+yNEEIyaXKZ/KHvbH8sXE9WCTIGJj1kmH3r6BJ+mDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j7xgZp9m9EO2cXxxPGTMsIQJP5CoxEvXneKnIKveLqiy57gakWZmSQZGdV+cRrxSS
         sMU050PhUUsEtUwC2hMAtJ14auoViTcD5lWQIAPR3DFRBYYELbwLBzImXIoe9ztzwf
         Kby/xe0aeFHnVpo+KWj57/Izti02MIBIZH/pZxlU1o8sDM0mDNsgp4PP9Fq6U6sRlM
         45kD2jZRvWxq8wK7Ltez6DuyMmGgVhirlCMSESTuoubfk6J/7y3PZFiCubyHbkf4pW
         sHzfYAdm5ofnOkP57WdY2GR6wXujs6GWi0mOTxQf/2RQpP1w/drq5RDuxhgNC2AF3T
         u75zYtxT9hkhw==
Date:   Mon, 21 Jun 2021 09:26:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     kishon@ti.com, robh+dt@kernel.org, ezequiel@collabora.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 0/2] phy: rockchip: add Innosilicon-based CSI DPHY
Message-ID: <YNAN5eg76VuZdyiq@vkoul-mobl>
References: <20210610212935.3520341-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610212935.3520341-1-heiko@sntech.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-06-21, 23:29, Heiko Stuebner wrote:
> Newer Rockchip SoCs use a different DPHY for camera operation
> based on an IP block from Innosilicon.
> 
> This adds a driver for it for px30/rk3326/rk3368/rk1808.

Applied, thanks

-- 
~Vinod
