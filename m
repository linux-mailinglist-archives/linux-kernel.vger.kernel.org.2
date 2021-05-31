Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62C23956CA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 10:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhEaIWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 04:22:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229640AbhEaIWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 04:22:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B4B4611EE;
        Mon, 31 May 2021 08:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622449239;
        bh=qZHb4f59HDu59685ZwIkFpkzcknD3fzRw4ifX4SpuYk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fl20srjg9zrqemgVtxIIP/4aKLen/uBi2ukdYMOtOciqXgJN8OorXSUFNJpgdvNST
         hb98qjtAqkCrFm+K0ia/S8rI1H0h+xwcwCSKsvQqBr+Tnm5I7mV1j7K+prciCh07lJ
         yeeTdQU7kSwmj1ijlrVmLi55bA70Tc9iUIAjHBIr3KY8nbpYnV85vFu1V5aNfBPHgQ
         k7CEVqgZt0FZndIruf4EBHY5n4PNzZcN3+tWZY+1iJoJfcTW3oazDEqO/6En8L4PVZ
         p/omT4NtAYKuZq0ThnnwVLbpfu3UFiGo02pn06X4Jw6ZhYkY2ynkALFS9tTrQbI/mI
         tZjWwtcLLDEJg==
Date:   Mon, 31 May 2021 13:50:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Wang Wensheng <wangwensheng4@huawei.com>
Cc:     kishon@ti.com, sjakhade@cadence.com, p.zabel@pengutronix.de,
        rikard.falkeborn@gmail.com, sparmar@cadence.com,
        chunfeng.yun@mediatek.com, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, rui.xiang@huawei.com
Subject: Re: [PATCH -next] phy: cadence: Sierra: Fix error return code in
 cdns_sierra_phy_probe()
Message-ID: <YLScUxaDt/G9+Wdf@vkoul-mobl.Dlink>
References: <20210517015749.127799-1-wangwensheng4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517015749.127799-1-wangwensheng4@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-05-21, 01:57, Wang Wensheng wrote:
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.

Applied, thanks

-- 
~Vinod
