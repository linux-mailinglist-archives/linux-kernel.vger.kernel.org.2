Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1292338094C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 14:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbhENMUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 08:20:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:38360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233019AbhENMUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 08:20:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE84B61285;
        Fri, 14 May 2021 12:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620994734;
        bh=aMVZgPT83NBUBF8KQEHbuZ0Yjw/tejPKbqGtSqU9RWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DiWL8z4a476ivGppjgknFVi08gdhprZ60J6jaLhyi8h8c6c7o5HfdUpTgdtwILpYN
         J9+fmfoc03bSprzndPhhMI1v5SzxfC67FLkxDjjVdOHLLQXS1BKgKdNDVM5LC14RZV
         S5yLssdFD5jP6nXx9vmEHovL1Yl3DChzPdODebdQN7GDq9MBh7tWQcDievww+tcO08
         nYbEU2B6maaYg79+M9Ii4U1+unFN/SxrD9PIU+u6aOlqjR0ZTdFbSvh4yoYCJo6mXa
         TSmHYbAHN5xMffU6Lzx8pkh0CibFRevO5zg31vM2T/IOFVrmLOLex8YGrUrQ4KBoUu
         NGrt7oEV8RYTg==
Date:   Fri, 14 May 2021 17:48:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Aswath Govindraju <a-govindraju@ti.com>
Subject: Re: [PATCH] phy: Allow a NULL phy name for devm_phy_get()
Message-ID: <YJ5qqswlgqpVIeIT@vkoul-mobl.Dlink>
References: <20210414135525.3535787-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414135525.3535787-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-04-21, 08:55, Rob Herring wrote:
> For a single PHY, there's no reason to have a phy-names entry in DT.
> The DT specific get functions allow for this already, but devm_phy_get()
> WARNs in this case. Other subsystems also don't warn in their get
> functions. Let's drop the WARN for DT case in devm_phy_get().

Applied, thanks

-- 
~Vinod
