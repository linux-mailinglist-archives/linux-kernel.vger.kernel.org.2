Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D77433AA80
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 05:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhCOEeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 00:34:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229672AbhCOEeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 00:34:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7145F64E25;
        Mon, 15 Mar 2021 04:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615782846;
        bh=9fzIgJk+ibjNC5c6gNXvttY3p/mcK4AhQgWxWwHFzK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QD0KSwNZF5INAfNpEbkhDnFe0ZOKUc34I4W11t3dXC5uHKmjyOHrXvioQqtCmSxjp
         JyDnedGqqCNeuXWPRReOah0MeBybmtJjfMRXuulpDy8NLV6ekUDD04jaF9RySyx0cD
         aEQMKEslqQK0RZEJUj1gJDEN2R58Y4/wHwGGOma8bVWfaxBYgomHxd8G2mdd2A7twJ
         NwJSxxQ15BBNJPw1hmQsK3sz4KvCdYuxOgTiM4c2imQ7mMgOfB6Gq2DAdDwAEV9Wry
         tbLPPb/R6j+E4sxwBD+9qGi6nCbxZptkbhFUZBunwMO3eeWqzu4M6tDK5i/Ad/wgV6
         Ia6Q/zoJLMttA==
Date:   Mon, 15 Mar 2021 12:33:57 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: ls1021a: mark crypto engine dma coherent
Message-ID: <20210315043344.GE11246@dragon>
References: <20210307205629.12180-1-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210307205629.12180-1-horia.geanta@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 07, 2021 at 10:56:29PM +0200, Horia Geantă wrote:
> Crypto engine (CAAM) on LS1021A platform is configured HW-coherent,
> mark accordingly the DT node.
> 
> Signed-off-by: Horia Geantă <horia.geanta@nxp.com>

Applied, thanks.
