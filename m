Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93CB730EDF2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 09:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbhBDIDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 03:03:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:55516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230252AbhBDIDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 03:03:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7667E64F4E;
        Thu,  4 Feb 2021 08:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612425787;
        bh=UERtmU9s9R2hdIA4Nk84pak1mejJyP62L4bzjlTRiuw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gyUehJl8yguibGhihp2h4NGbY8bJGGe4cgNQJeZoDjdP1OGyNBED/sETOHXwleh7J
         sfEu0Lxc7IDXrQFW4/tX3pBrZiz3Z49IE0eyQd+ecCfCnX8521I3OovIToUtV3LeG8
         6WZCq9yWwRVNrzJKpYtQ9w0jRerPd4PkkHzEr6lXqPG+2baU6P1q8Z26ukPnsYDN8g
         EwIIDLPNeCG0gYxP3YDkydI8oZK3XYz3hPYD+fCPtegK3svX2T5YNNhbTbV3QTgWMF
         kvPrne2xlRTodjq+LdHmOXipz+EKCsLiX1VE7Db9rJ7Y7A7Aez+CJN37hzL/BM70oO
         UNwJbXPnIMJ3g==
Date:   Thu, 4 Feb 2021 13:33:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: USB_LGM_PHY should depend on X86
Message-ID: <20210204080303.GK3079@vkoul-mobl.Dlink>
References: <20210129131753.2656306-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129131753.2656306-1-geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-01-21, 14:17, Geert Uytterhoeven wrote:
> The Intel Lightning Mountain (LGM) USB3 USB is only present on Intel
> Lightning Mountain SoCs.  Hence add a dependency on X86, to prevent
> asking the user about this driver when configuring a kernel without
> Intel Lightning Mountain platform support.

Applied, thanks

-- 
~Vinod
