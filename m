Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA3E400DBB
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 02:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235680AbhIEAoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 20:44:04 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:56422 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233396AbhIEAoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 20:44:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=MtoS3nIxFjGLmLa7oxlvwoAJICq8MHy8HmSBPzcja1w=; b=fg
        ysAOFmktp/3/y4aFomG63vb9cQMtlktWwiFpinyxyRdNBx5O17o0ao/YPROW3ajjomi7HnKRYwCNa
        5UPhbY59GXkydU5MNZaUlTm4Kf1bhyZYe4rOm0YLgW/M9awLdB1l88qApwDCq0v7sk60fESpxIP/i
        8ZOuIsRUJnW6gJE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1mMgFD-005KGS-9W; Sun, 05 Sep 2021 02:42:47 +0200
Date:   Sun, 5 Sep 2021 02:42:47 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     =?utf-8?B?Q2zDqW1lbnQgQsWTc2No?= <u@pkh.me>
Cc:     jernej.skrabec@gmail.com, davem@davemloft.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, mripard@kernel.org,
        robh+dt@kernel.org, wens@csie.org, willy.liu@realtek.com
Subject: Re: [PATCH v2] arm64: dts: allwinner: h5: NanoPI Neo 2: Fix ethernet
 node
Message-ID: <YTQShyhvCMcEmxkA@lunn.ch>
References: <116454729.UZi3dMzWh7@jernej-laptop>
 <20210905002027.171984-1-u@pkh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210905002027.171984-1-u@pkh.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 05, 2021 at 02:20:27AM +0200, Clément Bœsch wrote:
> RX and TX delay are provided by ethernet PHY. Reflect that in ethernet
> node.
> 
> Fixes: 44a94c7ef989 ("arm64: dts: allwinner: H5: Restore EMAC changes")
> Signed-off-by: Clément Bœsch <u@pkh.me>
> Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
