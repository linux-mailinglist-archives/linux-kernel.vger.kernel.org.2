Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9803F2380
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 01:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236474AbhHSXEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 19:04:53 -0400
Received: from gloria.sntech.de ([185.11.138.130]:54526 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229808AbhHSXEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 19:04:52 -0400
Received: from [212.185.68.41] (helo=phil.client.m3-hotspots.de)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mGr4y-00005w-2K; Fri, 20 Aug 2021 01:04:08 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, jay.xu@rock-chips.com,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, broonie@kernel.org
Subject: Re: [PATCH] soc: rockchip: io-domain: Remove unneeded semicolon
Date:   Fri, 20 Aug 2021 01:04:06 +0200
Message-Id: <162941424101.2925714.5080372869374112327.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <1629361749-97977-1-git-send-email-jiapeng.chong@linux.alibaba.com>
References: <1629361749-97977-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Aug 2021 16:29:09 +0800, Jiapeng Chong wrote:
> Fix the following coccicheck warnings:
> 
> ./drivers/soc/rockchip/io-domain.c:118:2-3: Unneeded semicolon.

Applied, thanks!

[1/1] soc: rockchip: io-domain: Remove unneeded semicolon
      commit: 9e5747c57807ad8a04c356340190cfdd0bd54111

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
