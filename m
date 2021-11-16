Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53761452F6D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 11:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbhKPKsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 05:48:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:53080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234406AbhKPKsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 05:48:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EBA3260D07;
        Tue, 16 Nov 2021 10:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637059533;
        bh=zSl8UclagdTHVWfyQeAcJb1WGxRat4K0SnmKCoDNROo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WOWVQxOaF/RWjoA4YIopsJxN1v67DB230LLyLVR/xoHdZfDHL6R4bwevONqrADV44
         x6gsa2cvPnnSwSrG2AkwA3cngMowXnJDsea+AzLtgNLZDgIByrsCkfZzjzxaYH/ZYp
         o9VQQ6qlWAkNZTVHAsSfj0froEj7b2ck/Uqi5ZqwPZ+1HKJc7jgn5/qimKuJo24kEV
         nBIgjLuCIab/rXECnyOExgQSq5y6lINi+USAjx6srek/Z43vmIfzzeNUDQLS7aOIyS
         U1AVXBJlDqaMEiiwjQACofSWwVRI6pLFE2mcJXwoyccs3rA3E4FX9drpEHTaXknZQ+
         EnOWowg+RLFnA==
Date:   Tue, 16 Nov 2021 16:15:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     kishon@ti.com, robh+dt@kernel.org, andrew@lunn.ch,
        alexandre.belloni@bootlin.com, kuba@kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend v4 0/3] phy: Add driver for lan966x Serdes driver
Message-ID: <YZOLyQPsgoOYJZch@matsya>
References: <20211116100818.1615762-1-horatiu.vultur@microchip.com>
 <20211116102151.k3evnn4f2rwsi5nk@soft-dev3-1.localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116102151.k3evnn4f2rwsi5nk@soft-dev3-1.localhost>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-11-21, 11:21, Horatiu Vultur wrote:
> The 11/16/2021 11:08, Horatiu Vultur wrote:
> 
> Hi Kison, Vinod,
> 
> Can you let me know if you have more comments to this patch series?
> Otherwise can you ack on it? Because I would like to have the patches
> merged via netdev if that is OK for you.

Any reason for merge thru netdev, there is no dependency and now with
merge window closed, I can pick this up..

-- 
~Vinod
