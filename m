Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FD145F625
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 22:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbhKZVH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 16:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbhKZVF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 16:05:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3EDC061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 13:02:13 -0800 (PST)
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FDFD62295;
        Fri, 26 Nov 2021 21:00:10 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 6A37E6008E;
        Fri, 26 Nov 2021 21:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637960409;
        bh=k7UsLT37k1GrFBDVVs6JzScp2NM+CaH2DoaCQ1FYxtM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Y1f2yPVDR4e8rjrcmDD6nEj0XOzJj1jUbpliTbK7TvZGF58SFqgpzzf2kCCcYnxIb
         gQ7oyil0jeaGlvnCJapj1NBcisAMQeWkX1lEnNa16PgvIcXiCEnsjmN72a6SVbPx4g
         maaS4uL4IgiK1KWF4CKHknl/gq3DLBYhwsAE+G7iY8RDLSFbzTKR3w5YRn2guhpADy
         l8MGu6YKZYZo488G8gZa8Z6whkqWWUiFNQLIEScVm5lfiyiHCbbp8ZAkYpdVdBovUu
         Rhhvl2IqY5Z0i1xwgUpc/U47iM9ybmzEQshg47y3e9Ngj53+GL8e15U8HqmDAgglMM
         yTeYGB4vf2h1Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 56A73609BA;
        Fri, 26 Nov 2021 21:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 1/1] net: dsa: microchip: implement multi-bridge
 support
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163796040935.20347.11458816221584433704.git-patchwork-notify@kernel.org>
Date:   Fri, 26 Nov 2021 21:00:09 +0000
References: <20211126123926.2981028-1-o.rempel@pengutronix.de>
In-Reply-To: <20211126123926.2981028-1-o.rempel@pengutronix.de>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
        andrew@lunn.ch, f.fainelli@gmail.com, vivien.didelot@gmail.com,
        olteanv@gmail.com, davem@davemloft.net, kuba@kernel.org,
        kernel@pengutronix.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 26 Nov 2021 13:39:26 +0100 you wrote:
> Current driver version is able to handle only one bridge at time.
> Configuring two bridges on two different ports would end up shorting this
> bridges by HW. To reproduce it:
> 
> 	ip l a name br0 type bridge
> 	ip l a name br1 type bridge
> 	ip l s dev br0 up
> 	ip l s dev br1 up
> 	ip l s lan1 master br0
> 	ip l s dev lan1 up
> 	ip l s lan2 master br1
> 	ip l s dev lan2 up
> 
> [...]

Here is the summary with links:
  - [net,v3,1/1] net: dsa: microchip: implement multi-bridge support
    https://git.kernel.org/netdev/net/c/b3612ccdf284

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


