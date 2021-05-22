Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090FF38D5CA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 14:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhEVM2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 08:28:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230417AbhEVM2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 08:28:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0554961152;
        Sat, 22 May 2021 12:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621686445;
        bh=DgierpELbInTlMRbHFy1AkWSKrMDQD7nwShd8dtlaLk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L7rv7i8t49gzL4TIpuDmZELx0XKuV9Tm7728eveAW6uWPzwZoSSJwqmIi2YHfu+LS
         mVVoVx/oaPblGYRasFUlK3DmA/lJcnICbU72N+TURksoSQtcyzXWVxNBb+V5+9RIcp
         SueS73FjxHhbwN5mwul009Hhd22iLrvevM12F8g84uvwnkw5/8lyKOR8vlg3OTUzRh
         dZ/5tYKPdufo8vpo+I+41DI0k+ly3BFHPyL+HMZIe9F+McLmglGVfg5Em0dIsyTz1Q
         jrPnL5wYIdIh1jcnI5gyBpdmlAlaBh8zPexzkL7ShAivlEvS+rnUa1TmrgPITMgfSD
         E9WVjbd4RkB+g==
Date:   Sat, 22 May 2021 20:27:20 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Kornel Duleba <mindal@semihalf.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, leoyang.li@nxp.com,
        robh+dt@kernel.org, mw@semihalf.com, tn@semihalf.com,
        upstream@semihalf.com
Subject: Re: [PATCH] arm64: dts: fsl-ls1028a: Correct ECAM PCIE window ranges
Message-ID: <20210522122719.GA3425@dragon>
References: <20210407123438.224551-1-mindal@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407123438.224551-1-mindal@semihalf.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 02:34:38PM +0200, Kornel Duleba wrote:
> Currently all PCIE windows point to bus address 0x0, which does not match
> the values obtained from hardware during EA.
> Replace those values with CPU addresses, since in reality we
> have a 1:1 mapping between the two.
> 
> Signed-off-by: Kornel Duleba <mindal@semihalf.com>

Applied, thanks.
