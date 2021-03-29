Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA4F34C131
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 03:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhC2Bgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 21:36:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230292AbhC2Bgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 21:36:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B8D96146B;
        Mon, 29 Mar 2021 01:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616981791;
        bh=s0kjD6LXHpUpMoWDbEEPfZ7AdW0jY2wydAM4oZ8pLkM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HoDi3/0uc06gslDKwUp2ARLN1cuprToRMHrju0SevJdfovDU4rjcY4d2eDG7kBM5M
         n/Q+gsurNIMr6Q8dE3q270tDbQLSrd7X793jm78TouMTp+7Ive82GK3eEpbqdfzmxI
         EaDo5SFnvW5zuxGNcREKC47tK/VPMCyk4C8PFZB0s15CnhAAFpUZuoGfMbVPpL+jIW
         aL52TBu/kSG5iP0IkPMCbEVXAy9x9bo8o3hOJ8ohJYRhs2HdUbi9rmyc0yt7m/30GQ
         mFsGO+Il0HiBFqYo+/O1vpgzUmZxTwPws8CEgTEHjJM2t8p5YU18t7KwpDu7Joch5+
         7SNmeXOviJ5LA==
Date:   Mon, 29 Mar 2021 09:36:27 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] arm64: configs: enable FlexTimer alarm timer
Message-ID: <20210329013626.GJ22955@dragon>
References: <20210320183436.27632-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210320183436.27632-1-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2021 at 07:34:36PM +0100, Michael Walle wrote:
> This driver is used on Layerscape SoCs to wake up the system from
> standby. It works in conjunction with the RCPM driver. The latter is
> only available as a builtin.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Applied, thanks.
